# Light-mode Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Konvertera Slidev-presentationen från dark-only till light-only för pedagogiskt-optimerad projektor-läsbarhet, baserat på godkänd design i `tasks/2026-05-05-light-mode-design.md`.

**Architecture:** Single-theme via Slidev `colorSchema: 'light'` + ett enda token-set i `:root`. Alla dark-mode-hacks (mix-blend, invert-filter, hardkodad `background:white`, `ring-white/10`) tas bort. Pedagogiskt skyddade konstanter (resistor-band, RGB-LED-färger, RGB-färgexempel) lämnas orörda.

**Tech Stack:** Slidev (theme: default), UnoCSS, Shiki (dual-theme bibehålls i `setup/shiki.ts`), Vue (WiringSlide.vue), inline-SVG, Playwright Chromium (för rendering).

**Spec:** `tasks/2026-05-05-light-mode-design.md`

---

## Förberedelse

### Task 0: Feature-branch och baseline-referens

**Files:**
- Create: `tasks/light-mode-baseline/` (mapp för referensskärmdumpar)

- [ ] **Step 1: Skapa feature-branch**

```bash
git checkout -b light-mode-only
```

- [ ] **Step 2: Spara nuvarande tasks-rapporter (committa designspec och audits)**

```bash
git add tasks/2026-05-05-light-mode-design.md tasks/asset-audit-light-mode.md tasks/slide-inventory-light-mode.md tasks/slidev-native-theme-research.md tasks/2026-05-05-light-mode-plan.md
git commit -m "docs(light-mode): designspec, audits och implementation-plan"
```

- [ ] **Step 3: Säkerställ att utvecklingsmiljön fungerar**

Run: `cd presentation && npm install` (om node_modules inte finns)
Run: `npm run dev` (i bakgrund)
Verify: Webbläsare öppnas på http://localhost:3030 och slide 1 visas i nuvarande dark-mode.

Stoppa servern (`Ctrl+C`) innan nästa task.

---

## Fas 1 — Tema-switch (CSS + Frontmatter)

### Task 1: Atomisk tema-switch — frontmatter + CSS-tokens

**Files:**
- Modify: `presentation/slides.md:21-25` (frontmatter)
- Modify: `presentation/styles/main.css:17-31` (Design-tokens-blocket)

**Rationale (per Gemini-review):** Frontmatter (`colorSchema`) och `:root`-tokens är strukturellt beroende — utan båda samtidigt blir presentationen visuellt trasig. Atomisk commit förhindrar att `git bisect` landar på ett brutet mellantillstånd.

- [ ] **Step 1: Ersätt frontmatter i slides.md**

Hitta rad 21-25:

```yaml
background: '#0a0e14'
class: cover
drawings:
  persist: false
colorSchema: dark
```

Ersätt med:

```yaml
class: cover
drawings:
  persist: false
colorSchema: 'light'
```

(Notera: `background: '#0a0e14'` tas bort helt — CSS-tokens hanterar bakgrunden.)

- [ ] **Step 2: Ersätt :root-tokenarna i main.css**

Hitta:

```css
:root {
  --ak-bg: #0a0e14;
  --ak-bg-raised: #111820;
  --ak-border: #1f2933;
  --ak-text: #eaeaea;
  --ak-text-dim: #9aa5b1;
  --ak-text-mute: #616e7c;
  --ak-accent: #00ffd1;
  --ak-accent-soft: rgba(0, 255, 209, 0.12);
  --ak-warn: #ffd400;
  --ak-danger: #ff3366;
  --ak-glow-cyan: 0 0 24px rgba(0, 255, 209, 0.35);
  --ak-glow-red: 0 0 24px rgba(255, 51, 102, 0.35);
}
```

Ersätt med:

```css
:root {
  /* Bakgrund och struktur */
  --ak-bg:        #fafaf7;
  --ak-bg-raised: #f0f1ed;
  --ak-border:    #d4d6d0;

  /* Text */
  --ak-text:      #0a0e14;
  --ak-text-dim:  #4a5568;
  --ak-text-mute: #8a95a3;

  /* Accent — Arduino-teal, AA-justerad */
  --ak-accent:      #00838c;
  --ak-accent-soft: rgba(0, 131, 140, 0.10);

  /* Semantik */
  --ak-warn:   #b45309;
  --ak-danger: #be123c;

  /* Glow — subtila accenter på framhävda kort */
  --ak-glow-cyan: 0 0 24px rgba(0, 131, 140, 0.15);
  --ak-glow-red:  0 0 24px rgba(190, 18, 60, 0.12);

  /* Skuggor och cover-text */
  --ak-code-shadow:  0 4px 14px rgba(15, 23, 42, 0.08);
  --ak-cover-fg:     #0a0e14;
  --ak-cover-shadow: none;
}
```

- [ ] **Step 3: Verifiera dev hot-reload**

Run: `cd presentation && npm run dev` (i bakgrund om inte redan igång) → bläddra till slide 1.
Expected: Slide 1 har nu vit-aktig bakgrund, mörk text, Arduino-teal accent. Cover-fotot visas men gradient-overlay och cover-h1-färg är fortfarande hardkodad dark i CSS (fixas i Task 2).

- [ ] **Step 4: Atomisk commit**

```bash
git add presentation/slides.md presentation/styles/main.css
git commit -m "feat(theme): switch till light-mode (frontmatter + tokens i en commit)"
```

---

### Task 2: CSS — layout-overrides (.cover, .section, .end)

**Files:**
- Modify: `presentation/styles/main.css:181-218` (.section, .cover, .end-block)

- [ ] **Step 1: Ersätt .section-blocket**

Hitta:

```css
.slidev-layout.section {
  background: radial-gradient(circle at 30% 30%, #141b26 0%, var(--ak-bg) 60%) !important;
  ...
}
```

Ersätt `background:`-raden med:

```css
.slidev-layout.section {
  background: radial-gradient(circle at 30% 30%, var(--ak-bg-raised) 0%, var(--ak-bg) 60%) !important;
  ...
}
```

(Resten av blocket — flex/align/h1-styling — lämnas orört.)

- [ ] **Step 2: Ersätt .cover-blocket**

Hitta:

```css
.slidev-layout.cover {
  background-color: var(--ak-bg) !important;
  background-image:
    linear-gradient(180deg, rgba(10, 14, 20, 0.35) 0%, rgba(10, 14, 20, 0.55) 55%, rgba(10, 14, 20, 0.95) 100%),
    url('/images/cover-arduino-hero.jpg') !important;
  background-size: cover !important;
  background-position: center center !important;
  background-repeat: no-repeat !important;
}
.slidev-layout.cover h1 {
  font-size: 4.2rem;
  line-height: 1.05;
  max-width: 100%;
  color: #ffffff;
  text-shadow: 0 2px 20px rgba(0, 0, 0, 0.9);
}
```

Ersätt med:

```css
.slidev-layout.cover {
  background-color: var(--ak-bg) !important;
  background-image:
    linear-gradient(180deg,
      color-mix(in srgb, var(--ak-bg) 25%, transparent) 0%,
      color-mix(in srgb, var(--ak-bg) 45%, transparent) 55%,
      color-mix(in srgb, var(--ak-bg) 88%, transparent) 100%),
    url('/images/cover-arduino-hero.jpg') !important;
  background-size: cover !important;
  background-position: center center !important;
  background-repeat: no-repeat !important;
}
.slidev-layout.cover h1 {
  font-size: 4.2rem;
  line-height: 1.05;
  max-width: 100%;
  color: var(--ak-cover-fg);
  text-shadow: var(--ak-cover-shadow);
}
```

- [ ] **Step 3: Ersätt .end-blocket**

Hitta:

```css
.slidev-layout.end {
  background: radial-gradient(ellipse at center, #1a2435 0%, var(--ak-bg) 70%) !important;
}
```

Ersätt med:

```css
.slidev-layout.end {
  background: radial-gradient(ellipse at center, var(--ak-bg-raised) 0%, var(--ak-bg) 70%) !important;
}
```

- [ ] **Step 4: Verifiera visuellt**

Bläddra till slide 1 (cover), 3 (section), 52 (end) i dev-läget.
Expected: Cover-fotot syns naturligt med ljus gradient ovanpå (texten är mörk på ljus). Section-rubrikerna har subtilt ljusgrå radial. End-sliden har mjuk ljusgrå mittpunkt.

- [ ] **Step 5: Commit**

```bash
git add presentation/styles/main.css
git commit -m "feat(styles): light-versioner av .cover/.section/.end-gradients"
```

---

### Task 3: CSS — code-wrapper, rgb-white, html.print

**Files:**
- Modify: `presentation/styles/main.css:109-113` (code-wrapper)
- Modify: `presentation/styles/main.css:241` (rgb-white)
- Modify: `presentation/styles/main.css:252-270` (html.print-block)

- [ ] **Step 1: Tokenisera code-wrapper-shadow**

Hitta:

```css
.slidev-layout .slidev-code-wrapper {
  border-radius: 12px;
  border: 1px solid var(--ak-border);
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
}
```

Ersätt `box-shadow`-raden:

```css
.slidev-layout .slidev-code-wrapper {
  border-radius: 12px;
  border: 1px solid var(--ak-border);
  box-shadow: var(--ak-code-shadow);
}
```

- [ ] **Step 2: Fixa .rgb-white**

Hitta:

```css
.rgb-white  { background-image: radial-gradient(circle closest-side, #ffffff 55%, rgba(255, 255, 255, 0.3) 70%, rgba(255, 255, 255, 0) 100%); }
```

Ersätt med:

```css
.rgb-white  { background-image: radial-gradient(circle closest-side, #d4d6d0 55%, rgba(212, 214, 208, 0.3) 70%, rgba(212, 214, 208, 0) 100%); }
```

- [ ] **Step 3: Förenkla html.print-blocket**

Hitta:

```css
html.print .slidev-layout .slidev-code-wrapper { box-shadow: none; }
html.print .sp.unlocked,
html.print .sp.current { box-shadow: none; }
html.print .warn-box { box-shadow: none; }
html.print .slidev-layout.cover {
  background-image: none !important;
}
html.print .slidev-layout.cover h1 {
  text-shadow: none;
}
html.print .shadow-2xl,
html.print .shadow-xl,
html.print .shadow-lg { box-shadow: none !important; }
```

Ersätt med (rensar bara redundanta cover-shadow-regeln; behåller cover-image-knockout för print eftersom Chromium-rastering har historiska buggar med `linear-gradient` ovanpå `url()` som ger banding/uppsvälld PDF):

```css
/* Print-export: Chromium-rastering bandar tunga blur:s. Knocka shadows. */
html.print .slidev-layout .slidev-code-wrapper { box-shadow: none; }
html.print .sp.unlocked,
html.print .sp.current { box-shadow: none; }
html.print .warn-box { box-shadow: none; }
html.print .slidev-layout.cover {
  background-image: none !important;
}
html.print .shadow-2xl,
html.print .shadow-xl,
html.print .shadow-lg { box-shadow: none !important; }
```

- [ ] **Step 4: Verifiera dev fortfarande renderar**

Bläddra till slide 15 (kodblock), slide 19 (rgb-circles), slide 1 (cover).
Expected: Kodblock har mjuk ljusgrå skugga (ej tung). RGB-cirklar inkl. "vit"-cirkeln syns mot vit bg. Cover-fotot oförändrat.

- [ ] **Step 5: Commit**

```bash
git add presentation/styles/main.css
git commit -m "feat(styles): tokenisera code-shadow, fixa rgb-white, förenkla print-overrides"
```

---

## Fas 2 — Slide-specifika fixar

### Task 4: Slide 8 — Ohms-triangel

**Files:**
- Modify: `presentation/slides.md:415-421`

- [ ] **Step 1: Identifiera nuvarande hardcodade färger**

Read `presentation/slides.md:393-453`. Notera radnummer för varje `#00ffd1` och `#e8ecf1`.

- [ ] **Step 2: Ersätt SVG-stroke och inline-color med tokens**

Sök i slide 8-blocket (rad 393-453) efter alla förekomster av:

```html
<!-- Före -->
stroke="#00ffd1"
style="color:#00ffd1"
style="color:#e8ecf1"
style="color:#00ffd1;opacity:0.8"
```

Ersätt med:

```html
<!-- Efter -->
stroke="var(--ak-accent)"
style="color:var(--ak-accent)"
style="color:var(--ak-text)"
style="color:var(--ak-accent);opacity:0.8"
```

(Det finns 6 förekomster på rad 415-421 enligt design-specen.)

- [ ] **Step 3: Verifiera visuellt**

Bläddra till slide 8 i dev-läget.
Expected: Triangeln ritas med Arduino-teal stroke. "U", "R · I", "U/I", "U/R"-symbolerna är synliga (mörk text).

- [ ] **Step 4: Commit**

```bash
git add presentation/slides.md
git commit -m "fix(slide8): byt hardkodade dark-färger mot tokens i Ohms-triangeln"
```

---

### Task 5: Slide 11 — Breadboard-internals

**Files:**
- Modify: `presentation/slides.md:610` (inline-style → klass)
- Modify: `presentation/styles/main.css` (lägg till klass)

- [ ] **Step 1: Lägg till .breadboard-diagram-klass i main.css**

Lägg till efter befintlig `.dots-bg`-regel (omkring rad 250):

```css
.breadboard-diagram {
  width: 100%;
  margin-top: 12px;
  border-radius: 8px;
  background: white;
  padding: 10px;
  border: 1px solid var(--ak-border);
}
```

- [ ] **Step 2: Ersätt inline-style med klass i slide 11**

Hitta rad 610:

```html
<img src="/images/breadboard-internals.png" style="width:100%;margin-top:12px;border-radius:8px;background:white;padding:10px" />
```

Ersätt med:

```html
<img src="/images/breadboard-internals.png" class="breadboard-diagram" />
```

- [ ] **Step 3: Verifiera**

Bläddra till slide 11.
Expected: Breadboard-internals-bilden syns identisk som tidigare (vit bg, padding, border-radius).

- [ ] **Step 4: Commit**

```bash
git add presentation/slides.md presentation/styles/main.css
git commit -m "refactor(slide11): flytta breadboard-img-style till .breadboard-diagram-klass"
```

---

### Task 6: Slide 21 — RGB-färgblandning (ta bort blend-mode)

**Files:**
- Modify: `presentation/slides.md:1151` (eller varhelst img-taggen är)
- Modify: `presentation/styles/main.css` (lägg till .rgb-demo-klass)

- [ ] **Step 1: Lägg till .rgb-demo-klass i main.css**

Lägg till efter `.breadboard-diagram` (eller annan logisk plats):

```css
.rgb-demo {
  width: 26rem;
  border-radius: 1rem;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
  background: #000;
  padding: 1rem;
}
```

- [ ] **Step 2: Ersätt img-taggen i slide 21**

Read `presentation/slides.md:1140-1193` för att hitta exakt rad för `<img src="/images/rgb-color-mixing.png" ...>`.

Hitta:

```html
<img src="/images/rgb-color-mixing.png" style="mix-blend-mode: screen; ..." />
```

Ersätt med:

```html
<img src="/images/rgb-color-mixing.png" class="rgb-demo" />
```

- [ ] **Step 3: Verifiera visuellt**

Bläddra till slide 21.
Expected: RGB-färgblandnings-bilden syns inramad i en svart "skärm-look" mot ljus slide. De tre färgcirklarna och deras additiva överlapp syns klart.

- [ ] **Step 4: Commit**

```bash
git add presentation/slides.md presentation/styles/main.css
git commit -m "fix(slide21): byt mix-blend-mode mot inramad .rgb-demo-container"
```

---

### Task 7: Slide 24 — PWM-vågform (ta bort invert-filter)

**Files:**
- Modify: `presentation/slides.md:1311` (eller varhelst img-taggen är)
- Modify: `presentation/styles/main.css` (lägg till .diagram-img)

- [ ] **Step 1: Lägg till .diagram-img-klass i main.css**

Lägg till efter `.rgb-demo`:

```css
.diagram-img {
  max-width: 100%;
  border-radius: 0.5rem;
  border: 1px solid var(--ak-border);
}
```

- [ ] **Step 2: Ersätt img-taggen i slide 24**

Read `presentation/slides.md:1293-1321` för exakt rad.

Hitta:

```html
<img src="/images/pwm-waveform.png" style="filter: invert(1) hue-rotate(180deg); ..." />
```

Ersätt med:

```html
<img src="/images/pwm-waveform.png" class="diagram-img" />
```

(Behåll eventuella icke-färg-relaterade attribut som `width=`, men ta bort `style="filter:..."`.)

- [ ] **Step 3: Verifiera**

Bläddra till slide 24.
Expected: PWM-vågformen visas i sina originalfärger (mörka linjer på ljus bg), med subtil border-radius och kant. Mer pedagogiskt korrekt än det inverterade filtret.

- [ ] **Step 4: Commit**

```bash
git add presentation/slides.md presentation/styles/main.css
git commit -m "fix(slide24): ta bort invert-filter på PWM-vågformen, lägg .diagram-img"
```

---

### Task 8: Slide 25 — Color-chips (orden, inte hex-koder)

**Files:**
- Modify: `presentation/slides.md:1340-1343` (de 4 color-spans)
- Modify: `presentation/styles/main.css` (lägg till .color-chip)

- [ ] **Step 1: Lägg till .color-chip-klass i main.css**

Lägg till efter `.diagram-img`:

```css
.color-chip {
  display: inline-block;
  background: var(--bg);
  color: var(--fg);
  padding: 0.1em 0.55em;
  border-radius: 0.4em;
  font-weight: 700;
  border: 1px solid color-mix(in srgb, var(--bg) 70%, #000 30%);
}
```

- [ ] **Step 2: Byt ut de 4 ord-spans i slide 25**

Hitta rad 1340-1343:

```html
<div>· <span class="font-bold" style="color:#b400dc">Lila</span> — röd + blå, ingen grön</div>
<div>· <span class="font-bold" style="color:#ff8cb4">Gammelrosa</span> — mycket röd, lagom blå, lite grön</div>
<div>· <span class="font-bold" style="color:#ffd400">Skolgul</span> — full röd, lagom grön, ingen blå</div>
<div>· <span class="font-bold" style="color:#00e0ff">Cyan</span> — ingen röd, full grön + blå</div>
```

Ersätt med:

```html
<div>· <span class="color-chip" style="--bg:#b400dc;--fg:#fff">Lila</span> — röd + blå, ingen grön</div>
<div>· <span class="color-chip" style="--bg:#ff8cb4;--fg:#000">Gammelrosa</span> — mycket röd, lagom blå, lite grön</div>
<div>· <span class="color-chip" style="--bg:#ffd400;--fg:#000">Skolgul</span> — full röd, lagom grön, ingen blå</div>
<div>· <span class="color-chip" style="--bg:#00e0ff;--fg:#000">Cyan</span> — ingen röd, full grön + blå</div>
```

(Lila → vit text för 5.4:1 kontrast. De andra 3 → svart text för 8-14:1 kontrast.)

- [ ] **Step 3: Verifiera**

Bläddra till slide 25.
Expected: Varje färg-namn visas som en chip med sin namn-färg som bakgrund — "Lila" på lila bg med vit text, "Skolgul" på gul bg med svart text, etc. De 4 färgblocken till höger (rad 1355-1358) är OFÖRÄNDRADE.

- [ ] **Step 4: Commit**

```bash
git add presentation/slides.md presentation/styles/main.css
git commit -m "feat(slide25): chip-design för färg-namnen — pedagogisk förbättring"
```

---

### Task 9: Slide 33 — Buzzer-bild ring tokeniseras

**Files:**
- Modify: `presentation/slides.md:1805`

- [ ] **Step 1: Byt klass på img-taggen**

Hitta rad 1805:

```html
<img src="/images/active-buzzer-sticker.jpg" class="max-h-[32rem] rounded-xl ring-2 ring-rose-500/50 shadow-2xl" />
```

Ersätt med:

```html
<img src="/images/active-buzzer-sticker.jpg" class="max-h-[32rem] rounded-xl ring-2 ring-[color-mix(in_srgb,var(--ak-danger)_50%,transparent)] shadow-md" />
```

- [ ] **Step 2: Verifiera**

Bläddra till slide 33.
Expected: Buzzer-bilden har en subtil rosa-tonad ring (matchar `--ak-danger`) och en mjukare skugga än `shadow-2xl`.

- [ ] **Step 3: Commit**

```bash
git add presentation/slides.md
git commit -m "refactor(slide33): tokenisera buzzer-img-ring och tona ner shadow"
```

---

### Task 10: WiringSlide.vue — ring-färg-fix

**Files:**
- Modify: `presentation/components/WiringSlide.vue:28`

- [ ] **Step 1: Byt rad 28**

Read `presentation/components/WiringSlide.vue` för att se aktuella radnummer (kan ha ändrats).

Hitta:

```vue
class="max-h-full max-w-full object-contain rounded-lg shadow-2xl ring-1 ring-white/10"
```

Ersätt med:

```vue
class="max-h-full max-w-full object-contain rounded-lg shadow-md ring-1 ring-[var(--ak-border)]"
```

- [ ] **Step 2: Verifiera**

Bläddra till slides 14, 22, 31, 34, 42, 43 (alla WiringSlide-användningar).
Expected: Wiring-bilderna har en synlig grå ring runt sig (var osynlig på vitt tidigare) och mjukare skugga.

- [ ] **Step 3: Commit**

```bash
git add presentation/components/WiringSlide.vue
git commit -m "fix(WiringSlide): byt ring-white/10 mot tokeniserad border-färg"
```

---

### Task 11: voltage-divider.svg — skriv om för light-mode

**Files:**
- Modify: `presentation/public/images/voltage-divider.svg`

- [ ] **Step 1: Inspektera SVG:n**

Run: `cat presentation/public/images/voltage-divider.svg | head -50`
Notera alla `fill="..."` och `stroke="..."` attribut med dark-färger:
- `#eaeaea` (text-färg, motsvarar `--ak-text` i dark-mode)
- `#9aa5b1` (text-dim)
- `#616e7c` (text-mute)
- `#1f2933` (border, motsvarar `--ak-border` i dark-mode)

- [ ] **Step 2: Sök-och-ersätt fills och strokes**

Mappa till light-värden:
- `#eaeaea` → `#0a0e14` (light's `--ak-text`)
- `#9aa5b1` → `#4a5568` (light's `--ak-text-dim`)
- `#616e7c` → `#8a95a3` (light's `--ak-text-mute`)
- `#1f2933` → `#d4d6d0` (light's `--ak-border`)

Använd Edit-verktyget med `replace_all: true` för varje färgkod, eller manuellt redigera.

- [ ] **Step 3: Verifiera SVG validitet**

Run: `xmllint --noout presentation/public/images/voltage-divider.svg && echo "OK"`
Expected: "OK" (om xmllint finns; annars öppna SVG:n i webbläsare manuellt — drag-och-släpp i Chrome).

- [ ] **Step 4: Verifiera visuellt i slide 41**

Bläddra till slide 41.
Expected: Spänningsdelaren ritas med mörka linjer och text på ljus bg — läsbar.

- [ ] **Step 5: Commit**

```bash
git add presentation/public/images/voltage-divider.svg
git commit -m "fix(svg): skriv om voltage-divider färger för light-mode"
```

---

## Fas 3 — Verifiering

### Task 12: Full visuell genomgång (npm run dev)

**Files:** None (manuellt arbete)

- [ ] **Step 1: Starta dev-server**

Run: `cd presentation && npm run dev`
Verify: Webbläsare öppnas, slide 1 visas i light-mode.

- [ ] **Step 2: Bläddra varenda slide (1-52) och anteckna problem**

Använd högerpil för att bläddra. Bedöm per slide:
- Är all text läsbar?
- Är accent-färg synlig (cyan-rester ska vara borta)?
- Har bilder problem (mörka rektanglar utan grund, inverterade färger, osynlig text-overlay)?
- Glow-effekter på `.sp.unlocked`/`.sp.current` (slide 2) — syns som mjuk highlight?

Skriv en markdown-checklista med slidenummer och eventuella issues. Spara som `tasks/light-mode-walkthrough-issues.md`.

- [ ] **Step 3: Åtgärda issues om de hittas**

Om det finns problem:
- Skapa task per fix (kortare format)
- Implementera och commit per fix

Om inga problem:
- Skapa filen `tasks/light-mode-walkthrough-issues.md` med innehåll: `# Visuell genomgång\n\nInga issues hittade. ✓`

- [ ] **Step 4: Commit walkthrough-rapporten**

```bash
git add tasks/light-mode-walkthrough-issues.md
git commit -m "docs: visuell genomgång — light-mode walkthrough resultat"
```

---

### Task 13: PDF-export och verifiering

**Files:**
- Create: `tasks/light-mode-rendered/slides-light.pdf`

- [ ] **Step 1: Bygg PDF**

Run: `cd presentation && npm run export -- --output ../tasks/light-mode-rendered/slides-light.pdf`

Om scriptet inte stödjer `--output`-flagga relativ-path: ändra till absolut path eller kör i rotmappen.

Expected: PDF skapas, ~52 sidor.

- [ ] **Step 2: Granska PDF visuellt**

Öppna PDF:en i Preview eller annan PDF-läsare. Bläddra alla sidor.
Expected: Varje sida ser identisk ut med dev-versionen (förutom shadow-knockout per print-overrides).

- [ ] **Step 3: Notera eventuella PDF-specifika regression**

PDF-rendering kan skilja sig från live (Chromium-rastering). Specifikt kontrollera:
- Cover-sidans hero-foto + gradient
- Code-block-skuggor (ska vara none i print)
- Color-chips (slide 25) — borders ska renderas

Om regression: skapa task för fix.

- [ ] **Step 4: Commit PDF**

```bash
mkdir -p tasks/light-mode-rendered
git add tasks/light-mode-rendered/slides-light.pdf
git commit -m "docs: ren-bygg PDF i light-mode för review"
```

---

### Task 14: Rendera alla 52 slides som PNG

**Files:**
- Create: `tasks/light-mode-rendered/slide-NN.png` (52 filer)

- [ ] **Step 1: Rendera alla slides via Slidev native PNG-export**

Run: `cd presentation && npm run export -- --format png --output ../tasks/light-mode-rendered/`

Slidev v52+ stödjer `--format png` nativt via inbyggt Playwright. Verifierat av Gemini-review.

Expected: 52 PNG-filer skapas i `tasks/light-mode-rendered/`.

- [ ] **Step 2: Verifiera att 52 PNG:er finns**

Run: `ls tasks/light-mode-rendered/*.png | wc -l`
Expected: `52`

- [ ] **Step 3: Spot-check 5 slumpmässiga slides**

Öppna 5 PNG:er manuellt:
- slide-01.png (cover)
- slide-08.png (Ohms-triangel)
- slide-21.png (RGB-blend)
- slide-25.png (chips)
- slide-41.png (voltage-divider)

Expected: Alla ser läsbara och korrekt-renderade ut.

- [ ] **Step 4: Commit PNG-renderingen**

```bash
git add tasks/light-mode-rendered/
git commit -m "docs: rendera alla 52 slides som PNG för extern review"
```

---

### Task 15: Gemini-review av slides + diff

**Files:** None (read-only review)

**Rationale:** Visuell granskning av 52 högupplösta PNG-bilder kräver multimodal AI med stort kontextfönster. Gemini 3.1 Pro Preview är byggd för storskalig multimodal batching (1M+ context). Codex-konsultation är osäker för bild-volymen och kan krascha på context limit eller hallucinera visuella detaljer. (Kritiska val verifierat av tidigare Gemini-review i `tasks/light-mode-gemini-review.md`.)

- [ ] **Step 1: Sammanställ kontext för Gemini**

Skapa en review-instruktion som inkluderar:
1. Designspec-länk: `tasks/2026-05-05-light-mode-design.md`
2. Diff: `git diff main..HEAD -- presentation/`
3. Renderade slides: `tasks/light-mode-rendered/slide-NN.png` × 52

- [ ] **Step 2: Invokera consult-gemini-skill**

Använd Skill-verktyget med skill `multi-ai-consultant:consult-gemini`.

Prompt-skiss till Gemini (lägg till `@`-referenser till alla 52 PNG-filer + spec + diff):
```
Granska denna implementation av light-mode för en Slidev Arduino-presentation.
Designspec: @tasks/2026-05-05-light-mode-design.md
Implementation diff: kör `git diff main..HEAD -- presentation/` och granska
Renderade slides (1920×1080 PNG): @tasks/light-mode-rendered/

Bedöm visuellt och tekniskt:
1. Korresponderar implementation med designspec?
2. Finns CSS-issue som kan dyka upp i edge-cases (t.ex. PDF-rasterisering)?
3. Är någon färg/kontrast under WCAG AA på någon slide? Mät 5 slides.
4. Har vi missat dark-mode-rest? Sök efter: #00ffd1, #eaeaea, #0a0e14, html.dark, colorSchema.*dark.
5. Pedagogisk koherens — kan en nybörjarstudent förstå slides 8 (Ohms), 21 (RGB-blend), 24 (PWM), 25 (color chips), 41 (voltage-divider) lika bra eller bättre än dark-versionen?
6. Slide-för-slide visuell sanity check: bilder läsbara, ringar synliga, gradients smooth?

Returnera i format: blocking issues, suggested improvements, nits.
```

**Notera om gemini-CLI:** Skillens "locked config" har felaktiga flaggor (`--thinking`, `--google-search`, `--grounding` finns inte i CLI:n). Använd `gemini -m gemini-3.1-pro-preview -y` direkt om skillen kraschar. Modellnamnet är `gemini-3.1-pro-preview` (per `gemini -p "list models"`).

- [ ] **Step 3: Spara Gemini-svaret**

Spara output till `tasks/light-mode-gemini-final-review.md`.

- [ ] **Step 4: Klassificera feedback**

Gå igenom svaret och klassificera:
- **Blocking** — måste fixas innan merge
- **Improvement** — bör fixas, lågprio
- **Nit** — diskuterbart, kan ignoreras

Skapa task per blocking-item om det finns några.

- [ ] **Step 5: Commit review-rapporten**

```bash
git add tasks/light-mode-gemini-final-review.md
git commit -m "docs: Gemini visual review av light-mode-implementation"
```

---

### Task 16: Åtgärda blocking-feedback (om någon)

**Files:** Variabel — beror på review

- [ ] **Step 1: Lista blocking-items från task 16**

(Om inga blocking → hoppa till Task 17.)

- [ ] **Step 2: Implementera fixar per item**

Per blocking-item:
- Identifiera fil + rader
- Skriv fix
- Verifiera visuellt
- Commit med beskrivande meddelande

- [ ] **Step 3: Bekräfta att alla blocking är åtgärdade**

Run: `grep -i blocking tasks/light-mode-gemini-final-review.md`
Markera varje åtgärdad item med ✓ i filen.

- [ ] **Step 4: Commit**

```bash
git add tasks/light-mode-gemini-final-review.md
git commit -m "fix(light-mode): adressera Gemini blocking feedback"
```

---

### Task 17: Multi-auditor-review final gate

**Files:** None

- [ ] **Step 1: Säkerställ rent git-tree**

Run: `git status`
Expected: `nothing to commit, working tree clean`

- [ ] **Step 2: Invokera multi-auditor-review-skill**

Använd Skill-verktyget med skill `multi-auditor-review`.

Skill:n dispatcher Claude opus subagents (code-quality + architecture) parallellt och returnerar Blocked/Fix recommended/Green-verdict.

- [ ] **Step 3: Spara verdict**

Spara skill-outputen till `tasks/light-mode-multi-auditor-verdict.md`.

- [ ] **Step 4: Hantera verdict**

- **Green** → klar, gå till Task 18
- **Fix recommended** → adressera punkter, commit, kör om steg 2
- **Blocked** → adressera blocking, commit, kör om steg 2

- [ ] **Step 5: Commit verdict-rapporten**

```bash
git add tasks/light-mode-multi-auditor-verdict.md
git commit -m "docs: multi-auditor-review verdict — light-mode"
```

---

### Task 18: Slutkontroll och merge-prep

**Files:** None

- [ ] **Step 1: Kör fullständig grep efter dark-rester**

Run:
```bash
git grep -n '#0a0e14\|#eaeaea\|#00ffd1\|colorSchema.*dark\|html\.dark' presentation/
```

Expected: Endast träffar i kommentarer eller bevarade `--shiki-dark`-värden i `setup/shiki.ts`. Inga aktiva dark-color-references.

- [ ] **Step 2: Kontrollera package.json är oförändrad**

Run: `git diff main..HEAD -- presentation/package.json`
Expected: Ingen output (filen oförändrad).

- [ ] **Step 3: Slutgranska commit-historien**

Run: `git log main..HEAD --oneline`
Expected: ~20 atomiska commits, alla meningsfullt namngivna.

- [ ] **Step 4: Push branch**

```bash
git push -u origin light-mode-only
```

- [ ] **Step 5: Notera till användaren**

Pause för användarvalidering: Visa branch-namn och länk. Användaren bestämmer om merge-PR skapas (gh pr create) eller om vi direkt-mergar till main.

---

## Out-of-Scope (separata tasks)

- **Kompendium-pipeline** — om kompendiet renderar slides via PDF-import behöver det re-genereras post-merge
- **Slides-per-dag distribution** — behöver re-genereras post-merge
- **Orphaned bilder städning** — 6 oanvända PNG/JPG i `public/images/`
- **Code-block-tema-finess** — om Slidev's default light Shiki-tema inte ger bra läsbarhet, lägg till explicit `themes: { light: 'vitesse-light' }` i `setup/shiki.ts`

---

## Self-Review (utförd vid plan-skrivning)

**Spec coverage:**
- §1 Bakgrund och beslut → motiverat i plan-headern
- §2 Token-arkitektur → Task 1 (atomisk med frontmatter)
- §3 Slidev-konfiguration → Task 1 (frontmatter + Shiki via colorSchema)
- §4 Layout-strategi → Task 2
- §5 Övriga main.css-justeringar → Task 3
- §6 Slide-fixar → Tasks 4-9
- §7 WiringSlide-fix → Task 10
- §8 SVG-fix → Task 11
- §9 Build-pipeline (oförändrad) → Task 18 verifiering
- §10 Verifierings-plan → Tasks 12, 13, 14
- §11 Out-of-scope → Out-of-scope-sektion
- §12 Migration / risker → adresseras i Task 15-18 reviews
- §13 Implementationsordning → Tasks följer ordningen, splittade till bite-sized

**Placeholder scan:**
- Inga TBD/TODO/"implement later"
- Alla CSS-block visar exakt kod
- Alla shell-kommandon är konkreta

**Type consistency:**
- `.color-chip` används konsekvent i Task 8
- `--ak-*`-tokens har samma namn i alla tasks
- Klassnamn (`.breadboard-diagram`, `.rgb-demo`, `.diagram-img`) unika och konsekventa

**Risker som adresserats efter Gemini-review (2026-05-05):**
- ✓ Slidev `--format png`-flagga verifierad nativt i v52+ (Playwright-fallback bortagen)
- ✓ Multimodal review-osäkerhet: bytt från Codex till Gemini (1M+ context, multimodal-byggd)
- ✓ Atomisk Task 1 ersätter brutet mellantillstånd (skyddar mot git bisect)
- ✓ `html.print` cover-image-knockout återställd (skyddar mot Chromium PDF-rasteriserings-buggar)

**Risker som kvarstår:**
- Slidev's default light Shiki-tema kan kräva manuell override till `vitesse-light` om läsbarhet är dålig (Out-of-scope-task)
