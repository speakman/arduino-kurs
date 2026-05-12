# Image cleanup → review webpage → slutrendering — Plan

## Mål
1. Rensa alla bilder som inte används (i `presentation/` OCH `kompendium/`).
2. Lista alla bilder som FAKTISKT används på en review-webbsida med kontext, så att samtliga kan gås igenom.
3. Rendera ALLT material en sista gång (presentation: PNG-batch + PDF; kompendium: alla PDF:er).

---

## 1. Inventarium (verifierat)

### `presentation/public/images/` (28 filer)

**Används (19):**
- `active-buzzer-sticker.png` (slide 33)
- `arduino-uno-hero.png` (slide 6)
- `breadboard-internals.png` (slide 11)
- `cover-arduino-hero.png` (slide 1 — cover-bg via main.css)
- `long-resistor.png` (slide 41)
- `ohms-law.png` (slide 8)
- `ohms-triangle.png` (slide 8)
- `photoresistors-three.png` (slide 39)
- `pwm-waveform.png` (slide 24)
- `resistor-220ohm.png` (slide 10)
- `rgb-color-mixing.png` (slide 21)
- `serial-plotter.png` (slide 46)
- `voltage-divider.png` (slide 42)
- `wiring/button-fritzing.png` (slide 31)
- `wiring/buzzer-fritzing.png` (slide 34)
- `wiring/led-fritzing.png` (slide 14)
- `wiring/photocell-schematic.png` (slide 43)
- `wiring/rgb-fritzing.png` (slide 22)
- `wiring/tilt-photo.png` (slide 44)

**Orphans, DELETE (9):**
- `breadboard-rails.png`
- `photoresistor-macro.jpg`
- `resistor-color-chart.png`
- `tilt-switch.jpg`
- `wiring/button-photo.png`
- `wiring/buzzer-photo.png`
- `wiring/photocell-wiring.png`
- `wiring/rgb-photo.png`
- `wiring/tilt-schematic.png`

### `kompendium/images/` (31 filer)

**Används (19):**
- `button-fritzing.png`, `buzzer-fritzing.png`
- ELEGOO PDF-utdrag: `elegoo-037-054`, `-038-055`, `-039-056`, `-040-057`, `-041-058`, `-043-060`, `-045-061`, `-047-063`, `-048-064`, `-052-069`, `-053-070`, `-058-074`, `-062-079`, `-065-083`, `-079-093`, `-080-095`, `-083-098`

**Orphans, DELETE (12):**
- `elegoo-042-059.png`, `-046-062.png`, `-049-065.png`, `-050-066.png`, `-054-071.png`, `-055-072.png`, `-057-073.png`, `-059-076.png`, `-060-077.png`, `-061-078.png`, `-063-081.png`, `-082-097.png`

**Totalt:** 21 filer att delete:a, 38 bilder att lista på review-sidan.

---

## 2. Steg

### Steg A: Rensa
```bash
git rm presentation/public/images/breadboard-rails.png \
       presentation/public/images/photoresistor-macro.jpg \
       presentation/public/images/resistor-color-chart.png \
       presentation/public/images/tilt-switch.jpg \
       presentation/public/images/wiring/button-photo.png \
       presentation/public/images/wiring/buzzer-photo.png \
       presentation/public/images/wiring/photocell-wiring.png \
       presentation/public/images/wiring/rgb-photo.png \
       presentation/public/images/wiring/tilt-schematic.png
git rm kompendium/images/elegoo-{042-059,046-062,049-065,050-066,054-071,055-072,057-073,059-076,060-077,061-078,063-081,082-097}.png
```

Commit: `chore(images): rensa 21 orphan-bilder från presentation + kompendium`.

### Steg B: Bygg review-webbsida
`tasks/image-review/index.html` — en lång scrollbar sida med två sektioner:

**Sektion 1: Presentation (19 bilder)**
Varje rad:
- Thumbnail
- Filnamn
- Slide-nummer + slide-titel
- Kort kontext (vad illustreras)
- Comment-textarea (för anteckningar)

**Sektion 2: Kompendium (19 bilder)**
Varje rad:
- Thumbnail
- Filnamn + (om elegoo) "ELEGOO-extrakt"
- Modul/bilaga-referens (vilken .typ-fil refererar)
- Kort kontext
- Comment-textarea

localStorage-persistens (`image-review-comments-v1`), JSON-export-knapp.
Hämtar listan från `image-review-data.json` (genererad av script).

### Steg C: Rendera ALLT
1. `cd presentation && npm run export -- --format png --output ../tasks/light-mode-rendered/`
2. `cd presentation && npm run export -- --output ../tasks/light-mode-rendered/slides-light.pdf` (efter PNG pga overskrivning)
3. `cd kompendium && ./build.sh` — bygger alla 9 PDF:er

### Steg D: Commit
- `chore(deliveries): refresh PNG + PDF + kompendium efter cleanup`

---

## 3. Tveksamheter / antaganden

1. **Orphan-filer**: Jag deleta:r dem direkt (de finns kvar i git-historik om de behövs). Alternativet är att flytta till `tasks/orphan-images/`.
2. **kompendium/review-pages/** är auto-genererade render-snapshots av Typst-output, inte källbilder — rör inte dessa.
3. **Hela kompendium-build via `./build.sh`** kompilerar 9 PDF:er. Tar några sekunder, säkert.
4. Review-sidan serveras lokalt via `python3 -m http.server` från `tasks/image-review/`. Comments JSON exportas till Downloads.

---

## 4. Verifierings-pipeline (efter cleanup)
1. `npm run build` — slidev build smoke-test (fångar broken refs)
2. `cd kompendium && ./build.sh` — Typst kompilerar utan missing-file-fel
3. Spot-render slide 1, 8, 33, 39, 42 — bekräfta att inget gick sönder
