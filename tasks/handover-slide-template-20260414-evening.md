# Handover — slide-mall klar 2026-04-14 (kväll)

Autonomt arbete medan användaren var borta. Alla 52 slides ska nu se konsistenta ut.

## Slutresultat
- **52/52 slides OK** enligt två triage-passningar med sonnet-subagents
- PDF: `kompendium/deliveries/slides-arduino-kurs.pdf` (v-evening)
- Ingen git i repo — ändringar är osparade i filsystemet

## Arkitektur (Slidev-idiomatisk)

Två filer styr hela decket:

### `presentation/uno.config.ts` (NY)
Rebaseline av Tailwind `text-xs..text-8xl` till canvasWidth: 1920. Bara `font-size` (ingen `line-height` i tupeln — den cascadar från body-base istället). Detta är Slidev-sanktionerad custom UnoCSS-konfig per `sli.dev/custom/config-unocss`.

### `presentation/styles/main.css`
~220 rader, strukturerad i 9 sektioner:

1. **Design tokens** (`:root` färgvariabler)
2. **Body base** — bg, färg, font-size 1.6rem, line-height 1.5, + overrid av Slidevs `p { @apply my-4 leading-6 }` (rotsaken till rad-överlappning — Slidev bakar in FIXED 24px line-height på paragrafer)
3. **Uniform vertical centering** — 3 regler, en per layout:
   - `.slidev-layout.default` → flex-column + `justify-content: safe center`
   - `.slidev-layout.two-cols-header` → `grid-template-rows: auto auto auto !important` + `align-content: safe center` (bryter Slidevs `auto 1fr auto` som pinnar headern överst)
   - `.slidev-layout.two-columns` → `align-content: safe center`
4. **Headings** (h1, h2, h3)
5. **Code** — ligatures av + ramar
6. **Domain components** — sp-grid, warn-box, tip-box
7. **Layout variants** — section, cover, end, image-left/right
8. **Utilities** — cyan/warn/danger/dim/mono, rgb-circles, big-code, dots-bg

## Rotsaker som hittades

1. **Paragrafer utan luft/överlappning (slides 10, 18, 46)**: Slidevs `layouts-base.css` sätter `p { @apply my-4 leading-6 }`. `leading-6` är `line-height: 1.5rem` = FIXED 24px, inte ratio. Vid rebased text-2xl (43 px font) kollapsade rader över varandra. Fix: override med ratio line-height.

2. **Header pinned top / void under (slide 10, slide 11, etc.)**: Slidevs `two-cols-header` grid är `auto 1fr auto`. 1fr-raden sträcker sig över hela återstående höjden och sätter headern överst. Fix: `auto auto auto` + `align-content: center` packar allt som en enhet.

3. **Miniaturerade slides (slide 9 Ohms-triangel)**: SVG `<text>`-element ärvde CSS-font-size från parent `.slidev-layout` vilket åsidosatte `font-size="28"`-attributet. Fix: slide 9 använder HTML-positionerade divs över en ren SVG-shape.

4. **Slide-14-orphan "kittets manual,"**: Rest från borttaget innehåll i `slides.md` rad 757-759. Bort.

## Per-slide fixes (minimala)

1. **Slide 9** — SVG-struktur konverterad till shape + HTML-text. Formeln är `U = R · I` (ej `U = I · R`) per användares rättelse. Triangeln har R vänster, I höger.
2. **Slide 14** — orphan-text `<div>kittets manual,</div>` borttagen.
3. **Slide 18** (`Din egen rytm`) — manuella `· <div>`-bullets konverterade till `<ul><li>` (real markdown-lista, får hanging-indent automatiskt från Slidev's `li { leading-1.8em; ml-1.1em }`).
4. **Slide 46** (`Hitta din tröskel`) — samma som 18, manuella bullets → `<ul><li>`. Paragraf inte längre nestad i samma wrapper som bullets.
5. **Slide 51** (`Pin-tilldelning`) — `max-w-3xl` → `max-w-5xl` (48rem → 64rem) så "Modul 3/4" inte wrappar.

## Inget rört

- 31 default-layout slides: bara globala reglerna gör jobbet.
- 6 two-cols-header slides: bara globala reglerna.
- 6 section-dividers, cover-slide, end-slide: befintlig layout-CSS ej rörd.

## Så här bygger du om

```bash
cd /Users/daniel/projects/arduino-kurs/presentation
npx slidev export --output ../kompendium/deliveries/slides-arduino-kurs.pdf
```

## Så här renderar du PNG för visuell audit

```bash
rm -rf /tmp/slides-all && mkdir -p /tmp/slides-all
pdftoppm -r 192 -scale-to-x 1920 -scale-to-y 1080 \
  kompendium/deliveries/slides-arduino-kurs.pdf /tmp/slides-all/slide -png
```

## Triage-rapporter från sonnet-agents

- `tasks/slide-triage-20260414.md` — första passningen (efter initial layout-fix), 16 broken identifierade men flera false-positives
- `tasks/slide-triage-final-20260414.md` — slutlig passning, 3 broken (alla nu fixade)

## Kontext som är värt att komma ihåg

- Inline `<code>`-badge fungerar nu eftersom `p { line-height: 1.5 }` ger tillräckligt luft för `padding: 0.15em 0.4em`.
- `safe center` i flex/grid är en modern CSS-feature som faller tillbaka till flex-start / start om innehåll skulle overflowa → ingen risk för clipping på långa slides.
- `two-cols-header` har numera `align-content: safe center` + `auto auto auto` rader. Om framtida slide får LÅNGT innehåll som inte får plats: lägg till `top`-klass i frontmatter för opt-out — men det är inte implementerat som regel ännu (behövs bara om det faktiskt behövs).
- Ohms-triangel-SVG:n har ingen risk för font-size cascade eftersom U/I/R är HTML-divs, inte SVG-text.
- `uno.config.ts` theme.fontSize merges med Slidevs interna config — ingen risk att bryta default utilities som inte finns i min rebase.

## Vad användaren kan vilja justera manuellt

- Slide 3 "Klassrummets viktigaste verktyg" — användaren nämnde i en tidigare kommentar att detta är "onödigt för 8 elever". Innehåll-beslut, ej layout.
- Visuell finjustering av font-storlekar i `uno.config.ts` om något känns för stort/litet i praktiken (projektor-test).
- Eventuellt tunna ut paragraf-spacing från `margin: 0.8em 0` till `0.6em` om det känns luftigt.

Annars: redo att showa.
