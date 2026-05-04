# Light-mode redesign — projektor-vänlig presentation

**Datum:** 2026-05-05
**Status:** Designspec, godkänd för implementation
**Berör:** `presentation/` — slides, styles, components, setup, public/images

---

## 1. Bakgrund och beslut

Presentationen var byggd som dark-only, vilket fungerar dåligt på klassrumsprojektorer (kontrast halveras, glow-effekter blir grågrumlig svärta). Initialt utforskades dual-mode (light + dark via `colorSchema: 'auto'`), men auditen visade att:

- 9 av 25 bilder är designade för vit bakgrund (Fritzing-PNG:er, produktfoton)
- 5 bilder är transparent-PNG (passar lika på båda men "naturligt" på vitt)
- 3 dark-only-hacks i CSS/inline-style (`mix-blend-mode:screen`, `filter:invert hue-rotate`, hardkodat `background:white`) hade krävts för att tvinga bilderna att fungera mot mörkt
- 1 SVG (`voltage-divider.svg`) hade fått sina färger justerade till dark — en regression från en naturligt-ljus tillgång

Innehållets natur är **ljust**. Dark mode var stilistiskt val, inte pedagogiskt.

**Beslut:** skrota dark mode helt, göra light-only med samma omsorg som lades på dark. Dark-versionen finns kvar i git-historiken om den någonsin behövs igen.

### Pedagogiskt motiverat

- All Arduino-relaterad referensliteratur (Fritzing, datablad, schemaläsning, PCB-tryck) är på vitt → konsistens i visuell vana
- Klassrumsprojektor är primärt media → vitt vinner trivialt
- Studentens PDF efter passet → vitt är trycktvänligt om någon vill skriva ut
- Tre bild-hacks försvinner → bilderna får visa sig som de är
- 52 slides ska valideras i **ett** läge → halverad testyta, halverad regressionrisk

---

## 2. Token-arkitektur (single set)

```css
:root {
  /* Bakgrund och struktur */
  --ak-bg:        #fafaf7;   /* varm off-white, behaglig på projektor */
  --ak-bg-raised: #f0f1ed;   /* kort, paneler */
  --ak-border:    #d4d6d0;   /* synlig men subtil */

  /* Text */
  --ak-text:      #0a0e14;   /* det tidigare bg-värdet — kontinuitet, max kontrast */
  --ak-text-dim:  #4a5568;
  --ak-text-mute: #8a95a3;

  /* Accent — Arduino-teal, justerad för WCAG AA på vitt */
  --ak-accent:      #00747d;
  --ak-accent-soft: rgba(0, 116, 125, 0.10);

  /* Semantik */
  --ak-warn:   #b45309;   /* amber-700, läsbar på vitt */
  --ak-danger: #be123c;   /* rose-700, kontrast ~5.5:1 */

  /* Glow — subtila accenter (verkligheten är att glow inte funkar mot vitt;
     dessa fungerar som "ljusare bakgrund" på framhävda element) */
  --ak-glow-cyan: 0 0 24px rgba(0, 116, 125, 0.15);
  --ak-glow-red:  0 0 24px rgba(190, 18, 60, 0.12);

  /* Skuggor och cover-text — tokeniserade för centraliserad styrning */
  --ak-code-shadow:  0 4px 14px rgba(15, 23, 42, 0.08);
  --ak-cover-fg:     #0a0e14;
  --ak-cover-shadow: none;
}
```

**Pedagogiskt skyddade konstanter (orörda):**
- Resistor-band-färger (slide 10): `#d4a574`, `#ff2222`, `#8b4513`, `#d4af37`
- RGB-cirkel-färger (slides 19, 26): `#ff1744`, `#00e676`, `#2979ff`
- RGB-färgexempel (slide 25): `#b400dc`, `#ff8cb4`, `#ffd400`, `#00e0ff`

---

## 3. Slidev-konfiguration

### Frontmatter (`slides.md` rad 21–25)

```yaml
# Före
background: '#0a0e14'
class: cover
colorSchema: dark

# Efter
class: cover
colorSchema: 'light'    # låser läget — ingen toggle, ingen OS-pref-fluktuation
```

`background:`-direktivet tas bort eftersom `--ak-bg` styr via CSS. `colorSchema: 'light'` säkerställer att Slidev:
- Sätter `<html class="light">` permanent
- Använder light-version av Shiki-tokens
- Döljer dark/light-toggle i nav-controls (eftersom valet är låst)
- Defaultar print/export till light

### Shiki (`setup/shiki.ts`)

Behåll Arduino-builtins-transformern. Eftersom `colorSchema: 'light'` styr aktiv tema kommer `--shiki-light` på Arduino-funktionerna att användas. `--shiki-dark`-värdena blir orörda (kostar ingenting att lämna kvar för framtida flexibilitet).

Tematval: Slidev's default light-tema appliceras automatiskt när `colorSchema: 'light'` är aktivt. Verifieras visuellt under §10A — om läsbarheten är dålig kan vi explicit sätta `themes: { light: 'vitesse-light' }` i `setup/shiki.ts`, men startpunkten är default.

---

## 4. Layout-strategi — `.cover`, `.section`, `.end`

```css
.slidev-layout.section {
  background: radial-gradient(circle at 30% 30%, var(--ak-bg-raised) 0%, var(--ak-bg) 60%) !important;
}
.slidev-layout.section h1 {
  color: var(--ak-accent);
}

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
}
.slidev-layout.cover h1 {
  color: var(--ak-cover-fg);
  text-shadow: var(--ak-cover-shadow);
}

.slidev-layout.end {
  background: radial-gradient(ellipse at center, var(--ak-bg-raised) 0%, var(--ak-bg) 70%) !important;
}
```

Samma gradient-recept som dark-versionen, andra tokens. `color-mix(in srgb, …)` är native i Chromium → ingen polyfill, ingen prepocess.

---

## 5. Övriga `main.css`-justeringar

### Tokeniserad code-wrapper-shadow

```css
.slidev-layout .slidev-code-wrapper {
  box-shadow: var(--ak-code-shadow);
  border: 1px solid var(--ak-border);
}
```

Mörka 50%-svarta shadows tas bort — på vitt skapar de tunga kontursvärtor.

### Print-overrides (`html.print`-block, rad 252–270)

Kan **förenklas dramatiskt**:
- `html.print .slidev-layout.cover { background-image: none }` → tas bort, hero-fotot funkar i light-export
- `html.print .slidev-layout.cover h1 { text-shadow: none }` → redundant (cover-shadow är redan `none`)
- Skugg-knockouts (`html.print .shadow-2xl { box-shadow: none !important }`) → behålls (Chromium-rastering bandar fortfarande)

Resultatet: ~10 rader istället för 18.

### `.rgb-white` (rad 241)

`.rgb-white { background-image: radial-gradient(circle closest-side, #ffffff 55%, ...) }` — vit cirkel på vit bakgrund är osynlig. Byt till en **subtilt-grå** "off"-state:

```css
.rgb-white { background-image: radial-gradient(circle closest-side, #d4d6d0 55%, rgba(212,214,208,0.3) 70%, transparent 100%); }
```

Pedagogiskt: representerar "alla LEDs av" (de svala glas-cirklarna på off-state-LED).

---

## 6. Slide-specifika fixar

### Slide 8 — Ohms-triangel (rad 393–453)

| Ändring | Före | Efter |
|---------|------|-------|
| SVG stroke | `stroke="#00ffd1"` | `stroke="var(--ak-accent)"` |
| Inline style | `color:#00ffd1` | `color:var(--ak-accent)` |
| Inline style | `color:#e8ecf1` (off-white, osynlig på vitt) | `color:var(--ak-text)` |
| Inline style | `color:#00ffd1;opacity:0.8` | `color:var(--ak-accent);opacity:0.8` |

### Slide 21 — RGB-färgblandning (rad 1140–1193)

`<img>` med `mix-blend-mode: screen` → ta **bort** blend mode helt. Bilden har naturligt svart bakgrund (originaldokumentationens stil — RGB-LED i mörkt rum). Vi ramar in den i en `.rgb-demo`-container som **också** har svart bakgrund + padding, så att bildens svarta yta möts av en svart frame utan synlig söm. Resultatet liknar en "skärm/display som visar RGB-demonstration" — pedagogiskt tydligt mot ljus slide.

```html
<!-- Före -->
<img src="/images/rgb-color-mixing.png" style="mix-blend-mode: screen; ..." />

<!-- Efter -->
<img src="/images/rgb-color-mixing.png" class="rgb-demo" />
```

```css
.rgb-demo {
  width: 26rem;
  border-radius: 1rem;
  box-shadow: 0 8px 24px rgba(0,0,0,0.12);
  background: #000;
  padding: 1rem;
}
```

Pedagogisk koppling: "så här ser RGB-LED ut i mörker — som vi kommer demonstrera i pratiken."

### Slide 24 — PWM-vågform (rad 1293–1321)

`<img>` med `filter: invert(1) hue-rotate(180deg)` → ta **bort** filtret helt. Originalbilden har mörka linjer på vit bakgrund — perfekt för light theme.

```html
<!-- Före -->
<img src="/images/pwm-waveform.png" style="filter: invert(1) hue-rotate(180deg); ..." />

<!-- Efter -->
<img src="/images/pwm-waveform.png" class="diagram-img" />
```

```css
.diagram-img {
  max-width: 100%;
  border-radius: 0.5rem;
  border: 1px solid var(--ak-border);
}
```

### Slide 25 — Färgexempel (rad 1323–1390)

**Korrigerad analys (efter visuell inspektion):** Sliden visar inte hex-koder som text — den visar **ord-namn** för färger (`Lila`, `Gammelrosa`, `Skolgul`, `Cyan`) inline-färgade med `style="color:#XXX"`. Till höger finns dessutom 4 färgblock som visar de exakta nyanserna.

Problemet: orden i `#ff8cb4`, `#ffd400`, `#00e0ff` blir oläsbara på vitt (kontrast 1–2.5:1). `#b400dc` är marginal (~3:1).

**Lösning — chip-version av ord-namnen:**

```html
<!-- Före (rad 1340–1343) -->
<div>· <span class="font-bold" style="color:#b400dc">Lila</span> — röd + blå, ingen grön</div>
<div>· <span class="font-bold" style="color:#ff8cb4">Gammelrosa</span> — mycket röd, lagom blå, lite grön</div>
<div>· <span class="font-bold" style="color:#ffd400">Skolgul</span> — full röd, lagom grön, ingen blå</div>
<div>· <span class="font-bold" style="color:#00e0ff">Cyan</span> — ingen röd, full grön + blå</div>

<!-- Efter -->
<div>· <span class="color-chip" style="--bg:#b400dc;--fg:#fff">Lila</span> — röd + blå, ingen grön</div>
<div>· <span class="color-chip" style="--bg:#ff8cb4;--fg:#000">Gammelrosa</span> — mycket röd, lagom blå, lite grön</div>
<div>· <span class="color-chip" style="--bg:#ffd400;--fg:#000">Skolgul</span> — full röd, lagom grön, ingen blå</div>
<div>· <span class="color-chip" style="--bg:#00e0ff;--fg:#000">Cyan</span> — ingen röd, full grön + blå</div>
```

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

`--fg`-värdena är handvalda per färg: vit på lila (kontrast 5.4:1), svart på rosa/gul/cyan (kontrast 8–14:1).

Pedagogiskt resultat: ordet **"Lila"** står på en lila-färgad chip — samma association som färgad text gav, fast garanterat läsbart. De 4 färgblocken till höger (rad 1355–1358) är orörda — de är fortfarande pedagogiskt skyddade konstanter och fungerar perfekt som "stora prov-blockets" mot vit slide.

### Slide 33 — Buzzer-bild (rad 1805)

**Korrigerad analys:** Den befintliga ringen `ring-2 ring-rose-500/50 shadow-2xl` är redan så subtil i nuvarande dark-rendering att användaren själv inte uppfattade den som dramatisk. Ingen pedagogisk drama-funktion att bevara.

**Minimal ändring** — bara tokenisera färgen så att den följer temat och tona ner shadow:

```vue
<!-- Före -->
<img src="..." class="max-h-[32rem] rounded-xl ring-2 ring-rose-500/50 shadow-2xl" />

<!-- Efter -->
<img src="..." class="max-h-[32rem] rounded-xl ring-2 ring-[color-mix(in_srgb,var(--ak-danger)_50%,transparent)] shadow-md" />
```

`shadow-2xl` → `shadow-md` av samma skäl som code-wrappers: tunga skuggor blir hårda kontursvärtor mot vitt.

### Slide 11 — Breadboard-internals (rad 610)

Inline `style="background:white;padding:10px"` → behåll. Bilden har medvetet vit bakgrund som matchar light theme. Migrera till klass för konsistens:

```html
<img src="/images/breadboard-internals.png" class="breadboard-diagram" />
```

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

---

## 7. Komponentfix — `WiringSlide.vue`

Rad 28: `ring-1 ring-white/10` → osynlig på vitt.

```vue
<!-- Före -->
class="max-h-full max-w-full object-contain rounded-lg shadow-2xl ring-1 ring-white/10"

<!-- Efter -->
class="max-h-full max-w-full object-contain rounded-lg shadow-md ring-1 ring-[var(--ak-border)]"
```

`shadow-2xl` → `shadow-md` (mindre dramatik på ljus bakgrund).

---

## 8. SVG-fix — `voltage-divider.svg`

SVG har hårdkodade dark-fills (`#eaeaea`, `#9aa5b1`, `#616e7c`, stroke `#1f2933`). Två lösningsvägar:

**A. Inline SVG i slide** (väljs)
- Flytta SVG-koden in i `slides.md` slide 41
- Använd `currentColor` på fills och stroke
- Tema-styrt via `style="color: var(--ak-text)"` på rot-elementet

**B. Två SVG-filer** (alternativ — kräver dual-asset-tracking)
- `voltage-divider.svg` blir light-version (svart-på-vitt)
- Light-only-projektet behöver bara light-versionen

**Vald väg: B — single light-only SVG.** Eftersom vi nu är light-only finns ingen anledning till `currentColor`-flexibilitet. Skriv om SVG:n direkt med:

```
fill="#0a0e14"  (var(--ak-text))
fill="#4a5568"  (var(--ak-text-dim))
fill="#8a95a3"  (var(--ak-text-mute))
stroke="#d4d6d0" (var(--ak-border))
```

Hardkodning i SVG är OK eftersom temat är låst. Om vi någon gång byter accent eller font-vikt på div-figuren kan vi då uppdatera.

---

## 9. Build-pipeline (`package.json`)

**Inga ändringar.** Befintliga scripts:
- `dev` — Slidev dev server, light som låst läge
- `build` — statisk build, light
- `export` — PDF, light
- `export-notes` — talnotes, ej tema-relaterat

`--dark`-flagga blir irrelevant. `slidev export --dark` skulle teoretiskt fortfarande fungera (Playwright kan tvinga `prefers-color-scheme: dark`), men vår `colorSchema: 'light'` i frontmatter låser bort det.

---

## 10. Verifierings-plan

### A. Visuellt — `npm run dev`

Bläddra genom alla 52 slides och kontrollera per slide:
- [ ] Text läsbar (no off-white-on-white)
- [ ] Accentfärg synlig (cyan-rester ska vara borta)
- [ ] Bilder placerade naturligt (ingen invertering, ingen blend mode oavsiktligt kvar)
- [ ] Kort, kantbordrar, dividers synliga men inte hårda
- [ ] Glow-effekter på `.sp.unlocked`/`.sp.current` syns som mjuk highlight (ej försvunna)

### B. Kod — `git grep`

```bash
git grep '#0a0e14\|#eaeaea\|#00ffd1\|colorSchema.*dark\|html\.dark' presentation/
```

Allt utfall ska vara antingen i CSS-tokens (där det är lagligt) eller i kommentarer.

### C. PDF-export — `npm run export`

- Öppna i Preview, granska alla sidor
- Skriva ut första 5 sidorna på vanlig kontorsskrivare (om tillgänglig) — kontrollera att text inte kommer ut grå/svag
- Verifiera att kompendium-pipelinen i `kompendium/deliveries/` fortfarande genererar valida PDF:er (köra om om relevant — separat task)

### D. Projektor-test (manuellt, om möjligt)

Anslut MacBook till projektor och bläddra slide 1, 8, 21, 24, 25, 41 (de färgkritiska). Iaktta:
- Är all text läsbar från bakre sittraden?
- Tappar accent-färgen tonen mot ljusgrå?
- Reflekteras text-shadow-bus från cover någonstans?

### E. Kontrast-mätning (rättsäkert)

Använda Chrome DevTools "Issues"-panelen eller WebAIM contrast checker på 5 slumpvis valda slides. Alla `--ak-text` på `--ak-bg` ska vara minst 7:1 (passar AAA). Accent på bakgrund minst 4.5:1 (AA).

---

## 11. Out of scope

- **Kompendium-pipelinen** (`kompendium/`) — separat ekosystem, ingen ändring i denna PR.
- **Per-dag PDF-distribution** (`kompendium/deliveries/slides-per-dag/`) — kommer behöva regenereras post-merge, men det är en separat operation.
- **Orphaned bilder** (6 oanvända PNG/JPG i public/images) — separat städ-task.
- **Code-block ljustema** — Slidev's default ljustema (`vitesse-light`) räcker; ingen anledning att custom-shika.
- **Återinförande av dark som opt-in** — explicit avskaffat. Git-historiken har dark-versionen om den nånsin behövs. (`setup/shiki.ts` behåller dock `--shiki-dark`-värdena på Arduino-builtins-transformern eftersom de inte kostar något att lämna kvar och ger framtida flexibilitet utan dyr migration.)

---

## 12. Migration / risker

- **Befintliga distribuerade dark-PDF:er** finns hos studenter. Light-versionen genererad post-merge ersätter dem som "kanonisk version". Inga åtgärder mot redan-utdelade kopior.
- **Risk: oavsiktligt utelämnad dark-referens.** Mitigering: `git grep` enligt §10B fångar de flesta.
- **Risk: Shiki light-tema väljs annorlunda än man tror.** Mitigering: visuell granskning av kodblock i §10A; Slidev fallback-tema är vitesse-light, vilket fungerar väl för Arduino C++.
- **Risk: contrast-regression i `--ak-text-mute`** (`#8a95a3` mot `#fafaf7` ≈ 3:1). Acceptabelt för "mute"-roller (footer, eyebrow), men EJ för fyldigare text. Säkerställ att `text-mute` bara används för decorationsroller.

---

## 13. Implementationsordning (för writing-plans)

1. CSS-tokens och layout-overrides (`styles/main.css`)
2. Frontmatter-flippa (`slides.md` rad 21–25)
3. Slide 8 (Ohms) — inline-styles bytes till tokens
4. Slide 21 (RGB-blend) — bort med `mix-blend-mode`, lägg `.rgb-demo`-klass
5. Slide 24 (PWM) — bort med `filter`, lägg `.diagram-img`-klass
6. Slide 25 (färgexempel) — chip-design + CSS
7. Slide 11 (breadboard) — flytta inline-style till klass
8. Slide 33 (buzzer) — ringtonen ned
9. `WiringSlide.vue` rad 28
10. `voltage-divider.svg` — skriv om fills/stroke
11. Verifiering enligt §10
12. Commit + multi-auditor-review
