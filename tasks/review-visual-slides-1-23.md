# Visuell slides granskning 1–23 — 2026-04-14

## Per slide

### Slide 1 (Cover — Elektronik & Programmering med Arduino)
- Verdict: OK
- Arduino background image renders correctly, title is large and readable, subtitle and footer lines are legible.

### Slide 2 (Kursöversikt — Fem träffar. Fem moduler.)
- Verdict: OK
- Five module cards aligned cleanly, labels and icons readable.

### Slide 3 (Klassrummets viktigaste verktyg)
- Verdict: OK
- Two colored squares, clean layout, good contrast.

### Slide 4 (Modul 1 section divider — LED & krets)
- Verdict: OK
- Centered, clean typography.

### Slide 5 (Dagens upplägg — Idag, två timmar.)
- Verdict: OK
- Four agenda items fit cleanly, no overflow.

### Slide 6 (Slutmålet — Det här ska vi bygga.)
- Verdict: OK
- Simple centered layout, readable.

### Slide 7 (Mikrokontrollern)
- Verdict: OK
- Full-bleed Arduino photo left, text right, good contrast.

### Slide 8 (Spänning, ström, GND)
- Verdict: MINOR
- Ohms law SVG triangle renders correctly and is visible. The etymology footnote is very small (~10–11px equivalent) and may be hard to read from the back of a classroom. Otherwise clean. No dark-on-dark issues.

### Slide 9 (Kretsen — som ett vattensystem)
- Verdict: OK
- Two-column layout, circuit ASCII diagram right side, good contrast. Minnessregel card renders cleanly.

### Slide 10 (LED & resistor)
- Verdict: MINOR
- Resistor color-band legend box at bottom-right is quite small. The `rö d · rö d · brun` formula rendering looks correct but the "rö d" spans have a faint space character visible — appears to be `rö d` (with a gap) rather than `röd`. Could be a font rendering artifact or intentional. Worth checking the source. Everything else clean.

### Slide 11 (Fem hål = en nod — breadboard anatomy)
- Verdict: OK
- Breadboard image renders correctly, annotated with red/blue/green labels, caption text readable. No clipping.

### Slide 12 (Bygg kretsen — step list)
- Verdict: OK
- Numbered steps readable, code tokens highlighted correctly with teal color.

### Slide 13 (Så här ska det se ut — blink wiring)
- Verdict: MINOR
- The wiring diagram shows a `220Ω` label on the resistor in the image. Instruction was that 1K/10K labels should NOT be visible — the `220Ω` label is on the Elegoo diagram itself and is correct for this circuit. However the label is part of the image and is visible. If the intent was "no resistance labels at all," this is still showing one. If 220Ω is acceptable, slide is OK.

### Slide 14 (setup() och loop())
- Verdict: OK
- Code block renders cleanly. Shiki syntax highlighting looks correct. No ligature issues visible for operators.

### Slide 15 (Hela Blink — på tre rader)
- Verdict: OK
- Three command cards with explanations, clean layout. No SOS code visible here — that is on slide 16.

### Slide 16 (Din egen rytm — UPPGIFT)
- Verdict: OK
- SOS pattern `· · · — — — · · ·` visible in bullet list. Right-column code block with SOS function renders correctly. Operators (no `==`/`!=`/`<`/`>` present in this snippet) clean.

### Slide 17 (Delresultat — Ni har byggt en blinkare)
- Verdict: OK
- Centered summary card, good contrast, "KLART" badge renders.

### Slide 18 (Nästa gång…)
- Verdict: OK
- Three colored circle icons, centered text, clean.

### Slide 19 (Modul 2 section divider — PWM & RGB)
- Verdict: OK
- Content is centered on the slide. Title `PWM & RGB` and subtitle are centered. No alignment issues.

### Slide 20 (Alla färger, av bara tre)
- Verdict: MINOR
- RGB Venn diagram renders but the image appears slightly left-of-center (the diagram sits more toward the horizontal center-left while text is below it spanning full width). The "VIKTIGT — RGB-LED:EN" info box at the bottom is readable. The word `Katod` appears in red inline with the pin order — correct. Minor visual imbalance but not broken.

### Slide 21 (Koppla RGB-LED:en)
- Verdict: OK
- Full-width wiring diagram is clean, caption text readable, no clipping.

### Slide 22 (analogWrite)
- Verdict: OK
- PWM waveform image from Elegoo renders on the right. Code block on the left: `analogWrite(ledR, 200)` etc. — operators absent here. Syntax highlighting clean. Caption "PWM vid 5 %, 50 % och 90 % duty cycle — Elegoo Lesson 4, sid 48" is small but legible.

### Slide 23 (Hitta färgen — övning)
- Verdict: OK
- Four color swatches top-right, bullet list with named colors, Regel card at bottom. Clean layout, good contrast.

---

## Code block operator check (slides 14, 15, 16, 22)
No ligature glyphs detected for `==`, `!=`, `<`, `>`. The operator fix appears to have worked — all operators render as plain ASCII characters.

---

## Summary

Total: 23. **Broken: 0. Minor: 4. OK: 19.**

**Top issues:**
1. **Slide 10** — "röd" in resistor legend may render with a visible space (`rö d`) — check source text.
2. **Slide 8** — etymology footnote text very small, borderline readable from distance.
3. **Slide 13** — `220Ω` label visible on wiring image; confirm this is acceptable (it is the correct value for this circuit, but double-check the "no labels" intent).
4. **Slide 20** — RGB Venn diagram slightly left-of-center visually; minor cosmetic imbalance.
