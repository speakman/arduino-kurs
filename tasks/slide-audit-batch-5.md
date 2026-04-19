# Slide-audit batch 5 (slides 37–45)

### Slide 37 — Arduinon lyssnar.
**Verdikt:** 🔴 Fix needed

**Observationer:**
- **FÖRBJUDET ORD:** "sinnesorgan" visas i cyan som accentord ("Arduinons första **sinnesorgan**"). "sinnen" är i förbjudna ord-listan; "sinnesorgan" är derivat.
- Layout i övrigt OK — center-layout.
- Accent-cyan används korrekt.

**Föreslagna fixar:**
- Byt "sinnesorgan" mot neutralt ord: "sensor" eller "ingång".

---

### Slide 38 — Träff 4 av 5 — Analog input
**Verdikt:** ✅ OK

**Observationer:**
- Section-layout, eyebrow korrekt. Cyan accent konsekvent.

---

### Slide 39 — Knappen var digital. Världen är analog.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Högerkolumnens text centrerat i mitten — stort tomt utrymme under caption-texten. Balans mot fotots höjd ojämn.
- "halvmörkt" är OK på svenska. Cyan värde "0–1023" korrekt.

**Föreslagna fixar:**
- Flytta högerkolumn till topp-alignment.

---

### Slide 40 — analogRead() — Arduinons linjal.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Stort tomt utrymme i nedre ~35 %.
- "GÖR DETTA NU"-boxen korrekt accentuerad.
- Eyebrow "NYTT KOMMANDO" korrekt.

**Föreslagna fixar:**
- Flytta innehållsblocket nedåt eller lägg till material.

---

### Slide 41 — Spänningsdelaren.
**Verdikt:** ⚠️ Minor

**Observationer:**
- SVG-diagram renderar väl; GND i rött, +5V i cyan — korrekt.
- Dubbel eyebrow "NYTT KONCEPT · FRÅN MOTSTÅND TILL MÄTVÄRDE" — längre än standard.
- "TYPISKA VÄRDEN"-kolumnen: "Lampa nära500-700" — mellanrum saknas mellan label och värde. **Typografiskt fel.**
- Vänstertext tät men rinner inte utanför.

**Föreslagna fixar:**
- Lägg till mellanslag/padding mellan label och värde i TYPISKA VÄRDEN.
- Korta eyebrow till "NYTT KONCEPT".

---

### Slide 42 — WiringSlide: fotocell-koppling
**Verdikt:** ✅ OK

**Observationer:**
- Diagram renderar korrekt. Labels läsbara.

---

### Slide 43 — WiringSlide: tilt-sensor-koppling
**Verdikt:** 🔴 Fix needed

**Observationer:**
- Foto-bild inte vertikalt centrerad — ~100 px tomrum ovanför, bilden klipper nästan i nederkanten. Asymmetrisk placering ser ut som layout-bug.
- Eyebrow och titel konsekventa med slide 42.
- Bilden visar två kablar till Arduino, ingen breadboard — korrekt.

**Föreslagna fixar:**
- Justera bildens `max-height` eller `object-fit: contain` med symmetriska marginaler.

---

### Slide 44 — Serial Monitor.
**Verdikt:** ⚠️ Minor

**Observationer:**
- "Öppna `förstoringsglaset` uppe till höger i Arduino IDE" — informell synekdoke. Arduino IDE 2.x har annan ikon, kan förvirra.
- Stor tom yta i nedre ~40 %.
- Cyan USB korrekt.

**Föreslagna fixar:**
- Beskriv Serial Monitor-ikonen mer precist.

---

### Slide 45 — Hitta din tröskel.
**Verdikt:** 🔴 Fix needed

**Observationer:**
- Sista bullet: "Håll tilt-sensorn upprätt, sen lutad — HIGH →" på rad 1, "LOW?" ensam på rad 2. Ser ut som eget stycke skilt från bulleten — förvirrande.
- HIGH/LOW saknar monospace/cyan-styling konsekvent med övriga slides.

**Föreslagna fixar:**
- Bryt om bullet 3 så "HIGH → LOW?" håller ihop på en rad.
- Ge HIGH/LOW monospace-styling.
