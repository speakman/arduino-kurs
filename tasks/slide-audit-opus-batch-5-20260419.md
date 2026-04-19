# Opus-audit batch 5 — slides 35-43

**Granskare:** Opus max effort, 2026-04-19
**Omfång:** slides 35-43 (markdown-rader 1917-2269)
**PNG:** /tmp/slide-audit/slide-35.png … slide-43.png (1920×1080)

## Slide-översikt

| # | Titel | Rader |
|---|-------|-------|
| 35 | Läs knapp. Styr buzzer. | 1917–1953 |
| 36 | Kärnan i `loop()`. | 1917–1953 (default layout) |
| 37 | Arduinon lyssnar. (outro Modul 3) | 1954–1984 |
| 38 | Analog input (sektion, Träff 4 av 5) | 1986–2010 |
| 39 | Knappen var digital. Världen är analog. | 2012–2073 |
| 40 | `analogRead()` — Arduinons linjal. | 2075–2120 |
| 41 | Spänningsdelaren. | 2122–2222 |
| 42 | Koppla fotocellen. | 2224–2244 |
| 43 | Koppla tilt-sensorn. | 2246–2269 |

---

## 🔴 Kritiska fel

**Inga kritiska faktafel hittade.** Alla pin-nummer, resistorvärden, koppling och kod
stämmer överens med kompendiet (modul 3 & 4). Bilderna matchar captions där de är
verifierbara.

---

## ⚠️ Inkonsekvenser / kontinuitetsbrott

### Slide 39 — "Knappen var digital. Världen är analog." (rad 2012)

**Problem 1 — Bilden visar bara 2 av 3 fotoresistorer.**
- **Bevis:** Filen heter `photoresistors-three.jpg` (2400×1350) men på sliden visas
  den som `width:720px;height:720px;object-fit:cover` (rad 2023). En 1:1-beskärning
  från en 16:9-källa kapar ~35 % på varje sida, och den största (högra) fotocellen
  syns inte i renderingen. På `/tmp/slide-audit/slide-39.png` är endast den mellersta
  och den vänstra synliga.
- **Bevis rad:** `style="width:720px;height:720px;object-fit:cover;..."` (slides.md:2023)
- **Föreslagen fix:** Byt till `object-fit:contain` eller en rektangulär ruta
  (t.ex. `width:900px;height:520px;object-fit:cover` för ~16:9) så att alla tre
  exemplaren syns. Alternativt: använd `photoresistor-macro.jpg` som troligen visar
  en enda cell tydligare, och omformulera texten.

**Problem 2 — Texten säger "Fotocell (LDR) mäter ljus: 0–1023" (rad 2028).**
- **Bevis:** Tekniskt korrekt är att `analogRead(A0)` returnerar 0–1023 efter att
  spänningsdelaren översatt ljus → resistans → spänning. Fotocellen själv "mäter"
  inte i skalan 0–1023; den ändrar resistans. Slide 40-41 reder ut detta, men på
  slide 39 är formuleringen pedagogiskt missvisande.
- **Föreslagen fix:** Byt till `analogRead(A0) ger 0–1023` eller
  `Arduinons siffra: 0 (mörker) → 1023 (fullt ljus)`. Nu binds bilden till rätt
  abstraktion.

**Problem 3 — Presenter-notes beordrar "VISA också Tilt-sensorn" (rad 2060-2072) men tilt-sensor-sliden kommer först fyra slides senare (slide 43).**
- **Bevis:** Rad 2060: `VISA också Tilt-sensorn: "Det här lilla cylindriska pryllet..."`.
  Efter detta kommer slide 40 (analogRead), 41 (spänningsdelaren), 42 (koppla fotocellen)
  innan vi når slide 43 (koppla tilt). Om läraren följer notes visar hen tilten här,
  pratar om tjuvlarmet — men eleverna har ingen visuell referens på skärmen och ska
  sedan direkt hoppa in i fotocell-delarna i fyra slides.
- **Föreslagen fix:** Flytta tilt-introduktionen till presenter-notes på slide 43 där
  den hör hemma, eller lägg till en uppsamlare-slide mellan 42 och 43 (typ "Ni har
  fotocellen; nu tar vi den andra sensorn"). Alternativt: klipp bort "VISA också
  Tilt-sensorn"-blocket från slide 39.

### Slide 37 — "Arduinon lyssnar." (rad 1962)

**Problem — Formuleringen "En läser, den andra reagerar" är tekniskt vilseledande.**
- **Bevis:** Rad 1966: `En läser, den andra reagerar.` Men varken knappen eller
  buzzern "läser" eller "reagerar" — Arduinon gör båda delarna (läser via
  `digitalRead`, beslutar i `if/else`, driver buzzern via `digitalWrite`).
  Knappen är passiv input, buzzern är passiv output.
- **Föreslagen fix:** `Arduinon läser en — och styr den andra.` eller
  `En är sensor, den andra är aktuator. Arduinon är hjärtat mellan dem.`

### Slide 36 — "Kärnan i `loop()`" (rad 1926)

**Problem — Koden använder `knappPin` och `buzzerPin` men variabeldeklarationen finns inte på sliden.**
- **Bevis:** Slidens kodblock rad 1931-1935 visar `if (digitalRead(knappPin) == LOW)
  { digitalWrite(buzzerPin, HIGH); }` — men `knappPin = 9` och `buzzerPin = 12`
  deklareras aldrig på sliden. Presenter-notes (rad 1946-1952) förklarar att full
  sketch finns i kompendiet. **Detta är per design** enligt MEMORY-anvisningen
  "Komplett kod i kompendiet, inte på slide". Inte ett fel, men värt att notera:
  eleven som tittar på sliden isolerat vet inte *vilken pin* knappen sitter på.
- **Bedömning:** OK — matchar policyn, men en liten eyebrow-tag eller fotnot
  typ `knappPin = 9 · buzzerPin = 12 (från tidigare slides)` skulle stärka
  kontinuiteten utan att bryta policyn.

---

## 💡 Polish-förslag

### Slide 35 — "Läs knapp. Styr buzzer." (rad 1877)
- Center-layout med bara text fungerar bra som hero-slide för syntes. Pilen
  `INPUT → if / else → OUTPUT` (rad 1885) är tydlig. Inget att åtgärda.

### Slide 40 — "analogRead() — Arduinons linjal." (rad 2084)
- Tipboxen till höger säger `fotocell + 1 kΩ → pin A0` — korrekt, men förkortat
  schemat från slide 41 skulle hjälpa dem som bygger innan nästa slide kommer upp.
  Ej kritiskt; nuvarande layout är fin.

### Slide 41 — "Spänningsdelaren." (rad 2131)
- Extremt tät slide (text + schema + värdetabell + fotnoter). Den har gått igenom
  codex+gemini-review enligt presenter-notes, och ser nu ren ut i PNG:en. Inget
  att göra.
- Presenter-notes nämner "`analogRead(A0) ger 0–1023`" — konsekvent med SVG-texten
  ("mörkt → lågt värde · ljust → högt värde"). Inga motsägelser.

### Slide 42 — "Koppla fotocellen." (rad 2229)
- Caption på rad 2233: `Spänningsdelare: 5 V → fotocell → A0 → 1 kΩ → GND.
  Mörker ger lågt värde, ljus ger högt värde.` — exakt konsekvent med schemat och
  kompendiets Modul 4 (rad 80: "Mörker = LÅG siffra, ljus = HÖG siffra"). Bra.
- Elegoo-loggan uppe till höger följer branding-policy.

### Slide 43 — "Koppla tilt-sensorn." (rad 2251)
- **Bildverifikation (utförd):** Zoomade in `tilt-photo.png` och kan bekräfta att
  den svarta kabeln går till **GND**-pinnen (märkt "GND" på PCB bredvid "AREF") och
  den gula kabeln till **pin ~2** (märkt "~2" på PCB). Captionen "ena benet → D2,
  andra benet → GND" **STÄMMER**. Detta är den exakta typ av bild/text-bug som
  batch-exemplet på slide 14 flaggade — här är det korrekt.
- Captionen nämner att tilt är digital och läses med `digitalRead`. Matchar
  kompendiets Modul 4, rad 23 och 122.

---

## ✅ Bekräftat OK

- **Förbjudet språk:** Inga förekomster av `superkraft`, `magi`, `hjärna`, `sinne`,
  `sinnesorgan`, `röntgen` i slide 35-43. (Anmärkning: kompendiets Modul 3.typ har
  "sinnesorgan" på rad 10 och "magin förklarad" som rubrik på rad 59 — men detta
  är kompendietexten, inte slide-deck, så utanför policy-omfång för denna audit.
  Värt att följa upp i en kompendium-audit om den inte redan gjorts.)
- **Förbjudna referenser:** Inga "Lesson N", "sid N" eller ELEGOO-manualreferenser
  i slide 35-43. Branding-markörer ("Elegoo Basic Starter Kit" uppe till höger på
  slide 42 och 43) följer branding-policyn.
- **Pin-nummer-kontinuitet:** `knappPin=9`, `buzzerPin=12`, `tiltPin=2`, `ldrPin=A0`
  genomgående konsekvent med både Modul 3 (kompendium rad 41, 166-167) och Modul 5
  (rad 48-51, 111-112, 135). Inga pin-konflikter.
- **Koden i slide 36 kompilerar:** `if (digitalRead(knappPin) == LOW)` → giltig
  C++/Arduino-syntax. Variablerna förutsätts deklarerade utanför (vilket de är i
  kompendiets skelett, Modul 3 rad 166-181).
- **Koden i slide 40:** `int ljus = analogRead(A0);` — giltig, korrekt.
- **Resistorvärden:** 1 kΩ mot GND på slide 40, 41, 42. Fotocell ~50 kΩ (mörker)
  och ~500 Ω (solljus) på slide 40. Alla värden matchar kompendiets Modul 4 rad 22,
  80, 96-98.
- **Spänningsdelare-schema SVG:** Topologin `+5 V → fotocell → A0 → 1 kΩ → GND`
  matchar text och compendium. Värdetabellen (Hand över 20-100, Rumsljus 150-400,
  Lampa nära 500-700) matchar kompendium rad 88-92.
- **Slide 38 (Träff 4 av 5):** Korrekt numrering, Modul 4 = Sensorer & Serial Monitor.
- **Layout-integritet:** Ingen avklippt text eller överlappande element funna på
  någon av slide 35-43 i 1920×1080-renderingen.
- **Tilt-photo wiring (slide 43):** Visuellt verifierad till pin D2 + GND via
  zoomad crop.

---

## Sammanfattning

Slide 35-43 är pedagogiskt stringenta och faktamässigt korrekta. Inga kritiska
fel som liknar slide-14-exemplet. Tre mindre inkonsekvenser är värda att åtgärda:

1. **Slide 39 bild-beskärning** — `object-fit:cover` kapar bort den tredje
   fotocellen (filnamn lovar "three").
2. **Slide 39 textprecision** — "Fotocell mäter 0–1023" är tekniskt missvisande.
3. **Slide 39 presenter-notes** — tilt-introduktion på fel slide (hör till 43).

Mindre polish:
- Slide 37 "En läser, den andra reagerar" antropomorfierar passiva komponenter.
- Slide 36 skulle må bra av en diskret pin-referens (`knappPin = 9 · buzzerPin = 12`)
  i eyebrow-raden.
