# Opus-audit batch 2 — slides 10-17

**Granskare:** Opus max effort, 2026-04-19
**Scope:** slides 10-17 (`slides.md` rad 505-999), rendrade PNG 1920×1080.
**Auktoritativ källa vid tvivel:** `kompendium/01-modul-1.typ`, `kompendium/appendix-c-komponenter.typ`.

---

## 🔴 Kritiska fel

### Slide 14 — "Så här ska det se ut." (Fritzing-kopplingsbild)

**Problem:** Fritzing-bilden `public/images/wiring/led-fritzing.png` visar signalkabeln ansluten till **5V-pinnen på Arduinons power-header**, inte till digital pin 13. Det är pedagogiskt förödande: en krets byggd enligt bilden ger en LED som **lyser konstant** (5V är alltid påslaget) — den kan aldrig blinka. Samtidigt säger slide-captionen `D13 → LED långt ben`, slide 13 steg 02 säger `Kabel från pin 13`, och hela sketch-exemplet i slide 15/16 (pinMode(13, OUTPUT), digitalWrite(13, HIGH)) förutsätter pin 13. Deltagare som följer bilden kommer få en lysande LED oavsett om de laddat upp Blink eller inte — och kan inte själva veta om deras kod funkar.

**Bevis:** Pixelanalys av `led-fritzing.png` (1212×823):
- Röd kabel har sin Arduino-ände vid ungefär `(x=425, y=372)` — det motsvarar Arduinons BOTTEN-header (power/analog-raden med labels `IOREF · RESET · 3.3V · 5V · GND · GND · Vin`).
- Tight crop runt plug-läget visar tydligt att röd kabel sitter i **5V-hålet** (fjärde pinnen från vänster i power-raden). Svart kabel sitter i GND bredvid.
- Arduinons TOPP-header (med pin 13, 12, ~11, ~10, ~9, 8, 7, 6, 5, 4, 3, 2, TX, RX) är helt oanvänd i bilden.
- Slide 14 caption (slides.md rad 750): `<span class="mono cyan">D13</span> → LED långt ben · LED kort ben → 220 Ω → <span class="mono cyan">GND</span>` — direkt konflikt med bilden.
- Kompendium 01-modul-1.typ rad 45: `Strömmen går ut från digital pin 13 när den är HIGH, in i LED:ens långa ben…` (auktoritativ källa bekräftar pin 13).

**Föreslagen fix:** Ersätt `public/images/wiring/led-fritzing.png` med en korrekt Fritzing-rendering där signalkabeln sitter i **digital pin 13** (topp-headern, pin märkt "13" mellan GND och 12, på samma sida som AREF). Svart GND-kabel bör gå till valfri GND-pin — antingen power-GND på bottenraden (som nu) eller pin-headerns GND (andra pin från vänster på topp-raden). Under tiden: lägg in en WARNING-overlay på slide 14, eller ta tillfälligt bort sliden tills bilden är rätt. Att bara ändra captionen räcker inte — bilden är det deltagarna kommer att följa.

---

## ⚠️ Inkonsekvenser / kontinuitetsbrott

### Slide 11 — "Fem hål = en nod." (terminologi vs visuell orientering)

**Problem:** Sliden (och kompendiet) säger `Fem hål i rad = en nod` respektive `Fem hål i rad, vågrätt, är samma elektriska nod`. Bilden `breadboard-internals.png` visar breadboarden i **landskapsorientering**, vilket innebär att de fem-håls-grupper som är elektriskt förbundna är ritade som **vertikala gröna kolumner** (inte horisontella rader). Ordet "rad" (och än mer explicit "vågrätt") kolliderar med vad ögat ser: gröna streck som går **lodrätt**. En deltagare som tolkar "rad" som "horisontell linje i bilden" kommer peka på fel sak.

**Bevis:** `public/images/breadboard-internals.png` är en 653×213 liggande bild. De gröna markerade 5-hålsgrupperna löper lodrätt i bilden (perpendikulärt mot de horisontella röda/blåa power-rails). Slide-text slides.md rad 612: `<strong>Fem hål i rad</strong> = en <span class="cyan">nod</span>`. Kompendium 01-modul-1.typ rad 57: `*Fem hål i rad, vågrätt, är samma elektriska nod.*` — ordet "vågrätt" motsäger direkt bildens orientering.

**Föreslagen fix:** Byt ordet "vågrätt" i kompendiet till "tvärs över brädan" eller ta bort det helt — bilden gör orienteringen självklar. I slide-texten: lämna "Fem hål i rad" men överväg att lägga till en pil eller markering i bilden som visar EN grupp, så deltagaren ser att "rad" här betyder 5-håls-strippen oavsett orientering. Alternativt: rotera bilden 90° så att 5-hålsgrupperna BLIR horisontella rader (mindre standard men matchar ordvalet).

### Slide 11 — power rail-orientering i bilden (minor)

**Problem:** `breadboard-internals.png` visar *yttre rail = blå* och *inre rail = röd* på både topp och botten (pixelanalys: y=11 blå, y=21 röd). På de flesta ELEGOO-breadboards är konventionen tvärtom — yttre rail är markerad med `+` (röd) och inre med `−` (blå). Om deltagarens fysiska breadboard har omvänd ordning kan det skapa en hicka när de ska översätta bild → verklighet.

**Bevis:** Pixelanalys: y=11 center-column BGR ≈ (80, 137, 200) = blå; y=21-24 ≈ (108-120, 10-15, 10-15) = röd. Det omvända mot många fysiska breadboards.

**Föreslagen fix:** Kontrollera fysisk ELEGOO-breadboard i kittet — om layouten faktiskt är `röd yttre, blå inre`, byt bild. Om bildens inverterade layout faktiskt matchar ELEGOO:s variant, ingen åtgärd. (Obs: kompendiet nämner bara "två par långa rälar: + och −" utan att specificera vilken sida — så kompendium + slide är konsistenta, det är bara bild vs fysisk bräda som behöver verifieras.)

---

## 💡 Polish-förslag

### Slide 10 — "LED & resistor."

- **Resistorvinjetten (röd·röd·brun+guld):** SVG-vinjetten i `.tip-box` visar bara 3 röda/bruna band + guld — bra approximation. Den skulle kunna vara ännu tydligare om färgerna exakt matchade verkliga resistorbanden (#E60000 röd, #8B4513 brun är redan bra; jag noterar att bilden är acceptabel).
- **"Tål ca 20 mA":** Korrekt enligt datablad, men slide 9 (föregående) pratar om strypventil/Ohms lag med 220 Ω som ger 13-15 mA. Koppla gärna ihop det muntligt ("vi siktar på ca 15 mA — säker marginal mot 20 mA-gränsen") men det kräver ingen ändring på sliden.

### Slide 11 — "Fem hål = en nod."

- Sliden är tät (bilden fyller övre halvan, fyra bullet-points nedtill). Fungerar. Om du vill ge texten mer luft, kan bullet-point-gridet göras `grid-cols-1` på riktigt stora skärmar — men ingen akut ändring.

### Slide 12 — "Kontrollera raden först."

- Mycket ren layout. "90 % av alla nybörjarfel är ett hål fel" är en kraftfull formulering. Ingen ändring.

### Slide 13 — "Bygg kretsen."

- 5-stegs-listan är korrekt och matchar kompendium. Steg 03 nämner båda 4-band och 5-band-färgkoderna — bra, samma information som slide 10, men upprepning är motiverad (student behöver se det när de plockar resistor).
- Observera att detta slide är ett förberedelse-slide för slide 14 (visuell bekräftelse). När slide 14:s bild är fixad är detta spår komplett.

### Slide 15 — "setup() och loop()."

- `Regel: exakt en setup() och en loop() per Arduino-kod. Aldrig fler.` Tekniskt korrekt (C++ förbjuder duplicerade funktionsnamn).
- Kodblocket refererar pin 13 — konsistent med hela modulen. Bra.

### Slide 16 — "Hela Blink — på tre rader."

- `HIGH = tänd (5 V), LOW = släckt (0 V)` — korrekt för en Arduino Uno (5V-logik).
- `Arduinon pausar allt annat under tiden` (om delay) — pedagogiskt korrekt förenkling för modul 1. Kompendium Bilaga A / modul 3 tar upp `millis()` som alternativ senare.

### Slide 17 — "Din egen rytm."

- `Hjärtslag — två snabba, sen paus` — `hjärtslag` är inte på förbjudet-listan (bara `hjärna`/`sinne`/etc). OK.
- Tip-box med grön/röd lapp är bra ritual. Ingen ändring.
- Presenter-notes är ovanligt långa men välstrukturerade — innehåller pedagogiska tips + felsöknings-script + avancerade CW-kommentarer. Bra material för instruktör.

---

## ✅ Bekräftat OK

- **Pin 13 / GND / 220 Ω**-faktan är konsistent mellan slide 10, 13, 14 (caption), 15 och 16 och matchar kompendium 01-modul-1.typ.
- **Resistorfärgkoder**: `röd·röd·brun+guld` (4-band) och `röd·röd·svart·svart+brun` (5-band) stämmer enligt appendix-c och standard-färgkoder.
- **Blink-sketch i slide 15**: `pinMode(13, OUTPUT); digitalWrite(13, HIGH); delay(1000); digitalWrite(13, LOW); delay(1000);` är giltig Arduino C++ och identisk med IDE:ns inbyggda exempel.
- **HIGH = 5 V, LOW = 0 V** på slide 16 — korrekt för Uno.
- **Förbjudet språk**: inga förekomster av `superkraft`, `magi`, `hjärna`, `sinne`, `sinnesorgan`, `röntgen` hittade i slides 10-17 (varken i synligt content eller i presenter-notes).
- **ELEGOO-manualreferenser**: inga "Lesson N" / "sid N"-referenser i slides 10-17. Varumärket `ELEGOO` syns bara på Fritzing-bildens PCB-silk (OK enligt branding-policy).
- **Layout-integritet**: inga avklippta texter eller överlappande element i de 8 rendrade PNG:erna.
- **setup()/loop()-beskrivningarna** matchar kompendium modul 1 rad 100.
- **Kontinuitet bakåt**: slide 10 bygger korrekt på slide 9 (Kretsen som vattensystem — strypventil-metafor → konkret 220 Ω + LED). Slide 11 introducerar breadboard utan behov av tidigare setup (bilden är självförklarande).
- **Kontinuitet framåt**: slide 13 förbereder slide 14 (visuell verifiering), slide 15 förbereder slide 16 (dekomponering), slide 16 förbereder slide 17 (uppgiften). God didaktisk trappa.

---

## Sammanfattning för PR/åtgärd

| Prioritet | Slide | Fel | Åtgärd |
| --- | --- | --- | --- |
| 🔴 Kritiskt | 14 | Fritzing-bild visar 5V istället för pin 13 | Ersätt PNG. Utan fix fungerar inte Blink-kretsen för deltagaren. |
| ⚠️ Mindre | 11 | "vågrätt" i kompendium motsäger bildens orientering | Byt ord i kompendium eller rotera bild. |
| ⚠️ Minor | 11 | Möjlig omvänd +/−-rail-order vs fysisk ELEGOO-bräda | Verifiera mot fysisk bräda, byt bild om nödvändigt. |

Inga kritiska fel i slides 10, 12, 13, 15, 16, 17 utöver vad som nämnts ovan.
