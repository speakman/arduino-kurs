# Slide-audit batch 3 (slides 19–27)

### Slide 19 — Nästa gång...
**Verdikt:** ⚠️ Minor

**Observationer:**
- Brödtexten bryter på ett olyckligt sätt: "Ni kan tända en lampa i en egen / rytm." — "rytm." hamnar ensam på rad 2 (änka).
- Den röda cirkeln har samma nyans som accent-röd (#ff3366-ish) — men här är rött inte GND/varning, utan en RGB-illustration. Konsekvensregeln om rött = GND/varning bryts visuellt.
- Inga förbjudna ord eller manualrefs.

**Föreslagna fixar:**
- Justera textblockets bredd eller radbrytning så att "rytm." inte är ensam på en rad.
- Rödcirkeln är förmodligen OK i kontext (RGB-demo), men överväg kommentar i källan.

---

### Slide 20 — Träff 2 av 5 — PWM & RGB
**Verdikt:** ✅ OK

**Observationer:**
- Section-layout, eyebrow "TRÄFF 2 AV 5" korrekt. Cyan accent konsekvent.

---

### Slide 21 — Alla färger, av bara tre.
**Verdikt:** ⚠️ Minor

**Observationer:**
- "Katod" är markerat i rött (#ff3366) i pinout-listan — komponentidentifiering, inte GND/varning. Potentiellt inkonsekvent med accent-regeln.
- "GND" i slutet av inforutan är rött — korrekt.
- "miljoner pixlar" och "er egen pixel" är i cyan — konsekvent.

**Föreslagna fixar:**
- Överväg om "Katod" ska vara röd eller neutral/vit bold.

---

### Slide 22 — WiringSlide: RGB-koppling
**Verdikt:** ⚠️ Minor

**Observationer:**
- Kaptionstexten längst ned: "–-skenan" — dubbelt bindestreck `--` i löptext. Ser ut som typo/kodläckage.
- Eyebrow saknar `opacity-50` jämfört med övriga slides.
- Kopplingar stämmer: R→D6, G→D5, B→D3.

**Föreslagna fixar:**
- Fixa `--skenan` → `–skenan` eller `minus-skenan`.
- Lägg till `opacity-50` på eyebrow.

---

### Slide 23 — analogWrite.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Brödtexten bryter olyckligt: "digitalWrite kunde bara två saker: HIGH eller / LOW." — "LOW." ensam på rad 2 (änka).
- `HIGH` i cyan, `LOW` i vit — asymmetri.

**Föreslagna fixar:**
- Justera textbredd så "LOW." inte hamnar ensam.
- Ge HIGH och LOW konsekvent behandling.

---

### Slide 24 — Duty cycle.
**Verdikt:** ⚠️ Minor

**Observationer:**
- PWM-diagrammet sitter långt ut till höger och nedanför mitten — stort tomt utrymme i övre halvan och vänster halva.
- Diagrammet har vit bakgrund mot mörkt slide-tema — sticker ut visuellt.
- "255 → alltid HIGH → full" — "full" avslutar utan substantiv.

**Föreslagna fixar:**
- Flytta diagrammet uppåt eller centrera det vertikalt bredvid bullet-punkterna.
- Ge diagrammet mörk/transparent bakgrund.
- Ändra "full" till "full styrka".

---

### Slide 25 — Hitta färgen.
**Verdikt:** ✅ OK

**Observationer:**
- Eyebrow "ÖVNING" korrekt. Färgrutor illustrerar målfärgerna bra. Inforutan "REGELN" tydlig.

---

### Slide 26 — Ni har en pixel.
**Verdikt:** ✅ OK

**Observationer:**
- Eyebrow "EFTER TRÄFF 2" korrekt. Cyan accent konsekvent.

---

### Slide 27 — Träff 3 av 5 — Digital input
**Verdikt:** ✅ OK

**Observationer:**
- Section-layout identisk med slide 20 — konsekvent.
