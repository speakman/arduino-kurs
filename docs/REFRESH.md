# docs/ — refresh-kontrakt

Den här mappen innehåller den publika **GitHub Pages-siten** för kursdeltagare:
`https://speakman.github.io/arduino-kurs/`

GitHub Pages deployar `/docs` från `main`-branchen direkt — det finns alltså **ingen CI**.
Det betyder att artifakterna här måste hållas i sync **manuellt** när källmaterialet ändras.

---

## När triggas en refresh?

| Ändrar du... | ...så behöver `docs/` regenereras |
|---|---|
| `presentation/slides.md` | Ja — Slidev-decket på `/slides/` blir stale |
| `presentation/public/images/*` | Ja — bilderna på dag-sidorna blir stale (om relevanta) |
| `kompendium/*.typ` | Ja — PDF:er måste byggas om OCH kopieras hit |
| `presentation/styles/main.css`-tokens | Sannolikt — `docs/assets/css/site.css` speglar dem (se kommentar i CSS-huvudet) |
| Kod i `presentation/slides.md`-fences | Ja — `docs/assets/code/*.ino` är manuellt extraherade ur slides |

---

## Refresh-stegen (manuellt, en åt gången)

### 1. Slidev-decket på `/slides/`

```bash
cd presentation
npm run build:pages   # → ../docs/slides/ (basepath /arduino-kurs/slides/)
```

### 2. Kompendium-PDF:er

```bash
cd kompendium
bash build.sh                                    # bygger 9 PDF:er i deliveries/
cp deliveries/*.pdf ../docs/assets/pdf/          # kopiera till docs
cp deliveries/slides-per-dag/*.pdf ../docs/assets/pdf/
```

### 3. Bilder (om presentation/public/images/ ändrats)

Bilder konverteras till WebP för pages. Originalet ligger i `presentation/public/images/`,
WebP-versionen i `docs/assets/img/`. PNG-original ligger INTE i docs (de tar bara plats).

```bash
# Exempel — om foo.png är uppdaterad:
magick presentation/public/images/foo.png -quality 88 docs/assets/img/foo.webp
```

### 4. Kodexempel (om sketches i slides.md ändrats)

Manuell extraktion: öppna `presentation/slides.md`, kopiera relevanta `` ```cpp ``-fences
till motsvarande fil i `docs/assets/code/`. Inga delete/rename — uppdatera bara innehåll.

---

## Verifiering efter refresh

```bash
cd docs && python3 -m http.server 8000   # lokal preview på localhost:8000
# Kontrollera live-sajten efter push:
gh api repos/speakman/arduino-kurs/pages   # status: "built"
```

Lighthouse-mål: A11y ≥ 95, Best-Practices ≥ 95, SEO 100, Performance ≥ 85.

---

## Anti-mönster — gör INTE

- **Kommittea `docs/slides/` separately** från `slides.md` — de måste alltid uppdateras tillsammans.
- **Symlinka** PDF:er från `kompendium/deliveries/` — GitHub Pages dereffer inte symlinks.
- **Hand-edita** `docs/slides/` — det är auto-generated build-output. Ändra `slides.md` istället.
