# Slide-audit batch 4 (slides 28–36)

### Slide 28 — const int och int.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Stort tomt utrymme i nedre halvan (~40 %) — innehållet topptungt.
- Fotnoten refererar till "Bilaga A" i kompendiet — intern kursref, OK.

**Föreslagna fixar:**
- Flytta innehållet vertikalt mot mitten.

---

### Slide 29 — Input ≠ Output.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Statement-layout fungerar, nedre ~35 % är tomt.
- Warn-boxen "VARFÖR PULLUP?" har cyan vänsterkant — konsekvent.

---

### Slide 30 — if / else.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Nedre ~40 % av canvasen tom — samma mönster.
- Fotnoten innehåller "kompendiets Bilaga A" — OK.

---

### Slide 31 — WiringSlide: knapp-koppling
**Verdikt:** ⚠️ Minor

**Observationer:**
- Arduino-kortets USB-del sticker ut utanför den vita rutan mot den mörka bakgrunden — slarvigt.
- Breadboard-diagrammet visar **två knappar** sida vid sida. Om kursen bara kräver en knapp kan detta förvirra.
- "GND" i bildtexten utan röd färg (slide 34 har röd GND).

**Föreslagna fixar:**
- Beskär/zooma diagrammet så USB inte sticker ut.
- Om bara en knapp används, byt till diagram med en knapp.
- Gör "GND" i bildtexten röd för att matcha slide 34.

---

### Slide 32 — Reagera på flanken.
**Verdikt:** ✅ OK

**Observationer:**
- Two-cols-header bra balans. Eyebrow "PEDAGOGISKT KRITISK" korrekt.
- "studs" introduceras utan förklaring men acceptabelt i kontext.

---

### Slide 33 — En varning först. (buzzer-klisterlappen)
**Verdikt:** ⚠️ Minor

**Observationer:**
- Warn-boxens text `"Remove after washing"` — klisterlappens faktiska text är "REMOVE SEAL AFTER WASHING" (syns på slide 34). Faktaavvikelse.
- "passive"/"active"-etiketter på fotografiet i vit text mot ljus bakgrund — låg kontrast.
- Nedre ~30 % av canvasen tom.

**Föreslagna fixar:**
- Ändra `"Remove after washing"` till `"REMOVE SEAL AFTER WASHING"`.
- Förbättra kontrast på etiketterna i fotografiet.

---

### Slide 34 — WiringSlide: buzzer-koppling
**Verdikt:** ⚠️ Minor

**Observationer:**
- Diagrammet är avsevärt mindre än slide 31 — inkonsekvent storlek.
- Arduino-kortets USB-del sticker ut utanför vita rutan (samma problem).
- Bildtextens "GND" är röd — konsekvent med färgkonventionen.

**Föreslagna fixar:**
- Skala upp diagrammet för att matcha slide 31.
- Beskär USB-delen.

---

### Slide 35 — Läs knapp. Styr buzzer.
**Verdikt:** ✅ OK

**Observationer:**
- Center-layout. Luftig, tydlig. `if`/`else` i cyan — konsekvent.

---

### Slide 36 — Kärnan i loop().
**Verdikt:** ⚠️ Minor

**Observationer:**
- Nedre ~35 % av canvasen tom.
- Dubbel eyebrow "SÄTT IHOP ALLT · KÄRNAN I LOOP()" avviker från single-label eyebrows på slides 28, 32.
- Fotnot: "Ingen tone() behövs." — `tone()` introduceras utan förklaring som något man *inte* behöver, orphaned begrepp.

**Föreslagna fixar:**
- Bestäm konvention för single vs. dubbel eyebrow.
- Kort parentes om `tone()`: "Ingen `tone()` (ton med frekvens) behövs."
