# GitHub Pages — Course Participant Site

> **Plan-mode:** Approved-on-execute. Implementeras task-by-task efter user-approval på plan-dokumentet.

**Goal:** Bygg en publik GitHub Pages-site där alla kursdeltagare hittar ALLT de behöver — slides (live + PDF), kompendium-PDF:er per modul, kodexempel och en kuraterad resurssida för nästa steg.

**Arkitektur:** Statisk HTML/CSS i `docs/`-mappen i samma repo. Slidev byggs lokalt till `docs/slides/` med korrekt base-path. GitHub Pages deployar `/docs` från `main` (ingen Actions-pipeline). Designsystem återanvänder samma tokens som presentationen (`--ak-*`) för visuell konsistens.

**Tech Stack:** Vanilla HTML5 + CSS (modern: `:has()`, `color-mix()`, CSS-vars), inga JS-frameworks. Slidev v52 för embedded deck. Inga byggsteg för själva siten — bara file → push → Pages.

**URL:** `https://speakman.github.io/arduino-kurs/`

---

## Site-struktur

```
docs/
├── index.html                Landing — kursintro, 5 dag-kort, kom-igång
├── dag/
│   ├── 1.html                Träff 1 — LED & krets
│   ├── 2.html                Träff 2 — PWM & RGB
│   ├── 3.html                Träff 3 — Digital input
│   ├── 4.html                Träff 4 — Analog input
│   └── 5.html                Träff 5 — Hackathon
├── nedladdningar.html        Central downloads-hub (alla PDF:er listade)
├── resurser.html             Curated länkar + extra tips
├── slides/                   Slidev-build (committad output)
│   ├── index.html
│   └── assets/
├── assets/
│   ├── css/site.css          Global stylesheet
│   ├── img/                  Hero-foton, dag-thumbnails
│   ├── pdf/                  Alla PDF:er (symlinkade el. kopierade från kompendium/deliveries/)
│   └── code/                 Kodexempel som .ino-filer
├── 404.html                  Vänlig fallback
└── CNAME                     (om custom domain — TBD med användaren senare)
```

---

## File-organisation och ansvar

| Fil | Ansvar |
|-----|--------|
| `docs/index.html` | Landing — hero, fem dag-kort, "Vad du har lärt dig", license-footer |
| `docs/dag/N.html` | Per-dag-sida — slides-länk, kompendium-PDF, kodexempel, bilder, sammanfattning |
| `docs/nedladdningar.html` | Allt nedladdningsbart, grupperat per typ (hela kompendiet / per modul / per dag / slides) |
| `docs/resurser.html` | Nästa steg — kuraterade externa länkar i kategorier (verifierade 2026) |
| `docs/assets/css/site.css` | Global design-system — återanvänd `--ak-*`-tokens, layout, components |
| `docs/slides/` | Slidev-build output, committad direkt (ingen CI) |
| `docs/assets/code/*.ino` | Extraherade sketches från `slides.md` — Blink, Fade, RGB, Button, Photocell, etc. |
| `presentation/package.json` | Add `build:pages` script — `slidev build --base /arduino-kurs/slides/ --out ../docs/slides` |

---

## Designsystem — återanvänd från presentationen

CSS-tokens (kopiera till `docs/assets/css/site.css`):

```css
:root {
  --ak-bg: #fafaf7;
  --ak-fg: #0a0e14;
  --ak-fg-muted: #4a4a4a;
  --ak-accent: #00747d;
  --ak-accent-bright: #0098a3;
  --ak-warn: #b15800;
  --ak-success: #2e7d32;
  --ak-card: #ffffff;
  --ak-border: #e3e0d8;
  --ak-shadow: 0 1px 3px rgba(0,0,0,0.04), 0 4px 16px rgba(0,0,0,0.06);
  --ak-radius: 12px;
}
```

Typografi: Inter (system fallback), JetBrains Mono för kod. Container max-width 1100px. WCAG AA-mål för all text.

---

## Task 1: Site-skeleton — landing, CSS-design-system, footer

**Files:**
- Create: `docs/index.html`
- Create: `docs/assets/css/site.css`
- Create: `docs/assets/img/.gitkeep`

- [ ] **Step 1: Skapa `docs/assets/css/site.css`** med tokens, reset, typografi, layout-grid, card-komponent, button, hero, footer-stilar.
- [ ] **Step 2: Skapa `docs/index.html`** med struktur:
  - Hero (titel, undertitel, "kom igång"-knapp → `dag/1.html`)
  - "Om kursen" — 2-3 paragrafer
  - 5 dag-kort i grid (titel, undertitel, kort summary, länk)
  - "Vad du nu kan" — 4-5 bullets över hela kursen
  - Footer: license CC BY-SA, repo-länk, FRO Ånge-credit
- [ ] **Step 3: Verifiera lokalt:** `cd docs && python3 -m http.server 8000` → öppna `http://localhost:8000/`
- [ ] **Step 4: Kontrollera WCAG AA-kontrast** (manuellt mot tokens — alla redan testade i presentationen)
- [ ] **Step 5: Commit:**
  ```bash
  git add docs/index.html docs/assets/css/site.css docs/assets/img/.gitkeep
  git commit -m "feat(pages): site skeleton + landing page med design-system"
  ```

---

## Task 2: Per-dag template — Träff 1

**Files:**
- Create: `docs/dag/1.html`

Template-struktur per dag:
1. Hero (dag-nummer + titel + 1-rad sammanfattning)
2. "Vad du lärde dig" — 4-5 bullets
3. Slides — länk till `/slides/#/<start-slide>` (live HTML) + PDF-knapp
4. Kompendium — länk till modul-N.pdf + "varför läsa denna"
5. Kodexempel — 1-3 sketches i Shiki-highlightade `<pre>`-block med "kopiera"-knapp och download `.ino`
6. Bilder/diagram — fritzing-thumbnails inbäddade direkt
7. Nästa: länk till `dag/2.html`

- [ ] **Step 1: Bygg `docs/dag/1.html`** med ovan struktur. Hardkoda kod-snippets från slides.md:
  - Blink (slides.md:794)
  - Blink m. `digitalWrite(LOW)` & `delay` (slides.md:843)
  - Variabel-version (slides.md:851, 859)
- [ ] **Step 2: Extrahera kod till `docs/assets/code/blink.ino`, `blink-variabel.ino`** för download.
- [ ] **Step 3: Kopiera relevanta bilder** till `docs/assets/img/dag-1/` (LED-Fritzing, breadboard-internals, ohms-law, ohms-triangle, resistor-220ohm).
- [ ] **Step 4: Kör server, öppna `http://localhost:8000/dag/1.html`** — verifiera layout, syntax-highlighting, alla länkar.
- [ ] **Step 5: Commit:** `feat(pages): dag 1 — LED & krets`

---

## Task 3: Dag 2 — PWM & RGB

**Files:**
- Create: `docs/dag/2.html`
- Create: `docs/assets/code/pwm-fade.ino`, `rgb-cycle.ino`
- Create: `docs/assets/img/dag-2/` (rgb-color-mixing, pwm-waveform, rgb-fritzing)

- [ ] **Step 1:** Klona template från `dag/1.html`, ersätt content.
- [ ] **Step 2:** Extrahera sketches från slides.md (PWM-fade ~rad 1242, RGB-cycle ~rad 1476).
- [ ] **Step 3:** Kopiera bilder från `presentation/public/images/`.
- [ ] **Step 4:** Verifiera browser.
- [ ] **Step 5:** Commit: `feat(pages): dag 2 — PWM & RGB`

---

## Task 4: Dag 3 — Digital input (knapp, buzzer)

**Files:**
- Create: `docs/dag/3.html`
- Create: `docs/assets/code/button.ino`, `button-buzzer.ino`
- Create: `docs/assets/img/dag-3/` (button-fritzing, buzzer-fritzing, active-buzzer-sticker)

- [ ] **Step 1:** Klona template, ersätt content (knapp + INPUT_PULLUP + buzzer-logik).
- [ ] **Step 2:** Extrahera sketches (slides.md ~1535, ~1697).
- [ ] **Step 3:** Bilder.
- [ ] **Step 4:** Verifiera.
- [ ] **Step 5:** Commit: `feat(pages): dag 3 — digital input`

---

## Task 5: Dag 4 — Analog input (fotocell, tilt, Serial)

**Files:**
- Create: `docs/dag/4.html`
- Create: `docs/assets/code/photocell-read.ino`, `photocell-led.ino`, `tilt-detect.ino`
- Create: `docs/assets/img/dag-4/` (photoresistors-three, voltage-divider, photocell-schematic, tilt-photo, long-resistor, serial-plotter)

- [ ] **Step 1:** Klona template, ersätt.
- [ ] **Step 2:** Extrahera sketches (slides.md ~1949, ~2126).
- [ ] **Step 3:** Bilder.
- [ ] **Step 4:** Verifiera.
- [ ] **Step 5:** Commit: `feat(pages): dag 4 — analog input`

---

## Task 6: Dag 5 — Hackathon (larm-integration)

**Files:**
- Create: `docs/dag/5.html`
- Create: `docs/assets/code/larm-skelett.ino`, `larm-komplett.ino`

- [ ] **Step 1:** Klona template, ersätt — fokus på integration/sense-act-loop.
- [ ] **Step 2:** Extrahera skelett (slides.md ~2430) och komplett lösning (~2624 + appendix-d-hackathon-losning).
- [ ] **Step 3:** Länka tydligt till `bilaga-d-hackathon-losning.pdf` (efter-kursen-bundle).
- [ ] **Step 4:** Verifiera.
- [ ] **Step 5:** Commit: `feat(pages): dag 5 — hackathon`

---

## Task 7: Nedladdnings-hub

**Files:**
- Create: `docs/nedladdningar.html`
- Create: `docs/assets/pdf/` (symlink eller kopia av `kompendium/deliveries/*.pdf` + `slides-per-dag/*.pdf` + `distribution/**`)

Sektioner på sidan:
1. **Hela kursen** — `slides-arduino-kurs.pdf` (54 sidor), `kompendium.pdf` (alla moduler ihop)
2. **Per kursdag** — fem rader: dag N slides + dag N kompendium-modul + dag N "innan kursen"-bundle
3. **Bilagor** — A-F separat (syntax, felmeddelanden, komponenter, hackathon-lösning, säkerhet, framspänningsfall)
4. **Allt i ett ZIP** — `arduino-kurs-allt.zip` (genereras vid release)

- [ ] **Step 1: Kopiera PDF:er** till `docs/assets/pdf/` med tydlig namnstruktur:
  ```
  docs/assets/pdf/
  ├── slides-arduino-kurs.pdf
  ├── kompendium.pdf
  ├── modul-1-led-krets.pdf
  ├── ... (modul-2..5)
  ├── bilaga-a-syntax.pdf (etc.)
  ├── slides-dag-1.pdf
  ├── ... (slides-dag-2..5)
  ```
- [ ] **Step 2: Skapa `docs/nedladdningar.html`** med tabeller per sektion. Visa filstorlek och sidantal för varje PDF.
- [ ] **Step 3: Generera `arduino-kurs-allt.zip`** med alla PDF:er ihopknyttade — `cd docs/assets/pdf && zip ../arduino-kurs-allt.zip *.pdf`.
- [ ] **Step 4: Verifiera browser** — klicka varje länk, kontrollera att PDF öppnas.
- [ ] **Step 5: Commit:** `feat(pages): nedladdnings-hub med alla PDF:er`

---

## Task 8: Resurser & nästa steg

**Files:**
- Create: `docs/resurser.html`

**Källa:** research-subagent (kör i bakgrunden vid plan-skrivning) producerar Markdown med verifierade, moderna 2026-länkar i kategorier:
1. Officiella Arduino-resurser
2. YouTube-kanaler
3. Communities
4. Projekt-inspiration
5. Reference/docs
6. C++ för Arduino-utvecklare
7. Nästa hardware (ESP32, RPi Pico, sensorer)
8. Verktyg utöver Arduino IDE (PlatformIO, Wokwi, TinkerCAD)
9. Bibliotek att utforska
10. Svenskspecifikt (Electrokit, Lawicel, makerspace-nätverk, FRO/MSB-kopplingar)

- [ ] **Step 1: Vänta in research-output** (subagent levererar färdig Markdown).
- [ ] **Step 2: Manuellt curation-pass** — välj 2-4 länkar per kategori, dumpa medelmåttiga.
- [ ] **Step 3: Bygg `docs/resurser.html`** med kategorier som `<section>`-grupper, varje länk som `<article>` med titel + beskrivning + "varför just denna"-rad.
- [ ] **Step 4: Lägg till "Topp 3 viktigaste"-sektion överst** (research-subagent tar fram detta).
- [ ] **Step 5: Verifiera alla länkar i webbläsare** (klick varje en).
- [ ] **Step 6: Commit:** `feat(pages): resurser & nästa steg — kuraterade 2026-länkar`

---

## Task 9: Bygg Slidev till `docs/slides/`

**Files:**
- Modify: `presentation/package.json` (add `build:pages` script)
- Create: `docs/slides/` (build output, committad)

- [ ] **Step 1: Lägg till script** i `presentation/package.json`:
  ```json
  "build:pages": "slidev build --base /arduino-kurs/slides/ --out ../docs/slides"
  ```
- [ ] **Step 2: Kör `npm run build:pages`** från `presentation/`.
- [ ] **Step 3: Verifiera output** finns i `docs/slides/index.html` + `assets/`.
- [ ] **Step 4: Testa lokalt:** servera `docs/` på `localhost:8000`, navigera till `/slides/` — verifiera att alla bilder och fonts laddas.
- [ ] **Step 5: Verifiera basepath-rewriting** — alla `<img src="/images/...">` i decket ska bli `/arduino-kurs/slides/images/...`.
- [ ] **Step 6: Commit:** `feat(pages): bygg Slidev-deck till /docs/slides/ för Pages-deploy`

---

## Task 10: GitHub Pages enable + smoke-test live

**Files:**
- Settings-ändring (UI eller `gh api`): Pages → source = main branch, folder = /docs

- [ ] **Step 1: Pusha till origin/main** — `git push`.
- [ ] **Step 2: Enable Pages via `gh`:**
  ```bash
  gh api repos/speakman/arduino-kurs/pages --method POST -f source[branch]=main -f source[path]=/docs
  ```
- [ ] **Step 3: Vänta 1-2 min** på första deploy. Verifiera via `gh api repos/speakman/arduino-kurs/pages` att `status: built`.
- [ ] **Step 4: Smoke-test live URL** (`https://speakman.github.io/arduino-kurs/`):
  - Landing renderar
  - Klicka varje dag-kort → öppnar dag/N.html
  - Klicka slides-länk → /slides/ laddar fullt deck
  - Klicka en PDF → laddar ned
- [ ] **Step 5: Verifiera mobile responsive** (DevTools → iPhone-emulering).
- [ ] **Step 6: Lighthouse-audit** — accessibility ≥ 95, performance ≥ 90.

---

## Task 11: Polish — SEO, social-cards, 404, README-länk

**Files:**
- Modify: alla `docs/*.html` (meta-taggar)
- Create: `docs/404.html`
- Create: `docs/assets/img/og-card.png` (social preview)
- Modify: `README.md` (lägg till "Live site" badge/sektion)

- [ ] **Step 1: Lägg till `<head>`-meta** i alla HTML-filer: title, description, og:title/description/image, twitter:card.
- [ ] **Step 2: Skapa `docs/404.html`** — vänlig fallback med länk tillbaka till landing.
- [ ] **Step 3: Generera och kopiera `og-card.png`** (1200×630, cover-foto + titel) — använd `cover-arduino-hero.png` croppad.
- [ ] **Step 4: Modify `README.md`** — lägg till sektion "Live kurssite: https://speakman.github.io/arduino-kurs/" överst.
- [ ] **Step 5: Final commit:** `feat(pages): SEO, social-cards, 404, README-länk`
- [ ] **Step 6: Push + smoke-test:** verifiera live att SEO-meta renderar via `view-source:` och 404 funkar.

---

## Verifikation före "klar"

1. `cd docs && python3 -m http.server 8000` — alla sidor öppnas felfritt
2. Slidev-decket fungerar fullt på `/slides/` (navigation, presenter view, alla bilder)
3. Alla PDF-länkar i nedladdningar.html laddar korrekta filer
4. Alla externa länkar i resurser.html svarar (200 OK)
5. Lighthouse: accessibility ≥ 95, performance ≥ 90
6. Mobile responsive (375px width)
7. WCAG AA-kontrast i hela siten (samma tokens som presentationen som redan är AA-verifierad)
8. Live URL `https://speakman.github.io/arduino-kurs/` — alla ovan upprepade på Pages
9. `multi-auditor-review` skill efter sista commit före announce

---

## Risker / öppna frågor

- **Custom domän:** Inget custom-domain i scope nu. Pages-default-URL räcker. Om användaren senare vill ha eget — separat task med CNAME.
- **Search:** Ingen Algolia/Pagefind nu (YAGNI). Om resurssidan växer kan vi lägga till.
- **Comments/feedback:** Inget formulär — användaren bad om "issues" i README. Räcker.
- **Slidev-base-path-konflikt:** Om Slidev v52 hanterar `--base` ofullständigt kan vi behöva manuell rewrite av `<base href>` i `docs/slides/index.html`. Verifieras i Task 9 step 4.
- **PDF-dubblering:** 9 PDF:er i `kompendium/deliveries/` + samma 9 i `docs/assets/pdf/`. Lösning: kopiera (≈10 MB total — försumbar). Inte symlink (Pages dereffer dåligt).
