# Arduino-kurs — CLAUDE.md

5-träffars Arduino-nybörjarkurs (FRO Ånge, ELEGOO UNO Basic Starter Kit). Detta repo har **tre oberoende delsystem** som inte ska blandas ihop:

- `presentation/` — Slidev-deck (52 slides, light-only-tema, projektor-prio)
- `kompendium/` — Typst-baserade kurshandouts (separat ekosystem, separat pipeline)
- `docs/` — GitHub Pages-site för kursdeltagare (vanilla HTML/CSS, ingen build-step; deployar `/docs` från `main`). Live på `https://speakman.github.io/arduino-kurs/`. **Refresh-kontrakt:** se `docs/REFRESH.md` — siten måste hand-syncas när slides/kompendium/bilder ändras.
- `tasks/` — designspecs, audits, reviews, plan-dokument, renderade artifakter
- `research/` — referensmaterial (ELEGOO PDF-bilder etc.)

Slides är **det primära mediet** (klassrumsprojektor). Kompendium ges till studenten efter passet. Docs är portalen som deltagare har kvar efter kursen.

---

## Bygg- och utvecklingskommandon

Allt körs från `presentation/`:

```bash
npm run dev                                                    # dev-server, port 3030
npm run dev:remote                                             # exponerar på LAN
npm run build                                                  # statisk build → dist/
npm run export                                                 # PDF (CLI-exporter, html.print active)
npm run export -- --format png --output ../tasks/light-mode-rendered/   # PNG-batch (52 filer)
npm run export-notes                                           # presenter-notes export
```

**Slidev v52+ stödjer `--format png` nativt** — ingen Playwright-fallback behövs.

**OBS:** `slidev export --format png` overskriver allt i `--output`-mappen. Generera PDF FÖRST om båda behövs samtidigt.

---

## Kodkonventioner — DO / DON'T

### CSS

| Do | Don't |
|----|-------|
| Använd `--ak-*`-tokens från `:root` i `presentation/styles/main.css` | Hardkoda hex-värden i CSS (förutom pedagogiska konstanter) |
| Använd `color-mix(in srgb, var(--ak-X) Y%, transparent)` för opaciter | Skriv `rgba(R,G,B,A)` med gamla token-värden (drift-risk) |
| Definiera nya domain-klasser i `main.css` (sektion 7) | Inline `style=` för återanvändbar styling |
| Inline `style="--bg:...;--fg:..."` för per-instans CSS-vars | Skapa N variant-klasser för varje färg |

### Slide-content (slides.md)

| Do | Don't |
|----|-------|
| Använd Markdown ` ```cpp `-fence för kod-block → Shiki per-token | Använd `<code>...</code>` för flera kod-rader (får bara inline-styling, inte Shiki) |
| Använd `<code>...</code>` eller backticks för **inline** kod-referenser | Använd `<span class="mono">` för kod-referenser (inkonsekvent med övriga) |
| Använd `class="cyan"` för accent-emfasis i prosa | Använd `style="color:#00747d"` för accent (inte tokeniserat) |
| Använd `<v-click>` för stegvis avslöjande där pedagogiskt motiverat | Tappa pedagogiska klipp för "snabbare flow" |

### Pedagogiskt skyddade konstanter (RÖR ALDRIG utan explicit motivering)

| Konstanter | Var | Varför |
|-----------|-----|--------|
| `#d4a574` `#ff2222` `#8b4513` `#d4af37` | slide 10 (resistor-band) + AI-prompt för `resistor-220ohm.png` | Fysiska komponentfärger studenten ska identifiera. AI-rendrade resistorer MÅSTE följa 4-band 220 Ω: röd-röd-brun + (gap) + guld |
| `#ff1744` `#00e676` `#2979ff` | slides 19, 26 (RGB-LED-cirklar) | Faktiska LED-färger |
| `#b400dc` `#ff8cb4` `#ffd400` `#00e0ff` | slide 25 (RGB-färgexempel) | Övningens målfärger |
| `#ffd400` (sun) | AI-prompt för `voltage-divider.png` | Sol-symbol — pedagogisk metafor (vid regeneration: behåll i prompt) |

### Atomic commits

- En commit per logisk enhet (en slide-fix, en CSS-block-byte, en SVG-rewrite)
- `feat(...)` för nya features, `fix(...)` per slide/komponent, `refactor(...)` för flytt utan funktionsändring, `docs(...)` för dokumentation
- Conventional Commits-stil
- **Aldrig amend** efter att en commit är gjord — gör ny commit istället

---

## Visuella kvalitetskrav

- **WCAG AA minimum** för all text: 4.5:1 mot bakgrund. AAA (7:1) önskvärt för body-text.
- Light-mode tokens: `#0a0e14` text på `#fafaf7` bg = 18.5:1 ✓
- Accent `#00747d` på `#fafaf7` = 5.28:1 ✓ (justerades upp från initial #00838c som missade AA)
- **Cover-slide** har dual-mode: live-presentation = vit text på mörk gradient över hero-foto, PDF/print = mörk text på off-white (foto killat via `html.print`-rule pga Chromium PDF-rasteriserings-buggar)
- **Inga slides får ha kontrast under 3:1** för någon synlig text — testa i `tasks/light-mode-rendered/*.png`

### Custom CSS-klass-registry (i `main.css` sektion 7)

| Klass | Slide(s) | Syfte |
|-------|----------|-------|
| `.color-chip` | 25 | Färgnamn på sin egen färg, kontrast-anpassad text via `--bg`/`--fg` inline |
| `.rgb-demo` | 21 | Sizing + soft shadow för RGB-blandnings-bild (bilden har egen mörk bg) |
| `.breadboard-diagram` | 11 | Vit-bg ram (medvetet hardkodad vit, oavsett tema) |
| `.sp-grid` / `.sp.locked/unlocked/current` | 2 | Modul-kort på kursöversikt |
| `.warn-box` / `.tip-box` | flera | Pedagogiska varnings/tips-rutor |
| `.rgb-circle` (.rgb-red/.rgb-green/.rgb-blue/.rgb-white) | 19, 26 | RGB-LED-visualisering |
| `.big-code` | 23, 36, 46 | Förstorat kod-block |

---

## Arkitektur — det icke-uppenbara

- **Single-theme light-only** sedan 2026-05-05. Skrotat dark mode helt, men `setup/shiki.ts` behåller `--shiki-dark` på Arduino-builtins-transformern (kostar inget; framtida flexibilitet).
- **`html.print`-block i `main.css`** finns för att skydda mot Chromium PDF-rasteriserings-buggar (banding på `linear-gradient` + `url()`). KEPT trots att light-mode i sig inte triggar buggen — historiskt skydd.
- **Shiki dual-theme-tokens** sätts på Arduino-funktioner via `setup/shiki.ts`. Aktivt tema styrs av `colorSchema`-frontmatter i `slides.md`.
- **canvasWidth: 1920** + UnoCSS font-size-skalan ombasad i `uno.config.ts` — text-sizes är inte default Tailwind-värden.
- **Pedagogiska konstanter** lever i slides.md (inline) och `voltage-divider.svg` (med token-mirror-kommentar). De är medvetet inte tokeniserade.

---

## Browser-exporter vs CLI-exporter

`http://localhost:3030/export` är ett alternativ till `npm run export`. Skillnaden är konkret:

- **CLI** → headless Chromium, applies `html.print` (cover hero-foto killat). Reproducerbar, CI-friendly. Default för all distribution.
- **Browser-exporter** → live dev-server, browser print-pipeline. Cover-hero-fotot syns i preview men kräver native print-dialog (kan inte automatiseras via Claude Code/MCP). Använd manuellt om du vill ha en "premium" cover-version med foto i PDF.

---

## AI-bildgenerering — modellval och workflow

Empiriskt verifierat 2026-05-05 över ~30 bildgenerationer + användar-jämförelse på alla 18 deck-bilder:

### Default: **Higgsfield `nano_banana_2`** för i princip allt

Användar-A/B-test 2026-05-05: NB2 vann över gpt-image-2 på **17/18 bilder** (cartoonen, triangeln, fotocell-states, breadboard, PWM, voltage-divider, RGB-mixing, cover, Arduino-hero, buzzer-sticker, fotocell-macro, resistor-220Ω, alla Fritzings). Hero-shots och pedagogiska illustrationer är NB2 jämbördigt eller bättre. På Fritzing-style med tät text-labels är NB2 markant bättre.

### Modellval per bildtyp

| Bildtyp | Modell | Endpoint / verktyg | Anteckning |
|---------|--------|---------------------|--------|
| **DEFAULT — allt** | **Higgsfield `nano_banana_2`** | `higgsfield generate create nano_banana_2 --image <ref> --prompt "..." --wait` | Bra på cartoon, illustrationer, schema, fotorealism, AND Fritzing-labels |
| Photo-fidelity-kritiska (exakt wiring i TinkerCAD-foton, Fritzings med specifika pin-anslutningar) | **Restore original** | n/a | Båda modeller hallucinerar pin-positioner. Originalets fidelity är pedagogiskt nödvändig |
| Fallback om NB2 fail eller specifik sak inte funkar | OpenAI `gpt-image-2` | `/v1/images/edits` | Hade tidigare default-rollen, fungerar men är sämre på text-labels och småskaligt detalj |

### Workflow för regen

1. **Pre-flight:** Kontrollera `higgsfield account status` (CLI authed). Concurrent-jobs-limit på starter-plan = **4**, max 4 parallella i taget.
2. **Originals först:** Backup till `tasks/image-gen/originals/` FÖRE delete-commit (omvänd ordning är data-loss-risk)
3. **Prompt-fil per bild:** Spara i `tasks/image-gen/v[N]/<name>-prompt.txt` för reproducerbarhet
4. **Strukturerad prompt:** Lista vad som BEVARAS exakt och vad som ÄNDRAS (en korrigering åt gången). Avslutas med "ABSOLUTE CONSTRAINTS — must NOT include..."
5. **Higgsfield-anrop**: `URL=$(higgsfield generate create nano_banana_2 --image <path> --prompt "$(cat prompt.txt)" --wait | tail -1) && curl -sS "$URL" -o tasks/image-gen/v[N]/<name>.png`. Run i background med run_in_background:true för parallellisering.
6. **Visuell review per bild**: Read tool på PNG, jämför mot original. Specifik check: pin-labels, kolumnsiffror på breadboard, +/− på rails, resistor-färgband.
7. **Användarjämförelse** (för stora regen-runder): bygg HTML i `tasks/image-gen/v[N]/comparison.html` med radio-buttons + comment-fält så användaren kan välja bästa variant per bild. localStorage-persistens, JSON-export.
8. **Integrera**: kopiera till `presentation/public/images/<same-name>` (samma path = ingen slides.md-edit). Vid ny bild (t.ex. ohms-triangle.png): edita slide-markdown.
9. **Filnamn-extension**: NB2 returnerar PNG. Om slide-ref använder .jpg → konvertera via `magick <src>.png -quality 90 <dst>.jpg`. Annars cp direkt.
10. **Build smoke**: `npm run build` (~6s)
11. **Slide-render-test**: `npx slidev export --format png --range "<n>" --output /tmp/preview/` per ändrad slide
12. **Atomic commit per logisk enhet** (en regen-runda = en commit, men distinkta refinements kan delas)

### Crop / CSS scaling

`/v1/images/edits` ger ofta omtolkade kompositioner (extra rader, omarrangerade element). Två räddningsverktyg:
- `magick <src> -crop WxH+X+Y +repage <dst>` — pixel-exakt crop när AI lagt till oönskade element
- Inline CSS `style="max-height:580px;width:auto;margin:0 auto;display:block"` på `<img>` — när AI-bilden är rätt men för stor i slide-layouten

### Modeller att UNDVIKA för det här projektet

- DALL-E 3 — saknar `/edits`-endpoint, ingen referensbevarande
- gpt-image-1.5 / 1 / mini — föregångare, sämre på allt
- Soul V2 / Soul Cinema — för stilfulla, NSFW-orienterade
- Marketing Studio — för branded ad video (inte vår use case)

### Kostnadsuppskattning

- nano_banana_2 (Higgsfield) ≈ **4 credits / bild** i praktiken (verifierat över 30 anrop). Starter-plan ger 1000+ credits.
- gpt-image-2 high 1024² ≈ $0.21 / bild
- gpt-image-2 high 1536×1024 ≈ $0.165 / bild
- gpt-image-2 medium 1024² ≈ $0.05 / bild

---

## Workflow-regler

- **Plan-mode för 3+ steg eller arkitektur-beslut.** Skriv plan i `tasks/<datum>-<topic>-plan.md` innan kodändringar.
- **Subagents för parallell research/audit.** Spawna sonnet-agents för slide-inventering, asset-audit etc.
- **Implementer-subagents ska INTE invokera review-skills självmant** (t.ex. `multi-auditor-review`) — det är controllerns ansvar och skapar dubblerad output.
- **Visuell verifiering** sker via `tasks/light-mode-rendered/*.png` + Gemini visual review (`multi-ai-consultant:consult-gemini`). PDF-rendering via `npm run export` är slut-test.
- **Multi-auditor-review** (Claude opus × 2) är final gate innan merge. Eskalera till Gemini/Codex bara vid security/payments/schema/produktion eller >300 LoC + >10 filer.
- **Inga TDD-tests** — projektet är visuellt, inte logik-driven. Verifiering sker visuellt + via build smoke-test (`npm run build`).
- **Inga skapade hooks/automatik utan explicit user-godkännande.**

---

## Verifierings-pipeline (ny visuell ändring)

1. `npm run build` — smoke-test, fångar syntax-fel
2. `npm run dev` — lokal manuell visuell genomgång
3. `npm run export -- --format png --output ../tasks/light-mode-rendered/` — 52 PNG:er
4. `npm run export -- --output ../tasks/light-mode-rendered/slides-light.pdf` — PDF (kör EFTER PNG eftersom PNG-export overskriver)
5. Spot-check Read tool på 5-10 PNG:er (ändrade slides + 1, 8, 21, 24, 25, 33, 41, 52)
6. **Vid AI-bild-regen specifikt**: pedagogisk visuell review per ändrad slide — inte bara render-spot-check. `multi-auditor-review` (kod-strukturell) **fångar inte** pedagogiska/visuella regressioner. Kör `multi-ai-consultant:consult-gemini` för multimodal review om en bild är kritisk.
7. Vid substantive change: `multi-auditor-review` skill → fixes → re-render → ny review
8. **Om ändringen påverkar `docs/`-siten** (slides.md, kompendium-PDF:er, eller bilder som visas där): följ `docs/REFRESH.md`-stegen. Live-deploy verifieras via `gh api repos/speakman/arduino-kurs/pages` (`status: built`) och spot-check på `https://speakman.github.io/arduino-kurs/`.

---

## Gemini CLI — quirks att veta

Lokalt installerat `gemini` CLI (Homebrew):

- **Modellnamn:** `gemini-3.1-pro-preview` eller alias `pro`. INTE `gemini-3-pro` (404).
- **Endast giltiga flaggor:** `-m <model>`, `-p <prompt>`, `-y` (yolo), `-o text|json|stream-json`.
- **INTE giltiga:** `--thinking`, `--google-search`, `--grounding` (skill-templates har fel "locked config" — använd raw flags).
- **Multimodal-batch (52 PNG-bilder):** Gemini 3.1 Pro har 1M+ context och är multimodal-byggd → rätt val. Codex GPT-5.2 har sämre multimodal-stöd för stor bild-volym.

---

## Out-of-scope för Slidev-arbete

- `kompendium/`-pipeline (Typst, separat make-flow). Behöver re-genereras post-merge om slides ändras radikalt.
- `kompendium/deliveries/slides-per-dag/` — per-dag-PDF:er. Re-generera vid behov, separat operation.
- 6 orphaned bilder i `presentation/public/images/` — separate städ-task om någonsin.
- `presentation/README.md` — uppdatera om relevant; har historiska referenser till "mörkt tema".

---

## Snabb-orientering vid varje session

```bash
git log --oneline -5             # senaste arbetsläge
ls tasks/                        # pågående/historiska planer och reviews
cat tasks/2026-05-05-light-mode-design.md   # aktuell designspec (light-mode)
cat presentation/styles/main.css | head -50 # token-arkitektur
```
