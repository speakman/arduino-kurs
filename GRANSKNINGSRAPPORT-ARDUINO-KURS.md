# Granskningsrapport: Elektronik & Programmering med Arduino

**Datum:** 19 april 2026  
**Mål:** Djupgående analys av konsistens, pedagogik, korrekthet och kodens validitet i Arduino-kompendiet (Modul 1-5, Bilagor A-F samt presentationsmaterial).

---

## 1. Sammanfattande Omdöme
Materialet håller extremt hög kvalitet. Den röda tråden (att bygga ett fullständigt larm över fem träffar) är tydlig från första stund. Den pedagogiska trappan – från enkel `digitalWrite` (Act), via sensoravläsning (Sense), till en komplett Sense-Act-loop – är logisk, konsekvent och inbjudande för nybörjare.

Jag har inte hittat några allvarliga logiska krascher, felaktiga påståenden, eller kodavsnitt som skulle misslyckas med att kompilera. Alla referenser till pin-nummer är exakta mellan modulerna och hackathon-lösningen. 

*Inga filer har ändrats under denna granskning, i enlighet med instruktionerna.*

---

## 2. Pedagogisk & Teknisk Analys (Modul för Modul)

### Modul 1: LED & Krets
*   **Analys:** Perfekt introduktion. Ohms lag förklaras utan att överväldiga. Valet av 220 Ω (beräknat som (5V - 2V) / 0.015A = 200 Ω -> närmaste standardvärde 220 Ω) är matematiskt och praktiskt helt korrekt. Färgkoderna för både 4- och 5-bandsresistorer stämmer exakt.
*   **Betyg:** Utmärkt.

### Modul 2: PWM & RGB
*   **Analys:** Bra förklaring av PWM och duty cycle. Att specificera kittets LED som *Common Cathode* och att noga definiera benens ordning från den platta sidan (Röd, Katod, Grön, Blå) räddar många från frustration. Koden `ledR = 6, ledG = 5, ledB = 3` stämmer väl överens med hackathonen senare.
*   **Betyg:** Utmärkt.

### Modul 3: Digital Input
*   **Analys:** `INPUT_PULLUP` och den omvända logiken (LOW = tryckt) hanteras pedagogiskt. Det viktigaste är införandet av *Edge-detection* (flank-detektering). Utan detta kraschar hackathon-logiken. Den implementation ni använder (`if (state == LOW && lastState == HIGH)`) är robust för kursens nivå.
*   **Betyg:** Utmärkt.

### Modul 4: Analog Input
*   **Analys:** Spänningsdelarens matematik (i relation till LDR och 1kΩ) förklaras briljant via vattenrörs-analogin. Värdena ni anger som referens (mörker = 20-100, starkt ljus = 700-900) stämmer perfekt överens med en 50kΩ/500Ω LDR + 1kΩ resistor i spänningsdelare över 5V med 10-bitars ADC (0-1023). Tilt-sensorn anges korrekt som en digital sensor trots att den uppfattas som analog av nybörjare.
*   **Betyg:** Utmärkt.

### Modul 5: Hackathon (Integration)
*   **Analys:** Här knyts allt ihop. Pin-karta (D9, D2, A0, D12, D6, D5, D3) är 100% konsistent med alla tidigare moduler, vilket betyder att deltagarna inte behöver riva hela sin breadboard inför sista momentet, utan bara addera till den.
*   **Betyg:** Utmärkt.

### Bilagor (A-F)
*   **Analys:** Bilagorna håller mycket hög klass. Distinktionen mellan `#define` och `const int` (Bilaga A) är spot on för modern C++. Felmeddelandena i Bilaga B är verklighetsförankrade. Bilaga F är en fröjd för de som vill förstå elektroniken i detalj.

---

## 3. Detaljanmärkningar & Mindre Inkonsekvenser

Granskningen har varit djup och finkammat allt, och i ett så här omfattande material uppstår alltid några mycket små inkonsekvenser. De presenteras här sorterade efter hur "viktiga" de är. **Ingen av dem är systemkritisk**, men de är värda att notera.

*(Viktighetsgrad: 1 = Enbart en observation, 5 = Kräver omedelbar åtgärd)*

### 1. Serial Monitor "smyg-introduceras" i Modul 3 (Viktighet: 2/5)
*   **Var:** Modul 3, Hemma-övning 2.
*   **Problem:** Övningen säger: *"Du behöver lägga till `Serial.begin(9600);` i setup och `Serial.println(tryckCount);` i rätt del av loopen."*
*   **Inkonsekvens:** I Modul 4 introduceras Serial Monitor formellt, med rubriken "Första gången på kursen kan Arduinon kommunicera *tillbaka* till er". Detta skapar en mild kronologisk krock.
*   **Omdöme:** Egentligen inget problem då det är en valfri *hemma-övning* för de snabba/intresserade deltagarna, men värd att vara medveten om som instruktör ifall någon frågar under lektion 3.

### 2. Tilt-sensorns debounce-delay (Viktighet: 2/5)
*   **Var:** Modul 5:s tips-text vs Bilaga D (koden).
*   **Problem:** I Modul 5:s text ("Ordna koden i block") står det: *"För tilten... lägg `delay(50)` efter läsningen."* Men i den slutgiltiga fullständiga referenskoden i Bilaga D saknas denna specifika `delay(50)` precis vid läsningen.
*   **Inkonsekvens:** Istället förlitar sig koden i Bilaga D på en global `delay(10)` i slutet av loopen och inbyggda `delay(100)` i själva larmsignalen (buzzer-if-grenen).
*   **Omdöme:** Det i Bilaga D fungerar bra i praktiken och koden förblir renare, men textens tips reflekteras inte explicit i kodfacit.

### 3. Fysisk Layout på "Pin 14" (Viktighet: 1/5)
*   **Var:** Modul 1, Vanliga fel och snabblösningar.
*   **Problem:** Det står *"Kabeln till pin 13 sitter i pin 12 eller pin 14. Räkna hålen."*
*   **Inkonsekvens:** En standard Arduino Uno har ingen header utmärkt som "Pin 14" intill Pin 13. Hålet precis intill Pin 13 är märkt "GND". (Därefter AREF, SDA, SCL).
*   **Omdöme:** Marginellt. En nybörjare som råkar sätta kabeln i hålet bredvid 13 kommer ha satt den i GND och lampan lyser inte, så felsökningssteget fungerar, men "Pin 14" är tekniskt missvisande.

### 4. Larmlogiken är inte "Latching" (Viktighet: 1/5 - Endast en pedagogisk notering)
*   **Var:** Modul 5 och Bilaga D.
*   **Observation:** Logiken `if (larmPaslaget && tiltLutad)` innebär att larmet endast tjuter *medan* sensorn lutas och kulan kortsluter benen. Om man slutar skaka på larmet, slutar det tjuta direkt. Ett "verkligt" tjuvlarm hade fortsatt tjuta tills man stängde av det (så kallad *latching*).
*   **Omdöme:** Detta är **helt rätt beslut pedagogiskt**. Latching kräver fler tillståndsvariabler och en tids-loop, vilket hade gjort Modul 5 onödigt svår att greppa. Den nuvarande "reaktiva" koden är perfekt för nivån.

---

## 4. Slutsats

Detta är ett mycket välproducerat kursmaterial. Kombinationen av pedagogiska slides, ett djupt kompendium, avskalade kodskelett och starkt fokus på att deltagaren ska förstå "varför" i stället för att bara kopiera, är lysande. Konsekvensen i pin-numrering mellan modulerna är en detalj som verkligen höjer helhetsupplevelsen för användaren under Hackathon-träffen.

**Rekommendation:** Materialet är färdigt och distributionsredo. Inga fler ändringar är nödvändiga för att köra en succékurs.

/ AI Granskningsassistent
