# Slidev Native Light/Dark Mode — Kartläggning

> Syfte: Förstå vad Slidev erbjuder nativt för dark/light-hantering innan vi skriver custom CSS.
> Kontext: `presentation/` använder `theme: default`, `colorSchema: dark`, Slidev CLI latest.
> Datum: 2026-05-04

---

## 1. `colorSchema`-alternativ

**Giltiga värden för `SlidevConfig` (frontmatter):** `'auto' | 'dark' | 'light' | 'all'`

Källa: `node_modules/@slidev/types/dist/index.d.mts` rad 400:
```typescript
colorSchema?: 'dark' | 'light' | 'all' | 'auto';
// @default 'auto'
```

**Beteende per värde:**

| Värde | Beteende |
|-------|----------|
| `'auto'` | Följer `localStorage['slidev-color-schema']` (default `'auto'`) → faller tillbaka på `prefers-color-scheme`. Toggle-knappen i nav visas och skriver till localStorage. |
| `'dark'` | Låser `isDark = true`. `isColorSchemaConfigured = true`. Toggle-knappen DÖLJS (se nedan). Ingen localStorage-effekt. |
| `'light'` | Låser `isDark = false`. Samma låsning. Toggle-knappen DÖLJS. |
| `'all'` | Typen accepterar det, men `dark.ts` behandlar det inte separat — `configs.colorSchema !== 'auto'` blir `true`, men `configs.colorSchema === 'dark'` blir `false`, vilket ger `isDark = false`. Praktiskt: `'all'` beter sig som `'light'` (html.light sätts). Inte dokumenterat som avsett; troligtvis ett tema-metadata-värde som läckt in i config-typen. |

**Notera:** `SlidevThemeMeta` (themes `package.json`) har sin *egna* `colorSchema?: 'dark' | 'light' | 'both'` (rad 238) — det är ett deklarativt metadatafält, inte en runtime-config.

---

## 2. Dark/light-klass-mekaniken

Källa: `node_modules/@slidev/client/logic/dark.ts` (hela filen, 49 rader)

```typescript
// Körs vid varje isDark-förändring (immediate: true)
html.classList.toggle('dark', v)   // html.dark sätts när dark = true
html.classList.toggle('light', !v) // html.light sätts när dark = false
```

**Viktiga observationer:**

1. **Alltid ett av två** — `html.dark` och `html.light` är komplementära. Aldrig båda, aldrig ingen.
2. **CSS `color-scheme`** — `styles/code.css` rad 1–3 sätter `html.dark:root { color-scheme: dark; }`. Ingen motsvarighet för light (default är light).
3. **Transition-suppression** — Klassen-bytet sker med en temporär `* { transition: none !important }` style som injectas och omedelbart tas bort, vilket förhindrar flash.
4. **localStorage-nyckel** — `'slidev-color-schema'` (string `'auto' | 'dark' | 'light'`). Om frontmatter sätter `colorSchema: dark` ignoreras localStorage helt (`isColorSchemaConfigured` guard på rad 18–20).

---

## 3. Toggle-UI i NavControls

Källa: `node_modules/@slidev/client/internals/NavControls.vue` rad 79–86:

```html
<IconButton
  v-if="!isColorSchemaConfigured"
  :title="isDark ? 'Switch to light mode theme' : 'Switch to dark mode theme'"
  @click="toggleDark()"
>
  <carbon-moon v-if="isDark" />
  <carbon-sun v-else />
</IconButton>
```

**Slutsats:**

- Toggle-knappen (sol/måne-ikon) är **inbyggd i NavControls och alltid med** — men villkorad på `!isColorSchemaConfigured`.
- Med `colorSchema: dark` (eller `light`) i frontmatter → `isColorSchemaConfigured = true` → **knappen är osynlig**.
- Med `colorSchema: auto` (eller ingen `colorSchema`) → knappen syns och fungerar.
- Det finns **inget frontmatter-fält för att explicit visa/dölja knappen** — enda kontrollen är om colorSchema är hårdkodat eller ej.
- För att exponera toggle-knappen: byt till `colorSchema: auto` i frontmatter.

---

## 4. `theme: default` light-stöd och CSS-variabler

Källa: `node_modules/@slidev/theme-default/styles/`

### `layouts.css`
Ingen dark/light-konditionering alls. Bara layout-regler (grid, text-size, Tailwind `@apply`). Inga `html.dark` eller `html.light` selektorer.

### `prism.css`
Komplett dual-mode för Prism syntax highlighting:

```css
html:not(.dark) {
  --prism-foreground: #393a34;
  --prism-comment: #a0ada0;
  --prism-string: #b56959;
  /* ...15 tokens totalt */
}

html.dark {
  --prism-foreground: #d4cfbf;
  --prism-comment: #758575;
  /* ...18 tokens totalt */
}
```

### Client-level `styles/vars.css`
```css
:root {
  --slidev-code-background: #f5f5f5;   /* ljus standard */
  --slidev-code-foreground: #1b1b1b;
  --slidev-theme-primary: #3ab9d5;
  /* ...fler */
}

html.dark {
  --slidev-code-background: #1b1b1b;   /* mörk override */
  --slidev-code-foreground: #eee;
  /* ...fler */
}
```

### Samtliga Slidev CSS-variabler:

**Alltid satta (`:root`):**
- `--slidev-code-background` (#f5f5f5 light default)
- `--slidev-code-foreground` (#1b1b1b)
- `--slidev-code-font-family`
- `--slidev-code-padding`
- `--slidev-code-font-size`
- `--slidev-code-line-height`
- `--slidev-code-radius`
- `--slidev-code-margin`
- `--slidev-theme-primary` (#3ab9d5)
- `--slidev-transition-duration` (0.5s)
- `--slidev-slide-container-background` (black)
- `--slidev-controls-foreground` (white)
- `--slidev-code-tab-divider`
- `--slidev-code-tab-text-color`
- `--slidev-code-tab-font-size`
- `--slidev-code-tab-active-text-color`

**Dark-overrides (`html.dark`):**
- `--slidev-code-background` (#1b1b1b)
- `--slidev-code-foreground` (#eee)
- `--slidev-code-tab-divider` (#222222)
- `--slidev-code-tab-text-color` (#98989f)
- `--slidev-code-tab-active-text-color` (#dfdfd6)

**Prism-tokens (dual-set, `html:not(.dark)` + `html.dark`):**
`--prism-foreground`, `--prism-comment`, `--prism-string`, `--prism-literal`, `--prism-number`, `--prism-keyword`, `--prism-function`, `--prism-boolean`, `--prism-constant`, `--prism-deleted`, `--prism-class`, `--prism-builtin`, `--prism-property`, `--prism-namespace`, `--prism-punctuation`, `--prism-decorator`, `--prism-regex`, `--prism-json-property`

**OBS:** `theme-default` deklarerar **ingen** `--slidev-slide-container-background` eller bakgrundsfärg för slides (det är client-lagret som sätter black). Temat exponerar inte heller egna light-mode-bakgrundsvariabler — det överlåts till användaren.

---

## 5. Shiki-temasystemet

### Standard dual-theme

Källa: `node_modules/@slidev/client/setup/shiki-options.ts` rad 29–34:

```typescript
// Om ingen theme/themes konfigureras → automatisk default:
if (!mergedOptions.theme && !mergedOptions.themes) {
  mergedOptions.themes = {
    dark: 'vitesse-dark',
    light: 'vitesse-light',
  }
}
```

Slidev väljer alltså **vitesse-dark + vitesse-light** som default om inget annat anges.

### CSS-kopplingen

Källa: `node_modules/@slidev/client/styles/code.css` rad 5–22:

```css
html.dark .shiki span {
  color: var(--shiki-dark);
}
html:not(.dark) .shiki span {
  color: var(--shiki-light);
}
```

Shikis dual-theme-output genererar inline CSS-variabler `--shiki-light` och `--shiki-dark` per token. Slidev's `code.css` selekterar rätt variabel baserat på `html.dark`-klassen. Systemet är **automatiskt och fullständigt** — ingen extra CSS behövs.

### Frontmatter-config

Det finns inget frontmatter-direktiv för Shiki-tema — det sätts enbart via `setup/shiki.ts`. Projektet har redan:

```typescript
// setup/shiki.ts
export default defineShikiSetup(() => ({
  transformers: [/* arduino-builtins transformer */],
}))
```

Ingen `themes`-nyckel → vitesse-dark/vitesse-light används. Byt tema genom att lägga till:
```typescript
export default defineShikiSetup(() => ({
  themes: { dark: 'vitesse-dark', light: 'vitesse-light' },
  transformers: [/* ... */],
}))
```

### `shiki-options.ts` logik för `themes` vs `theme`

- Om du anger `themes: { dark, light }` → `defaultColor: false` sätts automatiskt → dubbla CSS-variabler genereras per token.
- Om du anger `theme: 'vitesse-dark'` (single) → enbart `color` sätts, ingen `--shiki-dark`/`--shiki-light`.

---

## 6. Print-mode

### Hur `html.print` sätts

Källa: `node_modules/@slidev/client/pages/print.vue` rad 10–14:

```javascript
watchEffect(() => {
  if (isPrintMode)
    document.body.parentNode.classList.add('print')
  else
    document.body.parentNode.classList.remove('print')
})
```

### Hur `isPrintMode` triggras

Källa: `node_modules/@slidev/client/composables/useNav.ts` rad 283:

```javascript
const isPrintMode = computed(() =>
  query.value.has('print') || currentRoute.name === 'export'
)
```

Alltså: `html.print` sätts när URL har `?print` (eller `?print=clicks`) **eller** när man är på `/export`-routen.

### Kombination `html.light.print`

Ja, det är fullt möjligt. `html.dark` och `html.print` är oberoende klasser. CSS-selektorn `html.light.print` (eller `html.print:not(.dark)`) fungerar utan problem. Projektet använder redan `html.print` i `styles/main.css` (rad 258–270) för att nolla box-shadows m.m.

### Print + dark/light i CLI-export

Playwright-exporten sätter `html.print` via URL-parametern och sedan `colorScheme` via `page.emulateMedia({ colorScheme: dark ? 'dark' : 'light' })` (export-CLI rad 138). Dessa är oberoende av varandra.

---

## 7. Export-pipeline

### Playwright-flödet

Källa: `node_modules/@slidev/cli/dist/export-C4evmDwN.mjs`

```javascript
// rad 138:
await page.emulateMedia({
  colorScheme: dark ? "dark" : "light",
  media: "screen"
})

// rad 389 (hur `dark` bestäms):
dark: dark || options.data.config.colorSchema === "dark"
```

Logiken: Om CLI-flaggan `--dark` är satt **eller** om frontmatter har `colorSchema: dark` → exporteras i dark mode.

### CLI-flaggor för export

Källa: `node_modules/@slidev/cli/dist/cli.mjs` rad 482–484:

```
--dark        export as dark theme   (boolean)
```

Det finns **ingen** `--light`-flagga och ingen `--color-schema`-flagga. För att exportera light:
1. Sätt `colorSchema: light` i frontmatter (påverkar runtime OCH export)
2. Eller ta bort `colorSchema: dark` från frontmatter (default är `auto`, Playwright använder då `light` eftersom `dark = false`)

### Kan man kontrollera via URL-param eller localStorage?

- **URL-param:** Nej, ingen `?colorSchema=light` finns.
- **localStorage:** Playwright startar med fresh profil — localStorage är tomt, och eftersom `colorSchema: dark` finns i frontmatter ignoreras localStorage ändå (lock-logiken i `dark.ts`).
- **`page.emulateMedia`** är den enda mekanismen, och den styrs av `dark`-parametern till `exportSlides()`.

### Praktisk export-strategi

För att kunna producera **både** dark och light export:
- Light: Ändra temporärt frontmatter till `colorSchema: auto` (eller `light`) och kör `slidev export`
- Dark: Kör `slidev export --dark` (eller ha `colorSchema: dark` i frontmatter)
- Alternativt: Bygg en wrapper-script som kör export två gånger med olika output-namn.

---

## 8. Annat nativt

### Addons

Slidev har ett addon-system (liknar theme-systemet), men inget av de installerade paketen (`@slidev/cli`, `@slidev/client`, `@slidev/parser`, `@slidev/rough-notation`, `@slidev/theme-default`, `@slidev/theme-seriph`, `@slidev/types`) är ett addon. Inga addon-specifika dark-mode-helpers hittades i källkoden.

### Per-slide color override

**Finns inte nativt.** `FRONTMATTER_FIELDS` (constants.ts rad 33–49) listar tillåtna per-slide-fält: `clicks`, `layout`, `transition`, `zoom`, etc. `colorSchema` finns **inte** bland dem — det är ett `HEADMATTER_FIELDS`-fält (rad 73) som bara gäller slide 1. Det går inte att sätta `colorSchema: light` på enskild slide.

### `<LightOrDark>` — inbyggd komponent

Källa: `node_modules/@slidev/client/builtin/LightOrDark.vue`:

```html
<template>
  <div>
    <slot v-if="isDark" name="dark" />
    <slot v-else name="light" />
  </div>
</template>
```

Kan användas i slides för att rendera olika innehåll beroende på mode:
```markdown
<LightOrDark>
  <template #dark>Mörkt innehåll</template>
  <template #light>Ljust innehåll</template>
</LightOrDark>
```

### Layout-specifik färglogik

`cover`, `intro`, `statement`, `section`, `fact`, `quote` — inga av dessa layouts i `theme-default` har inbyggd färglogik. De är rent layout-CSS utan `html.dark`-villkor.

### `SlidevColorSchemaProvider`

Finns inte. Inget sådant interface eller provider hittades i källkoden.

---

## 9. `@slidev/theme-seriph` — dual-mode-stöd

`theme-seriph` är installerat (troligtvis som beroende eller dev-dep). Dess `prism.css` är **identisk** med `theme-default/prism.css` — samma Vitesse-light/dark tokens. `layouts.css` har en primärfärg (`--slidev-theme-primary: #5d8392`) men inga dark/light-villkor.

**Metadata** (package.json `slidev`-fält): Varken theme-default eller theme-seriph deklarerar `colorSchema`-fält i sin `package.json`. Enligt Slidev-docs innebär avsaknaden att de stödjer **both** (default).

**Rekommendation att byta?** Nej. Seriph är ett serif-tema (PT Serif-font) som inte passar en teknisk Arduino-kurs. Det har exakt samma dark/light-infrastruktur som default. Dina custom CSS-tokens (`--ak-*`) skulle gå sönder om du bytte.

---

## 10. Officiell dokumentation — relevanta avsnitt

### Från sli.dev/custom/:

> `colorSchema`: "force color schema for the slides, can be `'auto'`, `'light'`, or `'dark'`" — Default: `'auto'`

**OBS:** Dokumentationen nämner bara tre värden men typen har fyra (`'all'` är odokumenterat).

### Från sli.dev/guide/exporting:

> `slidev export --dark` — "export your slides using the dark version of the theme"

Inga `--light`-flaggor dokumenterade.

### Från sli.dev/guide/write-theme:

> "By default, Slidev assumes themes support both light mode and dark mode."
> Themes can declare: `"slidev": { "colorSchema": "light" }` i package.json för att begränsa till light-only.

### Från sli.dev/custom/config-highlighter:

Shiki `themes`-objekt med `dark` + `light` nycklar är det officiella sättet att hantera dual-mode code highlighting. CSS-variablerna `--shiki-light` och `--shiki-dark` genereras automatiskt av Shiki.

---

## Sammanfattning

### Saker Slidev ger oss gratis (använd dessa)

1. **`html.dark` / `html.light`** — komplementära klasser, sätts automatiskt av `dark.ts`. All CSS kan baseras på dessa selektorer.
2. **Shiki dual-theme** — `--shiki-dark` / `--shiki-light` genereras per token, `code.css` kopplar dem automatiskt. Lägg bara till `themes: { dark, light }` i `setup/shiki.ts`.
3. **Prism dual-theme** — `theme-default/prism.css` har komplett `html:not(.dark)` + `html.dark`-CSS för alla tokens. Fungerar direkt.
4. **`--slidev-code-*` variabler** — `vars.css` har light-default + dark-override. Använd dem i custom CSS.
5. **Toggle-knapp** — inbyggd i NavControls, aktiveras automatiskt när `colorSchema: auto` sätts.
6. **`<LightOrDark>`** — inbyggd Vue-komponent för att byta slide-innehåll baserat på mode.
7. **`html.print`** — sätts automatiskt av `print.vue` vid `?print` URL eller `/export`-route. Kan kombineras med `.light.print`.
8. **Export `--dark`** — CLI-flagga som via Playwright `emulateMedia` sätter rätt mode vid export. Frontmatter `colorSchema: dark` triggar detta automatiskt.

### Saker vi måste bygga själva

1. **Light-mode design tokens** — Projektet har enbart dark tokens (`--ak-bg: #0a0e14` etc). Vi måste definiera `html.light { --ak-bg: ...; }` overrides i `styles/main.css`.
2. **Light-mode per komponent** — `.sp`, `.warn-box`, `.tip-box`, `.section`, `.cover` etc är hårdkodade mot dark tokens. Kräver `html.light .sp { ... }` overrides.
3. **Dubbel export-workflow** — Inget enkelt `slidev export --light`-kommando finns. Kräver antingen frontmatter-byte + script, eller en wrapper.
4. **Cover-slide light** — `background-image` med hero-foto + gradient är dark-anpassad. Behöver `html.light .slidev-layout.cover { ... }`.

### Recommended architecture (3–5 punkter)

1. **Byt till `colorSchema: auto`** i frontmatter. Toggle-knappen dyker upp gratis, localStorage driver state, Playwright-export med `--dark` ger dark PDF.

2. **Lägg till light-tokens i `styles/main.css`** under ett `html.light { }` block som overridar `--ak-bg`, `--ak-bg-raised`, `--ak-border`, `--ak-text`, `--ak-text-dim`, `--ak-text-mute`. Accent-färger kan behållas eller justeras.

3. **Lägg till `themes: { dark: 'vitesse-dark', light: 'vitesse-light' }` i `setup/shiki.ts`** (eller valfria Shiki-teman). Det enda kod-filen behöver — resten sköts automatiskt av `code.css`.

4. **Bygg en `export.sh`** med två körningar:
   ```sh
   # Light (projektor):
   slidev export --output slides-light   # colorSchema: auto → Playwright default light
   # Dark (online):
   slidev export --dark --output slides-dark
   ```

5. **Använd `html.light.print`** för eventuella print-specifika overrides vid light-export. Kombinationen fungerar utan krock.
