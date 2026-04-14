# Slide Triage — 2026-04-14
> 52 slides rendered at 1920×1080. Diagnosis only — no files were edited.

---

## TL;DR

| Category | Slides |
|---|---|
| **[A] Content pushed hard into top-left / enormous empty bottom half** | 2, 5, 8, 25, 31, 41, 50 |
| **[B] Inline-code badge overflows into adjacent paragraph line (line-height clash)** | 18 |
| **[C] Manual `·` bullet paragraphs get 1em `p + *` rhythm → excessive inter-line gaps** | 18, 26, 46 |
| **[D] Two-cols-header layout renders too small / thumbnail-scale (thumbnail-mode fallback?)** | 10, 16, 24, 29, 33, 37 |
| **[E] Text overlapping itself — two paragraphs rendered on top of each other** | 46 |
| **[F] Orphaned / mis-wrapped text / content bugs** | 18 (word-wrap break mid-word "väljer."), 46 (two-line overlap) |

---

## Root-cause groupings

### Group A — Content anchored to top, half the canvas empty (7 slides)

**Slides:** 2, 5, 8, 25, 31, 41, 50

**What you see:** Heading + content block occupies roughly the upper 40–50 % of the canvas. The lower half is a pure black void. The content itself is fine; it is just sitting at the very top instead of being vertically centered.

**Root cause:** These slides all use `layout: default` with explicit top-padding classes (`px-14 pt-12` or `px-14 pt-16`). The `pt-12` / `pt-16` Tailwind utility provides a large fixed top padding. Because the layout is `flex-column + justify-content: safe center`, the centering only kicks in when the content is taller than the centerable area. When content is short (eyebrow + h1 + 2–3 short items), the large `pt-*` shifts the natural flow point well above center; the flexbox safe-center never wins back the lost vertical space.

Slides with heavy `pt-*` but *sufficient* content (e.g. slide 14 "Bygg kretsen" with 5 numbered steps, or slide 17 "Hela Blink" with the code table) look balanced. Slides with sparse content and `pt-16` look stranded at the top.

**Global fix** — reduce default top padding for short-content default slides, or remove the per-slide `pt-*` override entirely and let `justify-content: safe center` do its job:

```css
/* In main.css — tighten the default padding so safe center can truly center short content */
.slidev-layout.default {
  padding: 3rem 3.5rem;   /* was effectively pt-12 (3rem) or pt-16 (4rem) via Tailwind */
}
```

Then remove `pt-12` / `pt-16` from the per-slide `class:` frontmatter on slides 2, 5, 8, 25, 31, 41, 50. Because the CSS `justify-content: safe center` is already in place, content will automatically sit in the optical center of the canvas regardless of how much of it there is.

**Alternative global approach** (no frontmatter edits needed): cap the top padding when the layout is in flex-column centering mode:

```css
.slidev-layout.default {
  padding-top: min(3rem, 5vh);
}
```

---

### Group B — Inline `<code>` badge overflows line-height (1 slide, known issue)

**Slide:** 18 ("Din egen rytm")

**What you see:** The word "Blink" rendered as a cyan badge (`.mono` span with `background: var(--ak-accent-soft)`) sits inside a `text-3xl leading-relaxed` paragraph. The badge's padded box (0.15em top + 0.15em bottom) clips into the line above or below because `line-height: 1.45` on the base layout (and `leading-relaxed = 1.625` on the override) leaves insufficient vertical gap for a 0.9em badge with 0.3em of vertical padding.

**Root cause:** `:not(pre) > code` has `padding: 0.15em 0.4em`. At `text-3xl` (3.2rem = ~51px), that's ~7.5px of top/bottom padding per side, adding ~15px of extra height. With `line-height: 1.45` the inter-line gap at that size is ~22px — barely enough. Any font rendering or sub-pixel rounding collapses it to zero on the line below the badge.

**Global fix:**

```css
/* main.css — give inline code more breathing room via line-height bump */
.slidev-layout :not(pre) > code,
.slidev-layout .mono {
  line-height: 1.8;          /* lift the line containing the badge only */
  vertical-align: -0.05em;   /* optical correction keeps baseline aligned */
}
```

This is safe: `line-height` on an inline element affects only the line box that contains it, not surrounding lines.

---

### Group C — Manual `·` bullets via `<div>` paragraphs get aggressive `p + *` rhythm (3 slides)

**Slides:** 18 ("Din egen rytm"), 26 ("Hitta färgen"), 46 ("Hitta din tröskel")

**What you see:**
- Slide 18: the three `·` bullet `<div>`s inside a wrapper each get a 1em top-margin from the `p + *` rule because the wrapping paragraph (`Ändra Blink till ett mönster…`) is followed by a sibling `<div>` — the spacing is ~2–3× what a tight bullet list should have.
- Slide 26: same pattern — four `·` items separated by exaggerated gaps.
- Slide 46: most severe — two overlapping text blocks are both at ~1em-spaced interval from the lead paragraph, making the slide appear to stack two copies of the lead sentence on top of each other (the second `<div>` is rendered at the same Y as the tail of the first).

**Root cause:** The `p + *` rule fires on `<p>` → `<div>` transitions (the manual bullet wrappers are `<div>`s, not `<li>`s). Every `<div>` after the opening paragraph acquires `margin-top: 1em`. This compounds across the wrapper → child → next-child chain.

**Global fix** — scope the rhythm rule more tightly so it does not apply inside `space-y-*` containers (which handle their own gap) and does not cascade into nested divs:

```css
/* main.css — restrict p + * to direct block-level markdown siblings, not arbitrary divs */
.slidev-layout > * p + *,
.slidev-layout .prose p + * {
  margin-top: 1em;
}

/* Remove the broad blanket rule: */
/* DELETE: .slidev-layout p + *, .slidev-layout :is(ul, ol) + * { margin-top: 1em; } */
```

Alternatively, a lighter-touch fix that preserves the rhythm for genuine prose but cancels it inside manual layout wrappers:

```css
/* Cancel rhythm inside any element that carries a space-y-* class */
.slidev-layout [class*="space-y"] p + * {
  margin-top: 0;
}
```

This resolves all three slides without any per-slide edits.

---

### Group D — Two-cols-header / image-right slides render as tiny thumbnails (6 slides)

**Slides:** 10 ("Kretsen — som ett vattensystem"), 16 ("setup() och loop()"), 24 ("analogWrite"), 29 ("const int och int"), 33 ("Reagera på flanken"), 37 ("Kärnan i loop()")

**What you see:** The entire slide content appears at roughly 30–40% of normal scale, as if the canvas were 1024×576 instead of 1920×1080. All text, code blocks, and boxes are far too small and text appears in the lower-left quadrant with large black regions elsewhere.

**Root cause:** These slides have `layout: two-cols-header` **without** a `class: px-14 pt-12` (or with additional class overrides). The `grid-template-rows: auto auto auto !important` rule works as expected when the parent has normal box-sizing, but Slidev may inject a `<div class="slidev-layout two-cols-header">` that inherits a transform or zoom from the export pipeline. The fact that exactly the `two-cols-header` slides look undersized strongly suggests either:
1. A missing `width: 100%` / `height: 100%` on the two-cols-header container, so it shrinks to fit content rather than filling the canvas; or
2. The layout's grid not having `width: 100%; height: 100%` forced, leaving it to default block behaviour at the viewport's intrinsic size before the 1920-canvas scale is applied.

**Global fix:**

```css
/* main.css */
.slidev-layout.two-cols-header {
  width: 100%;
  height: 100%;
  min-height: 100%;    /* ensure it fills the canvas even with auto row heights */
  box-sizing: border-box;
}
```

If the issue is a zoom/scale applied by the exporter rather than a CSS sizing issue, also verify:

```css
.slidev-layout {
  transform-origin: top left;  /* prevent any inherited scale from mis-anchoring */
}
```

**Confidence note:** This group has the lowest confidence (see below) because all 6 slides looking uniformly under-sized could also mean the Slidev export applied the wrong canvas scaling for these specific layouts. Inspect the live browser render before committing a CSS fix.

---

### Group E — Text overlapping itself (slide 46, subset of Group C)

**Slide:** 46 ("Hitta din tröskel")

This is the most severe instance of Group C. The opening paragraph ("Printa **både** ljus och tilt…") and the immediately-following `<div>` block containing the bullet items land at the same Y coordinate — the second block renders directly on top of the first. This is not just spacing-too-large; it is spacing-effectively-zero (or negative), probably because the `<div class="mt-10 text-2xl">` wrapping element itself already has a margin that places the child bullets in a position that conflicts with the inner paragraph's bottom edge.

The Group C global fix resolves this.

---

## Per-slide notes (broken slides only)

| # | Slide title | Issue | Fix |
|---|---|---|---|
| 02 | Kursöversikt — Fem träffar | Content block in upper third; large black void below | Group A global fix |
| 05 | Dagens upplägg — Idag | Content block ~upper 45%; large void below | Group A global fix |
| 08 | Spänning, ström, GND | Three cards in upper half; empty lower half | Group A global fix |
| 10 | Kretsen — som ett vattensystem | Entire slide miniaturised (~35% scale), layout cramped into lower-left | Group D global fix |
| 16 | `setup()` och `loop()` | Entire slide miniaturised (~35% scale), code and text illegibly small | Group D global fix |
| 18 | Din egen rytm | (1) `Blink` badge clips line above; (2) `·` bullet items have ~1em gaps making them look unrelated; (3) line wraps mid-word ("väljer.") | Group B + Group C fixes |
| 24 | `analogWrite` | Entire slide miniaturised; heading + code code cramped bottom-left | Group D global fix |
| 25 | Duty cycle | Heading + content in upper 40%; lower half empty | Group A global fix |
| 26 | Hitta färgen | `·` bullets spaced too far apart via p+* rule | Group C global fix |
| 29 | `const int` och `int` | Entire slide miniaturised | Group D global fix |
| 31 | `if` / `else` | Content in upper 45%; lower half empty | Group A global fix |
| 33 | Reagera på flanken | Entire slide miniaturised | Group D global fix |
| 37 | Kärnan i `loop()` | Entire slide miniaturised | Group D global fix |
| 41 | `analogRead()` — Arduinons linjal | Content in upper 45%; lower half empty | Group A global fix |
| 46 | Hitta din tröskel | Two paragraphs rendered on top of each other + `·` bullets over-spaced | Group C global fix (resolves both) |
| 50 | Ingenjörsuppgiften | Content in upper 50%; lower half empty | Group A global fix |

---

## Slides that look fine (skipped)

1 (cover), 3 (klassrumsverktyg — intentional centered composition), 4 (section — LED & krets), 6 (slutmålet hero), 7 (Mikrokontrollern image-left), 9 (Ohms lag), 11 (LED & resistor — two-cols no header), 12 (Breadboard), 13 (Felsökning hero), 14 (Bygg kretsen — numbered steps), 15 (Så här ska det se ut — wiring), 17 (Hela Blink — tre rader), 19 (Delresultat träff 1), 20 (Nästa gång — end), 21 (section — PWM & RGB), 22 (Alla färger — center), 23 (Koppla RGB-LED), 27 (section — Ni har en pixel), 28 (section — Digital input), 30 (Digital Input ≠ Output), 32 (Koppla knappen), 34 (En varning först — image-right), 35 (Koppla buzzern), 36 (Läs knapp. Styr buzzer), 38 (Arduinon lyssnar), 39 (section — Analog input), 40 (Knappen var digital), 42 (Spänningsdelaren), 43 (Koppla fotocellen), 44 (Koppla tilt-sensorn), 45 (Serial Monitor), 47 (Koden att köra), 48 (Arduinon känner världen), 49 (section — Integration), 51 (Pin-tilldelning — dark thumbnail mode but intentional dense reference slide), 52 (Tack — end)

---

## Content bugs (not layout)

None found on rendered slides. The three occurrences of "REFERENS: kittets manual." in `slides.md` are all inside HTML `<!-- -->` comment blocks (lines 377, 542, 786) and do not appear on any rendered slide. No visible TODO markers, orphaned text, or typos were detected in the PNG renders.

---

## Confidence

| Group | Confidence | Reasoning |
|---|---|---|
| A — top-anchored content | **High** | Consistent across 7 slides; all have `pt-12`/`pt-16` + short content; flexbox safe-center analysis is deterministic |
| B — inline code line-height | **High** | Single-slide, visually unambiguous clip at slide 18 |
| C — p+* over-spacing | **High** | Mechanism is well-understood; three slides show it at different severities; root selector confirmed in main.css |
| D — miniaturised two-cols-header | **Medium** | All 6 affected slides share the `two-cols-header` layout; the 35%-scale appearance is striking and consistent, but the exact cause (missing `width/height: 100%` vs. export zoom miscalibration) needs a live browser check to confirm before applying the CSS fix |
| E — text overlap on slide 46 | **High** | Visually unambiguous; directly traceable to Group C mechanism |
