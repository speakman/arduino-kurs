# Slidev cleanup — slut-handover 2026-04-14 (sen kväll)

Fortsättning på `handover-before-clear-20260414.md`. Sektion 9 utförd.

## Vad gjordes

### Sektion 4a/4b/4e: pt-* cleanup
Sonnet-agent triagade alla 29 slides med `class: ... pt-N`. 17 flaggades som onödiga (innehåll förskjutet nedåt jämfört med global `safe center`-regel). Borttogs via sed per exakt radnummer:

| Slide | Rad | Borttagen klass |
|------:|----:|-----------------|
| 02 | 68  | pt-16 |
| 05 | 207 | pt-16 |
| 08 | 381 | pt-12 |
| 12 | 642 | pt-12 |
| 13 | 692 | pt-14 |
| 14 | 718 | pt-10 |
| 17 | 895 | pt-12 |
| 18 | 964 | pt-14 |
| 25 | 1337 | pt-12 |
| 26 | 1367 | pt-12 |
| 31 | 1628 | pt-10 |
| 36 | 1911 | pt-14 |
| 38 | 1997 | pt-14 |
| 41 | 2118 | pt-12 |
| 46 | 2413 | pt-12 |
| 48 | 2502 | pt-14 |
| 50 | 2565 | pt-10 |

12 slides KEEP (innehållet fyller redan canvas så pt-* är en no-op): 9, 11, 16, 24, 27, 29, 33, 37, 40, 42, 47, 51.

PDF och PNG omrenderade. Visuell verifiering: balanserat och välcentrerat.

### Inte gjort (medvetet)

- **4c** (`!p-0` fullbleed): legitimt, behållet
- **4d/4f** (`text-center`-tricks): författarens horisontella centrering, behållet
- **4g** (kodblock `[&_pre]:!text-Nxl`): 3 instanser med 2 olika storlekar och 2 paddings — för inkonsistent för en global regel utan att ändra design intent
- **4h** (raw inline `style="font-size:Npx"`): legitima per-element-tweaks (Ohms-triangel, warn-box-titlar)
- **4i** (Ohms-triangel divs): legitim SVG-text-cascade-workaround
- **4j** (`max-w-*`-tuning): författarens optiska linjelängd-beslut
- **4k** (`leading-relaxed` x31): UnoCSS-rebasen ger redan ~1.5 så `leading-relaxed` (1.625) är nästan no-op. Risk för subtila regressioner > vinst. Lämnat.

## Nuvarande tillstånd

- `presentation/slides.md` — 17 pt-* borttagna, inga andra innehållsändringar
- `presentation/uno.config.ts` — orörd
- `presentation/styles/main.css` — orörd
- `kompendium/deliveries/slides-arduino-kurs.pdf` — färsk export

## Möjliga nästa steg

1. **Visuell sista granskning av användaren** — bläddra PDF och kolla att det nya centrerings-beteendet känns rätt
2. **Eventuell global kodblock-storleksbump** om författaren vill ha större `<pre>` överallt — ersätter 4g per-slide-overrides
3. **Innehåll-revidering av slide 3** (Klassrummets verktyg) — separat från layoutarbetet
