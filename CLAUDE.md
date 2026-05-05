# Arduino-kurs — CLAUDE.md

5-träffars Arduino-nybörjarkurs (FRO Ånge, ELEGOO UNO Basic Starter Kit). Detta repo har **två oberoende delsystem** som inte ska blandas ihop:

- `presentation/` — Slidev-deck (52 slides, light-only-tema, projektor-prio)
- `kompendium/` — Typst-baserade kurshandouts (separat ekosystem, separat pipeline)
- `tasks/` — designspecs, audits, reviews, plan-dokument, renderade artifakter
- `research/` — referensmaterial (ELEGOO PDF-bilder etc.)

Slides är **det primära mediet** (klassrumsprojektor). Kompendium ges till studenten efter passet.

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
| `#d4a574` `#ff2222` `#8b4513` `#d4af37` | slide 10 (resistor-band) | Fysiska komponentfärger studenten ska identifiera |
| `#ff1744` `#00e676` `#2979ff` | slides 19, 26 (RGB-LED-cirklar) | Faktiska LED-färger |
| `#b400dc` `#ff8cb4` `#ffd400` `#00e0ff` | slide 25 (RGB-färgexempel) | Övningens målfärger |
| `#ffd400` (sun) | `voltage-divider.svg` | Sol-symbol — pedagogisk metafor |
| `#000` (`.rgb-demo` bg) | `main.css:281` | "Mörkrum"-metafor för RGB-LED-demo |

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
| `.rgb-demo` | 21 | Svart frame runt RGB-blandnings-bild ("mörkrum/skärmdemo") |
| `.diagram-img` | 24 | Generic diagram-ram med token-border |
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
6. Vid substantive change: `multi-auditor-review` skill → fixes → re-render → ny review

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
