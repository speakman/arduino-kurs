# ELEGOO UNO Project Basic Starter Kit — Research

Source of truth for component list and tutorial page numbers:
**Elegoo "The Basic Starter Kit Tutorial for UNO", V1.0.19.7.24** (official PDF,
83 pages). Downloaded from Amazon CDN: `https://m.media-amazon.com/images/I/C181Jog2UuL.pdf`
(this is the current version linked from Elegoo's official download center and
Amazon listing for the Basic kit as of 2025–2026).

Kit product page: https://www.elegoo.com/products/elegoo-uno-basic-starter-kit
(SKU SPUK-EL-KIT-004, $19.99 USD). Amazon listing:
https://www.amazon.com/ELEGOO-Starter-Tutorial-Compatible-Official/dp/B01DGD2GAO

> Note: The **Basic** kit is the smallest of Elegoo's three Arduino starter kits.
> Most online content describes the larger **Super** and **Most Complete** kits,
> which include many components the Basic kit does NOT have (LCD, servo, stepper,
> ultrasonic, DHT11, potentiometer, joystick, keypad, IR remote, etc.). Double
> check component names against the list below — do not assume.

---

## 1. Kit contents (confirmed, from the official PDF "Packing List" page)

Exact list, exactly as Elegoo specifies in the V1.0.19.7.24 tutorial packing list:

| Component | Qty | Notes |
|---|---|---|
| **Elegoo UNO R3** | 1 | Arduino-compatible clone. Blue PCB, Elegoo silkscreen. Uses the **genuine ATmega16U2** USB-to-serial chip (NOT the CH340 found on cheap clones), so **drivers work out of the box** on macOS/Windows/Linux. |
| **USB cable** | 1 | Bundled with the UNO. Type A (computer) to Type B (printer-style, the square-ish connector on the UNO). Typically blue transparent jacket to match the board. |
| **Breadboard** | 1 | **830 tie-points, MB-102 style**. Standard full-size solderless breadboard with red and blue power rails down both long sides. Confirmed by Lesson 3 ("BREADBOARD MB-102"). |
| **Breadboard jumper wires** | 65 | Rainbow set of pre-formed, stiff, color-coded M–M wires of various lengths. (These are the short stiff wires, NOT the long flexible DuPont wires.) |
| **F-M DuPont wires** | 5 | Flexible female-to-male jumper wires. Used for tilt switch + buzzer (see Lessons 6 & 7). |
| **LEDs (5 mm assorted colors)** | **30** | Red, yellow, green, blue. Colors are mixed — the kit does not specify quantities per color. Standard polarity: **longer lead = anode (+), shorter lead with flat on plastic rim = cathode (−)**. |
| **RGB LED** | 2 | **Common cathode** (confirmed by tutorial Lesson 4, page 46). 4 leads. Pin order from flat-side reference: Red, Cathode, Green, Blue. **The cathode is the longest pin** AND is the second pin from the flat side of the LED housing — NOT the center pin in the usual sense. Two separate anode leads flank it. See "Gotchas" below — this is often misremembered. |
| **Resistors** | 120 | Assorted 1/4 W through-hole with color-coded bands. Lesson 3 uses 220 Ω, 1 kΩ, 10 kΩ; Lesson 4 uses 220 Ω × 3; Lesson 10 (photocell) uses 1 kΩ; Lesson 8 (74HC595) uses 220 Ω × 8. Confirm values in the kit via the band colors or a multimeter. |
| **Button (Small, tactile)** | 5 | Standard 4-pin 6×6 mm tactile switches. Pins B–C are internally connected, A–D are internally connected (see PDF p. 53). |
| **Active buzzer** | 1 | The small black cylindrical buzzer with a white sticker reading **"REMOVE SEAL AFTER WASHING"** and a **+** symbol showing the longer positive lead. DC-driven, built-in oscillator. **This is the active buzzer, not passive** — the Basic kit does NOT include a passive buzzer. |
| **Photoresistor (photocell / LDR)** | 1 | Round disc, ~5 mm diameter, with characteristic gold "snake-eye" CdS zigzag pattern on top. ~50 kΩ dark, ~500 Ω in bright light. |
| **Tilt ball switch** | 1 | Small black cylindrical metal can with two leads. Conductive ball inside closes circuit when tilted. Labeled "HDX" on the PDF photo. |
| **74HC595 IC** | 1 | 16-pin DIP shift register (used in Lesson 8 for driving 8 LEDs with 3 pins). Bonus chip — this is the ONLY IC in the Basic kit. |

**Things NOT in the Basic kit** (but commonly assumed because they are in the
Super / Most Complete versions — do not reference them in the course):
servo motor, stepper motor, ULN2003 driver, LCD1602 display, potentiometer,
rotary encoder, joystick, keypad, 7-segment display, DHT11, ultrasonic sensor,
IR receiver, passive buzzer, thermistor, power supply module, 9 V battery clip,
relay, PIR sensor, transistors, diodes, capacitors.

---

## 2. Component image URLs

All Wikimedia Commons links are direct `upload.wikimedia.org` URLs (not gallery
pages) and are usable in a Slidev dark-theme presentation. Licenses are listed —
CC0 and public-domain images need no attribution; CC BY / CC BY-SA need credit.

| # | Component | Direct URL | Source | License | Dims | Description |
|---|---|---|---|---|---|---|
| 1 | **Arduino UNO R3 (studio shot, ATmega328P visible)** | https://upload.wikimedia.org/wikipedia/commons/2/2f/Arduino_Uno_Rev3_with_Atmega328P.jpg | Wikimedia Commons (HonCode) | **CC0 / Public Domain** | 4000×3000 | Clean studio photo of genuine UNO R3 on white. Best hero shot; public domain means no attribution needed. |
| 2 | **Arduino UNO R3 (alternate dev-board shot)** | https://upload.wikimedia.org/wikipedia/commons/5/56/Arduino_Uno_R3_development_board_(1).jpg | Wikimedia Commons (Suyash Dwivedi, 2025) | CC BY-SA 4.0 | 3195×2130 | Modern high-res photo of genuine UNO R3. Good angle showing header pins and USB port. Requires attribution. |
| 3 | **Arduino UNO R3 (classic 2013 photo)** | https://upload.wikimedia.org/wikipedia/commons/c/ce/Arduino_Uno_R3.JPG | Wikimedia Commons (Mr Revolution) | CC BY 3.0 | 3648×2736 | The canonical Wikipedia Arduino photo — instantly recognizable blue PCB. Requires attribution. |
| 4 | **Breadboard (400-point, top+bottom view showing rails)** | https://upload.wikimedia.org/wikipedia/commons/e/e8/Breadboard.png | Wikimedia Commons (Guhuru) | **CC0 / Public Domain** | 1479×1089 | Clean white-background shot of a solderless breadboard top and bottom. Good for the "how rails work" slide. Note: it's a 400-point, not 830 — use for structural explanation, not for showing the actual kit item. |
| 5 | **Breadboard (full breadboard with components, for context)** | https://upload.wikimedia.org/wikipedia/commons/5/52/Breadboard.JPG | Wikimedia Commons (LukeSurl et al) | CC BY-SA 3.0 + GFDL | 573×660 | Populated breadboard shot. Lower resolution — secondary option. |
| 6 | **Red 5 mm LED with leads (polarity visible)** | — | Elegoo Basic Kit PDF page 38 | Elegoo (use under fair use / as citation to the kit's own manual) | ~400×400 | Clear isolated shot of a red 5 mm LED with `+` (long lead) and `−` (short lead, flat side) labeled. This is the single best image for teaching polarity since it's in the student's own manual. Extract from PDF page 38. |
| 7 | **Red LED illuminated macro (alternative)** | https://upload.wikimedia.org/wikipedia/commons/thumb/f/f4/Red_LED_macro.jpg/1280px-Red_LED_macro.jpg | Wikimedia Commons (if available — verify) | CC BY-SA | varies | Fallback. If not verifiable, use PDF p. 38. |
| 8 | **RGB LED (common cathode) with 4 leads labeled** | — | Elegoo Basic Kit PDF page 45 | Elegoo | ~500×500 | Screenshot from the kit's own tutorial labeling BLUE / GREEN / CATHODE / RED pins. Use this — it matches what the student physically has and is the exact image the course outline refers to. |
| 9 | **Active buzzer with "REMOVE SEAL AFTER WASHING" sticker** | — | Elegoo Basic Kit PDF page 58 | Elegoo | ~400×400 | Isolated white-background shot showing the sticker. **This is the critical image for the warning slide** — it is literally the buzzer the student is holding, sticker and all. |
| 10 | **Photoresistor (three sizes, mm scale)** | https://upload.wikimedia.org/wikipedia/commons/9/9a/Photoresistors_-_three_sizes_-_mm_scale.jpg | Wikimedia Commons (Junkyardsparkle) | **CC0 / Public Domain** | 2400×1350 | Three photoresistors with scale bar — classic gold "snake-eye" look, clean white background, no attribution required. |
| 11 | **Photoresistor (single, orange background)** | https://upload.wikimedia.org/wikipedia/commons/2/2e/Photoresistor_with_orange_background-7536.jpg | Wikimedia Commons (Raimond Spekking) | CC BY-SA 4.0 | 3657×2743 | Single LDR, extreme macro, Canon 5D Mark IV 100 mm. Highest quality available. |
| 12 | **Tilt ball switch (HDX labeled)** | — | Elegoo Basic Kit PDF page 62 | Elegoo | ~300×400 | No free Wikimedia photo of the small hobbyist ball tilt switch exists. The Elegoo PDF photo is the one the student recognizes. |
| 13 | **Active buzzer (alternate generic)** | https://upload.wikimedia.org/wikipedia/commons/4/4f/KS-3206_6VDC_Electronic_Buzzer.jpg | Wikimedia Commons (Nvtj) | CC BY-SA 3.0 | 1824×1368 | Generic DC electronic buzzer. Missing the "REMOVE SEAL" sticker — only use as backup or for "what is a buzzer" generic slide. |
| 14 | **Arduino UNO project on a desk** (Unsplash, dark/moody) | https://unsplash.com/photos/blue-and-black-circuit-board-f2S93diaVn0 (page) — photographer: Harrison Broadbent | Unsplash (Harrison Broadbent) | **Unsplash License** (free commercial, attribution appreciated not required) | varies | Atmospheric "hero" shot for a title slide. Access via the page URL — Unsplash's direct CDN URLs change; download once, host locally in presentation assets. |
| 15 | **Arduino close-up on breadboard build** | https://unsplash.com/photos/blue-and-black-circuit-board-hz7EFrw06Qk — Harrison Broadbent | Unsplash | Unsplash License | varies | Hand/build shot, good "finished project" vibe. Same note on direct URLs. |
| 16 | **Breadboard category (search for better)** | https://commons.wikimedia.org/wiki/Category:Breadboards | Wikimedia Commons index | — | — | If the 400-point image isn't sufficient, browse this category for an 830-point shot. |

### Image-use notes
- **Prefer images #1, #4, #10, #11 for the main presentation** — all are CC0/public
  domain so you don't need to add attribution text on slides.
- **Elegoo PDF images (#6, #8, #9, #12) are exact matches for what the student
  holds in their hand.** Use these even though they're Elegoo copyright: quoting
  short portions of a product manual for teaching that same product is
  straightforward fair use. Just add a small "Bild: Elegoo Basic Starter Kit
  manual" caption.
- **Do not use Unsplash direct CDN URLs** in the final Slidev presentation —
  they change/expire. Download the image once to `presentation/assets/` and
  reference locally.
- **No free high-quality photo of the specific cylindrical ball-type tilt switch
  exists on Wikimedia Commons.** Use the PDF image, or photograph the actual
  component yourself on a dark background — it takes 30 seconds with a phone
  and gives you a perfect match.

---

## 3. Tutorial page verification

The course outline references six page numbers in the Elegoo tutorial PDF.
I verified all of them against the current V1.0.19.7.24 PDF (83 pages total).
**The outline's page numbers are slightly off** — see below.

| Topic (course outline) | Outline says | Actual page in V1.0.19.7.24 | Lesson | Verified content |
|---|---|---|---|---|
| Blink LED with breadboard + resistor | sid 42 | **p. 41** (schematic) / **p. 42** (breadboard wiring diagram) / **p. 43** (example photo) | Lesson 3 "LED" (starts p. 37) | ✅ Correct. Page 42 in the PDF shows the Fritzing-style wiring diagram of UNO → 220 Ω → red LED → GND with the 1 kΩ and 10 kΩ alternatives labeled. The outline's "sid 42" is spot-on. |
| RGB LED pinout warning (common cathode) | sid 45 | **p. 45** | Lesson 4 "RGB LED" (starts p. 44) | ✅ Correct. Page 45 has the photo of the 4-lead RGB LED labeled BLUE / GREEN / CATHODE / RED. Page 46 has the schematic and the critical text: *"The common negative connection of the LED package is the second pin from the flat side. It is also the longest of the four leads and will be connected to the ground."* |
| RGB color mixing (analogWrite / PWM) | sid 50 | **p. 48** (PWM theory) / **p. 51** (analogWrite code) | Lesson 4 continues | ⚠️ **Off by ~1–2 pages.** The outline's "sid 50" falls on the wiring diagram page. The actual PWM theory is p. 48 and the analogWrite code is p. 51. If the course deck quotes "sid 50," update to **"sid 48 (PWM) / sid 51 (kod)"** or just say "Lesson 4, sidorna 48–51". |
| Buzzer circuit | sid 60 | **p. 58** (lesson start with sticker photo) / **p. 59** (schematic) / **p. 60** (wiring diagram) | Lesson 6 "Active buzzer" | ⚠️ **Close but the key page is 58, not 60.** The "REMOVE SEAL AFTER WASHING" sticker photo that the course wants to highlight is on **p. 58**. Page 60 is the breadboard wiring diagram. Update to **"sid 58"** or keep 60 if you're showing the wiring, but mention 58 for the sticker. |
| Serial Monitor intro | sid 74 | **p. 73** (lesson start) / **p. 74** (first screenshot) | Lesson 9 "The Serial Monitor" | ✅ Correct. Page 74 shows the first Serial Monitor window screenshot. |
| Photoresistor voltage divider (1 kΩ) | sid 82 | **p. 79** (lesson start) / **p. 80** (voltage divider schematic showing photocell + 1 kΩ fixed resistor) | Lesson 10 "Photocell" | ⚠️ **Off by 2 pages.** The key schematic (photocell in series with 1 kΩ to ground, tap to A0) is on **p. 80**. Page 82 is toward the end of the lesson's code listing. Update to **"sid 80"**. |

### Recommended correction
Update the course outline's page references to:

- Blink LED breadboard: **sid 42** ✅ (no change)
- RGB LED pinout: **sid 45** ✅ (no change)
- RGB analogWrite / PWM: **sid 48 + 51** (was "sid 50")
- Active buzzer with sticker: **sid 58** (was "sid 60")
- Serial Monitor intro: **sid 74** ✅ (no change)
- Photoresistor 1 kΩ divider: **sid 80** (was "sid 82")

### Table of contents (current PDF, for reference)
| Lesson | Title | Start page |
|---|---|---|
| 0 | Installing IDE | 6 |
| 1 | Add Libraries and Open Serial Monitor | 17 |
| 2 | Blink (onboard LED) | 26 |
| 3 | LED (breadboard + resistor) | **37** |
| 4 | RGB LED | **44** |
| 5 | Digital Inputs (push buttons) | 53 |
| 6 | Active buzzer | **58** |
| 7 | Tilt Ball Switch | 62 |
| 8 | Eight LED with 74HC595 | 66 |
| 9 | The Serial Monitor | **73** |
| 10 | Photocell | **79** |

Total: 83 pages. Version string: **V1.0.19.7.24** (July 24, 2019 — still the
current published version as of 2025–2026 based on the Amazon CDN link used by
the current product page).

---

## 4. Gotchas and notes

### RGB LED polarity — this one will trip the teacher up
The course outline says *"long center pin is GND"*. **This is wrong as stated.**
The tutorial PDF (p. 46) is explicit:
- The RGB LED has 4 pins in a row, not 3.
- The cathode is **the second pin from the flat side of the LED body**, not the
  geometric center. From the flat-side reference: **Red, Cathode, Green, Blue**.
- The cathode IS the longest pin (course outline is right about that), but
  there's no "center" — it's an off-center position.
- It IS a common-cathode RGB LED (course outline is right about that too).

Recommended wording for the slide:

> "RGB LED: gemensam katod (common cathode).
> Det **längsta** benet är katoden — den är också det **andra benet från
> den platta sidan** av LED:ens hölje.
> Katod → GND, de andra tre benen → 220 Ω → digitala PWM-pinnar
> (märkta med `~` på UNO:n)."

This matches the physical part exactly and the course won't have a student
complaining "but the center pin is an anode!"

### Active buzzer sticker — the teacher's warning is correct and critical
Page 58 of the tutorial shows the buzzer with the sticker clearly: a white disc
reading **"REMOVE SEAL AFTER WASHING"** with a **+** symbol. The teacher is
right to warn students: the sticker is a factory seal that prevents solder flux
and cleaning solvents from getting inside the buzzer during PCB assembly and
washing. **If a student peels it off, the buzzer still works** (it's just
protection for manufacturing) — but Elegoo leaves it on, so it looks like a
"remove before use" tab and students instinctively peel it. Encourage them to
leave it alone; the buzzer sounds fine through it.

### Arduino is a clone, and that's fine — drivers "just work"
The board is an **Elegoo UNO R3**, not a genuine Arduino. Open-source design,
100% pin- and software-compatible. **Critically for a classroom setting: Elegoo
uses the real ATmega16U2 USB-to-serial chip** (same as genuine Arduino), NOT
the cheaper CH340 that many other clones use. This means:
- No driver installation on macOS / modern Windows / Linux
- The board shows up as "Arduino/Genuino UNO" in the IDE's Port menu
- Students won't hit the CH340 driver issue that plagues other cheap clones

One minor cosmetic note: the board has an "ELEGOO UNO R3" silkscreen in place
of the Arduino logo. The PCB is the same blue. If a slide needs a "this is
what Arduino looks like" image, either of the Wikimedia genuine-Arduino photos
is fine — students won't notice or care.

### Resistor quantities are not broken down
The packing list just says "Resistors 120 PCS". Elegoo does not publish the
breakdown per value. In practice the kit typically contains roughly equal
quantities of 220 Ω, 1 kΩ, 10 kΩ (and sometimes 330 Ω, 100 Ω). Have students
read the color bands on day 1 — this is a good first lesson in "reading the
physical part" anyway and the PDF page 40 has the full color code chart.

### Jumper wires: two different types bundled
The kit has:
- **65 × pre-formed stiff M-M wires** (the rainbow short wires) — "Breadboard
  Jumper Wire" in the packing list.
- **5 × flexible F-M DuPont wires** — used in Lessons 6 (buzzer) and 7 (tilt
  switch) where the component isn't on the breadboard and needs to plug
  directly into the Arduino headers.

There are **zero F-F wires** in the Basic kit. If a lesson needs F-F, students
won't have them. Lessons 0–10 in the tutorial don't require F-F, so this is
only a problem if you extend the course beyond what's in the manual.

### Expected beginner mistakes (for teacher cheat sheet)
1. **LED backwards.** Most common. Reinforce "long = plus, flat = minus" on day 1.
2. **Forgot the 220 Ω resistor with LED.** The LED survives a few seconds at 5 V
   without one, then dies. Keep spares.
3. **RGB LED wired as common anode** by habit from other tutorials. Common
   cathode means *sinking* current through the cathode to GND, not sourcing
   through a common 5 V rail.
4. **`analogWrite` on a non-PWM pin.** Only pins marked `~` (3, 5, 6, 9, 10, 11)
   support PWM. The tutorial uses D3, D5, D6 for RGB — all PWM, good.
5. **Wrong COM port** in Arduino IDE. On macOS with Elegoo's ATmega16U2, it will
   appear as `/dev/cu.usbmodemXXXX` — not a random `/dev/cu.wchusbserialXXXX`
   as with CH340 clones. Good news for the class: select the port that appears
   when you plug it in, de-select when you unplug, done.
6. **Active vs passive buzzer confusion.** The Basic kit only has the **active**
   one, so `digitalWrite(pin, HIGH)` is enough to make it beep. No `tone()`
   needed. Don't confuse students by teaching `tone()` on the active buzzer —
   it works but it's pointlessly complex.
7. **Tilt switch bouncing.** The ball physically bounces inside the can, so
   without software debounce the readout is noisy. Lesson 7's code just polls
   — if a student's tilt detection feels flaky, add a 50 ms debounce.
8. **Photoresistor divider direction.** The tutorial (p. 80) puts the photocell
   to 5 V and the 1 kΩ to GND. When it's dark, the photocell resistance is
   HIGH (~50 kΩ) and A0 reads LOW. Bright light → A0 reads HIGH. If the student
   wires it upside-down the behavior is inverted — not wrong, just inverted.
   Either is acceptable; pick one in class and stick with it.

---

## 5. Useful links
- **Official tutorial PDF (current)**: https://m.media-amazon.com/images/I/C181Jog2UuL.pdf
- **Elegoo download center**: https://www.elegoo.com/pages/download
- **Basic kit product page**: https://www.elegoo.com/products/elegoo-uno-basic-starter-kit
- **Basic kit tutorial blog post**: https://www.elegoo.com/blogs/arduino-projects/elegoo-uno-project-basic-starter-kit-tutorial
- **Amazon US Basic kit listing**: https://www.amazon.com/ELEGOO-Starter-Tutorial-Compatible-Official/dp/B01DGD2GAO
- **Elegoo vs genuine Arduino (good background read)**: https://pcbsync.com/elegoo-uno-r3-vs-arduino-uno/

## 6. PDF archival copy
The current tutorial PDF is already cached by Claude Code at:
`/Users/daniel/.claude/projects/-Users-daniel-projects-arduino-kurs/d469c550-f6f1-44bf-a305-4697c0af0025/tool-results/webfetch-1776085080488-4howsd.pdf`

Recommend copying it to `/Users/daniel/projects/arduino-kurs/research/elegoo-basic-kit-tutorial-v1.0.19.7.24.pdf` for stable local access.
