# Visuell slides granskning 24–46 — 2026-04-14

## Per slide

### Slide 24 (Ni har en pixel — delresultat)
- Verdict: OK
- Clean summary slide, text and circles render well, no overflow.

### Slide 25 (Digital input — Modul 3 section divider)
- Verdict: OK
- Centered, icon clear, subtitle readable.

### Slide 26 (const int och int)
- Verdict: MINOR
- Code block on the right is left-aligned within its column — correct per spec.
- The word `const` in the main body text appears slightly close to the left bullet border but is not clipped.
- One minor issue: `larePaslaget` in the code block (right column) appears to have a lowercase `l` where `larmPaslaget` is expected — possible typo in variable name visible to students.

### Slide 27 (Input ≠ Output)
- Verdict: OK
- Code block is centered inside a max-width wrapper. `INPUT_PULLUP` keyword renders correctly. No overflow.

### Slide 28 (if/else — CRITICAL ligature check)
- Verdict: OK
- `==` in the VANLIGASTE NYBÖRJARFELET box renders as two distinct `=` ASCII characters, NOT as a ligature. `!=` in the bullet `!=` also renders correctly as distinct `!` and `=`. The ligature fix is confirmed working.
- Code block on the right: `== LOW` and `!larmPaslaget` render as plain ASCII. No ligature glyphs visible.

### Slide 29 (Koppla knappen — button wiring)
- Verdict: OK
- Breadboard image is clear, pin labels legible. Caption text fits on one line without clipping.

### Slide 30 (Reagera på flanken — edge detection)
- Verdict: OK
- Code block is readable. `== LOW` and `== HIGH` both show as ASCII (no ligatures). `lastState` and `larmPaslaget` variable names visible and consistent. No overflow.

### Slide 31 (En varning först — buzzer sticker)
- Verdict: MINOR
- Photo renders well, passive/active labels are legible.
- The caption "Active buzzer - sticker stannar" at bottom-right is very small and low-contrast (light grey on dark background) — may be hard to read from a distance in a classroom.

### Slide 32 (Koppla buzzern)
- Verdict: OK
- Image centered and clear. Caption fits without overflow.

### Slide 33 (Läs knapp. Styr buzzer)
- Verdict: OK
- Code block on right is readable. `== LOW` renders as ASCII. Layout balanced, no overflow.

### Slide 34 (Arduinon lyssnar — delresultat)
- Verdict: OK
- Clean summary text, centered, no issues.

### Slide 35 (Analog input — Modul 4 section divider)
- Verdict: OK
- Centered layout. Icon and title look good.

### Slide 36 (Knappen var digital. Världen är analog.)
- Verdict: OK
- Fotocell component image is crisp. Text columns balanced. `analogRead(A0)` code snippet renders cleanly.

### Slide 37 (Spänningsdelaren)
- Verdict: MINOR
- HTML schematic on the right is clear and well-labelled (+5V, fotocell, A0, 1 kΩ, GND).
- The main text body on the left is dense; the last bullet point beginning "Fotocellen är det övre motstånd..." is cut off — the sentence ends with "→ AG sjunker. Ljuset → litet motstånd →" and the continuation is not visible. Text overflow on left column.

### Slide 38 (Koppla fotocellen — wiring diagram)
- Verdict: OK
- Circuit schematic is clean and legible. Labels "Fotocell", "1 kΩ", "5V", "A0", "GND" all present and readable. Caption fits on one line.

### Slide 39 (Koppla tilt-sensorn)
- Verdict: OK
- Elegoo board image is clear. DuPont cable caption fits without overflow.

### Slide 40 (Serial Monitor)
- Verdict: MINOR
- Code block on the right: `Serial.begin(9600)` and `Serial.println(ljus)` lines render at normal brightness. However, `delay(100)` and the closing brace `}` appear slightly dimmer than surrounding lines — possible syntax-highlighting dim on "less important" lines, but could confuse students about whether those lines are active code. Worth checking if dimming is intentional.

### Slide 41 (Hitta din tröskel)
- Verdict: OK
- Code block on right is fully bright and legible. Layout balanced, no overflow.

### Slide 42 (Arduinon känner världen — delresultat)
- Verdict: OK
- Clean summary, inline highlights for "ljus", "lutning", "titta in" are readable.

### Slide 43 (Integration — Modul 5 section divider)
- Verdict: OK
- Centered, icon and title crisp.

### Slide 44 (Ingenjörsuppgiften)
- Verdict: OK
- INPUT / LOGIK / OUTPUT icons are centered above their respective labels. Arrows between them are clear. Rule text at the bottom fits on one line without wrapping.

### Slide 45 (Pin-tilldelning)
- Verdict: MINOR
- Both code blocks render and fit within their columns.
- Right column: `loop()` function body contains comment lines `// 2. Flank → toggla larm` and `// (se Modul 3)` — these are intentional pseudocode comments and look fine pedagogically, but `// 3. Bestäm utfall:` and the lines below appear in a slightly dimmer shade compared to the `void` declarations above. Same potential dimming issue as slide 40.
- No overflow; both columns fit cleanly.

### Slide 46 (Tack)
- Verdict: OK
- Clean, minimal ending slide. "FRÖ Änge · 2026" footer is readable. No issues.

---

## Summary

**No BROKEN slides.** All 23 slides (24–46) are presentable.

**Ligature fix confirmed**: `==` and `!=` render as plain ASCII throughout slides 28, 30, and 33 — the fix is working.

**Issues requiring attention (4 MINOR):**

1. **Slide 26** — Variable name `larePaslaget` in right code block may be a typo (missing `m`); check source.
2. **Slide 31** — Bottom-right caption is very small and low-contrast; consider increasing size or removing it.
3. **Slide 37** — Left-column text overflows: the last sentence about Fotocell is cut off mid-phrase.
4. **Slides 40 & 45** — `delay()` and comment lines render slightly dimmed in code blocks; verify this is intentional syntax-highlighting behavior and not an artifact of the ligature/font fix.
