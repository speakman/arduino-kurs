# Handover — Slidev cleanup 2026-04-14 (inför /clear)

Detta är en strukturerad överlämning. En ny session ska kunna plocka upp arbetet utan att läsa hela chathistoriken. Läs den i ordning.

---

## 1. Vad problemet var

En Slidev-presentation (52 slides, svensk Arduino-kurs) hade typografi + layout kalibrerad för desktop-browser (~960 px bred canvas). Men Slidev är satt till `canvasWidth: 1920`. Resultatet: text och SVG:er var 2–6× för små, centrerings-defaulter lämnade tomrum längst ner på de flesta slides, och author hade försökt fixa symptomen per-slide med arbitrary `text-[Nrem]`-hack som bara löstes i sitt specifika kontext.

Användaren har gått igenom decket manuellt och kommenterat att många slides "ser förkrympta ut". Nuvarande session har rensat de värsta problemen men **per-slide tweaks är inte fullständigt rensade**. Den här handovern listar exakt vad som är kvar.

---

## 2. Nuvarande arkitektur

Två filer styr hela decket:

### `presentation/uno.config.ts`
UnoCSS theme-override. Rebaselinar `text-xs..text-8xl` för canvasWidth 1920 med progressiva line-heights (1.5 för body, tajt för headings). Slidev merger denna med sin interna config.

### `presentation/styles/main.css`
~220 rader, strukturerade i 9 sektioner:

1. **Design tokens** (`:root`)
2. **Body base** på `.slidev-layout` — font-size 1.6rem, line-height 1.5, + override av Slidevs egen `.slidev-layout p { @apply my-4 leading-6 }` som bakade in FIXED 24px line-height (rotsak till tidigare rad-överlappning)
3. **Uniform vertikal centrering**:
   - `.slidev-layout.default { display: flex; flex-direction: column; justify-content: safe center }`
   - `.slidev-layout.two-cols-header { grid-template-rows: auto auto auto !important; align-content: safe center }` — bryter Slidevs `auto 1fr auto` som pinnade headern överst
   - `.slidev-layout.two-columns { align-content: safe center }`
4. Headings (h1=3.5rem, h2/h3 utan font-size)
5. Code (ligatures av + ramar)
6. Domain components (sp-grid, warn-box, tip-box)
7. Layout variants (.section, .cover, .end, .image-left/right)
8. Utility classes (.cyan, .warn, .danger, .mono, .rgb-*, .big-code, .dots-bg)

Det är allt. Inga fler globala regler.

---

## 3. Vad som är fixat i denna session

- **Typografi-rebase** via uno.config.ts — alla `text-*`-utilities skalar för 1920 canvas
- **Paragraf-överlappning** (slide 18, 46) — Slidevs `p { leading-6 }` var FIXED 24px. Overridden med `.slidev-layout p { line-height: 1.5; margin: 0.8em 0 }`
- **Radavstånd för `<div>`-element med `text-*`** (slide 6) — line-height-tuplar i uno.config gör så UnoCSS emiterar `line-height` på utilities, så `<div class="text-xl">` ärver rätt
- **Header pinned top** (`two-cols-header`-slides, framförallt 10, 11) — Slidevs `grid-template-rows: auto 1fr auto` bytt till `auto auto auto` + `align-content`
- **Ohms-triangel på slide 9** — Använder HTML-positionerade divs över SVG-shape. Formeln är `U = R · I` (R vänster, I höger). Font-size cascade-problem från SVG `<text>` → HTML-divs är workaround.
- **Slide 14 orphan** — "kittets manual," borttagen (rad 757–759 i slides.md, var leftover)
- **Slide 14 body-size** — rad 727 hade `text-[1.05rem] leading-snug`, borttaget. Använder default body-storlek nu.
- **Slide 42 body-size** (Spänningsdelaren) — rad 2161 hade `text-[0.88rem] leading-snug`, borttaget.
- **Slide 18, 46** — manuella `· <div>`-pseudo-bullets → riktiga `<ul><li>` (får hanging-indent från Slidevs `li { leading-1.8em; ml-1.1em }`)
- **Slide 51** (Pin-tilldelning) — `max-w-3xl` → `max-w-5xl` så "Modul X"-kolumnen inte wrappar

---

## 4. Per-slide tweaks SOM FORTFARANDE FINNS i slides.md

Användarens uttryckliga direktiv: **minimera per-slide CSS, likforma via globala regler**. Nedanstående är INTE likformat. En ny session bör gå igenom och bedöma varje grupp.

### 4a. Frontmatter `class: px-14 pt-12/14/16` (21 slides)
Rader: 68, 207, 381, 429, 546, 642, 692, 718, 824, 895, 964, 1281, 1337, 1367, 1436, 1507, 1960, 2056, 2118, 2413, 2463, 2565, 2635 (ungefär)

**Vad det är**: Per-slide top-padding-override. Lägger `padding-top: 3rem/3.5rem/4rem` på `.slidev-layout.default`.

**Problem**: Med min globala `justify-content: safe center` är dessa _onödiga_ — de förskjuter content nedåt från canvas-center och motarbetar centreringen. De skadar inte men är dead weight.

**Åtgärd för ny session**: Ta bort `pt-12`/`pt-14`/`pt-16` från alla frontmatter. Behåll `px-14` om författaren explicit ville ha annan horisontal-padding än Slidev default. Använd global sed-replace.

### 4b. Frontmatter `class: px-12 pt-10` (2 slides: rad 1628, 1724, 2150)
Samma mönster som 4a. Ta bort `pt-10`, behåll `px-12`.

### 4c. Frontmatter `class: "!p-0"` (7 slides: 790, 1241, 1694, 1885, 2296, 2318)
Fullbleed-slides (bild tar hela canvas). Legitima — behåll.

### 4d. Frontmatter `class: text-center` (flera slides — 135, 1046, 1113, 1185, 1571)
Horisontellt centrerad text på `.default`-layout. Legitimt — behåll.

### 4e. Frontmatter `class: px-14 pt-14 text-center` (692, 1436, 1911, 1997, 2502)
Kombination av 4a + 4d. Ta bort `pt-14`, behåll `text-center`.

### 4f. Kompendiets `text-center`-trick (5 slides)
Rader 180, 1166, 1489, 2037, 2539 har pattern:
```html
<div style="text-align: center"><h1 style="display: inline-block">LED & krets</h1></div>
```
Skapar ett pseudo-centrerat h1 med inline-block för att border/background ska hugga om rubriken. Legitimt custom styling.

### 4g. Kodblock-override: `[&_pre]:!text-3xl [&_pre]:!leading-relaxed [&_pre]:!p-6` (3 slides: 1298, 1969, 2472)
Tailwind arbitrary child-selector som med `!important` bumpar `<pre>`-storlek inuti ett kodblock-wrapper. Workaround för att Slidevs default kodblock är för litet.

**Åtgärd för ny session**: Flytta denna boost till global main.css `.slidev-layout pre { font-size: 1.25rem }` eller liknande, så alla kodblock skalar samma. Ta bort per-slide overrides.

### 4h. Raw inline `style="font-size:XXpx"` etc (slide 34, 40, med flera)
Rader ~653, ~1811-1820, ~2067-2072. Använder raw pixel-font-size för att Tailwind/UnoCSS arbitrary values `w-[30rem]` inte funkade i tidigare version (enligt tidigare handover-doc). 

**Åtgärd för ny session**: Testa om arbitrary values funkar nu (efter uno.config-rebase). Om ja, konvertera raw inline styles till klasser. Om nej, lämna som är.

### 4i. Ohms-triangel på slide 9 (rad 441–449)
HTML-positionerade `<div>` med inline `style="color:#00d9ff;font-size:6.5rem;transform:translate(-50%,-50%)"` etc. Legitim workaround för SVG `<text>`-cascade.

### 4j. `max-w-*`-tuning (30+ instanser)
Många content-divs har `max-w-2xl`/`3xl`/`4xl`/`5xl` för att begränsa radlängd. Dessa är per-författare-beslut om optisk textbredd.

**Åtgärd**: Inte urgent, men utvärdera om default kan vara `max-w-4xl` på `.slidev-layout.default` eller liknande.

### 4k. `leading-relaxed`/`leading-loose`/`leading-snug`/`leading-tight` (31 instanser)
Många content-divs har explicit line-height-override. Efter uno.config-rebase är många redundanta (body är redan 1.5) men vissa är legitima för tajta diagramtexter.

**Åtgärd**: Gå igenom och ta bort redundanta `leading-relaxed` där font-size redan ger ratio 1.5. Behåll `leading-tight`/`leading-snug` där de används för kompakta element.

---

## 5. Kvarvarande kända content-buggar

Inga per senaste sonnet-triage (se `tasks/slide-triage-final-20260414.md`).

Slide 3 "Klassrummets viktigaste verktyg" — användaren har tidigare kommenterat att **innehållet** är onödigt för en 8-elevers-klass. Det är ett content-beslut, inte layout-bug.

---

## 6. Verktyg

### Bygga PDF
```bash
cd /Users/daniel/projects/arduino-kurs/presentation
npx slidev export --output ../kompendium/deliveries/slides-arduino-kurs.pdf
```
Tar ~15–25 sek. PDF hamnar i `kompendium/deliveries/slides-arduino-kurs.pdf`.

### Rendera PNG för visuell audit
```bash
rm -rf /tmp/slides-all && mkdir -p /tmp/slides-all
pdftoppm -r 192 -scale-to-x 1920 -scale-to-y 1080 \
  /Users/daniel/projects/arduino-kurs/kompendium/deliveries/slides-arduino-kurs.pdf \
  /tmp/slides-all/slide -png
```
Ger 52 st `slide-01.png` till `slide-52.png` i 1920×1080. `pdftoppm` varnar om "Bad bounding box in Type 3 glyph" — kosmetiskt, ignorera.

### Rendera en enskild slide
```bash
pdftoppm -r 192 -scale-to-x 1920 -scale-to-y 1080 -f N -l N \
  /path/to/slides-arduino-kurs.pdf /tmp/slide-test -png
```

### Bulk-triage via sonnet-subagent
Kasta skärmdumparna på en sonnet-agent med Read-åtkomst till `/tmp/slides-all/slide-*.png`. Tidigare använd prompt finns i chathistoriken. Triage-rapporter hamnar i `tasks/slide-triage-*.md`.

### Mäta content-bbox per slide
```bash
for i in $(seq -w 1 52); do
  bbox=$(magick /tmp/slides-all/slide-${i}.png -threshold 15% -trim -format '%wx%h+%X+%Y' info:)
  echo "$i: $bbox"
done
```
Slider vars `W/2 + X` inte är nära 960 eller `H/2 + Y` inte nära 540 har potentiellt fel centrering.

### Live dev-server
```bash
cd /Users/daniel/projects/arduino-kurs/presentation && npx slidev
```
Öppnar `http://localhost:3030`. HMR funkar för både `slides.md` och `styles/main.css`.

---

## 7. Filstruktur

```
arduino-kurs/
├── presentation/
│   ├── slides.md                    ← 52 slides, ~2700 rader
│   ├── uno.config.ts                ← NY fil, typografi-rebase
│   ├── styles/
│   │   ├── index.ts                 ← importerar main.css
│   │   └── main.css                 ← ~220 rader, 9 sektioner
│   ├── public/images/               ← breadboard, fotoceller, LDR, PWM-graf etc
│   ├── layouts/                     ← (tom, inga custom layouts används)
│   └── node_modules/
├── kompendium/
│   └── deliveries/
│       ├── kompendium-arduino-kurs.pdf   ← ej rörd
│       └── slides-arduino-kurs.pdf       ← aktuell export
└── tasks/
    ├── handover-before-clear-20260414.md   ← DETTA DOKUMENT
    ├── handover-slide-template-20260414-evening.md
    ├── handover-slides-manual-review-20260414.md  ← original manuell review
    ├── handover-slides-density-20260414.md
    ├── slide-triage-20260414.md           ← första sonnet-triagen
    ├── slide-triage-final-20260414.md     ← slutlig sonnet-triage (3 broken)
    └── slides-layout-rootcause-20260414.md ← ursprunglig root-cause-analys från opus-agent
```

**Inget git i detta repo.** Ändringar är osparade i filsystemet. Levereras via kompendium/deliveries/.

---

## 8. Minnesregler från tidigare handovers som fortfarande gäller

- **Komplett kod hör i kompendiet**, inte på slides. Slides visar essens. (`feedback_code_slides_vs_compendium` memory)
- **Använd sonnet för visuell audit/triage** av slides. (`feedback_use_sonnet_for_image_review` memory)
- **Parallella sonnet-agents för analys, sekventiella Edit:s för layout**. (`feedback_slide_restructure_workflow` memory)
- **ELEGOO får heta ELEGOO** (brand-namn), men inga sid-refs till ELEGOO-manualen i kompendiet. (`project_elegoo_branding_policy` memory)

---

## 9. Förslag på exakt nästa-session-plan

1. **Läs detta dokument** (handover-before-clear-20260414.md)
2. **Rendera alla 52 slides** med `pdftoppm`-kommandot ovan
3. **Sonnet-triage** — dispatcha en agent med listan i sektion 4 och be den verifiera vilka `class: px-14 pt-*` som faktiskt går att ta bort utan regression
4. **Systematisk cleanup** — per sektion 4:
   - 4a/4b/4e: sed-replace bort `pt-N`-prefix från alla frontmatter
   - 4g: lyft kodblock-boost till global main.css
   - 4h: testa om arbitrary values funkar, konvertera eller lämna
   - 4k: ta bort redundanta `leading-relaxed`
5. **Slutlig sonnet-triage** efter cleanup — verifiera inga regressioner
6. **Skriv slutlig handover**

Förväntad tid: 1-2 timmar autonom körning.

---

## 10. TL;DR för första meddelandet efter /clear

"Slidev-arbetet pausades. Hela kontext står i `tasks/handover-before-clear-20260414.md`. Läs den, rendera slides, och fortsätt per sektion 9 (steg 1-6)."
