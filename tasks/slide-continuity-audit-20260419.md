# Kontinuitets-audit av slides — 2026-04-19

Sonnet Explore-agent, fullt read av `presentation/slides.md` + stickprovskontroll mot rendered JPGs.

## Fynd (prioriterade)

### Fynd 1: `ledR/G/B` — orphan-variabler i hackathon-mallen
**Slide 50 (Modul 5 startmall)** listar `ledR / G / B` som tilldelade pin 6/5/3.

**Problem:** Variablerna definieras aldrig i Modul 2-slides. All synlig kod använder literaler (`analogWrite(6, 200)` etc. efter dagens fix). Hackathon-mallen refererar till variabler ingen lärt sig att definiera.

**Förslag:** Lägg `const int ledR = 6; const int ledG = 5; const int ledB = 3;` i Modul 2:s kodexempel och använd dessa namn konsekvent — analogt med hur `knappPin/buzzerPin` hanteras i Modul 3.

---

### Fynd 2: `ldrPin` och `tiltPin` — orphan-variabelnamn
**Slide 50 (startmall)** listar `ldrPin` (A0) och `tiltPin` (D2).

**Problem:** Modul 4-koden använder alltid literals: `analogRead(A0)`, `digitalRead(2)`. Variablerna deklareras aldrig på synliga slides. Samma mönster som Fynd 1, fast för Modul 4.

**Förslag:** Visa `const int ldrPin = A0;` och `const int tiltPin = 2;` i Modul 4:s kodexempel.

---

### Fynd 3: `const int` — forward-reference i Modul 3
**Slide 28** säger: "I morse har ni redan använt `const int` — för pin-nummer."

**Problem:** I Modul 1:s synliga kodslides används aldrig `const int`. Blink visar `pinMode(13, OUTPUT)` med literal. `const int` förekommer bara i speaker notes och kompendium. Referensen "ni har redan använt" antar off-slide-exponering.

**Förslag:** Antingen visa ett `const int ledPin = 13;`-exempel i Modul 1:s kodslides, eller byt formulering till "du kan ha stött på `const int` i kompendiet".

---

### Fynd 4: `morkTroskel` — utlovat callback som inte levereras
**Slide 46 speaker notes:** "Det numret används som `morkTroskel` i Modul 5."

**Problem:** `morkTroskel` dyker aldrig upp på Modul 5-slides eller startmallen. Utlovat variabelnamn saknar landningsplats.

**Förslag:** Lägg till `int morkTroskel = 300;` i startmallen (slide 50), eller ta bort referensen från Modul 4-talarmanuset.

---

### Fynd 5: `niva` — deklareras men används aldrig
**Slide 32 (INPUT_PULLUP)** visar `int niva = digitalRead(knappPin);`.

**Problem:** Variabeln används inte i efterföljande kodexempel. Alla följande slides läser knappen inline (`if (digitalRead(knappPin) == LOW)`). Onödig kognitiv last.

**Förslag:** Ta bort `niva`-raden och visa direkt `digitalRead()` inline. Eller använd `niva` konsekvent i efterföljande if-exempel.

---

### Fynd 6: Förbjudet ord `sinnet` i talarmanus
**Slide 29/30 speaker notes:** "Och det första sinnet vi ger den: en knapp."

**Problem:** `sinnet` är singularformen av förbjudet `sinnen`. Agenten från tidigare kontinuitetssökning hittade det (nya greppet `\bsinnet\b` bekräftar).

**Förslag:** Byt till "Och den första sensorn vi kopplar in: en knapp."

---

### Fynd 7: `tryckCount` — introduceras men används aldrig
**Slide 28** visar `int tryckCount = 0;` som illustration av muterbar variabel.

**Problem:** Används inte i Modul 3 eller startmallen. Introducerar ett namn som aldrig återkommer.

**Förslag:** Ersätt med variabel som faktiskt används senare (t.ex. `lastState` från flanken-sliden), eller ta bort.

---

### Fynd 8: Pin 9 både PWM-lista och knapp-pinne
**Slide 23 speaker notes** listar PWM-pinnar "3, 5, 6, 9, 10, 11". **Slide 28** tilldelar `knappPin = 9`.

**Problem:** Tekniskt OK (`digitalRead(9)` fungerar), men förvirrande för nybörjare som ser pin 9 i båda rollerna.

**Förslag:** Kort parentetiskt förtydligande vid knapp-tilldelningen: "Pin 9 stöder PWM men vi använder den digitalt här — det är helt ok."

---

### Fynd 9: Terminologi `sketch` vs `program` vs `kod`
**Slide 16/18** blandar "program ("sketch")", "Er första sketch". Speaker notes är inkonsekventa.

**Förslag:** Välj ett primärord (`sketch`) och håll konsekvent i synliga slides.

---

### Fynd 10: Hysteres utlovas i Modul 4 men uteblir i Modul 5
**Slide 43 speaker notes:** "Lösningen kallas hysteres: olika trösklar för av/på. Det tar vi som bonus i Modul 5 om någon fastnar där."

**Problem:** Inga Modul 5-slides eller speaker notes om hysteres.

**Förslag:** Byt formulering till "finns i kompendiet" utan att antyda lektionsmoment.

## Sammanfattning: mest blockerande

- **Fynd 6** (`sinnet`) — hårdpolicy-brott. **Omedelbar fix.**
- **Fynd 1/2** (`ledR/G/B`, `ldrPin/tiltPin`) — hackathon-mallen hänvisar till odefinierade variabler. Medelhög prioritet; löses konsistent med Fynd 3.
- **Fynd 3** (`const int` morse-ref) — enkel textjustering.
- **Fynd 4** (`morkTroskel` uteblir) — trivialt men löftesbrytande.
- **Fynd 5, 7** — döda variabler, pedagogisk städning.
- **Fynd 8, 9, 10** — polish, lågprio.
