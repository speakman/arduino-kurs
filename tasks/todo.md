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
