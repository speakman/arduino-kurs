# Plan — slide-densitet 2026-04-14

Konsoliderade rekommendationer från 10 parallella sonnet-audit-agenter. Fullständiga rapporter: `/tmp/slide-analysis/slide-NN.md`. Källbilder: `/tmp/slides-png/`.

**Slidev-källa:** `presentation/slides.md` (46 slides totalt).

## Sammanfattning

| Slide | Problem | Åtgärd | Ny slide-count |
|---|---|---|---|
| 8  | 160 ord, 4 lager Ohms lag | **SPLIT** 8a + 8b | +1 |
| 11 | Oläslig bildtext, packad layout | **SPLIT** 11a + 11b | +1 |
| 16 | 20-raders kodblock i two-cols | **LAYOUT-FIX** (ta bort kod+two-cols) | 0 |
| 22 | Text+kod+graf trängs | **SPLIT** 22a + 22b | +1 |
| 31 | Bild för liten, oläslig bildtext | **LAYOUT-FIX** (ta bort grid-cols-2, större bild) | 0 |
| 33 | Vänster-kolumn overload | **SPLIT** 33-A + 33-B | +1 |
| 36 | 3 koncept i two-cols | **SPLIT** 36A + 36B | +1 |
| 41 | Kodblock krympt i two-cols | **SPLIT** 41a + 41b | +1 |
| 45 | Dubbla kodblock redundanta | **LAYOUT-FIX** (ersätt med pin-tabell) | 0 |
| 46 | För liten text + låg opacity | **LAYOUT-FIX** (font/opacity) | 0 |

**Totalt:** 6 splits → 46 slides blir **52 slides**.

**Genomgående princip:** Ingenting nytt läggs till. Text/kod som redan finns i kompendiet tas bort från slides. Kvarvarande essens får mer luft + större font.

---

## Slide 8 — Spänning/ström/GND → SPLIT

**Diagnos:** ~160 ord på en slide (trekorts-grid + Ohms lag i 4 lager). Allt finns i Bilaga F + 01-modul-1.typ.

**Åtgärd:**
- **8a "Spänning, ström, GND"**: behåll korts-grid men ta bort brödtext i korten — bara ikon + etikett + enhet. ~15 synliga ord.
- **8b "Ohms lag" (ny)**: SVG-triangel + `U = I·R` stor + hänvisning "Se Bilaga F".
- Flytta till speaker notes: LED-räkneexempel, U/I-historik.

---

## Slide 11 — Breadboard → SPLIT

**Diagnos:** Rubrik + 4 bullets + tip-box + bild + 3-raders bildtext packade ihop. Bildtexten är oläslig och duplicerar kompendiet.

**Åtgärd:**
- **11a "Fem hål = en nod"**: rubrik + 4 bullets + stor breadboard-bild **utan bildtext under**.
- **11b "Kontrollera raden först" (ny)**: tip-boxen "90 % av nybörjarfel är ett hål fel" som ensamt budskap, stor font.

---

## Slide 16 — Din egen rytm → LAYOUT-FIX (ingen split)

**Diagnos:** 20-raders SOS-sketch i höger-kolumn är oläslig och redan i kompendiet (Hemma-övning 2-3).

**Åtgärd:**
- Ta bort `two-cols`-layouten helt.
- Ta bort hela kodblocket (20 rader).
- Behåll: rubrik + "Ändra Blink till ett mönster du själv väljer" + 3 bullets (SOS/tempo/hjärtslag).
- Flytta `const int`-tipset till speaker notes.

---

## Slide 22 — analogWrite → SPLIT

**Diagnos:** Text + kod + PWM-graf i two-cols → allt krymps till oläslighet.

**Åtgärd:**
- **22a "analogWrite"**: `layout: default`, full bredd. Rubrik + 2 meningar brödtext + 3-rads kodblock (essensen). Ta bort grafen.
- **22b "PWM — duty cycle" (ny)**: stor graf (≥70 % av ytan) + 3 bullets (0/128/255). Ingen kod här.
- ~-pinnar-noten → speaker notes.

---

## Slide 31 — Buzzer-varning → LAYOUT-FIX (ingen split)

**Diagnos:** Bilden är för liten (`max-h-80` i grid-cols-2) och bildtexten under är `text-xs` → oläslig.

**Åtgärd:**
- Ta bort `grid-cols-2`, använd flex med större bild (`max-h-96`).
- Ta bort bildtexten "Active buzzer · sticker stannar" (redundant mot warn-boxen).
- Behåll rubrik + warn-box + humor-meningen.

---

## Slide 33 — Knapp styr buzzer → SPLIT

**Diagnos:** Vänster-kolumnens 4 `text-sm`-punkter är oläsliga och är ren referenslista. Koden i höger-kolumn är OK essens (6 rader if/else).

**Åtgärd:**
- **33-A "Sätt ihop allt" (ny)**: rubrik + en mening + INPUT → if/else → OUTPUT (stor text). Referenslistan flyttas till speaker notes.
- **33-B "Kärnan i loop()"**: if/else-kodblocket ensamt, centrerat, stort.
- Tip-box "Full sketch" tas bort (kompendiet har den).

---

## Slide 36 — Digital→analog → SPLIT

**Diagnos:** Tre koncept (digital/analog-kontrast, fotocell-spec, tilt-intro) trängs i two-cols.

**Åtgärd:**
- **36A "Knappen var digital. Världen är analog."**: rubrik + 2 stora rader kontrast + fotocell-bild. **Ingen spec-data (50 kΩ/500 Ω), ingen tilt.**
- **36B "analogRead() — Arduinons linjal" (ny)**: ensam kodrad `int ljus = analogRead(A0);` + "bygg detta nu"-CTA.
- Tilt-sensor-intro → speaker notes (eller egen slide senare om behov).
- Spec-data finns i kompendiet § "Analog vs digital".

---

## Slide 41 — Hitta din tröskel → SPLIT

**Diagnos:** Kodblocket (7 rader) krymps i `two-cols-header`. Tip-box med "300? 400? 500?" är redundant (finns i kompendiet § Typiska A0-värden).

**Åtgärd:**
- **41a "Hitta din tröskel"**: `layout: default`, 3 bullet-frågor + "printa båda till Serial". Tip-box till speaker notes.
- **41b "Koden att köra" (ny)**: kodblocket i full bredd + fotnot "Full sketch i kompendiet kap 4".

---

## Slide 45 — Pin-tilldelning hackathon → LAYOUT-FIX (ingen split)

**Diagnos:** Dubbla kompletta kodblock (pin-konstanter + setup/loop) är båda i Bilaga D. Ren duplicering, oläslig i two-cols.

**Åtgärd:**
- Ta bort `two-cols` + båda kodblocken.
- Ersätt med **pin-tabell** (variabel | pin | modul) + enda raden `bool larmPaslaget = false;` + "→ Komplett startmall: Bilaga D".
- `loop()`-pseudokod → speaker notes.

---

## Slide 46 — Tack-slide → LAYOUT-FIX (ingen split)

**Diagnos:** Ingen pixlad bild (audit-citatet var fel — det är en CSS radial-gradient). Problemet är `text-sm opacity-50/60` på ingress och footer.

**Åtgärd:**
- `text-sm opacity-60` → `text-base opacity-75` (ingress)
- `text-xl opacity-80` → `text-2xl opacity-90` (brödtext)
- `text-sm opacity-50` → `text-base opacity-70` (footer)
- Rubriken `text-8xl` behålls som den är.

---

## Implementationsordning (vid godkännande)

Sekventiell pga slide-numrering skiftar vid splits. Börja BAKIFRÅN så numreringen framåt inte påverkas:

1. Slide 46 (fix)
2. Slide 45 (fix)
3. Slide 41 (split → 41a/41b)
4. Slide 36 (split → 36A/36B)
5. Slide 33 (split → 33-A/33-B)
6. Slide 31 (fix)
7. Slide 22 (split → 22a/22b)
8. Slide 16 (fix)
9. Slide 11 (split → 11a/11b)
10. Slide 8 (split → 8a/8b)

Efter alla ändringar: rebuild PDF + sonnet-re-audit av samma 10 slide-positioner (som då är 16 olika positioner i ny numrering).

## Verifiering

```bash
cd presentation && npx slidev export --output ../kompendium/deliveries/slides-arduino-kurs.pdf
rm -rf /tmp/slides-png && mkdir -p /tmp/slides-png
pdftoppm -r 100 kompendium/deliveries/slides-arduino-kurs.pdf /tmp/slides-png/slide -png
```

Sonnet-re-audit per ändrad slide.
