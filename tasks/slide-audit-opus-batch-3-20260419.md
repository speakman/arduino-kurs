# Opus-audit batch 3 — slides 18-26

**Granskare:** Opus max effort, 2026-04-19
**Scope:** slides 18-26 (delresultat modul 1 + öppning/huvudmaterial modul 2 + utgång modul 2)

Granskade källor:
- `/Users/daniel/projects/arduino-kurs/presentation/slides.md` (rader 1001-1435)
- `/tmp/slide-audit/slide-18.png` … `slide-26.png` (1920×1080)
- `/Users/daniel/projects/arduino-kurs/kompendium/02-modul-2.typ`
- `/Users/daniel/projects/arduino-kurs/presentation/public/images/wiring/rgb-fritzing.png` (uppskalad 4×)

Slide-mapping:
- 18 "Ni har byggt en blinkare." (delresultat träff 1) — slides.md:1001-1066
- 19 "Nästa gång…" (RGB-teaser) — slides.md:1068-1112
- 20 "PWM & RGB — Träff 2 av 5" (section) — slides.md:1114-1138
- 21 "Alla färger, av bara tre." — slides.md:1140-1193
- 22 "Koppla RGB-LED:en." (WiringSlide) — slides.md:1195-1233
- 23 "analogWrite." — slides.md:1235-1291
- 24 "Duty cycle." — slides.md:1293-1321
- 25 "Hitta färgen." (övning) — slides.md:1323-1390
- 26 "Ni har en pixel." (efter träff 2) — slides.md:1392-1435

---

## 🔴 Kritiska fel

Inga hårda faktafel i RGB-kopplingen. Fritzing-bilden stämmer mot kompendiet (R→pin 6, G→pin 5, B→pin 3, katod → GND, tre 220 Ω-resistorer, ingen resistor på katoden). Inga förbjudna ord i detta intervall. Inga Lesson/sid-referenser.

---

## ⚠️ Inkonsekvenser / kontinuitetsbrott

### Slide 22 — "Koppla RGB-LED:en."
- **Problem:** Fritzing-illustrationen är för liten. Hela nedre ~35 % av sliden är tomt svart utrymme (se crop 800×1500 från pixel (900,400)). `WiringSlide.vue` använder `max-h-full object-contain` men bildens aspect ratio (1170×814 ≈ 1.44:1) får den att bli kapad i höjd snarare än bredd — därmed flyter den i övre delen och captionen sitter strax under. Resten av sliden är död yta.
- **Bevis:** `slides.md:1195-1205` använder `<WiringSlide … img="/images/wiring/rgb-fritzing.png" … />` utan layout-override. Jämför med slide 14 (LED-fritzing) som har liknande problem men mindre påtagligt.
- **Föreslagen fix:** Antingen uppskala Fritzing-bilden (beskär svart bakgrund, spar som större), eller lägg till en `reference`-panel med pin-lista (R/K/G/B, 220 Ω) för att fylla ytan produktivt. CSS-alternativ: byt `object-contain` till `object-cover` med begränsad `h-[80vh]`.

### Slide 24 — "Duty cycle." (PWM-diagram)
- **Problem:** PWM-vågformens vita bakgrund (`bg-white rounded p-3` på `slides.md:1312`) sticker ut grovt mot det mörka slide-temat. Bilden är också placerad långt till höger medan textlistan sitter vänsterbunden → stor tom topp-yta (hela övre ~30 %).
- **Bevis:** `pwm-waveform.png` är en svart-på-vitt-illustration (kontur-stil). I det mörka temat blir den en bjärt vit ruta.
- **Föreslagen fix:** Antingen invertera PNG:n till vit-på-svart (matcha temat), eller kör `filter: invert(1)` via CSS för snabb lösning. Därutöver: centrera grid vertikalt (`items-center` redan på plats, men `grid-cols-[1fr_auto]` låter bilden bestämma sin höjd och tvåan styr inte text-blockets vertikala läge).

### Slide 25 — "Hitta färgen." färgdiskrepanser
- **Problem 1:** Slide-swatchen för **Lila** använder `#ff00c8` (R 255, G 0, B 200) medan kompendiet anger R 180, G 0, B 220. Resultatet är att eleverna siktar på compendiets värden men ser en mer mättad magenta-lila som "facit" på sliden.
- **Problem 2:** Textbeskrivningen av **Gammelrosa** säger *"mycket röd, lite blå, knapp grön"*. Kompendiet har R 255, G 140, B 180 — alltså är blå (180) *mer* än grön (140), så "lite blå" är missvisande. Bör läsa ungefär *"mycket röd, lagom blå, lite grön"*.
- **Bevis:** `slides.md:1341-1344` vs `02-modul-2.typ:93-95`. Slide-swatch: `background:#ff00c8`.
- **Föreslagen fix:** Matcha swatches till kompendiets hex (Lila: `#b400dc`, Gammelrosa: `#ffa0b4`, Skolgul: `#ffc800`, Mörk cyan ja men **Cyan** i slidens fjärde box är R 0 G 224 B 255 vilket duger mot kompendiets R 0 G 255 B 255 → OK). Alternativt: justera *kompendiets* värden för att matcha slides — välj en källa som sanning.

### Slide 23 — "analogWrite." kod saknar `pinMode()`
- **Problem:** Kodblocket visar bara `const int`-deklaration och tre `analogWrite`-rader, utan `setup()` med `pinMode(ledR, OUTPUT)` osv. En elev som kopierar rakt av får ingen utgång.
- **Bevis:** `slides.md:1256-1262`. Presenter-notes (`slides.md:1284-1286`) säger uttryckligen "Full sketch … ligger i kompendiet. Behövs inte på sliden. Visa bara essensen".
- **Bedömning:** Enligt policyn *"Komplett kod i kompendiet, inte på slide"* är detta medvetet. Ingen fix behövs. Dock: eyebrow "Nytt kommando · mellan av och på" är bra. Noterat att kompendiet (`02-modul-2.typ:175`) listar "Glömt `pinMode(ledR, OUTPUT)`" som vanligt fel — bra konsekvens.

### Slide 26 — förhandsreferens till "buzzer"
- **Problem:** *"Nästa gång: vi lyssnar. Knapp + buzzer."* — termen *buzzer* introduceras här utan definition och återkommer i modul 3. Sliden är en teaser så detta är OK, men "lyssnar" i kombination med buzzer är en *omvänd* metafor — buzzer *producerar* ljud, den lyssnar inte. "Lyssna" hör ihop med knappen/sensor-input, inte buzzer.
- **Bevis:** `slides.md:1413`.
- **Föreslagen fix:** *"Nästa gång: vi lyssnar på världen och svarar tillbaka. Knapp + buzzer."* — eller liknande dubbelriktad formulering.

---

## 💡 Polish-förslag

### Slide 18 — änkor i tre-kolumnsraden
- Col 2 "Er första kod": *"setup · loop · tre kommandon"* — "kommandon" fastnar på egen rad. Kan skrivas *"setup, loop & tre rader"* (kortare) eller *"setup · loop · tre rader kod"*.
- Col 3 "Er egen rytm": *"kod som styr världen"* renderas fint på en rad i nuvarande viewport, ingen ändring behövs.
- `slides.md:1029, 1034`.

### Slide 19 — typografi "Nästa gång…"
- Två punkter extra efter "Nästa gång." i `h1`-rubriken skapar ellipsis-känsla (`# Nästa gång...` = tre punkter). Kolla att `#`-syntax inte dödar fontstorleken — ser bra ut i renderingen, men på skärmen blir det tre "..." istället för Unicode-ellipsis "…". Mindre typografisk polish: byt till `…` för renare kerning.
- `slides.md:1083`.

### Slide 21 — "Katod" i rött
- Policy: rött reserverat för GND/varning. I warn-box är både "Katod" och "GND" rödmärkta. Katod är inte GND men är den kritiska förväxlingspunkten. Argumentet *att* rödmarkera båda är att katod ska till GND och det är där eleverna fastnar. **Behåll rött**, eller byt Katod till accent-cyan och låt bara "GND" vara rött. Bedömning: behåll, men medveten policy-avvikelse ska dokumenteras.
- `slides.md:1165-1166`.

### Slide 22 — eyebrow right-side label
- `WiringSlide.vue:18-20` har `Elegoo Basic Starter Kit`-text i höger hörn vid `opacity-35`. Acceptabel branding per project-policy, men verifiera att detta inte läcker in en "officiell" association.

### Slide 23 — kommentartext justering
- Kodradens kommentarer är manuellt inriktade med blanksteg: `analogWrite(ledG,   0);` vs `analogWrite(ledR, 200);`. Renderar korrekt i monospace men är ömtåligt vid redigering. Icke-kritiskt.
- `slides.md:1260`.

### Slide 24 — "full" utan substantiv
- `255 → alltid HIGH → full` saknar substantiv. Jämför raderna: `släckt` (adjektiv), `halvstyrka` (substantiv), `full` (adjektiv) — inkonsekvent. Kompendiets text säger *"full"* i `02-modul-2.typ:73`.
- **Fix:** ändra till `full styrka` för parallellism med `halvstyrka`.
- `slides.md:1309`.

### Slide 26 — "mellan" i kursiv
- *"något *mellan* helt av och helt på"* — `<em>` runt "mellan" fungerar pedagogiskt, men italik mitt i en lång mening bryter läsflödet. Acceptabelt.
- `slides.md:1409`.

---

## ✅ Bekräftat OK

- **Fritzing RGB-koppling** matchar kompendium: R→pin 6 (röd tråd), G→pin 5 (grön tråd), B→pin 3 (blå tråd), katod→GND (svart tråd), tre 220 Ω-resistorer, ingen resistor på katoden. Verifierat via 4× uppskalning av `rgb-fritzing.png`.
- **Pin-numren** R=6, G=5, B=3 är konsekventa mellan slide 22 caption, slide 23 kod, slide 26 referens och kompendium (02-modul-2.typ:50-54, :117-119, :186).
- **PWM-pinnar** (3, 5, 6, 9, 10, 11) konsekventa på slide 23 presenter-notes och kompendium :21, :78.
- **PWM-frekvens** — slide 24 och kompendium båda nämner 490 Hz / 980 Hz (pin 5&6). Waveform-diagrammets "1/500 second" är generaliserad frekvens, captionen i kompendiet förklarar detta.
- **Duty cycle-värden** 0/128/255 → släckt/halvstyrka/full (slide 24) matchar kompendium :70-73.
- **Common Cathode**-varningen konsekvent framställd: slide 21 warn-box + slide 22 caption + kompendium :56-58.
- **Inga förbjudna ord** (superkraft/magi/hjärna/sinne/röntgen) i intervallet 1001-1435.
- **Inga Lesson/sid/ELEGOO-manualreferenser**.
- **Träff-numrering** (Träff 2 av 5) på slide 20 konsekvent med roadmap slide 2.
- **RGB-färger på Venn-diagrammet** (slide 21) matchar verkligheten: R+G=gul, R+B=magenta, G+B=cyan, R+G+B=vit. Mix-blend-mode screen tillämpas korrekt.
- **Slide 18 "KLART"-badge** och "Delresultat · Träff 1"-eyebrow — korrekt pedagogisk inramning för delresultat.
- **Slide 26 "Efter träff 2"-eyebrow** — konsekvent mönster med slide 19 "Nästa träff".

---

## Prioriterad åtgärdsordning för denna batch

1. **Slide 25 Gammelrosa-beskrivningen** (⚠️) — faktuell felvisning mot kompendiet. `slides.md:1342`.
2. **Slide 25 Lila-swatch hex** (⚠️) — välj en sanning och synka slide↔kompendium.
3. **Slide 22 layout** (⚠️) — Fritzing för liten, halv slide tom. Inkludera pin-referens eller större bild.
4. **Slide 24 vit PWM-bakgrund** (⚠️) — invertera bild eller tematisera för mörkt tema.
5. **Slide 24 "full" → "full styrka"** (💡) — parallellism.
6. **Slide 18 "kommandon"-änka** (💡) — omformulera col 2.
7. **Slide 26 "lyssnar/buzzer"-metaforik** (💡) — buzzer lyssnar inte; spänningsbyt formuleringen.
