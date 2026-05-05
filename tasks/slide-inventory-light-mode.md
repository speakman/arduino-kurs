# Slide-inventering: light-mode-risker

**Källa:** `presentation/slides.md` · 2816 rader · 52 slides (104 `---`-separatorer)
**Skapad:** 2026-05-05
**Syfte:** Inför införandet av light-mode (projektor) — kartlägga vilka slides som har hardkodade dark-antaganden som måste åtgärdas.

---

## Per-slide-inventering

### Slide 1 (rader 1–65) — Cover: "Elektronik & Programmering med Arduino"
- Layout: `cover` (global config, ingen explicit layout-rad)
- Custom class: `cover`
- Innehåll: Titelslide med hero-foto, kursnamn, datum, ort
- Risker i light-mode:
  * **KRITISK** — `.slidev-layout.cover` i CSS sätter `background-image` med hårdkodad dark-gradient `linear-gradient(180deg, rgba(10,14,20,0.35)…rgba(10,14,20,0.95))` ovanpå `/images/cover-arduino-hero.jpg`. Gradienten är designad för att mörkna bilden; i light-mode vore en ljus gradient lämpligare men CSS-regeln saknar `html.light`-variant.
  * **KRITISK** — `.slidev-layout.cover h1` har `color: #ffffff` och `text-shadow: 0 2px 20px rgba(0,0,0,0.9)` hårdkodat i CSS. Vit text + svart shadow förutsätter dark bakgrund.
  * Global `background: '#0a0e14'` och `colorSchema: dark` i frontmatter — ingen `html.light`-toggling finns i CSS-filen.
  * `opacity-60` och `opacity-80` på underrubriker är intaglade för att ge kontrast mot dark bakgrund; på light bg behöver opaciteten antagligen höjas.
- Komponenter använda: inga

### Slide 2 (rader 67–132) — Kursöversikt: "Fem träffar. Fem moduler."
- Layout: `default` · class: `px-14`
- Innehåll: 5-modulers overview med `.sp-grid`-komponenter
- Risker:
  * `.sp-grid` / `.sp` använder `var(--ak-border)` och `var(--ak-bg-raised)` — token-driven, OK om tokens togglas.
  * `.sp.unlocked` och `.sp.current` använder `box-shadow: var(--ak-glow-cyan)` — gloweffekter förutsätter dark bg.
  * `opacity-60` på footer-text.

### Slide 3 (rader 134–166) — Section: "LED & krets / Modul 1"
- Layout: `section` · class: `section text-center`
- Risker:
  * **KRITISK** — `.slidev-layout.section`: `background: radial-gradient(circle at 30% 30%, #141b26 0%, var(--ak-bg) 60%)` — hårdkodad mörk radial, ingen `html.light`-variant.
  * `.slidev-layout.section h1` har `color: var(--ak-accent)` — token-driven, OK.

### Slide 4 (rader 168–234) — Agenda: "Idag — två timmar."
- Layout: `default` · class: `px-14`
- Risker: `opacity-70`, `opacity-50`, `opacity-60` genomgående.

### Slide 5 (rader 236–273) — Full: "Det här ska vi bygga."
- Layout: `full` · class: `relative`
- Risker: `opacity-75` på text. `.warn` token-driven, OK.

### Slide 6 (rader 274–343) — image-left: "Mikrokontrollern."
- Layout: `image-left` · class: `pl-4`
- Bild: `/images/arduino-uno-hero.jpg`
- Risker: `opacity-75`, `opacity-50`. Image-left bakgrundsbild är ren `background-image`, ingen `background-color`.

### Slide 7 (rader 345–391) — default: "Spänning, ström, GND."
- Layout: `default` · class: `px-14`
- Risker: Korten använder `border border-[var(--ak-border)] bg-[var(--ak-bg-raised)]` — token-driven, OK.

### Slide 8 (rader 393–453) — default: "U = R · I" (Ohms lag)
- Layout: `default` · class: `px-14 pt-12`
- Risker:
  * **KRITISK** — SVG: `stroke="#00ffd1"` (rad 415–416) hårdkodat cyan i SVG-element.
  * **KRITISK** — Inline style med `color:#00ffd1` (rad 418, 420) — cyan kan försvinna mot light bg.
  * **KRITISK** — Inline style med `color:#e8ecf1` (rad 419, 421) — off-white, **nästan osynlig på light bg**.
- Komponenter: inline SVG-triangel + absolut-positionerade divs

### Slide 9 (rader 455–502) — default: "Kretsen — som ett vattensystem."
- Layout: `default` · class: `px-14`
- Risker: `.danger` och `.tip-box` token-driven, OK.

### Slide 10 (rader 504–597) — two-cols-header: "LED & resistor."
- Layout: `two-cols-header` · class: `px-14 pt-12`
- Risker:
  * Resistor-färgkodsvinjett (rad 550–555): `bg-[#d4a574]`, `bg-[#ff2222]`, `bg-[#8b4513]`, `bg-[#d4af37]`. **Pedagogiskt nödvändiga konstanter** (representerar fysiska komponentfärger), ska EJ ändras.
  * Kortramar token-driven.

### Slide 11 (rader 600–646) — default: "Fem hål = en nod." (breadboard)
- Layout: `default` · class: `px-14`
- Bild: `/images/breadboard-internals.png`
- Risker:
  * **KRITISK** — `<img style="width:100%;margin-top:12px;border-radius:8px;background:white;padding:10px">` (rad 610) — hårdkodad `background:white` försvinner visuellt på light bg.
  * `text-red-400` och `text-blue-400` på +/−-skenorna — Tailwind-färger, ej token-driven men fungerar.

### Slide 12 (rader 648–671) — center: "Kontrollera raden först."
- Layout: `center`
- Risker: Ingen.

### Slide 13 (rader 673–741) — default: "Bygg kretsen."
- Layout: `default` · class: `px-14`
- Risker: `.mono cyan` och `.tip-box` token-driven, OK.

### Slide 14 (rader 743–774) — default (!p-0): WiringSlide LED
- Komponent: `<WiringSlide>` med `/images/wiring/led-fritzing.png`
- Risker: WiringSlide-internals (`ring-white/10` + opacity-knepen) — se separat audit.

### Slide 15 (rader 776–843) — two-cols-header: "`setup()` och `loop()`"
- Layout: `two-cols-header` · class: `px-14 pt-12`
- Risker:
  * `.slidev-layout .slidev-code-wrapper` har `box-shadow: 0 8px 30px rgba(0,0,0,0.5)` — på light bg ger svart shadow med 50% opacitet ett tungt utseende.
  * Shiki redan dual-theme-konfigurerad (se native-theme-research).

### Slide 16 (rader 845–911) — default: "Hela Blink — på tre rader."
- Layout: `default` · class: `px-14`
- Risker: `opacity-85`, `opacity-60`. Inga hardcodade färger.

### Slide 17 (rader 914–998) — default: "Din egen rytm."
- Layout: `default` · class: `px-14`
- Risker: `.tip-box` token-driven.

### Slide 18 (rader 1000–1066) — center: "Ni har byggt en blinkare."
- Layout: `center` · class: `text-center`
- Risker: `bg-[var(--ak-accent-soft)]` token-driven. `opacity-75`, `opacity-70`.

### Slide 19 (rader 1068–1112) — statement: "Nästa gång..."
- Layout: `statement` · class: `text-center`
- Risker:
  * `.rgb-circle` med `rgb-red`, `rgb-green`, `rgb-blue`: radial-gradient med hårdkodade LED-färger (`#ff1744`, `#00e676`, `#2979ff`). **Pedagogiskt korrekta**, behåll. Glöden tappar visuell effekt på light bg.

### Slide 20 (rader 1114–1138) — section: "PWM & RGB / Modul 2"
- Layout: `section` · class: `section text-center`
- Risker: Samma som slide 3 (mörk radial-gradient).

### Slide 21 (rader 1140–1193) — center: "Alla färger, av bara tre."
- Layout: `center` · class: `text-center`
- Bild: `/images/rgb-color-mixing.png`
- Risker:
  * **KRITISK** — `<img style="mix-blend-mode: screen;">` (rad 1151). Screen-blend fungerar på dark bg; på light bg blir bilden osynlig/vit.
  * `.warn-box` glow för dark.

### Slide 22 (rader 1195–1233) — default (!p-0): WiringSlide RGB LED
- Komponent: `<WiringSlide>` med `/images/wiring/rgb-fritzing.png`
- Risker: `text-red-400`, `text-green-400`, `text-blue-400` i caption — hardcoded Tailwind, OK på båda men ej tema-styrda.

### Slide 23 (rader 1235–1291) — default: "`analogWrite`"
- Layout: `default` · class: `px-14 pt-12`
- Risker: `.big-code` (storlek), kodblocks box-shadow (slide 15-risk).

### Slide 24 (rader 1293–1321) — default: "Duty cycle."
- Layout: `default` · class: `px-14`
- Bild: `/images/pwm-waveform.png`
- Risker:
  * **KRITISK** — `<img style="filter: invert(1) hue-rotate(180deg);">` (rad 1311). Dark-only-hack; på light bg visas originalfärger eller fel resultat.

### Slide 25 (rader 1323–1390) — default: "Hitta färgen."
- Layout: `default` · class: `px-14`
- Risker:
  * **KRITISK** — Inline `style="color:#b400dc"` (rad 1340) — kontrast ~3:1 på vitt (under WCAG AA 4.5:1).
  * **KRITISK** — `style="color:#ff8cb4"` (rad 1341) — kontrast ~2.2:1.
  * **KRITISK** — `style="color:#ffd400"` (rad 1342) — kontrast ~1.07:1 (nästan osynlig).
  * **KRITISK** — `style="color:#00e0ff"` (rad 1343) — kontrast ~1.3:1.
  * `style="background:#XXXXXX"` (rad 1355–1358) — färgprovs-kort. Pedagogiskt nödvändiga konstanter.

### Slide 26 (rader 1392–1435) — center: "Ni har en pixel."
- Layout: `center`
- Risker: Samma som slide 19 (rgb-circle-glow).

### Slide 27 (rader 1437–1460) — section: "Digital input / Modul 3"
- Risker: Mörk radial.

### Slide 28 (rader 1462–1529) — default: "`const int` och `int`."
- Layout: `default` · class: `px-14 pt-10`
- Risker: `.tip-box` token-driven. `opacity-55`.

### Slide 29 (rader 1531–1587) — statement: "Input ≠ Output."
- Layout: `statement` · class: `text-center`
- Risker: Statement-layout har ingen explicit CSS-regel i main.css — Slidev-default används.

### Slide 30 (rader 1589–1653) — two-cols-header: "`if` / `else`."
- Layout: `two-cols-header` · class: `px-12`
- Risker: `.tip-box` token-driven.

### Slide 31 (rader 1655–1679) — default (!p-0): WiringSlide Knapp
- Komponent: `<WiringSlide>` med `/images/wiring/button-fritzing.png`

### Slide 32 (rader 1681–1773) — two-cols-header: "Reagera på flanken."
- Layout: `two-cols-header` · class: `px-12 pt-10`
- Risker: `.tip-box` token-driven.

### Slide 33 (rader 1775–1863) — default: "En varning först." (buzzer)
- Layout: `default` · class: `px-14`
- Bild: `/images/active-buzzer-sticker.jpg`
- Risker:
  * `.warn-box` glow för dark.
  * **MEDEL** — `<img class="ring-2 ring-rose-500/50 shadow-2xl">` (rad 1805) — ring + shadow för dramatisk dark-effekt; på light blir det överdrivet tungt.

### Slide 34 (rader 1865–1889) — default (!p-0): WiringSlide Buzzer
- Komponent: `<WiringSlide>` med `/images/wiring/buzzer-fritzing.png`

### Slide 35 (rader 1891–1946) — center: "Läs knapp. Styr buzzer."
- Risker: `opacity-80` på mono-text.

### Slide 36 (rader 1948–2005) — default: "Kärnan i `loop()`."
- Layout: `default` · class: `px-14 pt-12`
- Risker: `.big-code`, kodblocks-shadow.

### Slide 37 (rader 2007–2037) — center: "Arduinon lyssnar."
- Risker: `opacity-80`, `opacity-60`.

### Slide 38 (rader 2039–2063) — section: "Analog input / Modul 4"
- Risker: Mörk radial.

### Slide 39 (rader 2065–2123) — default: "Knappen var digital. Världen är analog."
- Layout: `default` · class: `px-14 pt-12`
- Bild: `/images/photoresistors-three.jpg`
- Risker: Inline `style` är ren layout (ingen färg), OK.

### Slide 40 (rader 2125–2170) — two-cols-header: "`analogRead()` — Arduinons linjal."
- Risker: `.tip-box` token-driven.

### Slide 41 (rader 2172–2272) — two-cols-header: "Spänningsdelaren."
- Layout: `two-cols-header` · class: `px-12 pt-10`
- Bild: `/images/voltage-divider.svg`
- Risker:
  * **KRITISK** — SVG har **hårdkodade dark-färger inuti**: `fill="#eaeaea"`, `fill="#9aa5b1"`, `fill="#616e7c"`, stroke `#1f2933`. Måste antingen göras token-styrd via `currentColor` eller dubbletteras till `voltage-divider-light.svg`.

### Slide 42 (rader 2274–2293) — default (!p-0): WiringSlide Fotocell
- Komponent: `<WiringSlide>` med `/images/wiring/photocell-schematic.png`

### Slide 43 (rader 2296–2318) — default (!p-0): WiringSlide Tilt-sensor
- Komponent: `<WiringSlide>` med `/images/wiring/tilt-photo.png`

### Slide 44 (rader 2321–2388) — two-cols: "Serial Monitor."
- Layout: `two-cols` · class: `px-14`
- Risker: Inga hardcodade färger.

### Slide 45 (rader 2390–2438) — default: "Hitta din tröskel."
- Layout: `default` · class: `px-14`
- Risker: Inga.

### Slide 46 (rader 2441–2478) — default: "Koden att köra."
- Risker: `.big-code`.

### Slide 47 (rader 2480–2506) — center: "Arduinon känner världen."
- Risker: `opacity-80`, `opacity-60`.

### Slide 48 (rader 2509–2539) — section: "Integration / Modul 5"
- Risker: Mörk radial.

### Slide 49 (rader 2542–2609) — default: "Ingenjörsuppgiften."
- Layout: `default` · class: `px-14`
- Risker: `.warn` token-driven. `opacity-40`, `opacity-60` på pilar.

### Slide 50 (rader 2612–2705) — default: "Pin-tilldelning."
- Layout: `default` · class: `px-14 pt-10`
- Risker: `opacity-60`, `opacity-50` på rubriker.

### Slide 51 (rader 2708–2775) — default: "Vart härifrån?"
- Layout: `default` · class: `px-14 pt-12`
- Risker: Token-driven kort. `opacity-85`, `opacity-80`, `opacity-60`.

### Slide 52 (rader 2777–2816) — center: "Tack." (end)
- Layout: `center` · class: `end text-center`
- Risker:
  * **KRITISK** — `.slidev-layout.end`: `background: radial-gradient(ellipse at center, #1a2435 0%, var(--ak-bg) 70%)` — hårdkodad mörk radial, ingen `html.light`-variant.

---

## Sammanfattning

### Layout-fördelning

| Layout | Antal |
|--------|-------|
| default | 24 (varav 7 med `class:"!p-0"` för WiringSlide) |
| center | 9 |
| section | 5 |
| two-cols-header | 6 |
| statement | 2 |
| full | 1 |
| image-left | 1 |
| two-cols | 1 |
| cover (frontmatter) | 1 |
| end (custom class) | 1 |

### Kritiska problem (måste fixas)

1. **Slide 8 — Ohms-triangeln**: Inline SVG `stroke="#00ffd1"` + divs `color:#e8ecf1` → byt till `var(--ak-text)` och `var(--ak-accent)`.
2. **Slide 21 — RGB-blandning**: `mix-blend-mode: screen` osynlig på light → behöver kontextuell mörk container ELLER ny bild med transparent bakgrund.
3. **Slide 24 — PWM-vågform**: `filter: invert(1) hue-rotate(180deg)` är dark-hack → light-mode visar fel färger; behöver originalbild utan filter eller dual-asset.
4. **Slide 25 — Hitta färgen**: Fyra inline `color:#XXXXXX` med kontrast under WCAG AA på vitt. **Lösning**: ge varje färgexempel en mörk pillbakgrund (chip-design) som behåller pedagogiska färgen oavsett mode.
5. **Slide 41 — voltage-divider.svg**: Hårdkodade dark-fills inuti SVG → byt till `currentColor` + tema-CSS, eller skapa light-variant.
6. **CSS — `.cover`, `.section`, `.end`**: Hardkodade mörka gradients i layout-CSS, måste få light-mode-varianter.
7. **CSS — `.slidev-code-wrapper`**: `box-shadow: rgba(0,0,0,0.5)` för tungt på light → tokenisera till `var(--ak-code-shadow)`.

### Token-promotion-kandidater (clean-up)

- `opacity-XX`-värdena i text — kunde tokeniseras (`--ak-text-opacity-dim` etc) men är acceptabelt om light-mode `--ak-text` har god kontrast.
- `.cover h1` color/text-shadow → tokens (`--ak-cover-fg`, `--ak-cover-shadow`).
- `text-red-400`/`text-blue-400`/`text-green-400` i breadboard-rails och RGB-caption — kan ersättas av `.danger`, `.cyan` etc om vi vill ha tematisering, men nuvarande Tailwind funkar på båda.

### Pedagogiskt-skyddade konstanter (behåll oavsett mode)

- Resistor-band hex (slide 10): `#d4a574`, `#ff2222`, `#8b4513`, `#d4af37`.
- RGB-cirkel-färger (slides 19, 26): `#ff1744`, `#00e676`, `#2979ff`.
- RGB-färgexempel-bakgrunder (slide 25): `#b400dc`, `#ff8cb4`, `#ffd400`, `#00e0ff` — men deras textbeteckning behöver chip-bakgrund.

### Bild-inventering

| Fil | Slide | Notering |
|-----|-------|---------|
| `/images/cover-arduino-hero.jpg` | 1 | Via CSS background-image |
| `/images/ohms-law-cartoon.jpg` | 8 | Layout-style |
| `/images/breadboard-internals.png` | 11 | `background:white;padding` |
| `/images/rgb-color-mixing.png` | 21 | `mix-blend-mode: screen` — RISK |
| `/images/pwm-waveform.png` | 24 | `filter: invert(1) hue-rotate(180deg)` — RISK |
| `/images/wiring/led-fritzing.png` | 14 | Via WiringSlide |
| `/images/wiring/rgb-fritzing.png` | 22 | Via WiringSlide |
| `/images/wiring/button-fritzing.png` | 31 | Via WiringSlide |
| `/images/wiring/buzzer-fritzing.png` | 34 | Via WiringSlide |
| `/images/active-buzzer-sticker.jpg` | 33 | `ring-rose-500/50 shadow-2xl` |
| `/images/photoresistors-three.jpg` | 39 | Layout-style |
| `/images/voltage-divider.svg` | 41 | **Hardkodade dark-fills i SVG** — RISK |
| `/images/wiring/photocell-schematic.png` | 42 | Via WiringSlide |
| `/images/wiring/tilt-photo.png` | 43 | Via WiringSlide |
| `/images/arduino-uno-hero.jpg` | 6 | Via image-left layout |
