# Grundmaterial-uppdatering — genomförd 2026-04-18

Källa: `tasks/forslag-grundmaterial-slutgiltig-20260418.md` (min Opus 4.7-granskning efter dag 1).

## Scope

Användaren sa: "Alla deltagare har fått varsitt ELEGOO Arduino Basic Starter Kit. Fixa nu *allt* som behöver fixas!"

Plus två mid-flight-justeringar:
1. *Inga referenser till Elegoo-manualen* — kompendiet ska ersätta den.
2. Använd extraherade PDF-bilder i `research/elegoo-pdf-images/` (redan curat urval i `kompendium/images/`).

## Genomförda fixar

### Kompendium

**Modul 1 (LED & krets)**
- 15 mA-motivering tillagd i "Varför 220 Ω?" (C.3)
- LED_BUILTIN-förklaring i brödtexten under `digitalWrite`/`pinMode` (C.4)
- Upload-felsökning som `#tip`-box (C.5)
- Övning 2½ "Mamma-igenkänning" som bro från övning 2 till morse (C.2)
- Sense-act-föraviserring i "Inför nästa träff" (B.3)
- "Elegoo skeppar" → "kittet innehåller" (ton-rensning)
- "Elegoo-kitet" → "kitet" i avsked-raden

**Modul 2 (PWM & RGB)**
- `#fact`-box "Tänk skärm, inte färgburk" — additiv vs subtraktiv (D.1.2)
- `for`-loop anatomi bruten ut i tre delar med semikolon-förklaring (D.1.1)
- RGB-bildtext harmoniserad: "röd · katod · grön · blå från platta sidan" (A.5)
- Sense-act-föraviserring i "Inför nästa träff" (B.3)
- "Elegoos kit" → "kittet" (felrutan)
- "Elegoo-kitet" → "kitet"

**Modul 3 (Digital input)**
- "I kittet finns två buzzrar" → korrekt: active buzzer är den enda, passive beskrivs bara som jämförelse (A.2)
- `#tip`-box "Översättningsregel" för INPUT_PULLUP (D.2.1)
- "Fallande flanken"-term introducerad efter kodblocket (D.2.2)
- "Elegoo-kitet" → "kitet"

**Modul 4 (Analog input)**
- `#fact`-box "Varför just 1 kΩ?" (D.3.1)
- Ny sektion "Skala om värden med `map()`" i brödtexten (B.8)
- Ball-tilt-switch-terminologi nämnd två gånger (D.3.2)
- Sense-katalog-avslutning i "Vad du lärde dig idag" (B.3)
- "Elegoo-kitet" → "kitet"

**Modul 5 (Hackathon)**
- Inkrementell byggprocess i tre steg ersätter färdig lösning (D.4.1)
  - Steg 1 — knappen togglar larm-läget (edge-detection)
  - Steg 2 — tilt-sensor + buzzer
  - Steg 3 — fotocell + stämningsljus
- Hackathon-tidsram (2 h med paus, 60–80 min för grunden) (D.4.2)
- Gamla "Ordna koden i block" stramad — den fulla lösningen flyttad helt till Bilaga D
- "Skelettet finns i slidesen" bort, pekar nu på Bilaga D (F.4)

**Bilaga A (syntax-grammatik)**
- Ny sektion "Användbara Arduino-funktioner" med `map()`, `constrain()`, `millis()` (B.8)

**Bilaga C (komponentreferens)**
- "Det ni inte använder i kursen"-listan helt omskriven (A.1)
  - Tog bort: passive buzzer, LCD, DHT11, IR, servomotor, potentiometer, piezo
  - Behöll: 74HC595 (faktiskt i Basic-kittet)
  - Ny avslutning "Vill du ha fler komponenter?" pekar mot utökningskit/lösa komponenter
- "Elegoo skeppar" → "kittet innehåller"
- "Elegoo-kittet" → "kittet" i färgkod-raden

**Bilaga E (säkerhet)**
- Klisterlapp-trippel-nämning borttagen — stannar i Modul 3 + Bilaga C (E.5)

**Bilaga F (Ohms lag & framspänningsfall)**
- U/I-historik-sektionen kortad från sex rader till tre (E.6)

### Slides (`presentation/slides.md`)

- **CH340-varning** i "Mikrokontrollern"-talarnot borttagen (A.3) — ELEGOO använder äkta ATmega16U2, ingen drivrutin-fråga
- **Agenda-sliden** "Idag — två timmar" utökad med explicit paus-block 01:05–01:10 (C.1)
- **Röd/grön-lapp intro** som `tip-box` i slide "Din egen rytm" (B.2)
- **Tröskel 400 → 300** harmoniserad i alla talarnotiser och text (B.6)
- **"Appendix A" → "Bilaga A"** global harmonisering (B.4)
- **"kapitel 2" → "Modul 2"** i en talarnot (B.4)
- **Alla "manualen"-referenser borttagna** (10+ ställen):
  - "REFERENS: kittets manual" × 3 → borttagna eller ersatta
  - "sid 42 / sid 45 / sid 60 / sid 80"-referenser borttagna
  - "Modul X i manualen" → "kompendiet Modul X"
  - "startkit-manualen" borttaget
  - "enligt manualen" → "enligt kompendiets Modul X"

## Filer ändrade

| Fil | Ändringar |
|---|---|
| `kompendium/01-modul-1.typ` | 5 sektioner |
| `kompendium/02-modul-2.typ` | 5 sektioner |
| `kompendium/03-modul-3.typ` | 4 sektioner |
| `kompendium/04-modul-4.typ` | 5 sektioner |
| `kompendium/05-modul-5.typ` | 3 strukturella omskrivningar |
| `kompendium/appendix-a-syntax.typ` | 1 ny sektion |
| `kompendium/appendix-c-komponenter.typ` | 2 sektioner (stor omskrivning) |
| `kompendium/appendix-e-sakerhet.typ` | 1 borttagen sektion |
| `kompendium/appendix-f-framspanningsfall.typ` | 1 kortad sektion |
| `presentation/slides.md` | 15+ punktfixar |

## Verifiering

- **Kompendium-PDF bygger rent** — `kompendium.pdf` 16 MB, alla 6 separata PDF:er också (`modul-1`...`bilagor-a-f`).
- **Slidev bygger rent** — `npm run build` OK, 5.99s.
- **Slidev exporterar PDF rent** — `/tmp/slides-verified.pdf` 10 MB.
- **Visuell stickprovskontroll godkänd** via pdftoppm:
  - Slide "Idag — två timmar" (paus-rad cyan-markerad ✅)
  - Slide "Din egen rytm" (röd/grön-lapp-tipbox ✅)
  - Modul 1 sid 5 (15 mA-motivering + LED_BUILTIN-text ✅)
  - Modul 4 sid 4 ("Varför just 1 kΩ?" + map()-sektion ✅)
  - Modul 5 sid 4 (Steg 2 + Steg 3 inkrementella kodblock ✅)
  - Bilaga C sid 23 ("Vill du ha fler komponenter?" ✅)

## Vad som medvetet inte är gjort

| # | Förslag | Skäl |
|---|---|---|
| 19 | Modul ↔ Elegoo-Lesson-mappning | Användaren: "Inga referenser till Elegoo-manualen" |
| 24 | Du/ni-konsistens över hela kompendiet | Separat tonfalls-pass, ~30 min subjektivt arbete |
| — | ~~"Fem superkrafter"-metafor byggd ut visuellt~~ | Missförstått av mig — ordet är FÖRBJUDET i materialet (handover.md rad 493). Rätt åtgärd: strip, inte build. Borttaget från slide 2332 och README.md i efterhand. |
| 30 | Testpilot-läsning | Kräver en person — användarens åtgärd |

## Rapporter (kan arkiveras)

- `forslag-grundmaterial-20260418.md` — första pass, förstadium
- `forslag-grundmaterial-slutgiltig-20260418.md` — slutgiltig granskning (arbetsdokumentet)
- `fas3-review-20260414.md` — tidigare Slidev-idiomatisk-review (separat arbete)

---

# Pending TODO — diskuteras i ny session

## Spänningsfall-pedagogik: "långt motstånd + potentiometer-demo" som broa till spänningsdelaren

**Idé** (2026-05-05): Spänningsdelar-konceptet kan landa hårdare om vi först bygger intuitionen via en konkret "långt motstånd"-metafor och en fysisk vridpotentiometer.

### Konceptet

1. **Tänk dig ett lååångt motstånd.** Materialet i motståndet är jämnt fördelat. Det betyder att resistansen per cm är samma längs hela motståndet.
2. **Spänningen sjunker linjärt** över motståndet: +5 V i ena änden, 0 V i andra änden.
3. **Vid mitten är spänningen +2,5 V.** För att i mitten har bara halva motståndet "ätit upp" halva spänningen.
4. **Två lika motstånd i serie "delar" på bördan** — varje motstånd ser samma ström (i serie) och äter en lika stor spänningsandel. Detta är samma fenomen som ett lååångt motstånd, bara delat i två delar.
5. **Potentiometer-demonstrationen.** En vridpotentiometer ÄR ett långt motstånd med en glidande mätpunkt. Vrider du ratten flyttar du A0 längs det "långa motståndet". Konkret hands-on demo: koppla en pot mellan +5V och GND, mät A0 mitten, vrid och se A0 ändras 0–1023 jämnt.

### Pedagogisk värde

Detta bygger broa MELLAN:
- **Ohms lag** (Modul 1, slide 8) — som handlar om en resistor.
- **Spänningsdelaren** (Modul 4, slide 41) — som handlar om TVÅ resistorer i serie.

Idag är det ett kvanthopp mellan dem: i Modul 1 är resistorn en "strypventil" (vatten-metafor), i Modul 4 plötsligt två i serie med en mätpunkt mitt emellan. "Lååångt motstånd"-tanken kan göra övergången naturligare.

### Var det skulle kunna passa in

Ej beslutat — ska diskuteras i ny session. Kandidater:

1. **Slut på Modul 1 / början på Modul 4** — som direkt brygga.
2. **Bilaga F (Ohms lag & spänningsdelare)** — som introduktion innan formeln presenteras.
3. **En egen mini-modul "Före spänningsdelaren"** — med en eller två slides + en hands-on demo med vridpotentiometer.
4. **Inom slide 41 (Spänningsdelaren) som intro-clip** — en visuell sequence: lååångt motstånd → bröts i två → spänningsdelare.

### Om vridpotentiometern

Per nuvarande Bilaga C: potentiometern är medvetet UTANFÖR kursens scope ("det ni inte använder i kursen"). Men för EN demo skulle det funka — det räcker att läraren har en pot tillgänglig att visa upp + koppla in på Arduinon vid demo.

ELEGOO Basic Kit innehåller faktiskt en 10 kΩ-potentiometer. Den är medvetet exkluderad från kursinnehållet men finns att tillgå.

### Action items när vi tar upp detta

- [ ] Bestäm om vridpotentiometer-demo ska tilläggas (kräver att vi tar in pot i kursen — eller bara visning från läraren?)
- [ ] Skiss på var pedagogiskt brott naturligt sker (Modul 1 slut? Modul 4 start? Bilaga F?)
- [ ] Skissa illustration: lååångt motstånd med spänning-skala längs sidan + "tappar" vid 25%, 50%, 75%
- [ ] Bedöm om det förlänger kursen för mycket eller om det ersätter befintligt material
- [ ] Eventuellt en ny slide med "Två modeller av samma sak" — ett långt motstånd vs två i serie sida vid sida
