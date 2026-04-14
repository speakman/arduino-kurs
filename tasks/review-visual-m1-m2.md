# Visuell granskning Modul 1+2 — 2026-04-13

## Modul 1 (6 pages)

### Page 1 (chapter opener)
- Verdict: OK
- Clean chapter opener. "MODUL 1" label, large "LED & krets" H1, cyan rule, italic subtitle, and intro body all render correctly.
- H1 weight and size are editorial and clear.
- No running header on opener — correct.
- No page number visible — acceptable for opener if intentional; verify that this is a design choice rather than an omission.

### Page 2
- Verdict: MINOR
- Running header and right-aligned section label both render correctly.
- Large Arduino+breadboard photo renders well; caption is italic gray and readable.
- Caption text is dense but legible.
- **MINOR**: Caption line length is very long (nearly full column width) — could benefit from a max-width or centered layout to avoid tracking fatigue on a single-line caption that wraps awkwardly.
- H2 "Repetition av de viktigaste begreppen" renders correctly with good clearance above.
- H3 "KRETSEN" and "BREADBOARDEN" in cyan small caps — correct hierarchy, tight to following text.
- Bold inline terms (e.g. **Fem hål i rad**) render clearly.
- Page number (2) visible in footer — OK.

### Page 3
- Verdict: MINOR
- Running header correct.
- Breadboard diagram renders well; caption italic gray — OK.
- Math formula block (U = I · R) renders correctly with appropriate vertical space.
- LED polarity image (+ / − photo) is small but adequate.
- **MINOR**: The two side-by-side elements (LED photo left, resistor photo right with caption) create an asymmetric float layout — the resistor caption text on the right appears to wrap to a very narrow column, making it harder to read.
- H3 "OHMS LAG" and "VARFÖR 220 Ω?" in cyan small caps — correct.
- Ohm's law calculation block renders cleanly as a display formula.
- Page number (3) visible — OK.

### Page 4
- Verdict: MINOR
- Running header correct.
- Schematic wiring diagram renders at reasonable size; caption is readable.
- Code inline references (`digitalWrite`, `pinMode`, etc.) in monospace — readable.
- H2 "Bygg från minnet" and "Hemma-övningar" render correctly.
- **MINOR**: The schematic image is moderately small — detail in the wiring paths may be hard to follow when printed at A4. Consider enlarging or adding a zoom callout.
- H3 labels ("DIGITALMÄTNING OCH PINNAB", "ÖVNING 1 — HJÄLPSLAG") are readable.
- Page number (4) visible — OK.

### Page 5
- Verdict: MINOR
- Running header correct.
- **MINOR**: "LEDTRAD" callout box — the accent bar on the left is very thin and light; in print this could disappear entirely. The callout blends into surrounding body text more than it should.
- Code blocks ("EXEMPEL" and "SMART SÄTT") render with visible left accent bar and monospace font — mostly OK.
- **MINOR**: "SMART SÄTT" callout uses the same visual style as "EXEMPEL" — it is unclear at a glance that these are different callout types. Differentiate with color or label style if they convey different intent.
- "Vanliga fel och snabblösningar" table: two-column layout renders correctly; left column in monospace/bold, right column body text. Columns are aligned and padded adequately.
- **MINOR**: Table row for `'digitalWrit' was not declared in this scope` — the cell text in the right column appears to be cut off at the visible page boundary. Verify that the full explanation is not clipped.
- Page number (5) visible — OK.

### Page 6
- Verdict: OK
- Running header correct.
- Continuation of troubleshooting table renders cleanly. Both columns readable, good padding.
- "Snabbreferens" quickref table: monospace left column, body text right column — clean alignment, good spacing.
- "I SLIDESEN" callout box: cyan accent bar visible, small caps title, body readable — OK.
- H2 "Inför nästa träff" — correct size and clearance.
- No orphaned headings. Page feels balanced.
- Page number (6) visible — OK.

---

## Modul 2 (7 pages)

### Page 1 (chapter opener)
- Verdict: OK
- Same opener template as M1 — "MODUL 2", large "PWM & RGB" H1, cyan rule, italic subtitle, intro bullet list.
- Bullet list is longer than M1 opener (6 bullets) — page feels slightly denser but not broken.
- Bold inline code (`analogWrite(pin, värde)` etc.) in bullets renders correctly.
- No running header on opener — correct.
- No page number visible — consistent with M1 opener.

### Page 2
- Verdict: MINOR
- Running header correct ("ARDUINO-KURS · MODUL 2 · PWM & RGB" / "PWM & RGB").
- RGB additive color mixing diagram renders well; caption is italic gray — OK.
- RGB-LED photo with labeled pins renders clearly; four-row pin table below photo is well-aligned.
- **MINOR**: The pin table (Ben 1–4) uses inconsistent column widths — the left "Ben X" column is very narrow while the right description column is wide. A small amount of additional padding on the left column would improve readability.
- H2 and H3 hierarchy correct.
- Page number (1) visible — OK.

### Page 3
- Verdict: MINOR
- Running header correct.
- PWM duty cycle waveform diagrams (three stacked graphs at 5%, 50%, 90%) render clearly — good educational value.
- Caption below graphs is readable.
- **MINOR**: The three waveform graphs appear to use very thin line strokes. In print (especially at reduced scale) the signal lines may be too faint. Consider slightly thicker strokes or higher contrast.
- Bullet list below graphs readable; bold inline terms clear.
- Page number (3) visible — OK.

### Page 4
- Verdict: OK
- Running header correct.
- "INTE COMMON ANODE" callout box: cyan-ish left accent visible, small caps title, body readable — OK.
- Body text explaining duty cycle readable; inline code clean.
- Color table (Röd, Grön, Blå, Vit, Magenta, Lila, Guldenrod, Mörk cyan): two columns, left color name, right R/G/B values in monospace. Columns aligned, padded well.
- No orphaned headings.
- Page number (4) visible — OK.

### Page 5
- Verdict: MINOR
- Running header correct.
- Arduino+RGB-LED breadboard photo renders at a good size; caption is italic gray — readable.
- **MINOR**: Caption is quite long and wraps to multiple lines at full column width — same issue as M1 p.2. A narrower caption max-width would improve aesthetics.
- H2 "Bygg från minnet" and skeleton code section render correctly.
- Code block ("SKELETT"): left accent bar visible, monospace font clean, background subtle — OK.
- **MINOR**: Inside the code block, the comment `// blå stiger` and `// total tid: 255 * 20 ms = 5 s` appear to be right-aligned or at least pushed to column right — verify these don't risk clipping near the right margin on narrow print columns.
- Page number (5) visible — OK.

### Page 6
- Verdict: MINOR
- Running header correct.
- "Hemma-övningar" section with three H3 exercises — hierarchy clear.
- Code block ("FOR-LOOP FÖR ÖVERGÅNGAR"): renders correctly with cyan accent bar and monospace font.
- **MINOR**: Below the for-loop code block, there is a plain explanatory paragraph `for (int i = 0; i <= 255; i++)` — this inline code is in monospace within body text, but it runs rather long and nearly reaches the right margin. No visible clipping, but tight.
- "Vanliga fel och snabblösningar" table: two-column layout, same style as M1. Renders correctly.
- Page number (6) visible — OK.

### Page 7
- Verdict: OK
- Running header correct.
- Troubleshooting table continuation renders cleanly.
- "Snabbreferens" quickref table: well-aligned, monospace left column, readable right column.
- PWM-pinnar row value "3, 5, 6, 9, 10, 11" renders without clipping.
- "I SLIDESEN" callout: cyan accent bar, small caps title, body readable — OK.
- H2 "Inför nästa träff" — correct clearance, no orphan.
- Page number (7) visible — OK.

---

## Summary

- **Total pages audited:** 13
- **Broken:** 0
- **Minor:** 9
- **OK:** 4

### Top 5 issues to fix

1. **Callout box accent bar too thin (M1 p.5, repeated pattern)** — The "LEDTRAD" and similar callout left accent bars are very thin and light; they risk disappearing in print. Increase stroke weight or darken the accent color.

2. **Two-image float layout creates narrow caption column (M1 p.3)** — The side-by-side LED + resistor photo layout forces the right-side caption into a very narrow column. Reflow to a single-row layout or use a wider caption area.

3. **Schematic/wiring diagram too small (M1 p.4)** — The circuit schematic is small enough that wiring detail may be illegible in print. Enlarge or provide a zoom inset.

4. **PWM waveform line strokes too thin (M2 p.3)** — The three duty-cycle waveform graphs use thin lines that may not survive print reproduction. Increase line weight.

5. **Callout type differentiation missing (M1 p.5)** — "EXEMPEL" and "SMART SÄTT" callout boxes look visually identical. If they convey different intent, differentiate them with distinct accent colors or label typography so students can distinguish at a glance.
