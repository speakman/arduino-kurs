# Fas 3 final audit — 2026-04-14

## 🚨 Blockers (must fix before class)

### Slide 13 — "Så här ska det se ut." (LED wiring diagram)
**Issue:** Two unlabelled yellow component boxes appear floating in the top-right corner of the wiring photo, labelled "1K" and "10K". These look like stray legend artefacts or leftover labels from a previous version of the diagram. The actual circuit uses a 220 Ω resistor (correctly labelled at the bottom), so the "1K" and "10K" callouts are factually wrong and contradictory. A beginner looking at this will be confused about which resistor to use.  
**Suggested fix:** Remove the 1K/10K overlay labels entirely. The 220Ω label and the bottom caption already communicate the correct value.

### Slide 37 — "Spänningsdelaren." (bottom footnote clipped)
**Issue:** The bottom footnote text is partially cut off — it reads "Byter du plats på fotocell och 1 kΩ inverteras skalan. Vi kör fotocellen överst → mörker = låg siffra." but the last portion is visually at the very edge of the slide frame and appears clipped in the exported PNG. Important inversion note may be invisible to students in the back of the room.  
**Suggested fix:** Move the footnote up slightly or reduce its font size so it sits 10–15 px inside the slide boundary. Alternatively make it part of the main body text.

### Slide 40 — "Serial Monitor." (code block too low contrast / nearly invisible)
**Issue:** The code block on the right half of the slide is rendered with very dark text on a very dark background — the code is barely legible at classroom projection distance. The `void setup()`, `Serial.begin(9600)`, `void loop()` lines are almost invisible. This is the slide that teaches students how to use Serial Monitor — if they can't read the code example, the slide fails its purpose.  
**Suggested fix:** Increase the code block background to a medium-dark (e.g. `#1e2a1e` or standard dark grey `#1e1e1e`) with bright text, or lighten the text color. Consistent with the bright green-on-dark-grey style used on other code slides.

---

## ⚠️ Minor (would polish)

### Slide 8 — "Spänning, ström, GND."
The Ohm's law example reads: `(5 V – 2 V) / 15 mA = 200 Ω → välj 220 Ω`. Technically correct. However the LED forward-voltage assumption (2 V) is stated nowhere — a curious beginner might wonder where 2 V comes from. Minor, but worth a parenthetical "(typisk LED-spänning)" somewhere near the formula.

### Slide 11 — "Fem hål = en nod."
The SVG breadboard diagram renders correctly: green highlight box visible, red/blue rails labelled, dashed gap line present. No layout issues. One minor note: the dashed gap line is quite faint — at projector brightness it might not read clearly from the back row. Consider a slightly thicker or higher-contrast dashed stroke.

### Slide 13 — "Så här ska det se ut." (duplicate note, secondary issue)
Beyond the blocker above: the wiring image looks slightly low-resolution/compressed for a 1960×1104 export, with visible JPEG artefacts around the breadboard. Not critical but noticeable on a large projector.

### Slide 26 — "const int och int."
The code example on the right correctly shows `const int`, `int`, and `bool`. The comment says `// ändras aldrig` for `knappPin`. Small nit: `knappPin` is assigned `9` — on slide 45 it's also `9`, consistent. Good.

### Slide 29 — "Koppla knappen."
The wiring diagram caption reads: "Vi använder bara knapp A → D9 · andra benet till GND. Ingen pulldown-resistor — INPUT_PULLUP sköter det internt." This is correct and pedagogically clear. Minor: caption is small and at the very bottom — might be hard to read from row 3+.

### Slide 32 — "Koppla buzzern."
Wiring image shows buzzer connected directly to Arduino header pins without a breadboard, which matches the caption. Layout looks fine. Minor: caption at bottom is in a small dim font — same legibility concern as slide 29.

### Slide 36 — "Knappen var digital. Världen är analog."
The GÖR DETTA NU box says "Bygg spänningsdelaren: fotocell + 1kΩ → pin A0". This is consistent with slides 37 and 38. Good alignment across slides.

### Slide 38 — "Koppla fotocellen."
The schematic uses English labels ("Photocell", "Fixed Resistor"). The rest of the deck is in Swedish. This is an inconsistency — either translate to "Fotocell" / "Fast resistor 1 kΩ" or note that it's a standard schematic convention. Not blocking, but inconsistent with the deck's language.

### Slide 39 — "Koppla tilt-sensorn."
The tilt sensor appears as a thin white cylinder — barely identifiable from the image. The caption is helpful ("ena benet → D2, andra benet → GND") but the component itself might confuse students who've never seen one. Consider adding a small photo inset of the actual tilt sensor component, similar to how slide 31 shows the buzzer photos.

### Slide 45 — "Pin-tilldelning."
Both columns render correctly — left column pin constants, right column pseudocode `loop()`. The two-column layout is not broken. However, the right-column pseudocode uses Swedish comments (`// 1. Läs inputs`, `// 2. Flank → togla larm`, `// 3. Bestäm utfall:`) mixed with English/code. Minor: `togla` should be `toggla` (double g) to match the Swedish word and earlier slide 30 which spells it correctly as "toggle". Actually on closer inspection it says "togla" — this is a Swedish-flavored spelling, arguably fine, but inconsistent with "toggle" used elsewhere.

---

## 📝 Pedagogical notes

### Slide 9 — "Kretsen — som ett vattensystem."
The water analogy is good. However the right-side schematic shows the circuit path as `pin 13 → LED (+) → LED (-) → 220 Ω → GND`. This places the resistor after the LED (between LED and GND), which is electrically fine but differs from how some textbooks show it (resistor before LED). Worth a brief mention: "Resistorn kan sitta var som helst i serie — det spelar ingen roll."

### Slide 27 — "Input ≠ Output."
Excellent conceptual slide. The VARFÖR PULLUP? box is very well written. One suggestion: add a one-liner "Minnesregel: tryckt = LOW, släppt = HIGH" as a formatted callout (like the MINNESREGEL boxes used elsewhere) to make it scannable. The information is already there in the prose — just easier to find as a formatted box.

### Slide 30 — "Reagera på flanken."
The edge-detection code uses `delay(10); // mot studs`. This is a minimal software debounce. For a beginner class this is fine, but it's worth noting (even verbally) that this 10 ms delay doesn't fully solve debouncing — it just limits re-entry rate. The slide mentions "stroboskop" as the problem but doesn't fully connect that `delay(10)` is a practical workaround. A short "Det här är enklast möjliga lösning — fungerar bra för vår kurs" would prevent over-confidence.

### Slide 37 — "Spänningsdelaren." (pedagogical)
The water-pipe analogy returning from Modul 1 is a smart callback and aids memory. The direction of values ("Mörker → högt motstånd → mellanpunkten sjunker. Ljus → lågt motstånd → stiger") is correct and clearly stated. The TYPISKA VÄRDEN box is valuable for the threshold-hunting exercise on slide 41. Overall: this slide is well-constructed pedagogically.

### Slide 41 — "Hitta din tröskel."
The code sample shows both `ljus` and `tilt` printed to Serial Monitor simultaneously. This is a good combined exercise. The HITTA ETT TAL ATT KALLA "MÖRKT" box is excellent — it tells students exactly what number to look for and why it matters for Modul 5. Well done.

---

## 🧐 Swedish prose nitpicks

### Slide 5 — "Idag — två timmar."
"Arduino**n**on" appears in "Slutmålet & Arduinonon" — wait, reading again: it says "Slutmålet & Arduinon" which is correct (Arduino + definite suffix). Fine.

### Slide 7 — "Mikrokontrollern."
"En mikrokontroller — processor, minne och in-/utgångar på ett chip." — grammatically fine. "Kör ett enda program, helt förutsägbart." — correct.

### Slide 8 — "Spänning, ström, GND."
Etymology footnote: "Varför U och IT U från tyskans Spannung (spänning)..." — this appears to read "IT U" which is awkward. The footnote is very small and may say "I T U" or similar — hard to parse at this resolution. Should read something like "Varför U? Från tyskans Spannung (spänning), I från franskans intensité du courant (strömintensitet)." If "IT U" is an OCR/rendering artefact that's actually fine in source, no action needed.

### Slide 9 — "Kretsen — som ett vattensystem."
"en resistor på 220 Ω i serie" — correct Swedish.  
"Ingen krets utan väg tillbaka till GND." — slightly terse but intentionally so. Fine.

### Slide 11 — "Fem hål = en nod."
"En breadboard är bara en plastbit med metallklämmor inuti." — correct.  
"Fem hål i en vågrät rad är internt hopkopplade — en nod." — correct.  
"Raden bredvid är en helt egen nod." — correct.  
"Gapet i mitten bryter förbindelsen." — correct.  
"+/–-skenorna längs sidorna går hela vägen." — the hyphen usage "+/–-skenorna" is slightly awkward typographically (mixing en-dash and hyphen). Could be "+/-skenorna" or "Plus/minus-skenorna" for cleaner reading.

### Slide 15 — "Hela Blink — på tre rader."
"Sätt pin 13 till 5V." — the description says HIGH = tänd (5 V), LOW = släckt (0 V). Technically on Arduino the HIGH output is ~5 V but labeled as logical HIGH. Fine for a beginner course.

### Slide 27 — "Input ≠ Output."
"En pinne som bara 'lyssnar' utan koppling till plus eller minus *flyter*" — the italicized "flyter" is a good technical term (floating). Well done.

### Slide 33 — "Läs knapp. Styr buzzer."
"Knappen ner → buzzern tjuter. Släpp → tyst." — clean, correct.  
"Active buzzer: HIGH = pip, LOW = tyst. Ingen tone() behövs." — correct and useful.

### Slide 36 — "Knappen var digital. Världen är analog."
"Fotocell (LDR) — Mäter ljus: **0–1023**" — correct (10-bit ADC).  
"50 kΩ i mörker · 500 Ω i solljus" — typical LDR values, reasonable.

### Slide 37 — "Spänningsdelaren."
"Minns vattenröret från Modul 1: 5 V är kranen, GND är utloppet, en resistor är en strypventil." — elegant callback, well phrased.  
"Flödet (strömen) är lika stort genom båda — men trycket (våra 5 V) delas upp." — correct physics, clear analogy.  
"Hårdare ventil → större tryckfall över just den." — correct.  
"A0 är en tryckmätare för mellanpunkten." — perfect analogy for a beginner.  
The footnote: "Byter du plats på fotocell och 1 kΩ inverteras skalan. Vi kör fotocellen överst → mörker = låg siffra." — correct and helpful.

### Slide 44 — "Arduinon känner världen."
"Ni kan läsa **ljus** med en fotocell, **lutning** med en tilt-sensor, och **titta in** i Arduinons hjärna via Serial Monitor." — "titta in i Arduinons hjärna" is a charming metaphor. Slightly mixed — you're not looking "into the brain," you're seeing its output. Could be "följa med i vad Arduinon mäter" but the current phrasing is friendly and engaging for a casual course. Keep as-is.

### Slide 45 — "Pin-tilldelning."
`// togla larm` should be `// toggla larm` for consistency with standard Swedish loanword usage.

---

## ✅ Strengths

- **Consistent visual identity** throughout all 46 slides: dark background, teal accent, monospace code blocks, tip boxes. Professional and coherent.
- **Slide 37 "Spänningsdelaren"** is the strongest new slide — the water-pipe callback analogy is memorable, the schematic is clean and correct (fotocell on top, 1 kΩ to GND, A0 at midpoint), the TYPISKA VÄRDEN table is immediately practical.
- **Slide 27 "Input ≠ Output"** — the VARFÖR PULLUP? explanation is one of the best beginner explanations of floating pins I've seen in a course deck. Clear, concise, actionable.
- **Slide 11 "Fem hål = en nod"** — SVG renders correctly with all elements visible: green nod highlight, red/blue rails, dashed gap. Good visual pedagogy.
- **Slide 30 "Reagera på flanken"** — edge detection is a genuinely hard concept and this slide presents it accessibly with both prose and code.
- **Slide 41 "Hitta din tröskel"** — the tip box is a perfect bridge to Modul 5. Shows the instructor thought about the arc of the full course.
- **Slide 45 "Pin-tilldelning"** — the two-column layout is working correctly after fixes. Pin numbers consistent with earlier slides (knappPin=9, tiltPin=2, buzzerPin=12, ledR=6, ledG=5, ledB=3, ldrPin=A0).
- **Callbacks** ("Minns vattenröret från Modul 1") used deliberately — good pedagogical technique.
- **No placeholder text, TODO, FIXME, or dashed-border orphan elements** found in any slide.

---

## Per-slide verdict

| Slide | Title | Verdict | Notes |
|-------|-------|---------|-------|
| 1 | Elektronik & Programmering med Arduino | OK | Clean title slide, date correct (13 april 2026) |
| 2 | Fem träffar. Fem moduler. | OK | All 5 module cards visible, legible |
| 3 | Klassrummets viktigaste verktyg | OK | Green/red squares clear, simple and effective |
| 4 | LED & krets (modul title) | OK | Clean title slide |
| 5 | Idag — två timmar. | OK | Four-quadrant agenda readable |
| 6 | Det här ska vi bygga. | OK | Clean goal slide |
| 7 | Mikrokontrollern. | OK | Photo crisp, specs readable |
| 8 | Spänning, ström, GND. | Minor | Etymology footnote tiny; LED Vf assumption unstated |
| 9 | Kretsen — som ett vattensystem. | Minor | Resistor placement note could prevent confusion |
| 10 | LED & resistor. | OK | Colour band example correct (röd·röd·brun = 220 Ω) |
| 11 | Fem hål = en nod. | OK | SVG renders correctly; gap line slightly faint |
| 12 | Bygg kretsen. | OK | Steps clear, Elegoo manual reference helpful |
| 13 | Så här ska det se ut. | **BLOCKER** | Stray 1K/10K labels contradict 220Ω — remove them |
| 14 | setup() och loop(). | OK | Code readable, explanation clear |
| 15 | Hela Blink — på tre rader. | OK | Three commands well explained |
| 16 | Din egen rytm. | OK | Code visible, SOS/Hjärtslag examples fun |
| 17 | Ni har byggt en blinkare. | OK | Clean milestone slide |
| 18 | Nästa gång... | OK | Transition slide clear |
| 19 | PWM & RGB (modul title) | OK | Clean |
| 20 | Alla färger, av bara tre. | OK | Common Cathode warning box is important and present |
| 21 | Koppla RGB-LED:en. | OK | Pin assignments (D6,D5,D3) match slide 45 |
| 22 | analogWrite. | OK | PWM pins list (3,5,6,9,10,11) correct for UNO |
| 23 | Hitta färgen. | OK | Color swatches rendered correctly |
| 24 | Ni har en pixel. | OK | Clean milestone slide |
| 25 | Digital input (modul title) | OK | Clean |
| 26 | const int och int. | OK | knappPin=9 matches slide 45 |
| 27 | Input ≠ Output. | OK | Excellent PULLUP explanation |
| 28 | if / else. | OK | Code example correct, uses LED_BUILTIN for demo |
| 29 | Koppla knappen. | Minor | Caption small/dim; pin D9 consistent |
| 30 | Reagera på flanken. | Minor | Debounce caveat worth a verbal note |
| 31 | En varning först. | OK | Buzzer sticker warning is prominent and correct |
| 32 | Koppla buzzern. | Minor | Caption small/dim; pin D12 consistent with slide 45 |
| 33 | Läs knapp. Styr buzzer. | OK | Code snippet correct and minimal |
| 34 | Arduinon lyssnar. | OK | Clean milestone; "sinnesorgan" metaphor charming |
| 35 | Analog input (modul title) | OK | Clean |
| 36 | Knappen var digital. Världen är analog. | OK | LDR values plausible; circuit instruction correct |
| 37 | Spänningsdelaren. | Minor | Bottom footnote at edge risk; otherwise excellent |
| 38 | Koppla fotocellen. | Minor | English labels ("Photocell", "Fixed Resistor") inconsistent with Swedish deck |
| 39 | Koppla tilt-sensorn. | Minor | Tilt sensor hard to identify from image alone |
| 40 | Serial Monitor. | **BLOCKER** | Code block nearly invisible — contrast too low |
| 41 | Hitta din tröskel. | OK | Excellent bridge to Modul 5 |
| 42 | Arduinon känner världen. | OK | Clean milestone |
| 43 | Integration (modul title) | OK | Clean |
| 44 | Ingenjörsuppgiften. | OK | INPUT→LOGIK→OUTPUT diagram clean |
| 45 | Pin-tilldelning. | Minor | "togla" → "toggla" typo; layout fixed and working |
| 46 | Tack. | OK | Clean closing slide |
