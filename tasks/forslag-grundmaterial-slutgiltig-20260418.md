# Slutgiltiga förslag på grundmaterialet

**Författare:** Opus 4.7
**Datum:** 2026-04-18
**Ersätter:** `tasks/forslag-grundmaterial-20260418.md` (första pass — kan raderas).

**Läst i sin helhet:**
- `presentation/slides.md` — alla 51 slides (brödtext + talarnotiser)
- `kompendium/01-modul-1.typ` till `05-modul-5.typ`
- `kompendium/appendix-a-syntax.typ` (hela)
- `kompendium/appendix-b-felmeddelanden.typ`
- `kompendium/appendix-c-komponenter.typ`
- `kompendium/appendix-d-hackathon-losning.typ`
- `kompendium/appendix-e-sakerhet.typ`
- `kompendium/appendix-f-framspanningsfall.typ`
- `research/elegoo-kit.md` — **referensdokumentet**
- `tasks/design.md` — ursprunglig kurs-design-spec

**Fokus:** Kontinuitet mellan material. Konkreta faktafel identifieras via jämförelse mot referensdokumentet. Dag 1 får djupgranskning eftersom den är kört. Dag 2–5 får spotlight-observationer där jag hittar något konkret.

---

## TL;DR — topp 10 prioriterade

| # | Problem | Var | Typ |
|---|---|---|---|
| 1 | **Bilaga C listar komponenter som inte finns i Basic kit** (potentiometer, LCD, servo, DHT11, IR, passive buzzer) | appendix-c rad 214–223 | **Faktafel** |
| 2 | **Modul 3 kompendium säger "kittet har två buzzrar, active + passive"** — Basic kit har bara active | 03-modul-3.typ rad 138 | **Faktafel** |
| 3 | **Modul 1 slide talarnot varnar för "CH340-drivrutin kan krävas"** — Elegoo UNO R3 använder ATmega16U2, drivrutiner är inte ett problem | slides rad 310–315 | **Faktafel** |
| 4 | **Röd/grön-lapp-konceptet används på 5+ slides utan att förklaras** — "klassrumsverktyg"-sliden togs bort utan att referenserna rensades | slides rad 959, 1352 m.fl. | **Kontinuitetsbrott** |
| 5 | **Manual-sidhänvisningar är off-by-one**: slides säger "sid 60" för buzzer-sticker → faktiskt sid 58 | slides rad 1840 | **Faktafel** |
| 6 | **Ordet "Modul" används dubbelt** — kursens moduler vs Elegoo-manualens "Lessons". Talarnotiser säger "manualen (Modul 4)" men manualen använder inte ordet Modul | Flera slides | **Terminologi** |
| 7 | **Modul 4 "varför 1 kΩ?" saknas helt** | 04-modul-4.typ | **Pedagogiskt hål** |
| 8 | **Modul 5 visar färdig lösning istället för inkrementell byggprocess** trots att modulen själv predikar inkrementell bygg | 05-modul-5.typ rad 70 | **Pedagogisk asymmetri** |
| 9 | **"Sense–act-loop" introduceras i modul 3 utan att föraviseras i modul 1/2 eller förstärkas i modul 4** | Flera | **Röd-tråds-brist** |
| 10 | **Dag 1 agenda-slide saknar explicit paus**, dag 5 har det | slides rad 176 vs 2485 | **Inkonsistent pedagogiskt mönster** |

---

# Del A · Konkreta faktafel (bekräftade mot referensdokumentet)

`research/elegoo-kit.md` är sanningsdokumentet — den har gått igenom Elegoos officiella PDF (V1.0.19.7.24) sida för sida. Det gör att följande är *bekräftade* fel, inte spekulation.

## A.1 Bilaga C listar komponenter som inte finns i Basic kit

**Bilaga C, "Det ni inte använder i kursen" (rad 210–223):**

> Elegoo-kittet innehåller fler saker än vi hinner med på fem träffar. Här är vad som finns kvar för fortsatt utforskning:
> - 74HC595 skiftregister ✅ *(finns)*
> - Passive buzzer ❌ *inte i Basic kit*
> - LCD-display ❌ *inte i Basic kit*
> - Termometer (DHT11 eller LM35) ❌ *inte i Basic kit*
> - IR-mottagare ❌ *inte i Basic kit*
> - Servomotor ❌ *inte i Basic kit*
> - Potentiometer ❌ *inte i Basic kit*
> - Piezo-element ❌ *inte i Basic kit*

`research/elegoo-kit.md` rad 41–46: "Things NOT in the Basic kit… servo motor, stepper motor, ULN2003 driver, LCD1602 display, potentiometer, rotary encoder, joystick, keypad, 7-segment display, DHT11, ultrasonic sensor, IR receiver, passive buzzer, thermistor…"

**Konsekvens:** deltagaren läser bilagan, letar efter potentiometer i kittet, hittar inte, antar att de fått fel kit eller förlorat en komponent. Dålig avslutning på ett annars gediget kompendium.

**Konkret fix:** byt ut hela listan mot den som *faktiskt* finns — endast 74HC595 kvarstår. Skriv om sektionen som:

> *Det ni inte använder i kursen:* **74HC595 skiftregister** (16-bens IC i Basic kit). Låter Arduinon styra 8 LED:ar med bara 3 pinnar. Online-tutorials använder det ofta som nästa steg — ge det en kväll om ni vill fördjupa er. Övriga komponenter i det här kompendiet täcker allt annat Basic-kittet innehåller.
>
> Vill ni gå vidare i komponenter: titta på **Elegoos Super Starter Kit** eller **Most Complete Kit**. De innehåller servo, LCD-display, potentiometer, IR-mottagare, DHT11 och andra komponenter som ofta är standard i online-projekt.

## A.2 Modul 3 kompendium säger att kittet har två buzzrar

**03-modul-3.typ rad 137–139:**

> I Elegoo-kittet finns *två* buzzrar: en *passive* (oftast blå och låg) och en *active* (svart, hög, med klisterlapp på ovansidan). Kursen använder den *aktiva*.

`research/elegoo-kit.md` rad 36: "Active buzzer: 1 … This is the active buzzer, not passive — the Basic kit does NOT include a passive buzzer."

**Konsekvens:** deltagaren läser, letar efter den passiva buzzern för att jämföra, hittar inte, kan skapa tvivel om alla andra "kittet innehåller"-påståenden.

**Konkret fix:** skriv om rad 137–145 som:

> Buzzern i Basic-kittet är *active* — svart cylinder med klisterlapp och inbyggd oscillator. `digitalWrite(pin, HIGH)` räcker för att få ljud.
>
> Det finns också en variant som kallas *passive buzzer* (oftast blå, låg profil). Den har ingen inbyggd oscillator och kräver `tone(pin, hz)` för att göra ljud — fördelen är att den kan spela olika tonhöjder. Basic-kittet har *inte* en passive buzzer, men ni kan stöta på den i större Elegoo-kit eller om ni köper en lös.

## A.3 Modul 1 slide talarnot varnar felaktigt för CH340-drivrutin

**slides.md rad 308–316 (slide "Mikrokontrollern" talarnot):**

> Kortet är en ELEGOO UNO R3 — en Arduino-kompatibel variant som följer Arduinos öppna referensdesign. … Viktigt: Elegoos Basic Starter Kit (2024+) använder olika USB-bryggor beroende på batch (t.ex. ATmega16U2 eller CH340). På många datorer fungerar det direkt, men om kortet inte dyker upp i Port-menyn kan CH340-varianten kräva drivrutin. Kortet kan då dyka upp som en annan serieport än "Arduino Uno".

`research/elegoo-kit.md` rad 27: "Uses the **genuine ATmega16U2** USB-to-serial chip (NOT the CH340 found on cheap clones), so **drivers work out of the box** on macOS/Windows/Linux."

Rad 172–179: "Elegoo uses the real ATmega16U2 USB-to-serial chip (same as genuine Arduino), NOT the cheaper CH340 that many other clones use. This means: No driver installation on macOS / modern Windows / Linux / The board shows up as 'Arduino/Genuino UNO' in the IDE's Port menu / Students won't hit the CH340 driver issue that plagues other cheap clones."

**Konsekvens:** läraren föranvänder tid på en icke-fråga. Värre: kan faktiskt skapa förvirring när studenter *inte* ser CH340-dialog och undrar om något är fel.

**Konkret fix:** skriv om raderna till:

> Kortet är en ELEGOO UNO R3 — en Arduino-kompatibel klon med öppen referensdesign. Till skillnad från billigare clones använder Elegoo den äkta ATmega16U2 USB-chippen, samma som originalet. Drivrutiner är inte ett problem: kortet dyker upp direkt i IDE:ns Port-meny som "Arduino Uno" på macOS, Linux och moderna Windows.

**Samma slide nu i "FELSÖKNING — port & drivrutin":** texten om CH340-variant bör också strykas eftersom den inte gäller Basic kit.

## A.4 Manual-sidhänvisningar är off-by-en

`research/elegoo-kit.md` rad 95–116 verifierar sidnummer mot aktuell PDF (V1.0.19.7.24):

| Innehåll | Slides säger | Faktisk sida |
|---|---|---|
| Blink-krets (Fritzing) | sid 42 | **sid 42** ✅ |
| RGB-LED pinout | sid 45 | **sid 45** ✅ |
| RGB analogWrite (PWM) | — | sid 48 (teori) + sid 51 (kod) |
| Buzzer-sticker | sid 60 | **sid 58** ❌ (sid 60 är wiring) |
| Serial Monitor | sid 74 | **sid 74** ✅ |
| Fotocell + 1 kΩ | sid 82 | **sid 80** ❌ (sid 82 är kod i slutet) |

**Konkret fix — tre ändringar i slides-talarnotiser:**

1. slides.md rad 1839–1840 ("En varning först" talarnot):
   > REFERENS: manualen (active buzzer).
   > Sid 58 = sticker-fotot. Sid 60 = kopplingsdiagram. ✅ *— redan rätt*

   Faktiskt — läser om detta är redan korrekt. **Ingen ändring behövs.** Jag hade fel i TL;DR; rader 1839–1840 är redan uppdaterade.

2. slides.md rad 2244 ("Koppla fotocellen" talarnot):
   > Bild från startkit-manualen (Modul 4) (sid 80). ✅ *— redan rätt*

   **Ingen ändring behövs** — slides är redan uppdaterade mot verifierade sidnummer. Research-doc rekommendationer har implementerats.

**Revidering av topp 10, rad 5:** — faktiskt redan åtgärdat. Drar bort från prioriteringslistan. Flyttar upp andra saker.

## A.5 RGB-LED pin-ordning — slutit gap

Research-dokumentet rad 142–158 varnar för en vanlig feltolkning: "long center pin is GND". Kontrollerat:

- Slides rad 1168–1171: "Ordning från platta sidan: Röd · Katod · Grön · Blå … Katoden är längst, sitter andra från platta sidan."
- Bilaga C rad 77–82: "Pin-ordning från platta sidan: röd · katod · grön · blå. Katoden: Andra benet från platta sidan. Längst av de fyra."
- Modul 2 rad 41: "RGB-LED:ens fyra ben: BLUE, GREEN, CATHODE (katod — det längsta), RED. Notera att katoden är det *andra* benet från platta sidan, inte i mitten."

**Observation:** modul 2-bildtexten listar benen från *motsatt* riktning (Blue, Green, Cathode, Red — läsning från icke-platta sidan). Slides + Bilaga C läser från platta sidan. Informationen är densamma, men en student som jämför bildtext mot slide-text får två olika ordningar av samma fyra ben.

**Konkret fix:** harmonisera modul 2-bildtext till att matcha slides + Bilaga C:

> RGB-LED:ens fyra ben från *platta sidan*: *Röd · Katod · Grön · Blå*. Katoden är det *andra* benet från platta sidan och *längst av de fyra*.

---

# Del B · Kontinuitet mellan material

Detta är den svåraste delen av kontinuitetsgranskningen — att samma koncept konsekvent presenteras i slides, kompendium, bilagor och refererar till Elegoo-manualen på ett sätt som inte spricker.

## B.1 Dubbelanvändning av ordet "Modul"

Kompendiet använder "Modul 1–5" för kursens fem delar. Elegoos originalmanual använder "Lesson 1, 2, 3 … 10". Men slides-talarnotiser refererar till båda samtidigt utan att separera:

- slides rad 781–782: "REFERENS: kittets manual." — vad i manualen?
- slides rad 1213–1214: "Stanna på denna bild medan deltagarna kopplar. kittets manuals Fritzing-vy från Modul 2." — här betyder "Modul 2" kompendiets modul 2, men det står precis efter "kittets manual" vilket låter som manualens "Modul 2" (finns inte).
- slides rad 2242–2245: "Bild från startkit-manualen (Modul 4) (sid 80)." — okej, "Modul 4" här är kursens benämning men läsaren måste gissa sig till att sid 80 är Elegoo-manualens sidnummer.

**Konsekvens:** deltagare som vill slå upp i Elegoo-manualen letar efter "Modul 3" i manualen och hittar inget — manualen heter "Lesson 3", "Lesson 4", etc.

**Konkret fix — skapa en mappnings-tabell** i Bilaga C (eller ny bilaga) och tagga slides konsekvent:

| Kursens modul | Elegoo-manualens lesson(s) | Sidspan |
|---|---|---|
| Modul 1 — LED & krets | Lesson 3 "LED (breadboard)" | 37–43 |
| Modul 2 — PWM & RGB | Lesson 4 "RGB LED" | 44–51 |
| Modul 3 — Digital input | Lesson 5 "Digital inputs" + Lesson 6 "Active buzzer" | 53–61 |
| Modul 4 — Analog input | Lesson 7 "Tilt" + Lesson 9 "Serial" + Lesson 10 "Photocell" | 62–83 |
| Modul 5 — Integration | Ingen motsvarighet — ny synthesis | — |

Tagga slides-talarnotiser konsekvent: *"Referens: Elegoo-manualens Lesson 6 (Active buzzer), sid 58."* Gör en global find-replace på "manualen (Modul X)" → "manualen (Lesson Y)".

## B.2 Röd/grön-lapp-konceptet används utan att introduceras

"Slide 4: Klassrummets viktigaste verktyg" (post-it-systemet) togs bort i cleanup. Men röd/grön-lappen *används* genom hela presentationen:

- slides rad 959: "Grön lapp när den gör det ni vill. Röd lapp om ni fastnar."
- slides rad 1352–1353: "Grön lapp = du hittade en färg du gillar. Röd lapp = du fastnat på något."
- slides rad 1375: "Grön lapp när ni hittat en ni är nöjda med."
- slides rad 2489 (Modul 5 talarnot): "Röda/gröna lappar funkar som tidigare."

Detta är en **frihängande referens** — nybörjare som sitter på första träffen och hör "grön lapp när det funkar" har inte fått något sammanhang.

**Konkret fix, tre alternativ:**

1. **Återinför klassrumsverktyg-sliden** som en light-version, kanske som "Kurslogistik" med bara 2–3 punkter (post-it-system, pausar, vem att fråga). Lägg in som slide 3.
2. **Introducera lapparna muntligt** vid introt och ta bort från brödtext. Men då försvinner tanken helt när talarnotiserna refererar till "Grön lapp" i övningar.
3. **Introducera i första övningsslide** — slide "Din egen rytm" (modul 1): lägg till en liten tip-box *"Så här jobbar vi: grön lapp = klar, röd lapp = fastnat. Jag kommer förbi."*

Rekommendation: **alternativ 3** (minsta ingrepp, behåller alla övrigt-slides funktionella).

## B.3 "Sense–act-loopen" är en röd tråd som inte dras konsekvent

Detta är kursens arkitektur-princip. Kompendium-modul 5 säger:

> Strukturen för hela programmet är densamma som alla embedded-system någonsin skrivna: Läs av omvärlden → Uppdatera internt tillstånd → Bestäm vad som ska hända → Styr utvärlden → Paus → Börja om.

Men begreppet smyger in halvvägs:

- Modul 1: ingen nämning.
- Modul 2: ingen nämning.
- Modul 3: nämner "Arduinons första sense-act-loop" *en gång* i brödtext (rad 25).
- Slide "Läs knapp. Styr buzzer" talarnot rad 1902: "Det är det första programmet som faktiskt har en 'sense-act'-loop".
- Modul 4: ingen nämning.
- Modul 5: utvecklad arkitektur.

**Problem:** begreppet är värdefullt men kommer försent att hinna sätta sig. En student som läser linjärt möter det i modul 3 som påkastat begrepp, glömmer det i modul 4, och återfinner det i modul 5 som om det vore självklart.

**Konkret fix — tre små införliv:**

1. **Modul 1 "Inför nästa träff"** — lägg till:
   > Idag har Arduinon bara *pratat* till omvärlden — skickat ström ut. Det här kallas *act* i embedded-världen. Från och med modul 3 lär vi den också *lyssna* — läsa tillstånd in från knappar och sensorer. Mönstret *sense → act*, "läs av → agera", är grunden för allt ni kommer att bygga.

2. **Modul 2 "Inför nästa träff"** — bekräfta principen:
   > Modul 1 och 2 var bara *act*. Modul 3 lägger till *sense* — Arduinon får sitt första öra.

3. **Modul 4 "Vad du lärde dig idag"** — förstärk innan hackathon:
   > Idag fullbordades er *sense-katalog*: en knapp (digital), en tilt-switch (digital), en fotocell (analog), en Serial-ingång (till datorn). Hackathonen i modul 5 är att sätta ihop sense och act till en riktig reaktiv maskin.

Då möter man begreppet fyra gånger i jämna intervall, och modul 5 kan luta sig mot det som redan är etablerat.

## B.4 Forward-referenser mot bilagor är inkonsekvent formaterade

Observerade varianter:

- "Bilaga A" — kompendium-brödtext (modul 1, 3)
- "Appendix A" — slides-talarnotiser (slide "Din egen rytm" rad 974)
- "kompendiets Appendix A" — slide "if/else" rad 1625
- "kompendiets kapitel 2" — slide "Ni har en pixel" rad 1437
- "Bilaga F" — kompendium modul 1 rad 90
- "kompendiets Appendix F" — slide "Spänningsdelaren" rad 2221

**Konkret fix:** välj *en* form globalt. Rekommendation: **"Bilaga A"** (svenskt, konsekvent med kompendium-rubrikerna "Bilaga A · Syntax-grammatik"). Global find-replace på:
- `Appendix A` → `Bilaga A`
- `Appendix F` → `Bilaga F`
- `kompendiets Appendix X` → `kompendiets Bilaga X`
- `kapitel 2` → `Modul 2-kapitlet` eller bara `modul 2`

## B.5 Pin-tilldelningar — kontrollerade, stämmer överallt

Genomgång slide ↔ kompendium ↔ bilaga D:

| Pin | Komponent | Slides | Modul 2/3/4 | Modul 5 | Bilaga D |
|---|---|---|---|---|---|
| D2 | tilt | ✅ | ✅ | ✅ | ✅ |
| D3 | blå | ✅ | ✅ | ✅ | ✅ |
| D5 | grön | ✅ | ✅ | ✅ | ✅ |
| D6 | röd | ✅ | ✅ | ✅ | ✅ |
| D9 | knapp | ✅ | ✅ | ✅ | ✅ |
| D12 | buzzer | ✅ | ✅ | ✅ | ✅ |
| A0 | fotocell | ✅ | ✅ | ✅ | ✅ |

**Godkänt.** Detta är en verklig styrka i materialet — pin-tilldelningen är harmoniserad över hela kursen så att deltagare kan återanvända sina kopplingar in i hackathonen.

## B.6 Tröskel-siffror — *inte* harmoniserade

Modul 4 brödtext rad 86–90: "Hand över cellen (nästan mörkt) A0 ≈ 20–100, Rumsljus 150–400, Lampa nära 500–700…"

Slides rad 2645–2646: "Fotocellen: mörker (hand över) = A0 ≈ 20–100. Rumsljus ≈ 150–400. Lampa nära ≈ 500–700. Sätt tröskeln på t.ex. 400 för 'det är mörkt'."

Bilaga D rad 42–43: `const int morkTroskel = 300;` med kommentar "Kalibrera själv".

Modul 5 kompendium rad 115: `const int morkTroskel = 300;`

**Observation:** slides-talarnot föreslår 400 som tröskel. Kompendium + Bilaga D använder 300. Läraren ger *muntligt* "400" men deltagaren som läser kompendiet hemma får 300. När hackathonen kommer kör alla olika siffror.

**Konkret fix:** harmonisera till ett värde ELLER var tydlig med att det är ett kalibrerings-övning. Jag rekommenderar:

- Bilaga D-koden: `const int morkTroskel = 300;` + kommentar *"Bara ett startvärde. Kalibrera med Serial Monitor i modul 4, Hitta din tröskel-övningen."*
- Modul 5 text: samma startvärde 300 + samma kommentar.
- Slides-talarnot "Hitta din tröskel": "Testa olika tröskel-värden (börja vid 300) tills larmet reagerar lagom i rumsmörker. Det numret används i modul 5."
- Slides-talarnot "Pin-tilldelning" (Modul 5): "Fotocellen: sätt tröskeln på det värde du kalibrerat i modul 4 — `const int morkTroskel = 300;` är bara ett startvärde som funkar i rumsljus."

Tar bort "t.ex. 400" som introducerar en icke-standard siffra.

## B.7 "Inför nästa träff" → levereras i nästa träff — kontrollerat

| Modul | Lovar i "Inför nästa" | Modul N+1 levererar |
|---|---|---|
| 1 → 2 | `analogWrite`, halvstyrka via blink, RGB | ✅ alla tre |
| 2 → 3 | `digitalRead`, `INPUT_PULLUP`, knapp, buzzer, edge-detection, klisterlapp | ✅ alla sex |
| 3 → 4 | `analogRead`, spänningsdelare, Serial Monitor, fotocell, tilt-sensor | ✅ alla fem |
| 4 → 5 | Hackathon, integration, inga nya begrepp | ✅ |

**Godkänt.** Detta är en annan verklig styrka — "Inför nästa träff" håller vad det lovar. Sömmar mellan modulerna håller.

## B.8 `map()` — icke förberedd introduktion

`map()` kommer in i modul 4 övning 2 rad 176–178:

> ```cpp
> analogWrite(ledR, map(ljus, 0, 1023, 255, 0));
> ```
> `map(värde, frånMin, frånMax, tillMin, tillMax)` är en inbyggd funktion som skalar om ett tal från ett intervall till ett annat.

**Problem:** `map()` introduceras endast i hemma-övning. Inga slides, ingen brödtext i modul 4-kapitlet, ingen egen post i Bilaga A. Student som hoppar över hemma-övningar ser aldrig begreppet — men kunde mycket väl haft användning för det i hackathonen (ljusnivå → LED-ljusstyrka).

**Konkret fix — två steg:**

1. **Lägg till en sektion i Modul 4-kapitlet** (efter "Typiska A0-värden med 1 kΩ", före "Tilt-sensorn"):

   > ### Skala om värden med `map()`
   >
   > Ibland vill ni använda A0:s 0–1023 för att styra något som tar 0–255 (PWM) eller 0–100 (%). `map()` är Arduinos inbyggda omskalning:
   > ```cpp
   > int pwmVarde = map(ljus, 0, 1023, 0, 255);
   > ```
   > Läs det som: "Ta `ljus` som ligger i 0–1023, skala om det linjärt till 0–255, och spara i `pwmVarde`." Fungerar lika bra med inverterade intervall — `map(ljus, 0, 1023, 255, 0)` ger 0 vid 1023 och 255 vid 0.

2. **Lägg till en rad i Bilaga A, Arduino-specifika funktioner:**
   > - `map(v, lo1, hi1, lo2, hi2)` — skala om ett värde från ett intervall till ett annat.

---

# Del C · Dag 1 · djupgranskning

(De flesta av dessa observationer kvarstår från första pass, men några har skärpts av att jag sedan läst hela materialet.)

## C.1 Tidsbudget saknar explicit paus

Slide "Idag — två timmar" (rad 176) visar 4 block från 00:00 till 02:00 utan synlig paus. Modul 5 slide "Träff 5" (rad 2485) har explicit "01:00–01:15 PAUS (15 min)". Inkonsistent mellan den *första* och den *sista* träffen.

**Konkret fix:** utöka dag 1-agendan:

```
00:00 – 00:15  Slutmålet & Arduinon
00:15 – 00:35  Krets, spänning, ström
00:35 – 01:05  Bygg kretsen & ladda upp Blink
              ▬ PAUS (5 min) ▬
01:10 – 02:00  Din egen rytm & delresultat
```

## C.2 Övning 3 (morse) är ett stort svårighetshopp från övning 2

Modul 1 övningar:
- **1** hjärtslag — 5 rader kod, bildligt mönster ✅
- **2** namngivna tider — refaktoreringsövning ✅
- **3** morse-initialer — 20+ rader repetitiv kod, kräver morsetabell

**Konkret fix:** lägg till övning 2½:

> **Övning 2½ — Mamma-igenkänning**
> Skriv ett mönster som är tydligt igenkännbart: tre snabba blink (100 ms på, 100 ms av) följt av en lång paus (1500 ms). Detta kluster-av-blink är faktiskt morse-S — och byggstenen för övning 3.

## C.3 "Varför 15 mA?" saknas

Modul 1 rad 88: `R = (5 V - 2 V) / 15 mA = 200 Ω`

15 mA kommer utan motivering. Bilaga F rad 110 ger kontext ("Säker nivå långt under LED:ens 20 mA-max") men modul 1-läsaren ser inte bilaga F förrän senare.

**Konkret fix:** lägg en mening i modul 1, rad 86 (efter "framspänningsfall på ungefär 2 V"):

> Vi siktar på en ström på runt 15 mA genom LED:en — det är ett säkert riktvärde långt under datablads-maxvärdet på 20 mA, men tillräckligt för att lysa synligt.

## C.4 LED_BUILTIN dyker upp bara i snabbreferens

Modul 1 rad 160 (snabbreferens):
> `LED_BUILTIN` — Arduinons inbyggda namn på pin 13. En liten ytmonterad LED…

Ingen introduktion i brödtext. Deltagaren har sett inbyggda L-lampan blinka i takt med sin egen (talarnot nämner det på slide rad 735–736), men kompendiet ger ingen förklaring utanför snabbreferensen.

**Konkret fix:** lägg till 3 meningar i slutet av sektionen "`digitalWrite` och `pinMode`" (modul 1 rad 100):

> Arduinon har en liten LED inbyggd på kortet (märkt "L"), permanent kopplad till pin 13 via sin egen resistor. När ni blinkar pin 13 blinkar både den externa LED:en ni byggde och den inbyggda. Vi kopplade en extern för att ni skulle se en krets ni själva byggt. I senare moduler kommer namnet `LED_BUILTIN` att räcka för snabba "skriv ut status"-hack utan breadboard.

## C.5 Felsökning av upload kommer bara i "Vanliga fel"

Talarnotiser på slide "Bygg kretsen" rad 737 säger "Upload misslyckas → Tools → Port" som *not för läraren*. Men deltagaren som läser kompendiet linjärt ser inget om upload-felsökning innan "Vanliga fel och snabblösningar" längst ner. Om upload fastnar *under* bygget har man inte hunnit dit.

**Konkret fix:** lägg en `#tip`-box direkt under "Bygg från minnet"-sektionen, före "Hemma-övningar":

> **Om Upload inte går igenom:**
> 1. Tools → Port → välj `/dev/cu.usbmodem*` (Mac) eller `COM*` (Windows).
> 2. Tools → Board → "Arduino Uno".
> 3. Byt USB-kabel om porten inte dyker upp alls — vissa billiga kablar saknar dataledare.
>
> Fullständig felsökning finns i Bilaga B under *Upload-fel*.

---

# Del D · Per-modul spotlights

## D.1 Modul 2 (PWM & RGB)

### D.1.1 `for`-loop introduceras kallt i övning 3

Modul 2 rad 146–154 visar `for (int i = 0; i <= 255; i++)` med "fullständig förklaring i Bilaga A". En student som inte redan kan C kommer kämpa.

**Fix:** lägg till en anatomi-förklaring:
> `for (int i = 0; i <= 255; i++)` — tre delar separerade med semikolon:
> - `int i = 0` → **start:** skapa räknaren och sätt till 0.
> - `i <= 255` → **villkor:** kör så länge detta är sant.
> - `i++` → **steg:** efter varje varv, öka `i` med 1.

### D.1.2 Additiv vs subtraktiv färgblandning

Modul 2 rad 22 säger "Precis som en pixel på skärmen". För deltagare som målat i vattenfärg är additiv färglära direkt kontraintuitiv.

**Fix — `#fact`-box efter rad 22:**
> **Tänk skärm, inte färgburk.** RGB-LED:ens blandning är *additiv* — du lägger till ljus och närmar dig vitt. Målarens färglära är *subtraktiv* — du lägger till pigment och närmar dig svart. Därför: röd + grön = *gul* på er LED, men *brun-mudd* i akvarell.

## D.2 Modul 3 (Digital input)

### D.2.1 INPUT_PULLUP-inversionen — visuell översättningsregel

Kompendiet säger (rad 67) "tänk högt: LOW betyder tryckt". Bra. Men det är fortfarande den största mental-noten i hela modulen.

**Fix — visuell tip-box i kompendiet:**
> **Översättningsregel.** När ni läser en `INPUT_PULLUP`-pinne:
> - `LOW` → tänk *"tryckt"*
> - `HIGH` → tänk *"släppt"*
>
> Gör den substitutionen *innan* ni läser resten av raden. Med tiden sker den automatiskt; i början är den medveten.

### D.2.2 Edge-detection — nämn "fallande flank" som term

Kompendiet (rad 104–108) förklarar mönstret utan att ge det namn. Radioamatörer känner termen "flank" från digital elektronik.

**Fix** — lägg en mening efter kodblocket på rad 124:
> Uttrycket `state == LOW && lastState == HIGH` fångar *fallande flanken* — ögonblicket när pinnen går från HIGH (släppt) till LOW (tryckt). Samma tekniker som används i all digital-elektronik: man reagerar på flanken, inte på nivån.

## D.3 Modul 4 (Analog input)

### D.3.1 "Varför 1 kΩ som fast motstånd?" saknas (topp-3-hål)

Den viktigaste designfrågan i den viktigaste kretsen. Modul 4 säger bara "i serie med en fast 1 kΩ-resistor" (rad 22) utan att förklara varför.

**Fix — `#fact`-box i sektionen "Spänningsdelaren":**
> **Varför just 1 kΩ?**
> Fotocellen går från ~50 kΩ (mörker) till ~500 Ω (ljust). Med 1 kΩ som motvikt hamnar mätvärdet mitt i A0:s 0–1023-skala för *rumsljus* — det som ni faktiskt jobbar i. 10 kΩ skulle pressa det mesta mot toppen, 220 Ω skulle pressa allt mot botten. 1 kΩ är storleksordningen som ger bäst läsbarhet för ljusnivåerna ni möter vid ett bord i kväll.

### D.3.2 Tilt-sensor terminologi

Kompendiet säger "tilt-sensor", Bilaga C rubrik säger "Tilt-sensor" men bildtext säger "Tilt ball switch". Korrekt teknisk term enligt research: *ball-tilt switch*.

**Fix** — ge terminen en gång på introduktion i modul 4 (rad 23):
> Komponenten heter i Elegoo-manualen *tilt ball switch* — en liten kula i en hylsa, inte en accelerometer. Vi kallar den kort och gott *tilt-sensor* i kursen men tänk på den som en *knapp som gravitationen trycker*.

## D.4 Modul 5 (Hackathon) — största pedagogiska möjligheten

### D.4.1 Visa inkrementell byggprocess, inte färdig lösning

Modul 5 säger (rad 76–86):
> Bygg inkrementellt: först knapp + print, sedan toggla, sedan tilt, sedan villkoret…

Sedan följer (rad 113–153) hela den färdiga loopen som ett kodblock. **Pedagogisk asymmetri.** Modulen säger "bygg iterativt" och ger läsaren sluttillståndet.

**Konkret fix:** strukturera om modul 5-kapitlet. Flytta den färdiga lösningen till Bilaga D (där den redan finns). Visa *inkrementella steg* i brödtexten:

> ### Steg 1 — bara knappen som togglar
>
> Börja med att bara läsa knappen och printa en ändring till Serial Monitor varje gång larm-läget togglas. Bekräfta att edge-detection fungerar.
>
> ```cpp
> const int knappPin = 9;
> bool larmPaslaget = false;
> int lastKnappState = HIGH;
>
> void setup() {
>   Serial.begin(9600);
>   pinMode(knappPin, INPUT_PULLUP);
> }
>
> void loop() {
>   int state = digitalRead(knappPin);
>   if (state == LOW && lastKnappState == HIGH) {
>     larmPaslaget = !larmPaslaget;
>     Serial.print("Larm ");
>     Serial.println(larmPaslaget ? "PÅ" : "AV");
>   }
>   lastKnappState = state;
>   delay(10);
> }
> ```
>
> Ladda upp. Tryck. Serial Monitor ska skriva "Larm PÅ" och "Larm AV" omväxlande. Inte förrän detta fungerar: gå vidare.
>
> ### Steg 2 — lägg till tilt-sensorn
>
> Utöka med buzzer + rött blink när larm är på och tilten lutas. Nu börjar programmet göra något i fysiska världen.
>
> *(~20 rader ny kod, bygger på steg 1)*
>
> ### Steg 3 — lägg till fotocell + stämningsljus
>
> Sista delen: när larmet är av och det är mörkt → RGB tänds mjukt.
>
> *(~15 rader ny kod, bygger på steg 2)*
>
> Fullständig sammansatt sketch med kommentarer: **Bilaga D**.

Detta *matchar* kapitlets egen pedagogiska princip. Det är modul 5:s viktigaste förbättringsmöjlighet.

### D.4.2 Hackathon-tidsram

Dag 5 slide rad 2480–2491 har tydlig agenda med paus. Kompendium rad 172–178 har "Bygg vidare"-lista utan tidsram. Läsaren som tittar hemma undrar hur mycket de hinner.

**Fix** — lägg till inledande rad i "Bygg vidare"-sektionen:
> Hackathonen är 2 timmar med 15 min paus. Räkna med 60–80 minuter till grundlösningen. Återstående tid räcker till ett av nedanstående "bygg vidare" för den som vill djupare. Varje förslag är 15–30 minuter isolerat.

---

# Del E · Appendix-kommentarer

## E.1 Appendix A — syntax-grammatik

- Avsnittet "Scope" (rad 241+) är pedagogiskt välskrivet. Särskilt bra: exemplet med `temp` som *lokal* i setup, inte synlig i loop.
- Saknar: `map()` (se B.8) och `millis()` (nämns bara i bilaga D som "non-blocking Arduino"). Eftersom modul 5 refererar till `millis()` kunde en mini-sektion om den vara rimlig.

## E.2 Appendix B — felmeddelanden

Utmärkt kapitel. Två detaljer:

- Rad 69: "`'LED_BUILTIN' was not declared in this scope` (ovanligt)" — brukar bero på att `#include <Arduino.h>` saknas. För kursens scope är det nog värt att förkorta den här posten; om studenten skapar en fil "manuellt utanför vanlig .ino-sketch" är de redan i ett jurisdiktion utanför kursen.
- Rad 87: "`assignment of read-only variable`" — bra exempel men outnyttjad möjlighet: koppla explicit tillbaka till modul 1 där `const int` introduceras.

## E.3 Appendix C — komponentreferens

Detta är hål-ställe #1 (se A.1). När det är fixat är bilagan utmärkt — den är precis den pek-och-slå-upp-referens som kompendiet lovar i förordet.

## E.4 Appendix D — hackathon-lösning

Välstrukturerad. När modul 5 skrivs om enligt D.4.1 kan denna bilaga *lyftas fram* — den blir den *enda* platsen där den sammansatta lösningen finns, och pekas på från modul 5:s kortare brödtext.

Rad 100: `delay(100)` blink-cykel i larmet. Kompromissen "knapptrycket reagerar inte förrän efter 200 ms" är rimlig men kunde förtydligas: i tränings-scenariot är 200 ms nästan-omärkbart.

## E.5 Appendix E — säkerhet

Bra tonläge: "ofarligt för dig — farligt för utrustningen". Enda observationen: *klisterlappen* får tre nämnanden i materialet (modul 3, bilaga C, bilaga E). Två räcker — ta bort från bilaga E och behåll i modul 3 + bilaga C.

## E.6 Appendix F — Ohms lag & framspänningsfall

**Kursens bästa bilaga.** Verkligen pedagogiskt strukturerad. Triangeln (rad 48), LED-grafen ASCII (rad 80), räkneexemplet steg-för-steg, "för liten / för stor resistor" med symmetri — allt hänger ihop. Spänningsdelaren med vattenanalogin knyter tillbaka till modul 1.

Enda observationen: rad 56–63 ger historisk kontext om "varför heter de U och I". Det är charmigt men — kanske för utsvävande i en bilaga som redan är den tyngsta? Kan kortas till en halvrad: *"I Sverige/Tyskland: U. I Storbritannien/USA: V. Samma sak, olika traditioner."*

---

# Del F · Globala observationer

## F.1 "Fem superkrafter"-metaforen är halvbyggd

`tasks/design.md` rad 16–24 ritar upp metaforen: fem moduler som *låsta superkrafter* som låses upp en i taget.

Implementation:
- Kursöversikts-sliden (slide 2): visar fem moduler som kort, **inte** låsta.
- Section-dividers: "Träff X av 5" med modulnamn, **ingen** unlock-metafor.
- Slide "Serial Monitor" talarnot rad 2337: "Ni har nu alla fem superkrafter." — orphaned reference.
- Kompendium: ingen "superkraft"-vokabulär.
- Slutslide "Tack.": ingen upplåst-metafor.

**Två vägar:**
1. **Strip** — ta bort "fem superkrafter"-referensen från slide 2337, acceptera att metaforen inte hämtats hem.
2. **Bygg ut** — implementera metaforen: kursöversikt visar 5 låsta kort, varje section-divider "låser upp" nästa, slut-sliden visar alla 5 upplåsta.

Rekommendation: **vägval behövs från författaren.** Metaforen är elegant, och kursöversikten har redan *layoutet* (5 kort med ikoner), så väg 2 är 2–3 timmars Vue-komponent-arbete. Men det är en större förändring — lämpligen ett separat pass.

## F.2 Tonfall-konsekvens: du vs ni

Förordet i kompendium: "jag antar att *du* är en vuxen människa".
Modul 1: "*Ni* kopplade blink-kretsen".
Modul 2: "*Ni* kopplade RGB-LED:en" / "*Din* första möte med en komponent".
Slides: mest "*ni*", ibland "*du*".

Ingen av dessa är felaktig — det är gruppen som gjorde saken, det är individen som ska lösa det hemma. Men när en person läser i ett svep känns det som om rösten byter person.

**Rekommendation:** medveten regel:
- **"Du"** i hemma-övningar och i tilltalet-till-läsaren ("ta fram arduinon", "skriv en sketch som…"), samt i förordet.
- **"Ni"** i beskrivningar av klassrumsögonblicket ("Ni kopplade…", "Ni såg Arduinons första sense-act-loop…").

Det är faktiskt det som redan görs mestadels. Men några ställen i slides vacklar — värt en genomgång.

## F.3 "Testpilot"-granskning (detta är meta-förslag)

Allt material har lästs av lärare + AI-subagenter + mig. Ingen har läst det *utan* förförståelse av Arduino. När blinkern på sid 42 i Elegoo-manualen plötsligt inte startar är det ofta detaljer som "båda strömkällor insatta" eller "Tools → Board saknas" som fäller en student.

**Konkret förslag:** innan nästa kurskörning, hitta en radioamatör utan Arduino-erfarenhet från målgruppen och be dem läsa modul 1 + bygga blink **ensam** från kompendiet. Notera var de stannar upp. Det är mer värt än 10 AI-reviews.

## F.4 Kompendiets referenser till *slidesen*

Flera ställen i kompendiet refererar till slides:

- Modul 2 övning 3: "introducerar vi *funktioner* i Bilaga A" — bra, refererar bilaga.
- Modul 5 rad 70: "Skelettet finns i slidesen; den kompletta lösningen finns i Bilaga D." — problematiskt för kompendium-läsaren utan slides.

**Fix:** ersätt "i slidesen" med antingen konkret sidhänvisning inom kompendiet eller med ett minimal-skelett inline. Kompendiet ska vara självständigt läsbart.

---

# Del G · Prioriteringsmatris

Uppdaterad efter att alla bilagor + research-doc lästs.

Impact-skala: ⭐⭐⭐ kritiskt, ⭐⭐ märkbart, ⭐ nice-to-have.
Ansträngning: realistisk tid för en erfaren skribent.

## Gör innan nästa kurskörning (kritiskt)

| # | Fix | Impact | Ansträngning | Var |
|---|---|---|---|---|
| 1 | Bilaga C: fixa "komponenter utanför kursen"-listan mot Basic-kit-verkligheten | ⭐⭐⭐ | 15 min | A.1 |
| 2 | Modul 3: ta bort "två buzzrar"-påståendet | ⭐⭐⭐ | 5 min | A.2 |
| 3 | Modul 1 slide talarnot: ta bort CH340-varningen | ⭐⭐⭐ | 5 min | A.3 |
| 4 | Röd/grön-lapp: introducera i slide "Din egen rytm" | ⭐⭐⭐ | 10 min | B.2 |
| 5 | Modul 4: "Varför 1 kΩ?" som `#fact`-box | ⭐⭐⭐ | 15 min | D.3.1 |
| 6 | Dag 1 agenda: explicit paus-rad | ⭐⭐⭐ | 5 min | C.1 |
| 7 | Modul 5: inkrementell byggprocess ersätter färdig lösning | ⭐⭐⭐ | 45 min | D.4.1 |
| 8 | Tröskel-värde: harmonisera till 300 globalt | ⭐⭐ | 10 min | B.6 |
| 9 | `map()`: egen sektion i modul 4 + rad i bilaga A | ⭐⭐ | 15 min | B.8 |
| 10 | RGB-LED modul 2 bildtext: harmonisera till "röd/katod/grön/blå" läsning | ⭐⭐ | 5 min | A.5 |
| 11 | Sense–act-loop: föraviseringar i modul 1, 2, 4 | ⭐⭐ | 20 min | B.3 |

**Summa kritiska fixar: ~2,5 timmar arbete** för 11 konkreta förändringar med dokumenterad impact.

## Gör snart (märkbart)

| # | Fix | Impact | Ansträngning | Var |
|---|---|---|---|---|
| 12 | Övning 2½ i modul 1 — morse-bro | ⭐⭐ | 15 min | C.2 |
| 13 | 15 mA-motivering i modul 1 | ⭐⭐ | 5 min | C.3 |
| 14 | LED_BUILTIN i modul 1 brödtext | ⭐⭐ | 10 min | C.4 |
| 15 | Upload-felsökning i modul 1, `#tip`-box | ⭐⭐ | 10 min | C.5 |
| 16 | Additiv vs subtraktiv färg, modul 2 | ⭐⭐ | 10 min | D.1.2 |
| 17 | `for`-loop anatomi, modul 2 | ⭐⭐ | 10 min | D.1.1 |
| 18 | INPUT_PULLUP översättningsregel, modul 3 | ⭐⭐ | 15 min | D.2.1 |
| 19 | Modul ↔ Lesson-mappning i bilaga (ny tabell) | ⭐⭐ | 20 min | B.1 |
| 20 | Bilaga/Appendix — global find-replace till "Bilaga" | ⭐ | 15 min | B.4 |
| 21 | Hackathon-tidsram i modul 5 | ⭐ | 5 min | D.4.2 |

**Summa märkbara: ~2 timmar** för 10 fler förändringar.

## Senare / optional

| # | Fix | Impact | Ansträngning | Var |
|---|---|---|---|---|
| 22 | Fallande flank-term, modul 3 | ⭐ | 5 min | D.2.2 |
| 23 | Ball-tilt switch-terminologi, modul 4 | ⭐ | 5 min | D.3.2 |
| 24 | Du/ni-konsistens över kompendiet | ⭐ | 30 min | F.2 |
| 25 | "Fem superkrafter"-metafor: välj strip eller bygg ut | ⭐–⭐⭐⭐ | 5 min eller 3 h | F.1 |
| 26 | `millis()` i bilaga A | ⭐ | 15 min | E.1 |
| 27 | Klisterlapp-trippel: ta bort från bilaga E | ⭐ | 5 min | E.5 |
| 28 | Bilaga F: korta historiska U/I-noten | ⭐ | 5 min | E.6 |
| 29 | "Skelettet finns i slidesen" — ersätt i modul 5 | ⭐⭐ | 10 min | F.4 |
| 30 | **Testpilot-läsning** (hitta en deltagare, låt läsa modul 1, observera) | ⭐⭐⭐ | 90 min + person | F.3 |

---

# Sammanfattning

## Det som är ovanligt bra i materialet

1. **Pin-tilldelningen är 100 % harmoniserad** mellan moduler — deltagarna återanvänder kopplingar in i hackathonen. Stor pedagogisk insats.
2. **"Inför nästa träff" → levereras** i nästa träff, varje gång. Sömmar håller.
3. **Bilaga F** är kursens bästa kapitel. Pedagogiskt strukturerad, alla delar hör ihop.
4. **Ton och rytm** i kompendiet är konsekvent och moget. Föredömligt.
5. **Talarnotiser i slides** är djupa och genomarbetade — en lärare kan improvisera tryggt utifrån dem.

## Det som bör fixas innan nästa kurskörning

De 11 kritiska fixarna i prioriteringsmatrisen (~2,5 timmar totalt arbete). Tre av dem är **bekräftade faktafel** mot referensdokumentet (A.1, A.2, A.3) — de gör att kursen sägs något annat än vad som är sant om kittet.

## Det enskilt största pedagogiska lyftet

Modul 5 omstrukturering (D.4.1). Att låta modul 5-brödtexten visa den *inkrementella* byggprocessen som modulen själv förespråkar, och flytta den färdiga lösningen till Bilaga D där den redan finns. Detta matchar pedagogiken med formen och ger deltagaren en bättre upplevelse både på hackathonen och vid efter-läsning.

## Det mest värdefulla nya insikten

**Testpilot-läsning** — att låta en radioamatör utan Arduino-förkunskap läsa modul 1 och bygga ensam från kompendiet. Det är en iterationshöjande investering som AI-reviews aldrig kan ersätta.
