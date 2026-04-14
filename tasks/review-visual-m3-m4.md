# Visuell granskning Modul 3+4 — 2026-04-14

## Modul 3 (8 pages)

### Page 1 — Titel + "Vad du lärde dig idag"
- Verdict: OK
- Clean title page. Module label, h1, teal rule, italic subtitle, bullet list all render correctly. Running head absent (title page — expected). Page number present.

### Page 2 — Repetition / Variabler / PINMODE-magin
- Verdict: MINOR
- Two images at top: left (knapp på breadboard) renders fine; right (active buzzer) has a very dark/nearly black background — detail is barely visible. Captions are small italic and present but the buzzer caption text is tight against the image bottom with minimal breathing room.
- Heading hierarchy OK. Code block renders with teal left accent bar, monospace clean.

### Page 3 — INPUT_PULLUP / Breadboard-foto
- Verdict: MINOR
- Large breadboard photo dominates ~50% of the page. Good quality, caption present. However caption contains bold inline emphasis (`en`) which looks slightly jarring in an otherwise italic caption line.
- "BRYGGA TILL MODUL 4" callout box renders with teal accent and small-caps title — correct. Text in callout is readable.
- Body text above image is only ~4 lines, creating a very short text block before the large image — slightly unbalanced but not broken.

### Page 4 — IF/ELSE syntax + Edge-detection
- Verdict: OK
- Two code blocks: both have teal left bar, clean monospace, no clipping. `EDGE-DETECTION: AGERA PÅ FLANKEN` section heading is clearly differentiated (teal small-caps). Table-style operator reference renders with good alignment. Content is pedagogically strong.

### Page 5 — Debounce / Active buzzer direkt
- Verdict: MINOR
- Image (active buzzer direkt, ingen breadboard) is moderately sized — fine. Caption present and readable.
- `ACTIVE BUZZER — INTE PASSIVE` callout heading renders correctly with small-caps and teal accent.
- Two-column table (Active buzzer / Passive buzzer) has good padding and alignment.
- Minor: `!larmPaslaget` in body text — the `!` prefix runs directly into the variable name without a space; in rendered PDF this could read as a stray character to non-programmers. Consider wrapping in code span.

### Page 6 — "Bygg från minnet" + Hemma-övningar
- Verdict: OK
- Full sketch code block is clean, well-padded, no clipping. `SKELETT` label renders.
- `ÖVNING 1` and `ÖVNING 2` section headings with teal small-caps look good. `TESTA DIG FRAM` callout box renders correctly with teal accent.
- Page well-balanced. Running head + page number consistent.

### Page 7 — Vanliga fel / Snabbreferens
- Verdict: MINOR
- Two-column fault table renders well with clear left-column bold labels. Good padding.
- Snabbreferens code snippets at bottom are clean monospace but use no accent bar — this may be intentional (inline ref style) but inconsistent with body code blocks. Low severity.
- `I BLICKEN` callout at bottom is partially cut — only two lines visible before page ends. Content continues on p-8, which is fine, but the callout box has no bottom border visible — looks clipped rather than intentionally continued.

### Page 8 — Snabbreferens continued + "Inför nästa träff"
- Verdict: MINOR
- Snabbreferens table continues cleanly. Logical operators (`&&`, `||`, etc.) in table are clear.
- `I BLICKEN` callout box top border missing on this page — the continuation has no visual "resumed" indicator. Reader may not realize it's a continuation.
- "Inför nästa träff" closing section reads well. Module preview bullet list is clear.
- Running head + page number consistent.

---

## Modul 4 (8 pages)

### Page 1 — Titel + "Vad du lärde dig idag"
- Verdict: OK
- Clean title layout identical to M3. All elements render correctly. Bullet summary crisp and informative.

### Page 2 — Repetition / Analog vs Digital / Spänningsdelaren
- Verdict: MINOR
- Two images top of page: Fotocell (LDR) left and Tilt-sensor right. Fotocell image is small and relatively low-contrast — the component blends into the white background; caption is present but thin. Tilt-sensor image is sharp and well-sized. Captions both present.
- `SPÄNNINGSDELAREN` section: the rewritten analogy (strypventil/vattenanologi) reads naturally. Good use of bold for key values. No layout issues.
- `VARFÖR JUST 1024 STEG?` callout renders correctly with teal accent.

### Page 3 — Fotocell kopplingschema
- Verdict: MINOR
- Circuit diagram (schematic) renders clearly — Photocell + Fixed Resistor + 5V/GND/A0 labels legible. Caption present.
- `ORDNINGEN SPELAR ROLL` callout has teal accent and renders correctly.
- `TYPISKA A0-VÄRDEN MED 1 KΩ` reference table: column alignment good, bold A0 values readable. Minor: table has no outer border/rule — it sits flush in the text block, making it look like a continuation of the callout rather than a distinct reference. Low severity.
- Page bottom ends mid-section which continues on p-4 — acceptable.

### Page 4 — Fotocell breadboard foto + Tilt-sensor intro
- Verdict: MINOR
- Breadboard photo (fotocell-kretsen) is large, good quality. RGB LEDs visible in background. Caption present and accurate.
- `TILT-SENSORN` section heading with teal small-caps renders correctly.
- Good text-image balance. Running head consistent.

### Page 5 — Tilt-sensor koppling / Serial Monitor intro
- Verdict: MINOR
- Tilt-sensor breadboard photo: the wiring is minimal (two wires visible) which is correct, but the image is quite small relative to the page — the sensor itself is barely distinguishable. Caption present. Consider slightly larger image or a close-up inset.
- Code block (Serial Monitor sketch) has teal left bar, clean. Inline comments align well.
- `Förslösingsglasögon` icon reference for Serial Monitor is a nice touch — renders as text reference, no visual icon present (may be intentional).

### Page 6 — Serial Monitor code / "Bygg från minnet"
- Verdict: OK
- Continued code block at top is clean. `KÄLLA DET ARDUINOS TANKAR` callout renders with teal accent and small-caps. Good padding.
- "Bygg från minnet" section with numbered list renders cleanly. `ÖVNING 1 — STÄMNINGSLAMPA` with `STRUKTUR` code block renders correctly, teal bar present.
- Page well-balanced.

### Page 7 — Hemma-övningar / Vanliga fel / Snabbreferens
- Verdict: OK
- `ÖVNING 2` and `ÖVNING 3` headings render correctly. Code snippets within exercises are clean.
- Two-column fault table: good padding, bold left column, descriptive right column. `map()` function reference in table is clear.
- Snabbreferens at bottom: no accent bar on these code snippets (same issue as M3 p-7, likely intentional style).

### Page 8 — Snabbreferens continued + "Inför nästa träff"
- Verdict: OK
- Snabbreferens table rows clean. Tilt-sensor row with `D2 + GND, INPUT_PULLUP` is accurate.
- `I BLICKEN` callout renders fully on this page — no clipping issue (unlike M3). Good.
- "Inför nästa träff" preview clear. Module names ("hackathon", "Spänningsdelare din digital") readable.
- Running head + page number consistent throughout module.

---

## Summary

- **Broken:** 0
- **Minor:** 11
- **OK:** 5

### Top 5 issues to fix

1. **M3 p-2 — Dark buzzer photo**: Active buzzer image is near-black, detail lost. Replace with better-lit photo or increase image brightness.
2. **M3 p-7/p-8 — Split callout box**: `I BLICKEN` callout starts at bottom of p-7 and continues to p-8 with no visual continuation cue. Add a bottom-open/top-open border style or move the callout to avoid the split.
3. **M4 p-2 — Fotocell image low contrast**: LDR component blends into white background. Use a slightly warmer/grey background swatch or a more contrasting photo.
4. **M4 p-5 — Tilt-sensor image too small**: Sensor component is hard to identify at current scale. Increase image size or add a close-up inset.
5. **M3 p-3 — Very short text block before large image**: Only ~4 body lines before the full-width breadboard photo. Consider moving the callout box above the image or restructuring paragraph breaks to better balance the page.
