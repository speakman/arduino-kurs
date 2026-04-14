# Slides layout root-cause analysis — 2026-04-14

## TL;DR (one sentence)

The slides are NOT shrunken by a transform or wrong canvas — they render on a full 1920×1080 canvas as configured, but the body text, labels, captions and inline SVGs are authored with Tailwind **absolute-pixel** sizes (`text-xs`/`text-sm`/`text-base`/`text-lg` = 12–18 px, SVGs at 220×190 px) against a 1920-wide canvas. Relative to headlines at `text-6xl/text-7xl` (60–72 px) and against the full canvas width, body content becomes 1/5 to 1/8 the size it should be — visually interpreted by the viewer as "the slide shrunk into the upper-left corner."

There is no "different styles for different slides" bug, no missing layout, no rogue transform. There is ONE bug: the deck was typeset as if the canvas were a ~960-px browser window, then Slidev was told `canvasWidth: 1920`.

## The mechanism, end-to-end

1. `slides.md` sets `canvasWidth: 1920, aspectRatio: 16/9` → Slidev creates a `.slidev-slide-content` div that is literally 1920 × 1080 CSS pixels. `SlideContainer.vue` then `transform: scale()`s that whole box uniformly to fit whatever viewport/PDF page it is rendered into. Every slide uses the same canvas — no per-slide scale or zoom — confirmed in `presentation/node_modules/@slidev/client/internals/SlideContainer.vue` lines 45–56 and `env.ts` lines 10–14.
2. Inside that 1920-px canvas, Slidev's own base stylesheet `node_modules/@slidev/client/styles/layouts-base.css` line 2 sets:
   ```
   .slidev-layout { @apply px-14 py-10 text-[1.1rem] h-full; }
   ```
   i.e. default body font-size = **17.6 px on a 1920 canvas**. That is already too small — a body line should be ~30–36 px to feel like normal slide typography at 1920.
3. The project's `styles/main.css` only overrides `h1` (3.5 rem = 56 px) and `h2`. It never touches body size, paragraph size, list size or the utility classes. So the moment a slide uses `text-lg` (18 px), `text-sm` (14 px), `text-base` (16 px) or `text-xs` (12 px), that literal pixel value lands on the 1920 canvas. In viewer units that's 0.6 % – 0.9 % of slide width per x-height.
4. Headlines meanwhile are fixed at 3.5 rem (56 px) globally, 5.5 rem on `.section`, 4.2 rem on `.cover`, or explicitly `text-6xl`/`text-7xl` (60–72 px). So the ratio of headline : body on an "affected" slide is ~4:1 to 6:1 instead of a sane ~2:1 — which is exactly what "text crammed top-left, giant empty space" looks like.
5. Two of the three "default"-layout slides (5, 9, 10) compound the effect because `layout: default` is just `<div class="slidev-layout default"><slot/></div>` (see `client/layouts/default.vue`). There is no vertical centering. A short column of 14-px lines starting at `pt-12` fills maybe 30 % of slide height → black void below. There is nothing wrong with `default.vue`; it is doing what it always does. The content simply does not fill the box because it is typeset too small.
6. Slide 9's triangle SVG is `width="220" height="190"` — literally 220 CSS pixels on a 1920 canvas = 11 % of slide width. The `<text>` elements inside the SVG use `font-size="28"` and `font-size="24"` which, because SVG text scales with the SVG viewport, look *bigger* than the triangle that contains them. That is the "letters look OK but the triangle is broken" symptom, exactly.
7. Slides with the opposite failure mode — `layout: section`, `layout: cover`, `layout: center`, `layout: full` with inner flex — look fine only because their overrides in `main.css` (section h1 = 5.5 rem, cover h1 = 4.2 rem) or explicit inner `absolute inset-0 flex items-center justify-center` forcibly recenter and upsize the headline. The body text on THOSE slides is also 14–18 px, but the headline dominates and there is no big adjacent column of tiny text to expose the ratio, so the eye doesn't catch it.

## The fingerprint

An "affected" slide is any slide where **ALL three** of the following are true:

1. Frontmatter is `layout: default` OR `layout: two-cols-header` OR `layout: two-cols` (i.e. layouts with no forced flex-center and no section/cover override in `main.css`).
2. The body content outside `<h1>` uses any of `text-xs text-sm text-base text-lg text-xl` (or no explicit size at all, inheriting the 1.1 rem base), AND does **not** wrap itself in a `sp-grid`, `warn-box`, `tip-box` or a custom component whose CSS forces a larger font-size.
3. The content's natural flow stops before reaching roughly 60 % of canvas height (short paragraphs, short lists, small SVG).

Grep fingerprint that finds every offender in one pass:

```
# Slides whose body uses small tailwind sizes
grep -n 'layout: \(default\|two-cols\)' slides.md
grep -nE '\btext-(xs|sm|base|lg|xl)\b' slides.md
```

## Categorisation of slides 1–10

| # | Source lines | Layout | Verdict | One-line reason |
|---|---|---|---|---|
| 1 | 1–66 | `cover` | OK | `.slidev-layout.cover` in main.css + `text-2xl` subtitle + absolute-positioned corner notes on a hero image — headline at 4.2 rem dominates, body text is tiny but visually irrelevant. |
| 2 | 67–133 | `default` | OK | Uses `text-6xl` h1 and the `.sp-grid` component whose `.sp-name` is 1.3 rem and `.sp-icon` is 3.25 rem — the component forces large sizes, so the canvas looks filled. |
| 3 | 134–171 | `center` | OK | `center.vue` uses `grid place-content-center` → intrinsic-width content is centred; squares are `w-40 h-40` = 160 px which reads big enough. |
| 4 | 172–205 | `section` | BORDERLINE — user said "looks small" | `.slidev-layout.section` flex-centers everything and forces h1 to 5.5 rem, so the headline is actually large (~88 px). But the content footprint is still ~25 % of slide width → user reads it as "small / empty." Not a CSS bug, a composition issue. |
| 5 | 206–265 | `default` | **AFFECTED** | 2-col grid of agenda items typed with `text-lg` (18 px), `text-sm` (14 px), `text-xs` (12 px) on a 1920 canvas. Content stops around y=400 of 1080. Classic top-left shrunken look. |
| 6 | 266–305 | `full` | OK | Inner `<div class="absolute inset-0 flex items-center justify-center">` forcibly centres the content; uses `text-7xl` + `text-xl`. |
| 7 | 306–380 | `image-left` | OK (but fragile) | Image fills left half; text column on the right uses `text-xl` (20 px) and `text-xs` (12 px). The tiny lines are invisible at distance but the image hides the whitespace so nobody complains. |
| 8 | 381–428 | `default` | OK | Uses `text-3xl` / `text-5xl` inside `.grid.grid-cols-3` card tiles — big enough that the canvas reads filled. |
| 9 | 429–481 | `default` | **AFFECTED** | SVG hard-coded to 220×190 CSS px (11 % of canvas width) + `text-2xl` body copy. Explains exactly "triangeln är alldeles för liten — bokstäverna inuti är rimliga" because SVG text scales with its viewport but the viewport is 220×190. |
| 10 | 482–542 | `two-cols-header` | **AFFECTED** | Body column uses `text-lg` (18 px), tip-box uses inherited 17.6 px; ascii-arrow column uses `text-sm` (14 px). Left column stops at ~40 % height, right column is a 3-line block. Everything below ~50 % of canvas is empty.

Slides 11, 13, 14 not rendered in screenshots, but the user's complaint ("13+14 helt galen skalning, 14 säger 'kittets manual' längst ner") is consistent with the same fingerprint: small-font body + `layout: default`. The "kittets manual" text at the bottom is almost certainly content that was marked as a speaker-note reference but ended up in the slide body, not a layout bug.

## Global fix

Because the bug is "body text was authored at desktop-browser pixel sizes on a 1920 presentation canvas," the fix is a **single CSS block in `presentation/styles/main.css`** that re-bases the Tailwind absolute size scale to canvas-appropriate values *inside* `.slidev-layout`, AND forces `layout: default` to flex-center its content vertically so short slides don't collapse top-left. No per-slide edits needed.

```css
/* === Canvas-calibrated typography === */
/* The deck is authored for canvasWidth: 1920. Tailwind's absolute text-*
   utilities (text-xs..text-xl) are desktop-browser pixels and are 2-3×
   too small at this canvas. Rebase them globally inside .slidev-layout
   so every slide reads at presentation-appropriate sizes without
   per-slide edits. */
.slidev-layout {
  font-size: 1.75rem;          /* was 1.1rem — 28 px body on 1920 canvas */
  line-height: 1.45;
}
.slidev-layout .text-xs   { font-size: 1.10rem !important; line-height: 1.5; }  /* 17.6px */
.slidev-layout .text-sm   { font-size: 1.30rem !important; line-height: 1.5; }  /* 20.8px */
.slidev-layout .text-base { font-size: 1.60rem !important; line-height: 1.5; }  /* 25.6px */
.slidev-layout .text-lg   { font-size: 1.85rem !important; line-height: 1.5; }  /* 29.6px */
.slidev-layout .text-xl   { font-size: 2.15rem !important; line-height: 1.4; }  /* 34.4px */
.slidev-layout .text-2xl  { font-size: 2.60rem !important; line-height: 1.35; } /* 41.6px */

/* === Force layout:default to vertically centre short content === */
/* default.vue is just a bare <div class="slidev-layout default"><slot/></div>,
   so short slides (agenda, Ohms lag, etc.) collapse to the top-left.
   Promote it to a flex column that centres its content while preserving
   the top padding already set via frontmatter `class: px-14 pt-12`. */
.slidev-layout.default {
  display: flex;
  flex-direction: column;
  justify-content: center;
}
/* Escape hatch for slides that genuinely want top-anchored flow
   (e.g. long bulleted content). Add `class: default top` in frontmatter. */
.slidev-layout.default.top {
  justify-content: flex-start;
}

/* === SVG sanity: never let an inline SVG be smaller than 30% of canvas width === */
/* Prevents the "tiny triangle" problem (slide 9) without touching markup. */
.slidev-layout svg {
  min-width: min(100%, 30rem);
  height: auto;
}
```

Notes on the choices:

- **Why rebase in .slidev-layout and not :root?** Scoping to `.slidev-layout` keeps the presenter-UI chrome (speaker notes panel, nav bar) untouched. The fix only applies while Slidev is rendering slide content.
- **Why `!important` on the text-* utilities?** UnoCSS (which Slidev uses) injects them with layer=utilities specificity; matching or exceeding that is cleanest with `!important` once. The alternative is configuring `uno.config.ts` to rescale the typography preset — larger change, same effect.
- **Why not fix at `canvasWidth`?** Lowering canvasWidth to e.g. 1280 would fix the ratios but shrinks SVGs and images the author specified in CSS pixels, and breaks existing `.sp-grid`/tile CSS that was tuned for 1920. Rebasing the text scale is lower-impact.
- **Why `justify-content: center` on `.default`?** It's the smallest change that turns the "top-left collapse" symptom into "centred column." Slides that already use their own `h-full flex` wrapper (like slide 1) are unaffected because the outer flex box has nothing to center against — the inner `h-full` child fills it and takes over.
- **SVG min-width:** slide 9's broken triangle is fixed without editing the markdown. Any inline SVG smaller than 30 rem (480 px at 16 px root) is stretched up. Slides with legitimately large SVGs are unchanged because `min-width` cannot shrink.

## What this fix does NOT do

- Does not center slide 4 any better than `.section` already does — that was borderline and a pure composition critique, not a layout bug.
- Does not fix slide 14's "kittets manual" bottom text — that is a content error (a speaker-note reference leaked into slide body), not a CSS bug. Must be fixed by editing that slide.
- Does not fix `text-3xl` and above — they are already large enough at 1920; rebasing them would make headlines explode past the canvas.
- Does not touch the `image-left`/`image-right` layouts; those slides look fine today.

## Verification plan

After applying the CSS patch, re-export and re-render slides 1-14:

```
cd /Users/daniel/projects/arduino-kurs/presentation
npx slidev export --output /tmp/slides-fixed.pdf slides.md
pdftoppm -r 192 -scale-to-x 1920 -scale-to-y 1080 \
  -f 1 -l 14 /tmp/slides-fixed.pdf /tmp/slides-audit-after/slide -png
```

Pass criteria:

1. Slides 5, 9, 10, 11, 13, 14: body text reads ~28 px at canvas size (roughly 1/60 of slide width, "paperback-book large"); content occupies ≥ 60 % of slide height; no single slide has a full lower-right quadrant of empty black.
2. Slides 1, 2, 3, 4, 6, 7, 8: visually unchanged (before/after diff shows only text-size-class deltas, not layout shifts).
3. Slide 9: the Ohms-law triangle is now ≥ 480 px wide and the U/I/R letters inside sit at their vertices (not overlapping).

## Confidence

**High** — for the diagnosis of the mechanism. I traced the full rendering chain (`SlideContainer` → `PrintContainer` → `PrintSlideClick` → `SlideWrapper` → `layouts-base.css` → project `main.css`), confirmed `canvasWidth: 1920` is honoured, confirmed there is no per-slide transform, confirmed `layout: default` has no centering, confirmed the body font-size floor is 17.6 px on a 1920 canvas, and matched the symptom per-slide against the grep fingerprint.

**Medium-high** — for the specific rebase values in the CSS patch. They are calibrated against 1920 but unverified empirically; a single screenshot round-trip would move this to high. The escape hatch `.default.top` is the safety net if any slide becomes too cramped after centring.

**What would raise it to fully high:** run the CSS patch, re-export slides 1-14, re-read the PNGs, confirm the "top-left collapse" symptom is gone on slides 5/9/10/11/13/14 and no regression on 1/2/3/6/7/8.
