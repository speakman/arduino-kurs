# Slide-audit konsoliderad fix-lista — 2026-04-18

Batch-rapporter: `slide-audit-batch-1.md` … `slide-audit-batch-6.md`.

## 🔴 Kritiskt (måste fixas)

### Förbjudet språk (hårt brott mot policy)
Grep-resultat från `presentation/slides.md`:

| Rad | Ord | Kontext | Slide |
|---:|---|---|---:|
| 1429 | sinnesorgan | "knapp — Arduinons första sinnesorgan" | ~33 |
| 1566 | magin | "Förklara magin med INPUT_PULLUP" | ~29 |
| 1962 | sinnesorgan | "Arduinons första sinnesorgan — en knapp" | ~37 |
| 1974 | sinnesorgan | "Ni har Arduinons första sinnesorgan" | ~37 |
| 2006 | röntgen + hjärna | "röntgen in i Arduinons hjärna" | ~40/44 |
| 2378 | magiskt | "inte ett magiskt tal" | ~45 |
| 2437 | hjärna | "titta in i Arduinons hjärna" | ~47 |

### Andra 🔴
- **Slide 16**: monospace-font läcker in i sista paragrafens brödtext.
- **Slide 43**: tilt-sensor-foto inte vertikalt centrerat — layout-bug.
- **Slide 45**: bullet 3 änka "LOW?" ser ut som eget stycke skilt från bullet.

## ⚠️ Polish (bör fixas, inte kritiskt)

### Änkor (enstaka ord på sista raden)
- Slide 5: "någon rör det."
- Slide 17: "oregelbunden"
- Slide 18: "kommandon" (kol 2), "världen" (kol 3)
- Slide 19: "rytm."
- Slide 23: "LOW."
- Slide 51: "system."

### Typografi / stavning
- Slide 12: "ett hål fel" → "ett hålsfel"
- Slide 22: `--skenan` (dubbelt bindestreck) → `–skenan`
- Slide 41: "Lampa nära500-700" — mellanslag saknas mellan label och värde
- Slide 50: `larmPaslaget` — saknar å eller byt till `larmArmed`
- Slide 51: "FRO" — verifiera korrekt organisationsnamn

### Färg-konsekvens
- Slide 2, 5, 7: ikoner renderar vita istället för cyan
- Slide 8: triangel `#00d9ff` → `#00ffd1`
- Slide 17: "Röd lapp" i rött bryter regeln röd = GND/varning
- Slide 21: "Katod" i rött bryter samma regel
- Slide 31: "GND" i bildtext saknar röd (slide 34 har det)

### Layout
- Slide 2, 4, 7, 10, 13, 16, 24, 28, 29, 30, 36, 39, 40, 44, 46, 50: tomt utrymme i nedre delen (återkommande mönster)
- Slide 22: eyebrow saknar `opacity-50`
- Slide 24: PWM-diagram obalanserat, vit bakgrund sticker ut
- Slide 31, 34: Arduino USB sticker ut utanför vita rutan; slide 31 visar två knappar
- Slide 33: `"Remove after washing"` → `"REMOVE SEAL AFTER WASHING"` (matcha faktiskt tryck)
- Slide 36: dubbel eyebrow vs single eyebrow på andra slides
- Slide 41: eyebrow "NYTT KONCEPT · FRÅN MOTSTÅND TILL MÄTVÄRDE" → korta till "NYTT KONCEPT"
- Slide 50: tabell tar bara vänster ~45 %

### Innehåll
- Slide 15: "Serial, etc." introducerar Serial utan förklaring
- Slide 23: HIGH cyan + LOW vit = asymmetri
- Slide 24: "full" utan substantiv → "full styrka"
- Slide 36: "Ingen tone() behövs" — `tone()` orphaned begrepp
- Slide 44: "förstoringsglaset" informellt — framtidssäkra för IDE 2.x

## Prioriterad åtgärdsordning

1. **Förbjudna ord** (7 hits) — en global rensning
2. **Slide 16** monospace-läckage — CSS-fix
3. **Slide 43** foto-centrering — CSS-fix
4. **Slide 45** bullet-änka — innehållsfix
5. **Polish-ronden** (änkor, stavfel, färg-inkonsekvenser) — iterativt
6. **Layout-ronden** (tomrum, ikonfärger) — efter innehåll är rätt

Re-rendera slide för slide efter varje Edit och verifiera.
