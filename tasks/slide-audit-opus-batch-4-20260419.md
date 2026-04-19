# Opus-audit batch 4 — slides 27-34

**Granskare:** Opus max effort, 2026-04-19
**Scope:** rendered PNG slide 27-34 (`/tmp/slide-audit/slide-27..34.png`).
**Källkarta (PNG-nummer → slides.md-rader):**

| PNG | Rubrik | Rader i `slides.md` |
|---:|---|---|
| 27 | Träff 3 av 5 — Digital input | 1437-1461 |
| 28 | `const int` och `int`. | 1462-1530 |
| 29 | Input ≠ Output. | 1531-1588 |
| 30 | `if` / `else`. | 1589-1654 |
| 31 | Koppla knappen. (WiringSlide) | 1655-1684 |
| 32 | Reagera på flanken. | 1685-1758 |
| 33 | En varning först. (buzzer-sticker) | 1759-1842 |
| 34 | Koppla buzzern. (WiringSlide) | 1843-1868 |

---

## 🔴 Kritiska fel

### Slide 31 — "Koppla knappen." (WiringSlide)
- **Problem:** Bilden motsäger slide-texten. Presentationen säger *"Vi använder bara knapp A → D9 · andra benet till GND. Ingen pulldown-resistor — INPUT_PULLUP sköter det internt"*, men Fritzing-illustrationen (`button-fritzing.png`) visar:
  1. **Två tactile switches** (knapp A och knapp B) kopplade parallellt.
  2. En **extern röd LED + resistor** uppe till vänster på breadboard, med svart GND-tråd.
  3. **Fyra kablar till Arduino** — svart (GND), blå (~pin 10), gul (pin 9), röd (pin 6 eller 7).
  4. En resistor mellan knapp-raderna och LED-raden som sitter i en klassisk pull-down-/LED-krets-topologi.
  Så sliden kommunicerar motsägande: texten säger "enkel krets, en knapp, ingen resistor, inbyggd LED"; bilden visar "komplex krets, två knappar, extra resistor, extern LED".
- **Bevis:**
  - `slides.md:1663-1664` — caption: `Vi använder bara <span class="mono cyan">knapp A → D9</span> · andra benet till GND. Ingen pulldown-resistor — <span class="mono cyan">INPUT_PULLUP</span> sköter det internt.`
  - `slides.md:1668-1674` — presenter notes erkänner problemet öppet: `OBS: källbilden visar en tvåknapps-variant med extern LED. Vi förenklar i kursen: Bara EN knapp (knapp A, som sitter på D9 i kursens exempel). Vi använder Arduinons inbyggda LED på pin 13 som output — slipper koppla en egen.`
  - Kompendiet `03-modul-3.typ:78-82` använder samma bild (`elegoo-057-073.png`) med en tydligare bildtext: `Knappkretsen på breadboard — två tactile switches och en LED som output. I kursen använder vi bara en knapp (A → D9) och Arduinons inbyggda LED på pin 13.` — kompendiet förbehåller sig åtminstone rätten att förklara diskrepansen; sliden gör det inte.
  - Detta är exakt samma typ av bugg som slide 14 (LED från 5V istället för pin 13) som nämndes i briefen.
- **Föreslagen fix:** Tre alternativ, i fallande ordning:
  1. Byt ut Fritzing-bilden mot en ren **en-knapp**-variant (2 kablar: D9 + GND, inga extra komponenter). Detta är det korrekta långsiktiga draget. Gör en egen Fritzing eller rita om som SVG (jfr den nyligen SVG:ade voltage-divider på slide 41).
  2. Behåll bilden men uppdatera caption till att erkänna skillnaden: `Bilden visar kittets standardkrets (två knappar, extern LED). Vi använder bara <strong>knapp A → D9</strong> och Arduinons inbyggda LED på pin 13.`
  3. Beskär bilden så att bara knapp A + den gula kabeln + GND-kabeln syns.

---

## ⚠️ Inkonsekvenser / kontinuitetsbrott

### Slide 32 — "Reagera på flanken." (loop-hastighet)
- **Problem:** Slide-texten säger *"En knapp som hålls nere skulle toggla 50 gånger per sekund"*, men presenter notes för samma slide säger *"Arduinon kör loopen 10 000 gånger i sekunden"*. Kompendiet (`03-modul-3.typ:115`) säger *"hundratals loop-varv"*. Tre olika tal för samma fenomen.
- **Bevis:**
  - `slides.md:1700` — slide body: `skulle toggla 50 gånger per sekund`
  - `slides.md:1741-1742` — notes: `Arduinon kör loopen 10 000 gånger i sekunden. Så länge ni håller knappen nere togglar den 10 000 gånger`
  - `kompendium/03-modul-3.typ:115` — kompendium: `hundratals loop-varv`
  - Dessutom: slide-exemplets kod innehåller `delay(10)` som klämmer loophastigheten till ~100 Hz — så även siffran 50 är fel för den kod som visas på sliden.
- **Föreslagen fix:** Korrigera notes + slide till samma tal. Pedagogiskt ärligt värde: utan `delay(10)` kör Arduino-loopen i storleksordningen tiotusentals varv/sekund (beroende på innehåll); med `delay(10)` blir det ~100 Hz. Säg t.ex. *"skulle toggla tusentals gånger per sekund"* på sliden och matcha notes. Eller bättre: håll pedagogiken abstrakt ("hundratals gånger i sekunden") och lämna exakta siffror till notes.

### Slide 30 — `if` / `else`: `LED_BUILTIN` är orphan-symbol
- **Problem:** Kodsampel på sliden använder `LED_BUILTIN` utan att ordet någonsin förklarats student-synligt i tidigare slides. `LED_BUILTIN` dyker upp för första gången just här.
- **Bevis:**
  - `grep LED_BUILTIN`: första student-synliga förekomst är `slides.md:1618` (på denna slide). Tidigare förekomst på `slides.md:964` ligger i presenter-notes för modul 1 och når aldrig eleverna.
  - Presenter notes för denna slide (`1650-1652`) erkänner: `Peka på att LED_BUILTIN är Arduinons eget namn på pin 13. … vi såg det i Modul 1.` — notes *tror* att det visats tidigare, men det har det inte på sliden.
- **Föreslagen fix:** Lägg till en en-radig fotnot i sliden: `<div class="text-xs opacity-55 italic mt-2"><span class="mono">LED_BUILTIN</span> = Arduinons eget namn på pin 13 (inbyggd LED).</div>` eller byt `LED_BUILTIN` mot `ledPin` som redan är student-bekant. Sistnämnda är minst risk.

### Slide 27 — sektionsslide saknar teaser-rad om Modul 3:s output-komponent
- **Problem:** Slide 26 (källslide 27, strax innan detta batch — se `slides.md:1413-1414`) lovar *"Nästa gång: vi lyssnar. Knapp + buzzer."* — dvs två komponenter. Sektionssliden (PNG 27) listar `Knapp, buzzer, logik` vilket matchar. Men sliden känns visuellt tom — kontinuiteten är OK men utnyttjas inte.
- **Bevis:**
  - `slides.md:1413` teaser, `slides.md:1449` sektion-bullet.
  - Konsoliderad audit flaggade redan återkommande tomt-utrymme-mönster för sektions-slides.
- **Föreslagen fix:** Inte kritiskt. Om polish: lägg till en liten ikon-rad (knapp + buzzer) under underrubriken, matcha mönster från Modul 2:s sektions-slide.

---

## 💡 Polish-förslag

### Slide 28 — `const int` och `int`
- Stavfel/Swenglish: `larmPaslaget` saknar `å` på `Påslaget`. Konsolidation flaggade redan detta; gäller hela dokumentet (förekommer också på slide 32 rad 1714, 1721 och senare på slide 51-ish). Välj mellan att godkänna Swenglish eller rename till `larmArmed`/`larmOn`. Enhetlighet > korrekthet här.
- Höger kolumn har mycket tomrum — endast 3 kodrader. Kunde balansera med en liten visuell metafor eller exempel, men inte kritiskt.

### Slide 29 — Input ≠ Output
- Tip-box-texten innehåller `GND (LOW)` utan röd färg på `GND`. Konsoliderad audit flaggade redan att `GND` i bildtext ibland saknar den röda varnings-/GND-färgen på slides 31 och 34; inkonsekvensen gäller även här.
- `flyter` (kursiv) är informell — bra pedagogiskt men kompendiet använder också det, så OK.

### Slide 30 — `if` / `else`
- Operator-raden `Operatorerna: == lika, != olika, < mindre, > större.` – mellanrummet mellan mono-chips och kommatecken ser lite kompakt ut på den renderade bilden. Polish, inte bugg.

### Slide 31 — Koppla knappen (utöver det kritiska ovan)
- Arduino-brädan i Fritzing-bilden sticker ut nedanför den vita bakgrundsrutan (samma layout-polish-bugg som konsoliderad audit flaggade för slide 34).
- Caption-raden använder `<span class="mono cyan">` — jämför mot slide 34 som har `<span class="warn">+</span>` för plussymbol. Färg-policyn för `+`-symbol kontra pin-referens är inkonsekvent mellan wiring-slides.

### Slide 32 — Reagera på flanken
- Rubriken "Reagera på flanken." bryter mönstret. Övriga Modul 3-slides har monospace-chips i rubriken (`const int` och `int.`, `if` / `else.`). Denna är bara ren sans. Inte ett fel, men en visuell rytmbrytare mitt i modulen.
- Tip-box-rubriken `MÖNSTRET` är ensamt ord som uppercase-sticker. Kompendium-stilen använder istället `Mönstret`. Globalt konsekvensbeslut.

### Slide 33 — En varning först
- Den röda fraseologin (*era öron kommer att blöda och jag kastar ut er*) är en avvägning mellan humor och professionalism. Konsoliderad audit flaggade inte det men en senior-instruktör kan tycka det är för starkt. Bevara om det matchar kursens ton — bara notera.
- Bildens `max-h-[32rem]` tillsammans med ring-2-klass ger en kraftig rosa-ring runt buzzer-foto; ringen är estetiskt OK men kolliderar lite med `warn-box`:ens lilla gula border ovanför. Mikropolish.

### Slide 34 — Koppla buzzern (verifierad korrekt)
- Fritzing-bilden granskad i hires. Kabel-routingen är **korrekt**: svart (kort ben) → GND, röd (långt ben / +) → pin 12. Caption-claimen *"Långt ben (+) → D12 · kort ben → GND"* matchar helt.
- Enda småsak: texten `Rakt in i Arduino-headerna` — `headerna` är korrekt svenska, men hela kursen växlar mellan `header`, `headers` och `headerna`. Inkonsekvens-städning (ej blockerande).

---

## ✅ Bekräftat OK

- **Slide 27**: Sektionstitel `Digital input / Modul 3: Knapp, buzzer, logik` matchar Modul 3 i kompendiet (`03-modul-3.typ:7-11`). Ingen faktafelaktighet.
- **Slide 28**: `const int knappPin = 9` matchar kompendiets `03-modul-3.typ:41,166` — pin 9 för knappen är konsekvent.
- **Slide 29**: Pullup-förklaring matchar kompendiet (`03-modul-3.typ:59-76`). Inverterad logik (`tryckt = LOW`) korrekt återgiven.
- **Slide 30**: Operatorer `==`, `!=`, `<`, `>` matchar kompendiets `quickref` (`03-modul-3.typ:102-109`). `if`/`else` exempel-kod är syntaktiskt korrekt och kompilerar.
- **Slide 32 kod**: Edge-detection-mönstret är identiskt med kompendiets referenskod (`03-modul-3.typ:119-133`), inklusive `delay(10)` och `!larmPaslaget`.
- **Slide 33**: Instruktionen *"Dra absolut inte av klisterlappen"* och texten `"REMOVE SEAL AFTER WASHING"` matchar den faktiska stickern på active-buzzer-sticker.jpg. Ingen ELEGOO-manualreferens, ingen "Lesson N"-hänvisning.
- **Slide 34 (buzzer-wiring)**: *Verifierat i hires-crop* — röd kabel → pin 12, svart kabel → GND. Caption matchar bild. Detta är *inte* en slide-14-typ-bugg.
- **Förbjudet språk**: Ingen förekomst av `superkraft`, `magi`, `hjärna`, `sinne`, `sinnesorgan`, `röntgen` i slides 27-34 (varken i synligt innehåll eller `<!-- -->` notes). Tidigare rensning verifierad.
- **Förbjudna referenser**: Inga "Lesson N"-, "sid N"- eller ELEGOO-manualsidhänvisningar i batchen.
- **Kontinuitet bakåt**: `const int` bygger på Modul 1. Pin-nummer matchar. PWM-diskussionen om pin 9 i notes (1520-1523) är väl motiverad.
- **Kontinuitet framåt**: Slide 33/34 sätter upp Modul 4 (analogRead, Serial Monitor) via teaser-noten på slide 34 (notes rad 1839-1840).

---

## Prioritering

1. **🔴 Slide 31 — byt eller re-annotera Fritzing-bilden** — detta är den enda kritiska buggen i batchen och matchar slide-14-mönstret som briefen ville hitta.
2. **⚠️ Slide 32 — harmonisera loop-hastighetstalet** (50 / 100 / 10 000 / "hundratals") mellan slide-text, presenter notes och kompendium.
3. **⚠️ Slide 30 — lägg till en rad som förklarar `LED_BUILTIN`** eller byt till `ledPin`.
4. **💡 Polish-ronden** — `larmPaslaget` →`larmPåslaget`/`larmArmed`, GND-färgkonsekvens, Arduino-USB-overflow.
