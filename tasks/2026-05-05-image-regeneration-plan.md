# Image Regeneration Plan — 2026-05-05

## Mål
Ersätt 13 bilder i `presentation/public/images/` med konsekvent stil via Higgsfield Generate (`gpt_image_2`). Fritzing-bilderna (button/buzzer/led/rgb-fritzing.png, photocell-schematic.png) **behålls intakt** — de är tekniskt korrekta TinkerCAD-screenshots och får bara ev. bg-removal som separat scope (B) senare.

## Stil-baseline (validerad mot Arduino UNO test, godkänd 2026-05-05)
- Premium photorealistic 3D product render
- Three-quarter elevated angle
- Soft ambient grounding shadow under subject
- Off-white `#fafaf7` background (matchar deck `--ak-bg`)
- Studio-grade lighting from above-left
- NOT cartoon, NOT childish, NOT toy-like
- Refined editorial aesthetic

## Gemensam prompt-prefix
> Premium photorealistic 3D product render. Three-quarter elevated angle. Refined modern aesthetic, NOT cartoon, NOT childish, NOT toy-like. Studio-grade lighting from above-left with soft ambient grounding shadow beneath the subject. Background: solid warm off-white #fafaf7 only, no other colors or scenery. Composition: centered with generous margins, clean editorial framing. Quality: ultra-high detail, sharp focus, premium product visualization for a technical electronics course.

## Per-bild promptar

### Batch 1 — Komponenter (5)

| # | Filnamn | AR | Slide | Status |
|---|---------|-----|-------|--------|
| 1 | `cover-arduino-hero.jpg` | 16:9 | 1 (cover) | ✅ done (v2 vald) |
| 2 | `arduino-uno-hero.jpg` | 1:1 | 14 | ✅ done |
| 3 | `active-buzzer-sticker.jpg` | 1:1 | 33 | ✅ done |
| 4 | `photoresistor-macro.jpg` | 1:1 | 39 | ✅ done |
| 5 | `photoresistors-three.jpg` | 4:3 | 41 | ✅ done |

**#1 cover-arduino-hero.jpg:** [prefix] Subject: An Arduino UNO Rev3 microcontroller board as the central subject, hero composition. Cinematic depth slightly more dramatic than catalog shot. Surrounded by complementary electronic elements at varying depths: a few resistors with color bands, one small LED diode, 2-3 elegantly draped jumper wires in classic teal/red/yellow. Mood: invites curiosity, beginning a journey into electronics. Wide cinematic 16:9 framing, generous breathing room.

**#3 active-buzzer-sticker.jpg:** [prefix] Subject: A small blue cylindrical active piezo buzzer component, approximately 12mm diameter, with the typical yellow paper sticker on top showing the + polarity symbol clearly visible. Two thin metal pins extending from the bottom. Standalone close-up product shot, no other components.

**#4 photoresistor-macro.jpg:** [prefix] Subject: An extreme macro close-up of a single photoresistor / LDR / light-dependent-resistor — round 5mm disc with the distinctive serpentine cadmium-sulfide track winding across the top surface, two long thin tinned-copper leads extending downward. Shallow depth-of-field hint, razor-sharp focus on the sensor surface.

**#5 photoresistors-three.jpg:** [prefix] Subject: Three identical photoresistor components (CdS LDR with serpentine track and two leads each) arranged in a slight diagonal row composition, equal spacing, slightly varying tilt angles for visual rhythm. 4:3 horizontal framing.

### Batch 2 — Diagram (5)

| # | Filnamn | AR | Slide | Status |
|---|---------|-----|-------|--------|
| 6 | `voltage-divider.png` (replaces .svg) | 1:1 | 39-40 | ✅ done |
| 7 | `pwm-waveform.png` | 16:9 | 24 | ✅ done (continuous square-wave) |
| 8 | `rgb-color-mixing.png` | 1:1 | 21 | ✅ done (special: dark bg by design) |
| 9 | `breadboard-internals.png` | 16:9 | 11 | ✅ done |
| 10 | `ohms-law.png` (replaces .jpg cartoon) | 1:1 | 8 | ✅ done |

**#6 voltage-divider.png:** [prefix] Subject: A 3D pedagogical schematic illustration of a voltage divider circuit — two stylized cylindrical resistors with color bands stacked vertically between a small battery icon at top and ground symbol at bottom. A probe arrow at the midpoint between the resistors points to a label "Vout". For the photoresistor variant: top resistor is a photoresistor (light-sensitive disc) with a small soft sun icon (#ffd400 yellow) gently illuminating it from above. Arduino-teal accent (#00747d) for active circuit highlights.

**#7 pwm-waveform.png:** [prefix] Subject: A 3D illustration of pulse-width modulation — a square-wave digital signal rendered as crisp 3D extruded rectangular blocks rising to HIGH and falling to LOW levels, showing duty cycle clearly. Below or alongside: a softer smooth sine-like curve representing perceived analog brightness. X-axis labeled "Time" subtly, Y-axis labeled "Voltage" subtly. Arduino-teal accent for active signal. 16:9 wide composition.

**#8 rgb-color-mixing.png:** [prefix-DARK-VARIANT] Subject: 3D representation of additive RGB color mixing — three luminous glowing spheres in pure red (#ff1744), pure green (#00e676), pure blue (#2979ff), arranged in classic Venn-diagram three-circle overlap. Where any two overlap: yellow, cyan, magenta. Where all three overlap in the center: pure white. Soft realistic bloom and light emission. **Background for THIS image only: solid near-black #0a0e14 — pedagogical metaphor of light emerging in darkness, NOT off-white.** Other rules same as prefix.

**#9 breadboard-internals.png:** [prefix] Subject: A 3D cutaway view of a solderless breadboard. Top half shows the standard breadboard surface with terminal strip holes and power rail holes. The right half is "peeled away" or transparent to expose the internal metal clip-strips beneath: showing how 5 adjacent holes share one metal connector strip, and how the long power rails run continuously. Educational annotation feel. 16:9 wide composition.

**#10 ohms-law.png:** [prefix] Subject: A refined editorial 3D visualization of Ohm's law (V = I × R) — three connected stylized 3D elements representing Voltage (V, blue glass cylinder), Current (I, flowing yellow streak), Resistance (R, red constricted cylinder), arranged in a clean triangle composition with the formula "V = I × R" subtly typeset below. Premium technical-textbook aesthetic.

### Batch 3 — Wiring-foton (3)

| # | Filnamn | AR | Slide | Status |
|---|---------|-----|-------|--------|
| 11 | `wiring/button-photo.png` | 4:3 | 28 | ✅ done |
| 12 | `wiring/buzzer-photo.png` | 4:3 | 33 | ✅ done |
| 13 | `wiring/tilt-photo.png` | 4:3 | 35-37 | ✅ done |

**#11 button-photo.png:** [prefix] Subject: A solderless breadboard photographed from a slight three-quarter elevated angle, with a 4-pin tactile push button inserted near the middle straddling the center gap. Two jumper wires connect: a red wire from one side of the button up to the + power rail, a black wire from the other side down to the GND rail. One additional jumper goes to a digital pin position. Realistic component placement and wire routing. Clean educational composition.

**#12 buzzer-photo.png:** [prefix] Subject: A solderless breadboard from three-quarter elevated angle, with a small blue cylindrical piezo active buzzer (12mm) inserted into the breadboard mid-section. A red jumper wire connects the + pin to the power rail, a black jumper from − pin to GND, plus one signal wire to a digital pin position. Clean educational layout.

**#13 tilt-photo.png:** [prefix] Subject: A solderless breadboard from three-quarter elevated angle, with a tilt-switch component (small cylindrical metal body, two leads) inserted on its side into the breadboard. Two jumper wires: one to a digital pin, one to GND. Clean educational composition.

## Exekvering
1. Batch 1 — komponenter (cover först, sedan resterande 3 sekventiellt)
2. Batch 2 — diagram (5 sekventiellt; #8 dark bg-special)
3. Batch 3 — wiring (3 sekventiellt)
4. Alla resultat sparas i `tasks/image-gen/v1/<filename>.png`
5. Visuell granskning genom Read tool på varje
6. Vid behov: re-prompt och re-generate
7. Backup originalbilder → `tasks/image-gen/originals/`
8. Atomic commit per bild-byte i `slides.md`
9. CSS-städning: ta bort `.rgb-demo` black-bg-frame om #8 redan har dark bg inbakad, ta bort `.diagram-img` om inte längre behövs, etc.
10. `npm run build` smoke-test
11. `npm run export -- --format png --output ../tasks/light-mode-rendered/`
12. `npm run export -- --output ../tasks/light-mode-rendered/slides-light.pdf`
13. Multi-auditor-review (Claude opus × 2 — routine gate, inte security/payments)

## Out-of-scope (denna runda)
- Fritzing-PNG:er (button/buzzer/led/rgb-fritzing.png, photocell-schematic.png) — bevaras intakt; bg-removal är scope B
- 6 orphaned bilder (tilt-switch.jpg, breadboard-rails.png, resistor-color-chart.png, photocell-wiring.png, rgb-photo.png, tilt-schematic.png) — separat städ-task
- Kompendium-bilder (kompendium/-mappen)

## Post-merge follow-ups (skapade av multi-auditor-review 2026-05-05)
- **Per-dag-PDF:er**: `kompendium/deliveries/slides-per-dag/slides-dag-{1..5}.pdf` (28 apr) är stale — slide-content ändrats (image-swaps på 8/11/14/21/24/28/33/35-37/39-40/41 + direktiv-cleanup på 12/25). Re-generera innan nästa kurs-leverans.
- **Originals-backup-ordning**: nästa runda — gör `docs(tasks): backup originals` commit FÖRE `feat(images): regenerate` så original alltid finns i tracked tree innan delete.

## Credits-bedömning
- 13 generations × ~5-15 credits/st = ~65-200 credits
- Buffer för re-runs: ~50 credits
- Total estimat: ~150-250 av 908 tillgängliga
