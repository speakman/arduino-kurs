---
name: Arduino-kurs presentation — handover
description: Komplett handover för att fortsätta arbetet i en ny session efter /clear
type: handover
date: 2026-04-13
last_updated: 2026-04-13 (kväll — efter träff 1 expansion + kvalitetsgranskning)
---

# Handover: Arduino-kurs presentation

Detta dokument är avsett att läsas som FÖRSTA steget i en ny Claude Code-session
(efter `/clear`). Det innehåller all kontext som behövs för att fortsätta arbetet
utan att behöva gå igenom tidigare konversation.

> **Läs också:** `tasks/design.md`, `tasks/open-questions.md`, `research/elegoo-kit.md`.
> Manualen finns lokalt: `research/elegoo-basic-kit-tutorial-v1.0.19.7.24.pdf`.

## 🚦 Snabb entry-notis (2026-04-13 kväll)

**Sedan förra handover:**
- Träff 1 expanderad från 5 → 13 slides, verifierad via 4 parallella Opus-
  expertreviews (pedagogik, visuell, svensk-språk, teknisk fakta) plus live
  browser-verifiering via Chrome MCP.
- **Träff 1 är LEVERERAD och använd i första kursträffen idag 2026-04-13.**
- PDF-backup: `~/projects/arduino-kurs/presentation/presentation-backup.pdf`
- Live kommando: `cd ~/projects/arduino-kurs/presentation && npm run dev`
  → projektor: `http://localhost:3030/` · presenter: `.../presenter/`

**Nästa sessions uppgift:**
1. Fråga användaren hur träff 1 gick — eventuell feedback påverkar träff 2-5.
2. Expandera träff 2 (PWM & RGB) till 13 slides enligt mallen från träff 1.
3. Replikera sedan för träff 3, 4, 5.

**LÄS FÖRE DU RÖR KOD:** Sektion 7b "Träff 1 — lessons learned" innehåller
16+ specifika Slidev/CSS-fallgropar som redan är lösta. Hoppa inte över den.

---

---

## 1. Projektet i ett nötskal

En Slidev-baserad presentation för en **5-träffars nybörjarkurs i Arduino &
elektronik** som hålls av **FRO Ånge** (Frivilliga Radioorganisationen) i
**FRO-lokalen**, start **13 april 2026**.

Varje deltagare får en **ELEGOO UNO Project Basic Starter Kit**. Målgruppen är
**vuxna radioamatörer/teknikintresserade** — inte barn, inte kompletta nybörjare
på grundkoncept som spänning och ström, men nybörjare på mikrokontrollers/kod.

**Projektmapp:** `/Users/daniel/projects/arduino-kurs/`
**Source of truth för innehållet:** `presentation/slides.md`

---

## 2. PEDAGOGISK VISION (den allra viktigaste delen)

Detta är det pedagogiska ramverket som ALL vidare utveckling ska följa.
Användaren har varit tydlig med detta och det är icke-förhandlingsbart:

### 2.1 Vuxen ton
- **Inget "barn-språk"**. Använd inte ord som *magi*, *superkrafter*, *hjärnan*,
  *röntgen-glasögon*, *sinnen*, *KÄNSEL* (som tidigare utkast hade).
- Respektera att publiken är tekniskt intresserade vuxna.
- Använd **riktiga termer** och **förklara dem först** innan du använder dem.
  Exempel: innan du kastar ut "PWM", förklara vad pulsbreddsmodulering är och
  varför det är lösningen på "hur man får en lysdiod att lysa halvt ljust".

### 2.2 Varje träff måste sluta med ett TANGIBLT delresultat
Detta är kärnprincipen. Inte: "vi tar ett litet steg mot det slutliga larmet".
Istället: **"varje träff är en komplett mini-genomgång som avslutas med något
deltagarna kan se, höra eller röra vid"**. Delresultatet ska vara en stolthets-
trigger — "kolla vad jag just byggde!".

### 2.3 Pedagogisk logik per träff
Varje träff följer samma struktur:

1. **Kort recap** från föregående träff (1-2 slides)
2. **Idag:** introducera dagens tema (1 slide)
3. **Teori/koncept** — förklara EN NY sak tydligt, på djupet (2-4 slides)
4. **Komponenten/komponenterna** — fysiska föremålen framför dem (1-2 slides)
5. **Guidad bygg + kod** — lärare visar, deltagare gör parallellt (flera slides)
6. **Delresultat-demo** — alla visar upp sin fungerande grej (1 slide)
7. **Cliffhanger** mot nästa träff (1 slide)

Det innebär ~10-12 slides per träff, **inte 3-4**.

### 2.4 Bygg från enkelt till komplext
- Introducera EN ny sak per träff. Inte tre.
- Repetera föregående träffs koncept när det dyker upp igen.
- Inga kod-hopp. Om vi lade till `pinMode` i träff 1 ska den ligga kvar i
  kod-exempel i träff 2 och framåt så studenten känner igen sig.

---

## 3. Modulstruktur med delresultat per träff

Detta är den godkända strukturen. Modulnamnen är **tekniskt beskrivande**,
inte lekfulla.

### TRÄFF 1 — Modul 1: LED & krets
**Tema:** Digital output, Ohms lag, LED-polaritet, resistor som strypventil.

**Nytt koncept:** Arduino som ett digital-output-verktyg. Spänning, ström, resistor.

**Komponenter introducerade:** Arduino UNO R3, breadboard, LED, resistor, M-M jumper wires.

**Kopplingar (Elegoo Lesson 3, sid 37-43):** Pin 13 → LED anod → 220Ω → GND.

**DELRESULTAT:**
> "Jag har en lysdiod som blinkar i en takt jag själv bestämmer. Jag kan ändra
> `delay()` och ladda upp igen — och den blinkar annorlunda. Jag har skrivit
> min första rad kod som påverkar fysiska världen."

**Praktiskt moment:** Modifiera `Blink`-exemplet till en egen rytm (t.ex. SOS
i morse: · · · — — — · · ·). Varje deltagare visar upp sitt eget mönster.

### TRÄFF 2 — Modul 2: PWM & RGB
**Tema:** Pulsbreddsmodulering (förklaras), `analogWrite()`, common cathode-RGB,
färgblandning.

**Nytt koncept:** Att inte bara kunna styra PÅ/AV utan också "halvt på" via PWM.
PWM-teorin från Elegoo-manualen sid 48 (pulser 1/500 sek, procent av tiden HIGH).

**Komponenter introducerade:** RGB-LED (common cathode — pin-ordning: Röd, Katod,
Grön, Blå; katoden är andra från platta sidan och längst), 3 × 220Ω resistorer.

**Kopplingar (Elegoo Lesson 4, sid 44-52):** R=D6, G=D5, B=D3 (alla PWM, märkta
med `~`), katod → GND. Power rails på breadboarden introduceras nu.

**DELRESULTAT:**
> "Min RGB-LED cyklar mjukt mellan tre färger jag själv valt. Jag förstår hur
> `analogWrite(pin, 0-255)` styr ljusstyrkan och hur man blandar R+G+B för att
> få en given färg."

**Praktiskt moment:** Skriv en loop som fadar mellan favoritfärg A och B med
`analogWrite`. Eventuellt utmanings-moment: gör Åges flagga (FRO-färger?), en
polisbil (växla röd/blå), eller en "pulserande" effekt.

### TRÄFF 3 — Modul 3: Digital input
**Tema:** INPUT vs OUTPUT, `INPUT_PULLUP`, inverterad logik, `if`-satser,
active buzzer, enkla tillståndsmaskiner.

**Nytt koncept:** Att få Arduinon att LÄSA ett digitalt värde (knapptryck).
INPUT_PULLUP-tricket — varför intern pullup gör att man slipper externa
resistorer men logiken blir inverterad (LOW = tryckt).

**Komponenter introducerade:** Tactile push button, active buzzer (med den
viktiga "REMOVE SEAL AFTER WASHING"-varningen — stickern ska sitta kvar!).

**Kopplingar:**
- Knapp (Elegoo Lesson 5, sid 53-57): knapp → D9 + GND, INPUT_PULLUP
- Buzzer (Elegoo Lesson 6, sid 58-61): buzzer + → D12, - → GND

**DELRESULTAT:**
> "När jag trycker på knappen piper buzzern OCH min RGB-LED blinkar rött. När
> jag släpper slutar det. Jag har byggt ett enkelt interaktivt system som
> reagerar på mig."

**Praktiskt moment:** Kombinera knapp + buzzer + RGB från förra träffen. Detta
är första gången flera moduler samverkar.

### TRÄFF 4 — Modul 4: Analog input & Serial Monitor
**Tema:** Analog vs digital input, spänningsdelare, `analogRead()` (0-1023),
Serial Monitor som felsökningsverktyg.

**Nytt koncept:** Världen är inte bara PÅ/AV — den är analog. Spänningsdelare
förklaras rigoröst (inte bara "gör så här"). Serial Monitor som fönster in i
Arduinons tänkande.

**Komponenter introducerade:** Fotocell (LDR), tilt ball switch (grundläggande
även om den är digital — plugs ihop bra pedagogiskt med LDR).

**Kopplingar:**
- LDR (Elegoo Lesson 10, sid 79-82): 5V → LDR → A0 → 1kΩ → GND
- Tilt (Elegoo Lesson 7, sid 62-65): D2 + GND

**DELRESULTAT:**
> "Jag öppnar Serial Monitor och ser ett tal mellan 0 och 1023 som ändras i
> realtid när jag håller handen över fotocellen. Min RGB-LED lyser dessutom
> automatiskt svagt när det blir mörkt i rummet — en enkel nattlampa."

**Praktiskt moment:** Skriv en sketch som läser LDR, printar värdet till
Serial Monitor, och tänder RGB-LED:en i "mysigt gult" när värdet < 400.

### TRÄFF 5 — Modul 5: Integration (Hackathon)
**Tema:** Ingen ny teori. Integration av allt tidigare. Felsökning.
Tillståndsmaskiner (larm PÅ/AV). Debouncing.

**Nytt koncept:** Systemtänkande — få alla delar att samverka. Kodstruktur
för ett större program. `bool`-tillstånd.

**Kopplingar:** Allt från tidigare träffar, på samma breadboard samtidigt.
Ingen ny komponent.

**DELRESULTAT:**
> "Ett fungerande tjuvlarm/stämningsljus. När det är mörkt och larmet är AV
> lyser stämningsljuset. När jag trycker på knappen för att aktivera larmet
> släcks ljuset. Om någon sen rör systemet (tilt-sensor) börjar buzzern tjuta
> och RGB-LED:en blinkar rött. Det här tar jag med mig hem."

**Praktiskt moment:** Full hackathon. 60-75 minuter fri bygge med läraren som
runt-går-hjälpare. Avsluta med ljust→mörkt rum-demo där alla larm går loss.

---

## 4. Tekniska konstanter (ändra inte utan starka skäl)

### Pin-tilldelningar — MÅSTE matcha Elegoo-lektionerna
Detta är viktigt för att deltagarna ska kunna återanvända sina kopplingar
mellan träffar utan att bygga om.

```cpp
const int knappPin  = 9;   // Elegoo Lesson 5 (knapp A)
const int tiltPin   = 2;   // Elegoo Lesson 7
const int ldrPin    = A0;  // Elegoo Lesson 10
const int buzzerPin = 12;  // Elegoo Lesson 6
const int ledR      = 6;   // Elegoo Lesson 4 (PWM)
const int ledG      = 5;   // Elegoo Lesson 4 (PWM)
const int ledB      = 3;   // Elegoo Lesson 4 (PWM)
```

### RGB-LED:ens benkonfiguration (lätt att missförstå)
Från Elegoo-manualen sid 45-46, verifierat mot riktiga fotot:
- **4 ben** (inte 3).
- Pin-ordning från den **platta sidan** av LED-höljet: **Röd, Katod, Grön, Blå**.
- **Katoden är det längsta benet** OCH **andra benet från platta sidan** — inte
  det geometriska "mittenbenet". Tidigare utkast hade fel på detta.
- Katoden → GND. De tre andra → 220Ω → respektive PWM-pin (D3, D5, D6).

### Active buzzer — använd `digitalWrite`, inte `tone()`
ELEGOO Basic Kit har en **active** buzzer med inbyggd oscillator. Det räcker
med `digitalWrite(buzzerPin, HIGH)` för att få den att pipa. `tone()` fungerar
men är onödigt komplicerat. Pedagogiken förenklas av att köra digitalWrite.

**Klisterlappen "REMOVE SEAL AFTER WASHING" ska SITTA KVAR** — den är en
fabriksdämpare. Utan den är buzzern obehagligt hög i klassrummet. Tekniskt
funkar den utan, men det är inte värt det. Warning-slide i träff 3 tar upp
detta explicit.

### Tilt-sensor debounce
Kulan studsar inuti. `delay(50)` efter `digitalRead()` är tillräckligt för
stabila läsningar. Tidigare utkast hade `delay(100)` vilket fungerar men är
slöare än nödvändigt.

### Inga drivrutiner behövs
Elegoo UNO R3 använder **äkta ATmega16U2** för USB, inte CH340. Mac/Windows/Linux
behöver inget driver-installerande. Kortet dyker upp som "Arduino/Genuino UNO"
i IDE:ns Port-meny.

### Fotocellens koppling
`5V → fotocell → A0 → 1kΩ → GND`
- Mörker: fotocell har högt motstånd (~50kΩ) → A0 läser LÅGT (~100-300)
- Dagsljus: fotocell har lågt motstånd (~500Ω) → A0 läser HÖGT (~700-1000)
- Tröskel för "det är mörkt" i koden: ~400

---

## 5. Språk och terminologi

### Svenska genomgående
Innehållet på sliderna och talarnotiserna är på **svenska**. Kod-kommentarer
är på svenska. Engelska termer (`pinMode`, `analogRead`, `INPUT_PULLUP`,
`Serial Monitor`, `void setup()`) behålls oöversatta eftersom studenterna ser
dem i IDE:n.

### Svenska tekniska termer att använda
- *mikrokontroller* (inte "hjärna")
- *krets*, *spänning*, *ström*, *resistor*, *motstånd*, *GND* / *jord*
- *digital output*, *digital input*, *analog input*
- *pulsbreddsmodulering* (första gången) sedan *PWM* (när termen är introducerad)
- *spänningsdelare*
- *tillståndsmaskin*
- *felsökning* (inte "debuggning" eller "debuga")
- *bibliotek* (för Arduino libraries)
- *uppladdning* / *ladda upp* (för "upload")

### Förbjudna ord (från tidigare utkast som användaren ratade)
- ~~superkrafter~~ → moduler
- ~~magin börjar~~ → (bara modulnamnet)
- ~~hjärnan~~ → mikrokontrollern
- ~~röntgen-glasögon~~ → Serial Monitor / felsökning
- ~~sinnen~~ → input
- ~~KÄNSEL~~ → digital input / analog input
- ~~dum men snabb~~ → "en enkel, energisnål processor som kör kod rad för rad"
- ~~magi-momentet~~ → nyckelmoment / aha-ögonblick

---

## 6. Teknisk setup (Slidev v52.x)

### Versioner
- Node.js v25.9.0
- npm 11.12.1
- @slidev/cli 52.14.2
- @slidev/theme-default 0.25.0
- playwright-chromium (installerat för PDF-export)

### Filstruktur
```
arduino-kurs/
├── presentation/
│   ├── slides.md              # All content (källan)
│   ├── package.json           # Slidev + deps
│   ├── styles/
│   │   ├── main.css           # Custom dark theme + komponenter
│   │   └── index.js           # CSS loader
│   ├── public/images/         # Lokala bilder (cachat)
│   │   ├── arduino-uno-hero.jpg      # 4000x2400, beskuren (watermark borttagen)
│   │   ├── breadboard-rails.png
│   │   ├── photoresistors-three.jpg
│   │   ├── photoresistor-macro.jpg
│   │   ├── active-buzzer-sticker.jpg # active+passive jämförelse
│   │   ├── tilt-switch.jpg
│   │   └── cover-arduino-hero.jpg    # atmosfärisk cover-bg
│   ├── dist/                  # Byggd statisk version
│   ├── presentation-backup.pdf # Senaste export
│   └── README.md              # Svensk körguide
├── research/
│   ├── elegoo-kit.md          # Research-rapport
│   ├── elegoo-basic-kit-tutorial-v1.0.19.7.24.pdf  # Manualen lokalt
│   └── image-urls.md          # Image-URL-katalog
└── tasks/
    ├── design.md              # Design-spec
    ├── todo.md                # Arbetsplan
    ├── open-questions.md      # Öppna frågor
    └── handover.md            # Detta dokument
```

### Bygg-kommandon
```bash
cd ~/projects/arduino-kurs/presentation
npm run dev                    # Dev-server, localhost:3030
npm run build                  # Bygger dist/
./node_modules/.bin/slidev export --output presentation-backup.pdf
```

### Presenter-setup på Mac
1. Systeminställningar → Skärmar → avmarkera "Spegla skärmar"
2. Öppna `dist/index.html` i Chrome, dra till projektor-displayen
3. Fullskärm (F)
4. Ny Chrome-flik på laptop: lägg till `#/presenter` till URL:en
5. Två fönster synkar automatiskt (localStorage)

---

## 7. Aktuell status: slides.md har ~26 slides

**Träff 1 är KLAR och verifierad** (13 slides). Träff 2-5 är fortfarande
underutvecklade (2-3 slides vardera enligt originalet). Målbild: **~50-55
slides totalt** (ca 10-12 per träff).

### Vad finns just nu
**Pre-träff:**
1. Titel (cover-bild)
2. Översikt (5 moduler)
3. Klassrumsverktyget (röd/grön lapp)

**Träff 1 — KLAR (13 slides, 4-16):**
4. Divider — "LED & krets"
5. Agenda — "Idag — två timmar"
6. Slutmålet — "Det här ska vi bygga"
7. Mikrokontrollern — Arduino UNO R3 image-left
8. Spänning, ström, GND + Ohms lag (3 kort + inline formel)
9. Kretsen — som ett vattensystem
10. LED & resistor — komponenterna (polaritet, färgkoder)
11. Bygg kretsen — 5 numrerade steg
12. `setup()` och `loop()` — kodens anatomi
13. Hela Blink — tre kommandon
14. Din egen rytm — SOS-uppgift + kodexempel med blink() helper
15. Delresultat — "Ni har byggt en blinkare" + tagline
16. Cliffhanger — Nästa gång (RGB-cirkel med conic-gradient)

**Träff 2-5 — fortfarande underutvecklade:**
17-22+ ungefär: gamla divider + 2-3 slides per träff (RGB/illusion, power
rails, digital input, larm, LDR, Serial Monitor, hackathon, startmall, tack).
Varje träff behöver expandera till 10-12 slides enligt mönstret från Träff 1.

### Vad som saknas — träff 2-5 behöver expansion

**Träff 1 behöver INGET mer — den är klar, verifierad i live browser och PDF.**

### Mönster från Träff 1 att replikera (VIKTIGT)

När du expanderar träff 2-5, följ exakt samma 13-slide-mönster:

1. **Divider** — section layout med ikon + "Träff N av 5" + modul-namn
2. **Agenda** — "Idag" med 4 kort i 2×2 grid (tider, titel, beskrivning)
3. **Recap från förra träffen** (ny, från träff 2) — bygg broar tillbaka
4. **Dagens nya koncept** (1-2 slides) — förklaras INNAN det används
5. **Komponenten/komponenterna** — fysiska föremålen + deras egenheter
6. **Bygg kretsen** — numrerade steg (1-5) i grid-layout med koppling-card
7. **Kodens anatomi / nya kommandon** — visual breakdown
8. **Uppgift** — praktiskt moment med kodexempel
9. **Delresultat** — celebration-slide med KLART-badge + tagline + 3 ikoner
10. **Cliffhanger** — teasa nästa träff

### Träff 2-4: varje träff behöver expansion

**Träff 2 (PWM & RGB) behöver lägga till:**
- Recap från träff 1
- Agenda
- **Vad är PWM?** — dedikerad slide med förklarande diagram (Elegoo har detta på sid 48)
- RGB-LED close-up med tydlig pin-etikett (kritiskt för att undvika fel-wiring)
- `analogWrite(pin, 0-255)` — förklaring
- Färg-tabell: hur man blandar fram vanliga färger
- Guidat bygge
- **Delresultat-demon:** "alla cyklar mellan sina valda favoritfärger"
- (redan finns: illusion, power rails, divider)

**Träff 3 behöver lägga till:**
- Recap
- Agenda
- Knapp-komponenten (tactile switch med 4 stift-pinnar A/B/C/D)
- `INPUT_PULLUP` förklarat pedagogiskt (inkl. varför logiken blir inverterad)
- `if/else`-strukturen som koncept
- Active vs passive buzzer (kort — vi har bara active, men det är värt att nämna)
- Guidat bygge: knapp+LED, sen knapp+buzzer+RGB
- **Delresultat-demon:** "tryck → pip + rött blink"
- (redan finns: INPUT, Larmet, divider)

**Träff 4 behöver lägga till:**
- Recap
- Agenda
- Analog vs digital — ordentlig förklaring
- Vad är en spänningsdelare? — dedikerad slide med diagram
- `analogRead(A0)` → 0-1023
- Serial Monitor-gränssnittet (screenshot + förklaring)
- `Serial.begin(9600)`, `Serial.println()` — förklaringar
- Guidat bygge: LDR-spänningsdelare, serial-utskrift, sen reagera på mörker
- **Delresultat-demon:** "alla visar upp sin 'nattlampa' som lyser när mörker sker"
- (redan finns: LDR+tilt-sliden, Serial Monitor-sliden, divider)

**Träff 5 behöver lägga till:**
- Recap av alla 4 tidigare moduler
- Agenda: "idag ingen ny teori — vi kopplar ihop allt"
- Flödesschema: vad ska systemet göra (state-diagram)
- Guidat start (setup-koden) sen fritt byggande
- Debug-tips
- Checklist: "det ska kunna göra X, Y, Z"
- **Avslutnings-demon:** "rummet släcks, alla larm går loss"
- (redan finns: divider, hackathon-flödet, startmall × 2, tack-slide)

Med dessa tillägg hamnar vi på ~50-55 slides totalt.

---

## 7b. Träff 1 — lessons learned (LÄS DETTA FÖRE TRÄFF 2)

Dessa fallgropar upptäcktes under träff 1-expansion + 4 parallella expert-
reviews + live browser-verifiering. Applicera lärdomarna direkt på träff 2-5
istället för att återupptäcka dem.

### Slidev/CSS-fallgropar som clippar innehåll

1. **`.tip-box` / `.warn-box` på full-height slides clippas**
   När en slide har ett grid + en tip-box nedtill på en fylld layout, clippas
   boxen i PDF-export. Fyra slides i träff 1 led av detta (Spänning, LED &
   resistor, setup/loop, Din egen rytm). **Fix-mönster:** ersätt tip-box med
   en inline muted text-rad: `<div class="mt-4 text-xs opacity-60 italic">...`

2. **`two-cols-header`-layout ger för mycket vertikal padding**
   När jag expanderade Bygg-kretsen-sliden till `two-cols-header` med `pt-10`
   clippades ändå sista steget. **Fix:** använd `layout: default` + explicit
   tailwind grid (`grid grid-cols-[1.5fr_1fr]`) för full kontroll.

3. **`whitespace-nowrap` + långa rader → hela sliden skalas ner**
   Slidev skalar hela sliden för att få med overflow. En för-lång `nowrap`
   meta-rad i `image-left` layouten krympte HELA sliden till 50%. **Fix:** dela
   manuellt med `<br/>`, inte nowrap.

4. **`background-clip: text` med gradient läcker i PDF-export**
   Cliffhanger-sliden hade `<div>` med `conic-gradient` + `background-clip: text`
   på ett `◉`-tecken → cyan/magenta horisontella linjer läckte ut i PDF:n.
   **Fix:** använd en riktig rundad `<div>` med `conic-gradient` bakgrund +
   `radial-gradient` mask för hålet, inte text-clip-hack.

5. **Ikoner centreras inte i `.text-center`-wrappers**
   `<div class="text-8xl i-carbon-alarm">` inuti en `.text-center`-wrapper blev
   vänster-alignerad (block-level div tar full bredd, icon mask renderar vid
   left edge). **Fix:** wrappa i `<div class="flex justify-center">`.

6. **Ogiltigt icon-namn = tyst felande kort**
   `i-carbon-battery-charging-full` existerar INTE i Carbon Icons. Sliden
   renderade utan felmeddelande men kortet saknade ikon. **Fix:** verifiera
   icon-namn mot faktiska Carbon Icons, eller använd kända bra: `i-carbon-flash`,
   `i-carbon-flow`, `i-carbon-earth-filled`, `i-carbon-circuit-composer`,
   `i-carbon-code`, `i-carbon-view`, `i-carbon-light`, `i-carbon-color-palette`,
   `i-carbon-touch-1`, `i-carbon-chart-line`, `i-carbon-chip`, `i-carbon-play`.

### Språk/terminologi-fallgropar

7. **"superkrafter" / "sinnen" / "röntgen" / "magi" / "hjärnan" är FÖRBJUDNA**
   Förra versionen hade dessa i talarnotiser även när slide-body var ren.
   Leta i TALARNOTISER också, inte bara slide-body. Använd Grep med
   `superkraft|magi|hjärna|sinnen|röntgen` efter varje ny slide-batch.

8. **"hands-on" är anglicism — använd "praktiskt" eller "praktiskt moment"**

9. **"processor" ≠ "mikrokontroller"** — en mikrokontroller innehåller en
   processor. Var noga. "En liten dator på ett chip" är den bra förklaringen.

10. **"cliffhanger" / "teaser" i talarnotiser är anglicism** — använd
    "kort lockande antydan" eller liknande.

### Tekniska fakta som måste stämma

11. **Arduino UNO R3 = Arduino Uno i IDE** — "Genuino" dropades 2017, säg inte
    "Arduino/Genuino UNO" längre.

12. **Elegoo Basic Starter Kit 2024+ använder ATmega16U2** för USB — INGA
    drivrutiner behövs. Men äldre Elegoo-varianter kan ha CH340. Ha en
    felsöknings-rad för det fallet.

13. **delay() blockerar huvudprogrammet — inte "allt"** (interrupts fortsätter
    köra). Säg "huvudprogrammet väntar" för framtidssäkerhet när interrupts
    introduceras senare.

14. **SOS-rytm i koden är INTE strikt morsetiming** — dit/dah-pauser inom en
    bokstav ska vara 1 unit, inte lika med tecknet. Radioamatörerna kommer
    märka. Lägg en caveat i talarnotisen: "SOS-rytm, förenklad".

15. **220Ω = röd-röd-brun** (inte brun-röd-röd). 2·10¹ = 20 är fel — det är
    2·2·×10¹ = 220.

16. **Ohms lag för LED**: R = (5V − 2V) / 15mA ≈ 200Ω → välj 220Ω (E12-
    standardvärde). Vf för röd LED ≈ 2V, target current ≈ 15mA (säker
    undergräns av 20mA max).

### Verktygsfallgropar för verifiering

17. **PDF-export är det verkliga testet** — live dev-server-HMR kan ha
    glitches som inte finns i produktions-buildet. Verifiera ALLTID med
    `npm run build && slidev export` innan du rapporterar klart.

18. **Live browser-verifiering (Chrome MCP) fångar saker PDF missar** —
    scaling-issues, icon-rendering, font-loading. Kör båda.

19. **Parallella expert-subagents ÄR värda det för kvalitetskritiskt innehåll**.
    Användaren validerade denna approach explicit: "UPPSJÖ av expert subagents".
    Dispatcha 3-4 parallellt (pedagogik + visuell + språk + teknisk fakta)
    innan du rapporterar träff-expansion klar. Gav konkreta, icke-överlappande
    fynd i träff 1.

---

## 8. Kända visuella problem (fixade just innan /clear)

Dessa var problem i PDF-exporten från senaste iteration:

- ✅ **Fixat:** Cover-titel överflödade höger kant (reducerat till 4.2rem)
- ✅ **Fixat:** Mikrokontroller-titeln överflödade + bild hade "2025/" watermark
  (bilden beskars från 4000×3000 till 4000×2400 med `sips`)
- ✅ **Fixat:** RGB-cirklarna på PWM-sliden renderade inte — ersatt inline
  styles med custom CSS-klasser `.rgb-red` / `.rgb-green` / `.rgb-blue` /
  `.rgb-white` i `styles/main.css`
- ✅ **Fixat:** Kod-skelettet överflödade vertikalt — splittat till två
  slides (pins + struktur) via `layout: two-cols`
- ✅ **Fixat:** Hackathon-flödet överflödade — förenklat till en horisontell rad
- ✅ **Fixat:** Tack-sliden hade kort-grid + titel som överflödade — tagit
  bort grid, bara titel + text
- ✅ **Fixat:** Analog input-sliden hade tip-box som kapades — reducerat text
- ✅ **Fixat:** Divider-ikoner hamnade top-left — wrappade i `<div class="flex
  justify-center">` och CSS tvingar `.slidev-layout.section` till flex-column-
  center

### Inte verifierat efter sista fixen (kör ny build + PDF-inspektion)
Efter `/clear`: kör **`npm run build && ./node_modules/.bin/slidev export --output
presentation-backup.pdf`** och läs sedan PDF:en via Claude Codes `Read`-tool
(pages-parameter) för att kolla varje slide visuellt.

---

## 9. Vad den nya sessionen ska göra (prioriterat)

**Kontext för ny session:** Träff 1 är redan LEVERERAD och använd i första
kursträffen (2026-04-13). Träff 2 är om en vecka ungefär. Nästa session ska
börja direkt med **Träff 2-expansion**. Hoppa över träff 1 — rör den inte
om inte användaren explicit ber om det (kan finnas feedback efter första
träffen, fråga först).

### Steg 1 — Verifiera nuläget (3 min)
1. Läs detta dokument (hela, men särskilt sektion 2-3, 7, 7b)
2. Läs särskilt **sektion 7b (lessons learned)** — dessa fallgropar är
   redan lösta för träff 1, applicera direkt på träff 2-5
3. Kör `cd ~/projects/arduino-kurs/presentation && npm run build` för att
   verifiera att nuvarande slide-fil fortfarande bygger rent
4. Läs igenom träff 1 slides (4-16) i PDF:en som referensmall — det är
   mönstret som ska replikeras

### Steg 2 — Fråga användaren om feedback från träff 1 först
Första kursträffen gick TODAY (2026-04-13 kväll). Innan du börjar expandera
träff 2, fråga användaren:
- Hur gick träff 1? Funkade slideset pedagogiskt?
- Fanns det slides som var för långa/korta/ovärdig?
- Nya insikter om deltagarnas förkunskapsnivå?
- Någon del av upplägget som behöver justeras för framtida träffar?

Eventuell feedback som ändrar pedagogiska strukturen ska påverka träff 2-5.

### Steg 3 — Expandera träff 2 först (PWM & RGB)
Följ exakt 13-slide-mönstret från sektion 7 ovan. Räkna med att steg 3
ska inkludera recap från träff 1 (ny från träff 2 och framåt — träff 1
hade ingen recap).

**Slide-lista att skriva för träff 2:**
1. Divider (finns redan — kan behöva polering)
2. **Recap från träff 1** (NY) — 1 slide, 3-4 punkter om vad de kan nu
3. Agenda — "Idag" 4 kort 2×2 grid
4. Nytt koncept: **PWM — pulsbreddsmodulering** (NY, dedikerad slide med
   diagram — Elegoo-manualen sid 48 har en bra förklaring)
5. `analogWrite(pin, 0-255)` — förklaring
6. RGB-LED close-up: **common cathode**, pin-ordning (kritiskt: Röd · Katod ·
   Grön · Blå från platta sidan, katoden är det längsta benet och 2:a från
   platta sidan) — detta MÅSTE vara glasklart
7. Breadboardens power rails (finns redan som egen slide)
8. Färg-tabell: hur man blandar fram vanliga färger
9. Bygg kretsen — 5 numrerade steg (RGB + 3×220Ω + power rails)
10. Kod-exempel: fade mellan två favoritfärger
11. Uppgift — "välj två favoritfärger och cykla mellan dem"
12. **Delresultat** — "Er RGB-LED cyklar mjukt mellan era färger"
13. Cliffhanger till träff 3 (digital input)

### Steg 4 — Kvalitetsgrind: 4 parallella expertgranskare
Efter träff 2 är skriven, INNAN du rapporterar klart, dispatcha parallellt:
- Pedagogik & vuxen ton (Opus subagent) — läser sektion 2 i handover, granskar
- Visuell rendering (Opus subagent) — bygger PDF, inspekterar varje sida
- Svensk språk/terminologi (Opus subagent) — letar efter förbjudna ord
- Teknisk fakta (Opus subagent, eller extern via Codex/Gemini) — verifierar
  PWM-teori, RGB-common-cathode, pin-ordning, färg-blandning

Detta mönster fungerade i träff 1 och gav 15+ actionable fynd i ett svep.
Se sektion 7b punkt 19.

### Steg 5 — Live browser-verifiering via Chrome MCP
Efter PDF-verifiering, starta `npm run dev` och stega igenom varje slide i
Chrome MCP (tabs_create, navigate, computer screenshot). PDF missar scaling-
issues och icon-rendering-fel. Träff 1 hade 3 problem som ENDAST syntes i
live browser (alarm-ikon-offset, saknad battery-icon, meta-rad-wrap).

### Steg 6 — Fortsätt till träff 3, 4, 5 i samma ordning
Träff 2 är mallen. När den är validerad av användaren, kör samma process
för träff 3-5. Varje träff: skriv → expertreview → PDF → browser → leverera.

### Steg 7 — Final leverans
- Uppdatera README om setup har ändrats
- Exportera färdig PDF
- Rapportera till användaren med öppningsinstruktioner per träff

---

## 10. Viktiga öppna frågor (till användaren, om de dyker upp)

Dessa frågor är redan besvarade / dokumenterade, men notera om nya dyker upp:

✅ **Titel:** "Elektronik & Programmering med Arduino"
✅ **Undertitel:** "Fem träffar. Fem moduler. Ett fungerande larm."
✅ **Instruktör:** FRO Ånge
✅ **Datum:** 13 april 2026
✅ **Plats:** FRO-lokalen
✅ **Målgrupp:** FRO-medlemmar, vuxna radioamatörer/teknikintresserade
✅ **Kit:** ELEGOO UNO Project Basic Starter Kit
✅ **Längd per träff:** Antagande ~2h (bekräfta om tempo-cues blir aktuella)
❓ **QR-kod / extra material:** Inget specificerat, default: ingen QR-kod

### Pedagogiska principer som INTE kan förhandlas bort
(från denna konversation, 2026-04-13)
1. Vuxen ton, inga barn-ord
2. Delresultat i slutet av varje träff
3. Förklara termer innan de används (PWM, spänningsdelare, INPUT_PULLUP)
4. Bygg från enkelt till komplext
5. Tekniska pin-tilldelningar matchar Elegoo-lektionerna

---

## 11. Användarprofil (relevant för tonen)

- **Senior utvecklare** i både hårdvara och mjukvara — behöver inte tekniskt
  handholding på Slidev/npm/TypeScript, vill att Claude Code gör jobbet åt dem.
- Kör **Claude Code** dagligen → har Node.js, git, terminal, allt setup.
- Är **svensktalande** och vill ha all innehåll på svenska (outline,
  talarnotiser, README, kommentarer).
- Undervisar frivilligt för **FRO Ånge** — vill att det ska kännas **proffsigt**.
- Håller mentalt i **pedagogiska visionen** själv — du (Claude) får detaljerade
  instruktioner om hur det ska vara, och de ska respekteras.
- Vill kunna **iterera snabbt** mellan träffar om något behöver justeras.

---

## 12. Snabbreferens: kommandon du kommer behöva

```bash
# Aktivera projektet
cd ~/projects/arduino-kurs/presentation

# Utveckling (hot-reload)
npm run dev

# Produktionsbygge
npm run build

# PDF-export (efter build)
./node_modules/.bin/slidev export --output presentation-backup.pdf

# Kolla versioner
node --version
./node_modules/.bin/slidev --version

# Öppna presentationen
open dist/index.html

# Läs en specifik PDF-sida visuellt (från Claude Code)
# Använd Read-tool med pages-parameter, t.ex. pages: "1-12"
```

---

**Slutord till nästa session:** Läs detta dokument innan du gör något annat.
Följ den pedagogiska visionen i sektion 2-3 bokstavstroget. Användaren kommer
att notera om tonen slinker tillbaka till "superkrafter"-språk eller om
delresultaten glöms bort.

Fråga användaren om klarhet kring steg när du börjar — det är bättre att
påbörja träff 1-expansionen och få feedback efter första träffen än att
försöka bygga hela 50-slide-presentationen i ett svep.
