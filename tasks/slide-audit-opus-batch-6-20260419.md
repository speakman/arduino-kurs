# Opus-audit batch 6 — slides 44-51

**Granskare:** Opus max effort, 2026-04-19
**Omfattning:** Serial Monitor + Modul 4-avslut + Modul 5 Hackathon-intro + Tack-slide
**Källor:** `presentation/slides.md` (rader 2271–2697), PNG 44–51, `kompendium/04-modul-4.typ`, `05-modul-5.typ`, `appendix-d-hackathon-losning.typ`

---

## Sammanfattning

Denna batch är den hemmaplan-starkaste i hela decket: slides 44–47 är en tight Modul-4-avslutning (Serial Monitor → fri övning → Koden → "Arduinon känner världen"), slides 48–50 är Modul 5-intro (sektion → ingenjörsuppgift → pin-tilldelning), och slide 51 är avskeds-slide. **Inga kritiska fel hittades.** Pin-tilldelningar, kod, trösklar och kompendium-referenser stämmer rad-för-rad mot Appendix D och Modul 4–5.

Två polish-punkter värda att nämna nedan.

---

## 🔴 Kritiska fel

**Inga.**

Varje testpunkt verifierad:

- Slide 44 `Serial.begin(9600)` + `analogRead(A0)` + `Serial.println(ljus)` ⇔ `04-modul-4.typ:138–148` identiskt.
- Slide 46 `digitalRead(2)` tilt-avläsning, `Serial.print("ljus=")` + `" tilt="` ⇔ `04-modul-4.typ:154–159` exakt.
- Slide 46 referens "kompendiet, kapitel 4" ⇔ Modul 4 är kapitel 4. Korrekt.
- Slide 48 presenter-note "mörker ≈ 20–100, rumsljus ≈ 150–400, lampa nära ≈ 500–700" ⇔ `04-modul-4.typ:87–91` identiskt.
- Slide 48 presenter-note "KATODEN (andra benet från platta sidan, det längsta) ska till GND" ⇔ `02-modul-2.typ:45–52` (ben 2 från platta sidan = längst = gemensam katod → GND).
- Slide 48 pin-notes: RGB R=D6/G=D5/B=D3, knapp=D9, buzzer=D12, tilt=D2, fotocell=A0 ⇔ `appendix-d-hackathon-losning.typ:33–39` identiskt.
- Slide 49 Regler: "Knappen togglar larm-läge / Larm PÅ + tilt rörd = tjut + rött blink / Larm AV + mörkt = stämningsljus" ⇔ `appendix-d-hackathon-losning.typ:24–27` + `05-modul-5.typ:34–37` identiskt.
- Slide 50 pin-tilldelning-tabell: knappPin=D9, tiltPin=D2, ldrPin=A0, buzzerPin=D12, ledR/G/B=6/5/3 ⇔ `05-modul-5.typ:48–54` + `appendix-d-hackathon-losning.typ:33–39` identiskt.
- Slide 50 `bool larmPaslaget = false` + `int morkTroskel = 300` ⇔ `appendix-d-hackathon-losning.typ:43,46` värdemässigt identiskt.
- Slide 50 "Komplett startmall … Bilaga D" ⇔ Bilaga D existerar (`appendix-d-hackathon-losning.typ`) och innehåller faktiskt en komplett sketch med `setup()` + `loop()`.
- Slide 45 bullet "ser du HIGH → LOW?" stämmer mot `INPUT_PULLUP` + `tiltLutad = (digitalRead(tiltPin) == LOW)` i `appendix-d-hackathon-losning.typ:73`.

---

## ⚠️ Inkonsekvenser / kontinuitetsbrott

### Slide 50 — `int morkTroskel` vs kompendiets `const int morkTroskel`

- **Problem:** Sliden visar `int morkTroskel = 300;` utan `const`. Kompendiet (`appendix-d-hackathon-losning.typ:43` och `05-modul-5.typ:137`) använder konsekvent `const int morkTroskel = 300;`.
- **Bevis:** `slides.md:2590`: `<div><span class="opacity-60">int</span> morkTroskel <span class="opacity-60">=</span> 300; …</div>`
- **Föreslagen fix:** Lägg till `const` på sliden för att matcha kompendiets kodstil. Samma rad har `bool larmPaslaget` (ingen const, korrekt — den ska kunna ändras), men `morkTroskel` är en kalibreringskonstant som i kompendiet konsekvent är `const`. Nybörjare som skriver av sliden riskerar inte kompilera fel, men slides bör spegla det "kanoniska" sättet.
- **Allvarlighetsgrad:** Låg (kodstil-inkonsekvens, inte faktafel).

### Slide 46 → Slide 47 övergång — saknad blinkering av Ljuskänsla

- **Problem:** Slide 47 "Arduinon känner världen" listar tre färdigheter: *ljus* + *lutning* + *titta in via Serial Monitor*. Det är korrekt för Modul 4, men formuleringen "känner världen" ligger gränsfallet mot den förbjudna ordklassen `sinne/sinnesorgan`.
- **Bevis:** `slides.md:2437` `# Arduinon känner världen.` + `slides.md:2670–2672` ("läser av omvärlden och reagerar på den" i Tack-sliden).
- **Bedömning:** Policyn förbjuder specifikt `superkraft|magi|hjärna|sinne|sinnesorgan|röntgen`. "Känner" är *inte* på listan och är etablerat svenskt ord för "sensar" i tekniksammanhang (jfr. "temperaturkännare"). Slide 51 använder den mer neutrala formuleringen "läser av omvärlden och reagerar på den" — den är mer precis. Om auctor vill vara konsekvent kan slide 47 byta till något i stil med "Arduinon läser omvärlden." Helt valfritt — nuvarande text bryter inte mot den explicita listan.
- **Föreslagen fix:** Om ultra-strikt: ändra slide 47-rubriken till `# Arduinon läser världen.` eller `# Arduinon läser av omvärlden.` så att den matchar Tack-slidens ton. Annars: behåll.

---

## 💡 Polish-förslag

### Slide 44 — Teaser i presenter-notes upprepar Tack-slide-takeaway

- **Observation:** Slide 44s presenter-note avslutar med `TEASER: "Ni har nu alla byggstenar. Nästa vecka… HACKATHON. Vi sätter ihop allt till tjuvlarmet. Kom hungriga."` — i princip identisk med slide 47s synliga teaser och sen en tredje gång i slide 47s presenter-not. Inte ett fel, men "kom hungriga" sägs tre gånger inom tre slides.
- **Förslag:** Ta bort TEASER-blocket på slide 44 (rad 2334–2336). Teasern hör hemma på slide 47 som är hero-message-sliden.

### Slide 50 — "kalibrerat i Modul 4" är marginellt missvisande

- **Observation:** Kommentaren `// kalibrerat i Modul 4` implicerar att eleverna redan har ett specifikt kalibrerat värde från Modul 4. I själva verket lämnar Modul 4 (och "Hitta din tröskel"-övningen slide 45) det som en *kalibrerings-uppgift för individen* — det är inte ett kursgemensamt värde.
- **Bevis:** `04-modul-4.typ:94` "Kalibrera själv: öppna Serial Monitor…" + `appendix-d-hackathon-losning.typ:117` "`300` är en gissning. Du ska kalibrera själv."
- **Förslag:** Byt kommentar till `// kalibrera själv — 300 är startvärde` eller `// startvärde, kalibrera med Serial Monitor`. Matchar kompendiets ton exakt.

### Slide 45 — layout-utrymme oanvänt

- **Observation:** Sliden använder `layout: default` med bara en rubrik, en intro-rad och tre bullets. Slidan känns glest utnyttjad (hälften tom på högersidan enligt PNG).
- **Förslag:** Inte ett fel — minimalism är decknets estetik. Men om man vill hamna kortare kunde slide 45 + 46 kombineras i en `two-cols`-layout med bullets till vänster och koden till höger. Gör aktiviteten mer sjävgående utan att behöva klicka mellan två slides under övningen. Lågprioritet.

### Slide 48 — ingen visuell referens till appendix D-logiken

- **Observation:** Presenter-noten på slide 48 innehåller den perfekta "logik på whiteboard"-listan (rad 2544–2547). Den står på papper men visas inte på sliden. På sliden är *Regler:*-texten lite hoppressad längst ned.
- **Förslag:** Överväg att lägga ut 4 regler som en numrerad kolumn på sliden istället för ihopklottrad fließtext. Lågprioritet-polish.

---

## ✅ Bekräftat OK

### Slide 44 — Serial Monitor
- Kod kompilerar (mental körning): `setup()` har `Serial.begin(9600);`, `loop()` har `analogRead(A0)`, `Serial.println(ljus)`, `delay(100)`.
- "Förstoringsglaset uppe till höger i Arduino IDE" — korrekt i dagens Arduino IDE 2.x.
- Ingen förbjuden vokabulär.

### Slide 45 — Hitta din tröskel
- Tre övningar matchar precis aktiviteterna i Modul 4 Bygg från minnet (rad 165–169).
- `HIGH → LOW` för tilt stämmer med `INPUT_PULLUP`-konventionen.

### Slide 46 — Koden att köra
- Kodblocket kompilerar med `setup()` tillagt (som sliden uttryckligen refererar till): `Serial.begin(9600)`, `pinMode(2, INPUT_PULLUP)` behövs.
- Kommentaren "Full sketch med `setup()` i kompendiet, kapitel 4" är korrekt — fullständig sketch finns i `04-modul-4.typ:138–148` + modulens "Bygg från minnet".

### Slide 47 — Arduinon känner världen (Modul 4-avslut)
- Tre uppnådda färdigheter listade korrekt: ljus (fotocell), lutning (tilt), titta in (Serial Monitor).
- Hackathon-teaser på plats. Matchar decksspråket.

### Slide 48 — Integration (sektion)
- "Träff 5 av 5", "Modul 5: Hackathon — bygg larmet" — kontinuitet stämmer.
- Layout `section text-center` använt konsekvent med tidigare sektions-slides (2, 8, etc.).

### Slide 49 — Ingenjörsuppgiften
- INPUT → LOGIK → OUTPUT-diagrammet är korrekt mappat: Knapp/LDR/Tilt → Arduino → RGB/Buzzer.
- Reglerna stämmer exakt mot `appendix-d-hackathon-losning.typ:24–27`.
- Ikoner (eye / chip / light+volume) matchar kategorierna semantiskt.

### Slide 50 — Pin-tilldelning
- ALLA pinnumer verifierade mot Appendix D och Modul 5.
- Variabelnamn (knappPin, tiltPin, ldrPin, buzzerPin, ledR/G/B) stämmer.
- Bilaga D-referensen är giltig — bilagan existerar och innehåller komplett startmall med `setup()` + `loop()`.

### Slide 51 — Tack
- "Efter fem träffar" stämmer numeriskt (5 träffar totalt).
- "Ni har byggt ett system som läser av omvärlden och reagerar på den. Grunden i inbyggda system." — saklig och korrekt för det system som faktiskt byggts.
- FRO Ånge · 2026 — matchar slide 1 ("FRO Ånge · 13 april 2026").
- Ingen förbjuden vokabulär.
- Presenter-notes avslutar snyggt; nämner online-resurser (Hackster, Instructables, makerspaces) utan felaktiga referenser.

---

## Verifiering

- Alla 8 PNG inlästa och jämförda mot slide-källan.
- Alla pin-värden och konstanter (`9/2/A0/12/6/5/3`, `300`, `9600`) jämförda mot tre källor: Modul 5, Appendix D, Modul 4.
- Förbjuden-ordlista (`superkraft|magi|hjärn|sinne|röntgen|Lesson|sid\s\d`) sökt genom hela `slides.md` — noll träffar i denna batch.
- Brutna/osäkra referenser: inga — "Bilaga D" och "kapitel 4" är båda giltiga.

**Bedömning:** Batch 6 är **grönt**. Två polish-ändringar (rad 2590 `const int morkTroskel`, rad 2590 kommentar) kan göras på under en minut om man vill, men ingenting blockerar leverans.
