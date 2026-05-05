# Asset Audit: Light Mode — Arduino-kurs Presentation

**Skapad:** 2026-05-05
**Syfte:** Audit av bilder, custom Vue-komponenter och hardkodade färger inför införandet av light-mode.

---

## 1. Bilder

### Top-level `/public/images/` (14 filer)

| Fil | Dim (px) | Format | Alpha | Bakgrund | Status |
|-----|----------|--------|-------|----------|--------|
| `active-buzzer-sticker.jpg` | 700×660 | JPEG | Nej | Foto, vit/ljus bakgrund (sticker-stil) | **GUL** — Fungerar troligen på båda; ring kan behöva justeras |
| `arduino-uno-hero.jpg` | 4000×2400 | JPEG | Nej | Foto av Arduino-kort, image-left-bakgrund | **GUL** — Fungerar på båda men dark overlay i CSS måste justeras |
| `cover-arduino-hero.jpg` | 2400×1351 | JPEG | Nej | Cover-foto — mörk gradient i main.css ovanpå | **RÖD** — `.slidev-layout.cover` hardkodad rgba(10,14,20,...) gradient + `color:#ffffff` h1 |
| `ohms-law-cartoon.jpg` | 543×449 | JPEG | Nej | Cartoon, troligen ljus bakgrund | **GUL** — Fungerar troligen bra på light; spot-check |
| `photoresistor-macro.jpg` | 3657×2743 | JPEG | Nej | Foto, orange bakgrund | **GUL** — Fungerar på båda |
| `photoresistors-three.jpg` | 2400×1350 | JPEG | Nej | Foto, mörkare kamerainställning | **GUL** — Spot-check |
| `tilt-switch.jpg` | 1000×1000 | JPEG | Nej | Produktfoto | **EJ REFERERAD** — orphan |
| `breadboard-internals.png` | 653×213 | PNG RGB | Nej | Diagram med explicit `background:white` i slides.md | **GRÖN** — Medvetet vit |
| `breadboard-rails.png` | 1479×1089 | PNG RGB | Nej | Okänd bakgrund | **EJ REFERERAD** — orphan |
| `pwm-waveform.png` | 800×679 | PNG RGB | Nej | Vågform — `filter:invert(1) hue-rotate(180deg)` på rad 1311 | **RÖD** — dark-only-hack |
| `resistor-color-chart.png` | 501×785 | PNG RGB | Nej | Färgtabell | **EJ REFERERAD** — orphan |
| `rgb-color-mixing.png` | 400×400 | PNG RGB | Nej | RGB-cirkel mot svart, `mix-blend-mode:screen` på rad 1151 | **RÖD** — osynlig mot vitt |
| `voltage-divider.svg` | 820×820 | SVG | Nej | **Hardkodade dark-fills inuti**: `fill="#eaeaea"`, `fill="#9aa5b1"`, `fill="#616e7c"`, stroke `#1f2933` | **RÖD** — text + linjer osynliga på vitt |

### Wiring `/public/images/wiring/` (11 filer)

| Fil | Dim (px) | Format | Alpha | Bakgrund | Status |
|-----|----------|--------|-------|----------|--------|
| `button-fritzing.png` | 1724×1588 | PNG **RGBA** | Ja | Transparent | **GRÖN** — fungerar på båda |
| `button-photo.png` | 1813×1813 | PNG RGB | Nej | Okänd | **GUL** — visuell kontroll |
| `buzzer-fritzing.png` | 822×874 | PNG RGB | Nej | Troligen ljus (Fritzing default) | **GUL** — bra på light, dåligt på dark |
| `buzzer-photo.png` | 1819×1820 | PNG RGB | Nej | Okänd | **GUL** |
| `led-fritzing.png` | 1752×1742 | PNG **RGBA** | Ja | Transparent | **GRÖN** |
| `photocell-schematic.png` | 1616×1472 | PNG **RGBA** | Ja | Transparent | **GRÖN** |
| `photocell-wiring.png` | 1192×859 | PNG RGB | Nej | Okänd | **EJ REFERERAD** — orphan |
| `rgb-fritzing.png` | 1804×1640 | PNG **RGBA** | Ja | Transparent | **GRÖN** |
| `rgb-photo.png` | 1819×1634 | PNG RGB | Nej | Okänd | **EJ REFERERAD** — orphan |
| `tilt-photo.png` | 1986×1498 | PNG **RGBA** | Ja | Transparent | **GRÖN** |
| `tilt-schematic.png` | 842×873 | PNG RGB | Nej | Okänd | **EJ REFERERAD** — orphan |

---

## 2. WiringSlide.vue — dark-antaganden

`/Users/daniel/projects/arduino-kurs/presentation/components/WiringSlide.vue`

| Rad | Klass | Problem |
|-----|-------|---------|
| 15 | `opacity-50` | Eyebrow-text dimmas — på vitt riskerar för låg kontrast |
| 18 | `opacity-35` | "Elegoo Basic Starter Kit" — extremt låg opacity, riskerar osynlig på vitt |
| **28** | **`ring-1 ring-white/10`** | **OSYNLIG på vitt — vit ring på vit bakgrund. Måste tokeniseras eller bytas via `html.light`-override.** |
| 28 | `shadow-2xl` | Kraftig shadow — fungerar på dark, kan se platt/tung ut på light |
| 32 | `opacity-85` | Reference-panel — marginal-fall |
| 39 | `opacity-65` | Caption — marginal-fall på light med ljust text-tema |

**Den enda hård buggen är rad 28 — `ring-white/10` försvinner helt på vit bakgrund.**

---

## 3. Globala hardkodade färger (filer + radnummer)

### `presentation/slides.md`

| Rad | Typ | Värde | Problem på light |
|-----|-----|-------|-----------------|
| 21 | Frontmatter `background` | `'#0a0e14'` | Global mörk bakgrund |
| 415–416 | SVG `stroke="#00ffd1"` | Cyan triangel-stroke | Kan blekna mot vitt |
| 418 | `style="color:#00ffd1"` | Cyan accent | Kontrast OK men kanten lider |
| 419 | `style="color:#e8ecf1"` | Off-white | **Osynlig mot vitt** |
| 420 | `style="color:#00ffd1;opacity:0.8"` | Cyan separator | Se 418 |
| 421 | `style="color:#e8ecf1"` | Off-white | **Osynlig mot vitt** |
| 550 | `bg-[#d4a574]` | Brun (resistorillustration) | **Pedagogiskt skyddad** |
| 551–552 | `bg-[#ff2222]` | Röd (resistor-band) | **Pedagogiskt skyddad** |
| 553 | `bg-[#8b4513]` | Brun (resistor-band) | **Pedagogiskt skyddad** |
| 555 | `bg-[#d4af37]` | Guldgul (resistor-band) | **Pedagogiskt skyddad** |
| 610 | `style="background:white"` | Vit bakgrund på breadboard-bild | Avsiktligt |
| 1151 | `style="mix-blend-mode: screen"` | Screen blend på RGB-bild | **Trasig på vitt** |
| 1311 | `style="filter: invert(1) hue-rotate(180deg)"` | Inverterat filter | **Partiellt trasig på vitt** |
| 1340 | `style="color:#b400dc"` | Lila exempel | Kontrast ~3:1 |
| 1341 | `style="color:#ff8cb4"` | Rosa exempel | Kontrast ~2.2:1 |
| 1342 | `style="color:#ffd400"` | Skolgul exempel | **Kontrast ~1.07:1 — osynlig** |
| 1343 | `style="color:#00e0ff"` | Cyan exempel | Kontrast ~1.3:1 |
| 1355–1358 | `style="background:#XXXXXX"` | Färgblock-bakgrunder | **Pedagogiskt skyddade** |
| 1805 | `ring-2 ring-rose-500/50 shadow-2xl` | Buzzer-bild ring | Tung på light |

### `presentation/styles/main.css`

| Rad(er) | Värde | Problem |
|---------|-------|---------|
| 19 | `--ak-bg: #0a0e14` | Mörk bakgrundsvariabel |
| 20 | `--ak-bg-raised: #111820` | Mörk raised |
| 21 | `--ak-border: #1f2933` | Mörk kant |
| 22 | `--ak-text: #eaeaea` | Ljus text — osynlig på vitt |
| 23 | `--ak-text-dim: #9aa5b1` | För dark |
| 24 | `--ak-text-mute: #616e7c` | För dark |
| 25 | `--ak-accent: #00ffd1` | Cyan glow — låg kontrast på vitt |
| 27 | `--ak-warn: #ffd400` | Gul — osynlig på vitt |
| 28 | `--ak-danger: #ff3366` | Rosa-röd — OK på vitt med tweak |
| 29–30 | `--ak-glow-cyan/red` | Glow box-shadows för dark |
| 34–36 | `.slidev-layout { background-color: var(--ak-bg) !important }` | Tvingar bakgrund |
| 112 | `box-shadow: 0 8px 30px rgba(0,0,0,0.5)` | Mörk shadow på code-wrapper |
| 183 | `.section` radial: `#141b26 / var(--ak-bg)` | Hardkodad mörk |
| 199–207 | `.cover` background overlay + cover-hero.jpg | Allt dark |
| 212 | `.cover h1 { color: #ffffff }` | Vit rubrik |
| 213 | `text-shadow: 0 2px 20px rgba(0,0,0,0.9)` | Mörk shadow |
| 217 | `.end` radial: `#1a2435 / var(--ak-bg)` | Hardkodad mörk |
| 241 | `.rgb-white` radial-gradient `#ffffff` | Osynlig mot vit bg |

### `presentation/components/WiringSlide.vue`

| Rad | Värde | Problem |
|-----|-------|---------|
| 28 | `ring-white/10` | Osynlig på vitt |

---

## 4. Snippets-mapp

`/Users/daniel/projects/arduino-kurs/presentation/snippets/` är **tom** — ej relevant.

---

## 5. Sammanfattning

### Måste bytas/dubbletteras (RÖD)

- **`voltage-divider.svg`** — hardkodade dark-färger; antingen `currentColor` + tema-CSS eller separat `voltage-divider-light.svg`.
- **`rgb-color-mixing.png`** — `mix-blend-mode:screen` osynlig på vitt; behöver dark container-frame ELLER ny RGBA-bild med transparent bakgrund.
- **`pwm-waveform.png`** — `filter:invert(1) hue-rotate(180deg)` är dark-only; behöver originalbild utan filter eller dual-asset.
- **`styles/main.css` tokens + `.cover/.section/.end`** — hela token-systemet är dark-only.
- **`slides.md` rader 419, 421** — `color:#e8ecf1` (off-white) i Ohms-triangeln, byt till `var(--ak-text)`.
- **`WiringSlide.vue` rad 28** — `ring-white/10` byt till tokeniserad ring (`ring-[var(--ak-border)]` el. liknande).

### Kan fungera med tweaks (GUL)

- **`cover-arduino-hero.jpg`** — ny gradient-overlay + h1-color via `html.light`-overrides.
- **`arduino-uno-hero.jpg`** — fungerar som foto.
- **`active-buzzer-sticker.jpg`** — ring-rose-färg fungerar men är överdriven på vitt; överväg `html.light` override.
- **Övriga foton** — visuell spot-check.

### OK utan ändringar (GRÖN)

- Alla wiring-PNG:er med RGBA (transparent bakgrund).
- `breadboard-internals.png` med explicit `background:white`.
- Resistor-band hex (slides 10) — pedagogiskt skyddade.
- RGB-färgexempel (slide 25) — pedagogiskt skyddade.

### Orphaned assets (kan städas)

`tilt-switch.jpg`, `breadboard-rails.png`, `resistor-color-chart.png`, `photocell-wiring.png`, `rgb-photo.png`, `tilt-schematic.png`. Sex bilder används inte.
