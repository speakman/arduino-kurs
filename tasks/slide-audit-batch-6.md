# Slide-audit batch 6 (slides 46–51)

### Slide 46 — Koden att köra.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Eyebrow "FRI ÖVNING · KODEN" korrekt.
- Kodblocket upptar ~55 % av canvasen vertikalt, läsbart.
- Fotnot "Full sketch med `setup()` i kompendiet, kapitel 4." — intern kursref, OK.
- Stor tom yta längst ned (~25 %).

**Föreslagna fixar:**
- Flytta ned kodblocket eller lägg till `void setup() { … }` ovanför för att slippa fotnoten.

---

### Slide 47 — Arduinon känner världen.
**Verdikt:** 🔴 Fix needed

**Observationer:**
- **FÖRBJUDET ORD:** "hjärna" förekommer i brödtexten — "titta in i Arduinons hjärna via Serial Monitor."
- Center-layout OK. Eyebrow "EFTER TRÄFF 4" korrekt.
- Accentfärger korrekt: "ljus" = cyan, "lutning" = cyan, "titta in" = cyan.

**Föreslagna fixar:**
- Ersätt "hjärna" med neutralt ord: "titta in i Arduinons minne" eller "följa Arduinons utdata via Serial Monitor".

---

### Slide 48 — Träff 5 av 5 — Integration
**Verdikt:** ✅ OK

**Observationer:**
- Section-layout korrekt. Eyebrow "TRÄFF 5 AV 5" korrekt. Cyan accent.

---

### Slide 49 — Ingenjörsuppgiften.
**Verdikt:** ✅ OK

**Observationer:**
- Eyebrow "HACKATHON" korrekt. Cyan accent på "Sätt ihop dem." och "Regler:" — konsekvent.
- INPUT → LOGIK → OUTPUT-flödet balanserat.
- "Ingen manual att kopiera." — bra, explicit anti-manualref.

---

### Slide 50 — Pin-tilldelning (hackathon-startmall)
**Verdikt:** ⚠️ Minor

**Observationer:**
- Tabellen tar bara vänster ~45 % av canvasbredden — höger halva helt tom.
- PIN-värden i cyan — konsekvent.
- `ledR / G / B   6 / 5 / 3` — kolumnalignering tappar, extra whitespace.
- `bool larmPaslaget = false;` — **stavfel:** "Paslaget" borde vara "Påslaget" (saknar å). Om ascii-only föredras i kod, välj t.ex. `larmArmed` konsekvent.
- Fotnot "Bilaga D" är bilagehänvisning, OK.

**Föreslagna fixar:**
- Rätta `larmPaslaget` → `larmPaslagen` med å eller `larmArmed`.
- Sprid tabellen bredare.

---

### Slide 51 — Tack. (slut)
**Verdikt:** ⚠️ Minor

**Observationer:**
- Center-layout välbalanserad.
- Eyebrow "EFTER FEM TRÄFFAR" korrekt.
- "läser av omvärlden" i cyan, "reagerar på den." i cyan — konsekvent.
- Fotnot "FRO Ånge · 2026" — kontrollera stavning av "FRO" (rätt organisation?).
- "Det är grunden i inbyggda / system." — "system." ensam på sista raden (änka).

**Föreslagna fixar:**
- Verifiera "FRO" — korrekt organisationsnamn?
- Justera radbrytning: "Det är grunden i / inbyggda system."
