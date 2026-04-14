# Visuell granskning Modul 5 + Bilagor — 2026-04-14

## Modul 5 (6 pages)

### Page 1 — Kapitelöppnare
- Verdict: OK
- Chapter opener renders well. "MODUL 5" label, large h1, italic subtitle, hero photo sharp with readable caption. No issues.

### Page 2 — Vad du gjorde i dag / Systemets arkitektur
- Verdict: MINOR
- Running head and page number present. Body text readable, bullet list clean.
- Code table (pin-map) renders as a code block — monospace, left-aligned, clean.
- **Minor**: The pin-map block uses code styling for what is essentially a definition list. Visually fine but the horizontal dash `—` separators inside the monospace block look slightly inconsistent in spacing.

### Page 3 — SENSE-ACT-LOOP / Tips för hackathon-formatet
- Verdict: OK
- Numbered lists, h2 and h3 hierarchy clear. Inline code `LarmPaslaget`, `edge-detection` render correctly.
- Code block at bottom (DEBUG-PRINT SNABBRECEPT) has left accent, monospace clean. No overflow.

### Page 4 — Ordna koden i block (code block, continues from p3)
- Verdict: OK
- Large code block fills most of the page. Monospace is clean, indentation preserved, no text clipping. Left accent bar present. Pagination break is reasonable (block starts on p3, ends here).

### Page 5 — Vanliga problem / Bygg vidare
- Verdict: MINOR
- Two-column problem table is readable but cells are somewhat tight.
- **Minor**: "Kompilerar inte — 'variable not in scope'" table row: the cell text wraps tightly; at print size it is legible but borderline.
- Callout box (I SLIDESEN) renders with correct styling.

### Page 6 — Snabbreferens / Efter kursen
- Verdict: OK
- Quick-ref table well-aligned. Callout box styling intact. Bullet lists readable. No orphans visible.

---

## Bilagor A–F (40 pages)

### Bilaga A — Syntax-grammatik (p1–p8)

#### p-1 — Kapitelöppnare
- Verdict: OK
- Clean opener. Label, h1, rule, italic subtitle. No issues.

#### p-2 — Primitiva datatyper / const
- Verdict: OK
- Two separate code blocks (const int examples), both clean. Inline code renders well. Body readable.

#### p-3 — Operatorer
- Verdict: MINOR
- **Minor**: The arithmetic/comparison/logical operator mini-blocks are styled as code blocks but mixed with prose annotations inline. On p-3 the "HELTALSDIVISION TRICKAR MÅNGA" and "JÄMFÖRELSE" sub-sections present code and comment inline in the same code block — the Swedish comments after `//` are readable but visually thin in mono.
- No overflow or clipping.

#### p-4 — Villkorssatser
- Verdict: OK
- Code blocks for if/else, if/else if/else, ternary all clean. Left accent bar present. `KORT IF-SYNTAX (TERNÄR)` label legible.

#### p-5 — Loopar
- Verdict: OK
- for/while loops with Swedish comments render cleanly. No overflow.

#### p-6 — Scope
- Verdict: OK
- Code blocks comparing local vs global scope clear. Body text readable.

#### p-7 — Kommentarer / Arduino-specifika konstanter / Vanliga kompilatorfel
- Verdict: MINOR
- **Minor**: "Vanliga kompilatorfel" section uses a two-column layout (error string | explanation). The right column text wraps across multiple lines while the left column code string stays on one line, creating uneven row heights. Legible but somewhat ragged.

#### p-8 — (Kompilatorfel fortsättning, mostly whitespace)
- Verdict: MINOR
- **Minor**: Page ends with three table rows and then ~60% blank space. The section likely continues on the next bilaga. The blank space is a result of the chapter boundary — acceptable but the page looks sparse. Could consider a short closing note or page break adjustment.

---

### Bilaga B — Felmeddelanden (p9–p13)

#### p-9 — Kapitelöppnare
- Verdict: OK
- Clean opener. BILAGA B label, h1, italic subtitle. Rule present.

#### p-10 — Kompilatorfel du kommer stöta på (first entries)
- Verdict: OK
- Inline code rendered as highlighted monospace (EXPECTED ';' BEFORE ..., 'VARIABEL' WAS NOT DECLARED). Code blocks with left accent clean. Red X icon inline renders correctly.

#### p-11 — More compiler errors
- Verdict: OK
- `INVALID OPERANDS OF TYPES`, `TOO MANY ARGUMENTS TO FUNCTION`, `VOID VALUE NOT IGNORED` sections all render well. Code blocks clean. Left accent consistent.

#### p-12 — Upload-fel / Runtime-beteenden
- Verdict: OK
- Numbered list for upload troubleshooting clear. Section headings in teal uppercase distinct from body. Serial Monitor tips readable.

#### p-13 — Felsöknings-checklista
- Verdict: MINOR
- **Minor**: The numbered checklist spans only 7 lines and then the page ends — leaving roughly 70% white. Next bilaga starts fresh on p-14, so this page is genuinely sparse. Could benefit from a visual closing element or merged with prior content.

---

### Bilaga C — Komponentreferens (p14–p22)

#### p-14 — Kapitelöppnare
- Verdict: OK
- Clean opener. LED section begins with component photo (anod/katod markings), clear caption below image.

#### p-15 — Resistor
- Verdict: OK
- Resistor photo renders cleanly. Table (Polaritet, Värden, Avläsning, färgkoder) reads well.

#### p-16 — Resistor färgkod tabell
- Verdict: MINOR
- **Minor**: The color-band resistor chart (4-band and 5-band codes) is a dense image. Colors and labels are legible but the image is slightly small — the rightmost column labels (multiplier/tolerance values) are tight. Functional but could use slightly more width or higher-res rendering.

#### p-17 — RGB-LED / Breadboard
- Verdict: OK
- RGB-LED photo sharp, caption identifies pins correctly. Breadboard overview image clear, caption legible.

#### p-18 — Knapp (tactile switch) / Active buzzer
- Verdict: OK
- Two-image layout works. Knapp photo with A–D pin labels visible. Table rows clean.

#### p-19 — Active buzzer (fortsättning) / Fotocell
- Verdict: OK
- Fotocell (LDR) photo small but sharp. Property table clean.

#### p-20 — Tilt-sensor / Arduino Uno R3
- Verdict: OK
- Tilt-sensor photo clear. Arduino Uno R3 property table well-aligned.

#### p-21 — Arduino Uno R3 (fortsättning) / Kablar / Det ni inte använder
- Verdict: OK
- Cable type table (M-M, M-F, F-F) and "not used in course" table both render cleanly.

#### p-22 — (Potentiometer, Piezo-element, closing sentence)
- Verdict: MINOR
- **Minor**: Page has only 4 lines of content (two table rows + closing sentence) and then ~80% white. Same sparse-ending issue as p-8 and p-13. Not broken, just visually thin.

---

### Bilaga D — Hackathon-lösning (p23–p28)

#### p-23 — Kapitelöppnare
- Verdict: OK
- BILAGA D label, h1 "Hackathon-lösning", italic subtitle. Code begins on this page (pin declarations). Clean.

#### p-24 — Komplett sketch (part 1)
- Verdict: OK
- Dense code block fills page. Monospace clean, indentation intact, Swedish comments render correctly with `//`. No overflow or text clipping.

#### p-25 — Komplett sketch (part 2) + Rad-för-rad-förklaring
- Verdict: OK
- Code block at top continues cleanly. Explanatory prose section below with teal subheadings. No pagination artifact at the code/prose boundary.

#### p-26 — Rad-för-rad-förklaring (fortsättning)
- Verdict: OK
- Prose-heavy page. Readable, correct line spacing.

#### p-27 — Varianter att prova (with code blocks)
- Verdict: OK
- Two variation code blocks (VARIATION 1 pip-larm, VARIATION 2 hysteres). Both render cleanly with left accent. No clipping.

#### p-28 — Sista rådet (closing)
- Verdict: MINOR
- **Minor**: Page contains only 2 short paragraphs, then ~75% whitespace. Short closing page is intentional but visually sparse.

---

### Bilaga E — Säkerhet (p29–p32)

#### p-29 — Kapitelöppnare
- Verdict: OK
- BILAGA E, h1 "Säkerhet", italic subtitle, clean rule. Section 1–2 render well.

#### p-30 — Säkerhetsregler (fortsättning)
- Verdict: OK
- Bullet lists and bold terms (Fel att undvika, Regel) render correctly. Readable body text.

#### p-31 — Statisk elektricitet / Säker felsökning / Och till slut
- Verdict: OK
- Numbered lists clean. Bold inline terms legible.

#### p-32 — (Closing sentence)
- Verdict: BROKEN
- **Broken**: Page contains only one sentence ("Slappna av. Bygg.") and then the entire rest of the page is blank — roughly 95% whitespace. This is almost certainly a page-break artifact. The sentence should either move to p-31 or this orphaned page should be eliminated.

---

### Bilaga F — Ohms lag, framspänningsfall, spänningsdelare (p33–p40)

#### p-33 — Kapitelöppnare
- Verdict: MINOR
- **Minor**: The h1 title "Ohms lag, framspännings-fall, spänningsdelare" wraps across two lines with an awkward hyphenation break "framspännings-\nfall". The hyphen appears to be a soft-hyphen inserted mid-compound-word. At this heading size it looks like a typo or layout error. Should read as one word "framspänningsfall" without the break, or the title should be reformatted.

#### p-34 — Ohms lag formler
- Verdict: OK
- Math formulas (U = I·R, I = U/R, R = U/I) render as display-style centered blocks with clean box styling. Triangle mnemonic renders as ASCII art inside a code-styled box — acceptable and readable.

#### p-35 — Varför en LED inte följer Ohms lag / Räkneexempel (I–V graph)
- Verdict: OK
- I–V graph (ström vs spänning) renders clearly, axis labels visible. Formula block clean.

#### p-36 — Räkneexempel (fortsättning) / Vad händer om resistorn är för liten?
- Verdict: OK
- Display formula `U = I·R = 0,015 A · 220 Ω = 3,3 V` and `R = U/I = 3V/0,015 A = 200 Ω` render cleanly. Warning callout box (EN LED UTAN SERIEMOTSTÅND) has correct teal-border styling and is legible.

#### p-37 — Framspänningsfall för andra färger / Spänningsdelare
- Verdict: OK
- Definition table (Röd/Gul/Grön/Blå/Vit Vf values) clean. No formula overflow.

#### p-38 — Spänningsdelare (koppling + formler)
- Verdict: OK
- Series-circuit diagram rendered as ASCII/box diagram inside a code block — legible. Formulas `V_out = ...` and `I = ...` render as centered display blocks. Clean.

#### p-39 — Exempel 1–3 / Serie-resistorer / Parallell-resistorer
- Verdict: OK
- Multiple formula blocks on one page render cleanly without overlapping. Teal subheadings (SÅ VARFÖR PRATAR NI OM SIFFROR SOM 150/400/900?) distinct.

#### p-40 — Sammanfattning (last page)
- Verdict: MINOR
- **Minor**: Page ends after 5 bullet points with ~70% blank space. Last page of the document — likely intentional but looks unfinished. Could add a colophon or closing graphic.

---

## Summary

- **Broken**: 1 (Bilaga E p-32 — single orphaned sentence on near-blank page)
- **Minor**: 11
  - M5 p-2: pin-map dash spacing
  - M5 p-5: tight problem-table cells
  - Bilaga A p-3: mono comment styling
  - Bilaga A p-7: uneven two-column compiler error rows
  - Bilaga A p-8: sparse page (~60% blank)
  - Bilaga B p-13: sparse page (~70% blank)
  - Bilaga C p-16: resistor color chart slightly small
  - Bilaga C p-22: sparse page (~80% blank)
  - Bilaga D p-28: sparse closing page
  - Bilaga F p-33: hyphenated "framspännings-\nfall" in h1
  - Bilaga F p-40: sparse last page
- **OK**: 34

### Top issues to fix
1. **Bilaga E p-32** — orphaned closing sentence on its own page; merge to p-31 or remove forced page break.
2. **Bilaga F p-33** — h1 heading hyphenates "framspänningsfall" across two lines; remove soft hyphen or shorten title.
3. **Sparse chapter-end pages** (A p-8, B p-13, C p-22, D p-28, F p-40) — recurring pattern of section endings leaving 60–80% blank; consider tighter page-break control or adding closing callouts.
4. **Bilaga A p-7 / B compiler error tables** — uneven two-column row heights; consider switching to definition-list or card styling for error reference entries.
