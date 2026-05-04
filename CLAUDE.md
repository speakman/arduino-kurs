# Arduino-kurs — projekt-specifika instruktioner

5-träffars Arduino-nybörjarkurs (FRO Ånge). Två huvuddelar:

- `presentation/` — Slidev-deck (52 slides, theme: default, custom CSS-tokens)
- `kompendium/` — Typst-baserade kurshandouts + dag-uppdelade leveranser
- `tasks/` — designspecs, audits, reviews, plans (output discipline per global CLAUDE.md)

## Slidev — Build-kommandon

```bash
cd presentation/
npm run dev          # dev-server, port 3030, hot reload
npm run dev:remote   # som dev men exponerar på LAN
npm run build        # statisk build → dist/
npm run export       # PDF via headless Chromium (CLI-exporter)
npm run export -- --format png --output ../tasks/light-mode-rendered/   # PNG-batch
npm run export-notes # exportera presenter notes
```

**Slidev v52+ stödjer `--format png` nativt** — ingen Playwright-fallback behövs.

## Browser-exporter (alternativ till CLI)

`http://localhost:3030/export` ger en interaktiv exportvy som renderar via webbläsarens egna print-pipeline istället för headless Chromium. Skillnaden är konkret:

- **CLI (`npm run export`)** → Slidev lägger `html.print` på `<html>`. Vår CSS-regel `html.print .slidev-layout.cover { background-image: none !important }` släcker hero-fotot på cover-sliden för att skydda mot Chromium PDF-rasteriserings-buggar (banding på `linear-gradient` + `url()`-kombinationer). Resultat: cover är bare titel-text på off-white. Reproducerbar, CI-friendly.
- **Browser-exporter** → renderar live i webbläsaren, hero-bilden visas i preview, men användaren måste KLICKA "Start" → **native print-dialog** öppnas → spara som PDF (med "Print backgrounds" påslagen för att få bg-bilder med).

**Browser-exporter är en human-in-the-loop-workflow.** Native print-dialog kan inte automatiseras via Claude Code/MCP. Använd när du manuellt vill ha en "premium" cover-version med hero-bild för viktiga distribution. För routine-export och CI: använd CLI.

## CSS-arkitektur

Single-theme **light-only** (skrotad dark-mode 2026-05-05). Token-driven via `:root` i `presentation/styles/main.css`:

```
--ak-bg / --ak-bg-raised / --ak-border       (grå-skala)
--ak-text / --ak-text-dim / --ak-text-mute   (text-färg)
--ak-accent / --ak-accent-soft               (#00747d Arduino-teal, AA-justerad)
--ak-warn / --ak-danger                      (semantisk)
--ak-glow-cyan / --ak-glow-red               (subtila box-shadows)
--ak-code-shadow / --ak-cover-fg / --ak-cover-shadow  (komponenter)
```

`colorSchema: 'light'` i `slides.md`-frontmatter låser läget. Toggle-knappen i nav-controls är gömd.

### Pedagogiskt skyddade konstanter (RÖR EJ)

- Resistor-band-färger (slide 10): `#d4a574`, `#ff2222`, `#8b4513`, `#d4af37`
- RGB-cirkel-färger (slides 19, 26): `#ff1744`, `#00e676`, `#2979ff`
- RGB-färgexempel (slide 25): `#b400dc`, `#ff8cb4`, `#ffd400`, `#00e0ff`
- Sun-symbol i `voltage-divider.svg`: `#ffd400`

### Custom CSS-klasser

| Klass | Syfte |
|-------|-------|
| `.color-chip` | Slide 25 — färg-namn med bg=färgvärde + kontrast-anpassad text-färg via `--bg`/`--fg` inline-vars |
| `.rgb-demo` | Slide 21 — svart frame runt RGB-blandnings-bilden |
| `.diagram-img` | Slide 24 — generic ram för diagram-bilder |
| `.breadboard-diagram` | Slide 11 — vit-bg ram för breadboard-internals |
| `.sp-grid` / `.sp` | Section 7 — modul-kort på kursöversikt |
| `.warn-box` / `.tip-box` | Pedagogiska varnings/tips-rutor |
| `.hex-chip` | Inline kod-token |
| `.rgb-circle` (.rgb-red/.rgb-green/.rgb-blue/.rgb-white) | RGB-LED visualisering |

## Slidev / Shiki

- Custom Shiki-transformer i `presentation/setup/shiki.ts` — färg-överstyr Arduino-funktioner (pinMode, digitalWrite, analogRead, etc.) eftersom cpp-grammatiken inkonsistent classar dem som plain text. Behåller både `--shiki-light` och `--shiki-dark` för framtida flexibilitet.
- Custom font: Inter sans, JetBrains Mono code (Google Fonts).
- canvasWidth: 1920. UnoCSS font-size-skalan ombasad i `uno.config.ts`.

## Custom Vue-komponenter

- `presentation/components/WiringSlide.vue` — använd för Fritzing wiring-slides (slides 14, 22, 31, 34, 42, 43)

## Verifierings-pipeline

För visuella ändringar i presentationen:

1. `npm run build` — smoke-test (fångar syntax-fel)
2. `npm run dev` + manuellt bläddra
3. `npm run export` → 6.6 MB PDF, 52 sidor (light)
4. `npm run export -- --format png` → 52 PNG:er i out-mappen
5. **Visuell review via Gemini 3.1 Pro Preview**:
   ```bash
   gemini -m gemini-3.1-pro-preview -y < /tmp/review-prompt.txt
   ```
   `multi-ai-consultant:consult-gemini` kör korrekt modell. Skickar in `@tasks/light-mode-rendered/` + `@presentation/` för analys.

## Gemini CLI-quirks (lokalt installerat)

- Modellnamn är `gemini-3.1-pro-preview` eller alias `pro`. INTE `gemini-3-pro` (404).
- Endast giltiga flaggor: `-m <model>`, `-p <prompt>`, `-y` (yolo/auto-approve), `-o text|json|stream-json`.
- INTE giltiga: `--thinking`, `--google-search`, `--grounding` (skillens "locked config" är fel — använd raw flags).
- För 1M+ context (multimodal review av många bilder) → Gemini 3.1 Pro är rätt. Codex GPT-5.2 har sämre multimodal-stöd.

## Workflow-regler

- **CSS-only-ändringar** → atomic commit per logiskt block. Implementer-subagent + spec-review.
- **Slide-content-ändringar** → atomic commit per slide. Plan-driven.
- **Dispatched implementers ska INTE invokera `multi-auditor-review` självmant** — det är controllerns ansvar.
- **Pedagogiska konstanter** kräver explicit motivering för ändring.
- **Dark-mode är skrotad** men `--shiki-dark` i `setup/shiki.ts` lämnas kvar (kostar inget, ger framtida flexibilitet).

## Deliverables och distribution

- `presentation/dist/` — statisk build (web-deploy)
- `kompendium/deliveries/distribution/` — kurshandouts + dagar
- `tasks/light-mode-rendered/` — referens-renderingar (PNG + PDF) för review

`kompendium/`-pipelinen är separat ekosystem (Typst). Ändringar i `presentation/` påverkar inte `kompendium/` direkt.
