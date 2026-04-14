# Handover — manuell genomgång av slides 2026-04-14 (sen eftermiddag)

**User kommer nu gå igenom alla 52 slides manuellt** efter en session med täthets-/läsbarhetsfixar. Detta dokument beskriver vad som gjorts så du förstår vad du kan hitta.

## Aktuell status

- **Source:** `presentation/slides.md` — **52 slides** (var 46 innan, 6 splits tillagda)
- **Levererad PDF:** `kompendium/deliveries/slides-arduino-kurs.pdf` — ombyggd senast 14 april eftermiddag (v6)
- **Inga kända problem** enligt sonnet-audit (16/16 PASS på sista re-audit av de 16 ändrade positionerna)
- **Ingen git** i denna repo — ändringar är osparade i filsystemet

## Vad som gjordes denna session

Föregående handover: `tasks/handover-slides-density-20260414.md` listade 10 slides flaggade av sonnet-audit som "mikrotext / för dense". Denna session åtgärdade alla 10 via:

### 6 splits (46 → 52 slides)

| Gammalt # | Nytt # | Vad som hände |
|---|---|---|
| 8 (spänning/ström/GND + Ohms lag) | **8** + **9** | Trekorts-grid utan brödtext (8), Ohms lag-triangel ensam med hänvisning till Bilaga F (9) |
| 11 (breadboard) | **12** + **13** | Full-bredd breadboard-bild + bullets (12), "Kontrollera raden först" som eget mantra (13) |
| 22 (analogWrite) | **24** + **26** | Text + kod (24), PWM duty cycle-graf ensam med 3 bullets (26) — slide 25 "Hitta färgen" ligger mellan |
| 33 (läs knapp styr buzzer) | **36** + **37** | Konceptbro INPUT→if/else→OUTPUT (36), Kärnan i `loop()` kod ensam (37) |
| 36 (knappen digital / världen analog) | **40** + **41** | Stor LDR-bild + kontrast-text (40), `analogRead()` + "Gör detta nu" (41) |
| 41 (hitta din tröskel) | **46** + **47** | Tre bullet-frågor ensamma (46), 9-radigt kodblock i full bredd (47) |

### 4 layout-fixar (ingen split)

- **Slide 16 (→ 18)** — Din egen rytm: tog bort 20-raders SOS-kodblock + two-cols. Koden finns i kompendiet (Hemma-övning 2–3).
- **Slide 31 (→ 34)** — En varning först (buzzer): tog bort grid-cols-2, större bild (`max-h-[32rem]`), större varn-box-font (inline `style=` pga UnoCSS-problem med arbitrary values — se gotcha nedan).
- **Slide 45 (→ 51)** — Pin-tilldelning: ersatte dubbla kodblock med en markdown-liknande pin-tabell (variabel | pin | modul) + enda raden `bool larmPaslaget = false;` + hänvisning "Bilaga D".
- **Slide 46 (→ 52)** — Tack: bumpade font-sizes (`text-4xl` brödtext, `text-xl` footer). Audit-påståendet om pixlad bild var fel — det är en CSS radial-gradient.

### Font-size-fixar på kodblock (ISSUE-kategori)

Slidev/UnoCSS använder små kodfonter som default. För slide **24, 37, 47** wrap:adade jag kodblocken i en div med Tailwind arbitrary selector:

```html
<div class="mt-6 [&_pre]:!text-3xl [&_pre]:!leading-relaxed [&_pre]:!p-6">

```cpp
...kod...
```

</div>
```

Detta funkar eftersom UnoCSS stödjer `[&_pre]:!text-3xl`-syntaxen för att nå nästlade elementer. Koden blir ~40–60 px per rad i PDF-export — läsbar på 3 m projektor.

## Gotcha: UnoCSS och arbitrary values

**`w-[30rem]` renderas INTE som 30rem** i denna Slidev/UnoCSS-setup (åtminstone inte konsekvent). Jag försökte detta på slide 40 för LDR-bilden och det gav inget synligt resultat — PNG:en matchade en tidigare version bit-för-bit trots class-byte.

**Lösning:** använd inline `style="width:720px;..."` direkt. Det är vad slide 40 och 34 nu använder för kritiska dimensioner. Tailwind-klasser som `text-4xl`, `mt-8`, `gap-16`, `flex`, `items-center` etc. fungerar bra — det är bara arbitrary values `[...]` som är opålitliga för vissa properties.

`[&_pre]:!text-3xl`-tricket för kodblock fungerar däremot (det är en child selector, inte arbitrary value).

## Filstruktur

```
presentation/
├── slides.md                    ← 52 slides, 2700+ rader
├── public/images/               ← breadboard-internals.png, photoresistors-three.jpg, 
│                                  active-buzzer-sticker.jpg, pwm-waveform.png
└── styles/main.css              ← warn-box, tip-box, .end (tack-slide gradient)

kompendium/
├── chapters/
│   ├── 01-modul-1.typ           ← breadboard, Blink, GND
│   ├── 02-modul-2.typ           ← PWM, RGB
│   ├── 03-modul-3.typ           ← buzzer, if/else
│   ├── 04-modul-4.typ           ← analog sensorer, Serial Monitor
│   ├── 05-modul-5.typ           ← hackathon, larm
│   ├── appendix-d-hackathon-losning.typ
│   └── appendix-f-framspanningsfall.typ (Ohms lag, räkneexempel)
└── deliveries/
    ├── kompendium-arduino-kurs.pdf
    └── slides-arduino-kurs.pdf   ← SENASTE BYGGET (v6)

tasks/
├── plan-slides-density.md                    ← planen user godkände
├── handover-slides-density-20260414.md       ← föregående session
├── handover-slides-manual-review-20260414.md ← DETTA DOKUMENT
└── todo.md
```

## Hur man bygger om (om user ändrar något)

```bash
cd /Users/daniel/projects/arduino-kurs/presentation
npx slidev export --output ../kompendium/deliveries/slides-arduino-kurs.pdf
```

Tar ~15–30 sek. Kör från `presentation/`-dir.

## Hur man renderar PNG (för visuell audit)

```bash
rm -rf /tmp/slides-png && mkdir -p /tmp/slides-png
pdftoppm -r 100 kompendium/deliveries/slides-arduino-kurs.pdf /tmp/slides-png/slide -png
```

Ger 52 st `slide-NN.png` (2000×1125 px, 16:9). `pdftoppm` varnar om "Bad bounding box in Type 3 glyph" — det är kosmetiskt, ignorera.

## Hur man startar dev-server (för live-preview)

```bash
cd presentation && npx slidev
```

Öppnar på `http://localhost:3030`. HMR funkar bra för slide.md-ändringar.

## Regler från memory som styr arbetet

- **`feedback_code_slides_vs_compendium`**: Komplett kod hör i KOMPENDIET, inte på slides. Slides visar essens. Om du tycker någon slide saknar kod-kontext — svaret är att lägga det i kompendiet, INTE klämma in på sliden.
- **`feedback_use_sonnet_for_image_review`**: Explicit `model=sonnet` på subagents som bedömer bilder.
- **`feedback_slide_restructure_workflow`**: Parallella sonnet-agents för analys, men sekventiella Edits (slide-numrering skiftar vid splits).
- **`project_elegoo_branding_policy`**: ELEGOO får heta ELEGOO (brand-namn), men inga sid/Lesson-refs till ELEGOO-manualen i kompendiet.

## Vad user förmodligen tittar efter under manuell review

Baserat på tidigare sessioner:
1. **Läsbarhet på 3 m** — om text ser liten ut, bumpa `text-2xl` → `text-3xl` eller använd inline-style.
2. **Kontinuitet** — pinnar (knappPin=D9, tiltPin=D2, ldrPin=A0, buzzerPin=D12, ledR/G/B=6/5/3) måste matcha över alla moduler och bilaga D. Förra sessionen fixade två Modul 5-bugs (300/400 mismatch + saknad `morkTroskel`-konstant).
3. **Speaker notes** — är `<!-- ... -->` under slides och innehåller långa pedagogiska skript. Viktiga för läraren, ska inte tas bort.
4. **Typografi/emoji-regler** — denna repo har tidigare haft fixar för ligatures, emoji-rensning, syntax highlighting. Återinförda emojis eller emoticons är förmodligen oavsiktligt.
5. **Brand-namn** — ELEGOO får förekomma som komponentnamn, men inte som kursreferens.

## Om user pekar på en specifik slide att ändra

1. Kör `grep -n "^# [rubriktext]" presentation/slides.md` för att hitta raden
2. Läs ±20 rader runt för kontext (frontmatter, layout, CSS-klasser)
3. Edit targeted. Rebuild. Rendera PNG. Visuellt verifiera innan du säger "klart".
4. Om kodblock behöver större font: wrappa i `[&_pre]:!text-3xl`-div.
5. Om image/text dimension inte tar effekt: byt till inline `style=`.

## Senaste audit-rapporten

`/tmp/slide-analysis/reaudit-v5.md` — 15 PASS, 1 FAIL (slide-24 analogWrite kodblock). FAIL:en löstes sedan i v6 med samma `[&_pre]:!text-3xl`-wrapper. Ingen v6-re-audit kört — användaren tar manuell review istället.

Andra analysrapporter (per slide, från första iterationen):
`/tmp/slide-analysis/slide-{08,11,16,22,31,33,36,41,45,46}.md`

Dessa är dokumentation av resonemanget bakom varje restrukturering — kan vara värd att läsa om en specifik slide ifrågasätts.

## Snabb-referens: vilka slide-nummer blev vad

Nya slide-nummer efter ändringar (1-indexerade, matchar Slidev-export-PDF):

| # | Innehåll | Ändrat? |
|---|---|---|
| 1–7 | Intro, kursöversikt, modulkort | Oförändrad |
| **8** | Spänning, ström, GND — trekorts-grid | ✅ (split, brödtext borttagen) |
| **9** | `U = I · R` triangel + Bilaga F-ref | ✅ (NY, del av split) |
| 10–11 | (mellanslides) | Oförändrad |
| **12** | Fem hål = en nod (breadboard full-bredd) | ✅ (split + bild-storlek) |
| **13** | Kontrollera raden först | ✅ (NY, del av split) |
| 14–17 | (mellanslides) | Oförändrad |
| **18** | Din egen rytm — bullets utan kod | ✅ (two-cols borttaget) |
| 19–23 | (mellanslides) | Oförändrad |
| **24** | `analogWrite` text + kod (stort kodblock) | ✅ (split + font-size) |
| 25 | Hitta färgen (övning) | Oförändrad |
| **26** | PWM duty cycle — stor graf | ✅ (NY, del av split) |
| 27–33 | (mellanslides) | Oförändrad |
| **34** | En varning först (buzzer, större box+bild) | ✅ (layout-fix) |
| 35 | (mellanslide) | Oförändrad |
| **36** | Läs knapp. Styr buzzer — konceptbro | ✅ (split, kärntext) |
| **37** | Kärnan i `loop()` — if/else kod ensam | ✅ (NY, del av split) |
| 38–39 | (mellanslides) | Oförändrad |
| **40** | Knappen digital. Världen analog (stor LDR) | ✅ (split + stor bild) |
| **41** | `analogRead()` — Arduinons linjal | ✅ (NY, del av split) |
| 42–45 | (mellanslides) | Oförändrad |
| **46** | Hitta din tröskel — bullet-frågor | ✅ (split) |
| **47** | Koden att köra — 9-radig sketch stor | ✅ (NY, del av split) |
| 48–50 | (mellanslides) | Oförändrad |
| **51** | Pin-tilldelning — tabell istället för kod | ✅ (layout-fix) |
| **52** | Tack (större brödtext) | ✅ (font-fix) |

Fetstilta nummer = ändrade denna session. Totalt 16 slides ändrade (10 utgångspunkter → 6 splits gav +6 slides).

## TL;DR för ny session

User ska manuellt gå igenom alla 52 slides i `kompendium/deliveries/slides-arduino-kurs.pdf`. Om hen pekar ut något:
1. Öppna `presentation/slides.md`, hitta sliden via grep på rubrik eller innehåll.
2. Edit, rebuild (`cd presentation && npx slidev export --output ../kompendium/deliveries/slides-arduino-kurs.pdf`), rendera PNG, verifiera visuellt.
3. Använd inline `style=` för kritiska dimensioner, `[&_pre]:!text-Nxl` för kodblock-font, vanliga Tailwind-klasser för övrigt.
4. Komplett kod stannar i KOMPENDIET, inte på slides.

Inget klart att committa — repo har ingen git. Levereras direkt via filsystemet.
