# Spec — Slidev-idiomatisk omskrivning av presentation/slides.md

**Datum:** 2026-04-14
**Status:** Utkast för user-review innan implementationsplan
**Källor:** `tasks/slide-taxonomi-20260414.md`, `tasks/handover-slides-cleanup-20260414-final.md`

## Mål

Konvertera `presentation/slides.md` från ett HTML-tungt, utility-class-överlastat tillstånd till ett Slidev-idiomatiskt mönster där:

1. Slides bärs av Slidev's inbyggda layouts (`cover`, `center`, `section`, `default`, `two-cols`, `statement`, `end`).
2. Typografi, rytm och centrering lever i `presentation/styles/main.css` via `.slidev-layout`-scopning, inte per-slide utility-cascade.
3. Varje slide innehåller så lite markup som möjligt — helst plain markdown + en layout-direktiv.
4. HTML-struktur bevaras endast där den representerar domänspecifikt innehåll som inte kan uttryckas i markdown (sp-grid, Ohms-triangel, RGB-cirklar, WiringSlide-komponenter, warn-/tip-boxes).

**Icke-mål:** Ingen innehållsrevidering av sliden. Ingen omformulering av text, ändrad slide-ordning, eller design-rework. Detta är en *form-städning*, inte en redesign.

## Bakgrund

Tidigare cleanup-pass (se handover 2026-04-14) tog bort 17 onödiga `pt-*`-klasser. Kvar finns ~28 `leading-relaxed`, 3 `[&_pre]:!text-Nxl` kodblock-overrides, 5 section-slides med inline `<div style="text-align:center"><h1 style="display:inline-block">`-workarounds, samt en stor mängd upprepad utility-wrappning (`<div class="mt-N text-Nxl leading-relaxed max-w-Nxl mx-auto">`) runt innehåll som borde vara plain markdown.

Användaren har explicit sagt: "jag vill inte att varje slide innehåller en himla massa olika direktiv, jag vill att de ser snarlika ut och framför allt håller sig till Slidev's egna standard."

## Taxonomi (sammanfattning)

Inventering i `tasks/slide-taxonomi-20260414.md`. 52 presentation-slides, 1 raderas (slide 4), 51 kvar.

| Kluster | Antal | Target-layout |
|---|---:|---|
| cover | 1 | `cover` (oförändrad) |
| section-divider | 5 | `section` |
| hero-message | 10 | `center` / `statement` |
| content-bullets | 11 | `default` + markdown |
| two-column | 7 | `two-cols` |
| code-demo | 7 | `default` + fence |
| domain-custom | 10 | `default`, HTML bevaras |
| end | 1 | `end` (oförändrad) |
| BORT | 1 | slide 4 raderas |

**Risk-hotspots (6 slides):** 9, 11, 26, 34, 40, 42 — Ohms-triangel, resistor-färgring, inline-färgrutor, buzzer warn-box, helt-inline-slide, spänningsdelare-diagram. Dessa konverteras SIST med individuell review.

## Design

### Arkitektur-principer

1. **Global > lokal.** Allt som kan uttryckas en gång i `main.css` ska uttryckas där. Per-slide overrides är undantag, inte regel.
2. **Layout > utility.** Använd Slidev-layouts för struktur. Utility-klasser tillåts bara för äkta per-element-tweaks.
3. **Markdown > HTML.** Rubriker, listor, paragraffer, kodblock = markdown. HTML reserveras för visuellt strukturerade komponenter.
4. **Bevara visuell intent.** Målet är inte pixel-exakt oförändrad rendering — det är konsistent och städad. Visuell drift tillåts där det gör markupen påtagligt enklare.

### Gränssnitt: `.slidev-layout` i main.css

Nya/uppdaterade regler i `presentation/styles/main.css`:

1. **`.slidev-layout.section`** — h1 ska centreras utan inline-style workaround. Nuvarande regel har `text-align: center !important` på `.section` men h1-centrering fungerar ej utan `display: block` eller motsvarande. Verifiera och fixa.
2. **`.slidev-layout.center`** — hero-layout. Definiera typografi-rytm för markdown-children:
   - `h1` — stor, nedtonad margin-top
   - `p` (första paragraffen efter h1) — subtitle-storlek (~text-2xl-ekvivalent), dimmad opacity
   - `p + p` — mindre text för efter-subtitle-rader
3. **`.slidev-layout pre`** — baseline kodblock-storlek. Välj `font-size: 1.0em` som baseline; de tre stora kodblocken (slides 25, 38, 48 i nya numret) får en `.big-code` modifier-klass som redan finns men är fel (sätter 0.85em = mindre). Uppdatera `.big-code pre` till `font-size: 1.15em`.
4. **`.slidev-layout ul, .slidev-layout ol`** — listor får rimlig typografi och vertikal rytm utan per-slide-wrap. Föreslås: `font-size: inherit`, `li { margin: 0.5em 0 }`.
5. **`.slidev-layout.two-cols`** — verifiera att `::left::`/`::right::`-split fungerar med nuvarande CSS. Ev. gap-tuning.

### Gränssnitt: slides.md

Varje slide som konverteras följer detta mönster:

**Före (hero-message, typiskt):**
```md
---
layout: default
class: px-14
---

<div class="h-full flex flex-col items-center justify-center">
<div class="text-center">

# Mikrokontrollern.

<div class="mt-16 text-4xl leading-relaxed max-w-4xl mx-auto">
Datorn i din ficka, fast mindre och enklare.
</div>

</div>
</div>
```

**Efter:**
```md
---
layout: center
---

# Mikrokontrollern.

Datorn i din ficka, fast mindre och enklare.
```

**Content-bullets, typiskt:**
```md
---
layout: default
class: px-14
---

# Rubrik

<ul class="mt-10 text-2xl space-y-4 max-w-5xl leading-relaxed">
  <li>Första punkten</li>
  <li>Andra punkten</li>
</ul>
```

**Efter:**
```md
---
layout: default
---

# Rubrik

- Första punkten
- Andra punkten
```

**Two-column, typiskt:**
```md
---
layout: default
---

<div class="grid grid-cols-2 gap-12">
<div>…text…</div>
<div>…kod…</div>
</div>
```

**Efter:**
```md
---
layout: two-cols
---

…text…

::right::

```cpp
…kod…
```
```

### Bevarat HTML (domain-custom)

Dessa strukturer lämnas orörda internt, men omgivande wrappers (som `<div class="mt-16 ...">` runt en sp-grid) stryps:

- `.sp-grid` / `.sp` i slide 3 (kursöversikt)
- `<WiringSlide>` Vue-komponent i slides 16, 24, 33, 36, 44, 45
- `.rgb-circle` i slides 21, 28
- `.warn-box` / `.tip-box` (flera slides)
- Ohms-triangel-divs i slide 9 (särskild review)
- Resistor-färgring SVG i slide 11 (särskild review)
- Spänningsdelare-diagram i slide 42 (särskild review)

## Execution-plan

### Fas 0 — Cheap wins (~30 min, ingen visuell risk)

1. Radera slide 4 (rad 133-169, "Klassrummets viktigaste verktyg"). Kontrollera att omgivande `---` också tas bort rent.
2. Sed-purga alla 28 `leading-relaxed` från slides.md. Ingen risk — global base = 1.5, leading-relaxed = 1.625, nära no-op.
3. Render PDF + PNG. Visuell sanity-check: ser allt oförändrat ut?

**Commit:** `chore(slides): remove post-it slide and redundant leading-relaxed`

### Fas 1 — main.css centralization (~45 min)

1. Lägg till/uppdatera `.slidev-layout.section h1`-centrering (eliminera behov av inline-workaround).
2. Lägg till `.slidev-layout.center`-regler för hero-typografi.
3. Uppdatera `.big-code pre` till korrekt större storlek.
4. Lägg till `.slidev-layout ul/ol`-regler.
5. Verifiera `.slidev-layout.two-cols`.
6. Render PDF. Redan-OK slides ska se *nära oförändrade* ut.

**Commit:** `style(presentation): centralize layout typography in main.css`

### Fas 2 — Kluster-konvertering (iterativ)

Ordning: enklast → svårast. Efter VARJE kluster: render, visuell diff med sonnet-agent, stopp-och-justera om drift.

1. **2a — section-divider (5 slides):** stryp inline `<div style="text-align:center"><h1 style="display:inline-block">`-workaround. Verifiera att CSS-fixet i Fas 1 bär centreringen.
2. **2b — code-demo (7 slides):** stryp `[&_pre]:!text-Nxl`-overrides på slides 25, 38, 48. Lägg till `.big-code`-wrap om storleken verkligen måste vara större än baseline.
3. **2c — content-bullets (11 slides):** konvertera `<ul class="...">` → markdown-listor. Stryp `<div class="mt-N max-w-Nxl">`-wrappers.
4. **2d — hero-message (10 slides):** byt från `default` till `center`/`statement`. Stryp centrerings-wrappers.
5. **2e — two-column (7 slides):** konvertera till `layout: two-cols` med `::left::`/`::right::`.
6. **2f — domain-custom (10 slides):** bara wrapper-rensning runt de bevarade strukturerna.

**Commits:** en per delsteg (2a, 2b, …).

### Fas 3 — Finputs

1. Full PDF-genomgång (hela filen).
2. High-risk slides får individuell review — slides 9, 11, 26, 34, 40, 42.
3. Enstaka avvikare justeras manuellt.

**Commit:** `style(slides): final touch-ups after idiomatic rewrite`

## Risk-mitigation

- **Commit-kadens:** efter varje fas-steg (Fas 0, Fas 1, Fas 2a, 2b, 2c, 2d, 2e, 2f, Fas 3). Rollback-punkt per kluster.
- **Visuell verifiering:** sonnet-subagent med `model=sonnet` som jämför before/after-PNGs per konverterat kluster. Presenteras för användaren innan nästa kluster körs.
- **STOPP-regel:** om visuell drift är oacceptabel på fler än 2 slides i ett kluster → stanna, justera CSS eller backa, förhandla om den specifika sliden ska behålla sin HTML-form.
- **High-risk-slides sist:** 9, 11, 26, 34, 40, 42 konverteras i fas 2f eller fas 3 med individuell review.
- **Inget rör `uno.config.ts`.** Typografi-scale är redan kalibrerad och fungerar.
- **Inget rör domänkomponenter internt.** Sp-grid, WiringSlide, Ohms-triangel, RGB, warn/tip-box strukturer bevaras exakt som de är.

## Framgångskriterier

1. ✅ Slide 4 (Klassrumsverktyget) raderad.
2. ✅ Alla konverterade slides renderar utan visuella regressioner som användaren bedömer oacceptabla.
3. ✅ `leading-relaxed` borta från slides.md (eller bara kvar där det faktiskt gör skillnad).
4. ✅ `[&_pre]:!text-Nxl`-overrides borta från slides.md.
5. ✅ Inline `style="text-align:center"`-workaround borta från section-slides.
6. ✅ Hero-message-slides, content-bullets-slides och two-column-slides använder Slidev-layouts istället för manuell HTML-centrering.
7. ✅ Domänkomponenter (sp-grid, WiringSlide, etc.) oförändrade i struktur.
8. ✅ `main.css` bär typografi-regler centralt.

## Öppna frågor (bör besvaras innan implementation)

Inga just nu — designen är godkänd muntligt. Specifikt:

- ✅ Slide 4 (Klassrumsverktyget) är den som raderas (användaren bekräftat).
- ✅ Slide 3 (Kursöversikt med sp-grid) STANNAR.
- ✅ Iterativ kluster-konvertering med visuell verifiering godkänd.
- ✅ Commit per fas-steg godkänt.

## Filer som påverkas

- `presentation/slides.md` — huvudmålet för omskrivning
- `presentation/styles/main.css` — typografi-centralisering (Fas 1)
- `kompendium/deliveries/slides-arduino-kurs.pdf` — regenereras efter varje fas

**Ingen ändring i:**
- `presentation/uno.config.ts`
- Vue-komponenter i `presentation/components/`
- Innehåll i kompendiet (texter, kod-sketches)
