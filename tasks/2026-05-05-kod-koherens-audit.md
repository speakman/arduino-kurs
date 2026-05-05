---
title: Kod-koherens & konsistens-audit (slides + kompendium)
date: 2026-05-05
scope: Alla cpp-fences i presentation/slides.md (inkl. presenter-notes) + alla cpp-block i kompendium/*.typ (5 modul-filer + 6 bilagor)
auditor: Senior Arduino reviewer (single-pass, manuell läsning av all källkod)
total_cpp_blocks_reviewed: ~45 distinkta kod-block / snippets
verdict_preview: SHIP med två små fix (B-kategori), inga A-kategori-blockers
---

# Sammanfattning

Genomgången omfattar alla `cpp`-block i `slides.md` (presenter-notes + slide-content) samt alla `cpp`-block i `kompendium/*.typ` (modul 1–5 + bilagor A, B, C, D, E, F). Materialet är **överlag mycket konsekvent**. Inga A-kategori-buggar (kod som inte skulle kompilera, fel pin-mapping mot kursens kanon, eller saknad pinMode på pinnar som kräver det). Alla pin-tilldelningar är konsekventa över alla 3 ytor (slides / modul-kompendium / Bilaga D).

De fynd som finns är:
- Två B/D-stylistik-avvikelser i slide-koden (slides 31 + 45/46) som bryter mot projektets egna namnkonventioner
- En medveten variabel-namn-skift mellan modul 3 och Bilaga D som **redan är dokumenterad** i Bilaga D:s tip-box — fungerar pedagogiskt
- Ett "klassrums-larm tjuter konstant"-problem som **redan är diskuterat** i presenter-notes (slide 35) och som hackathonen löser genom kombinerat `larmPaslaget && tiltLutad`-villkor

# A. Korrekthets-buggar — INGA fynd

Genomsökning av alla 45 cpp-block:

- Alla `pinMode`-anrop matchar pin-användningen
- Alla setup() i kompendiet (där fullständiga sketches finns) har korrekt `Serial.begin(9600)` när Serial används
- Alla `INPUT_PULLUP`-pinnar (D9 knapp, D2 tilt) har korrekt `pinMode(..., INPUT_PULLUP)` i tillhörande setup
- Alla `OUTPUT`-pinnar (D12 buzzer, D3/D5/D6 RGB, LED_BUILTIN) har korrekt `pinMode(..., OUTPUT)`
- Alla PWM-anrop (`analogWrite`) går till PWM-pinnar (3, 5, 6, 9, 10, 11)
- A0 används korrekt med `analogRead`, aldrig med `digitalRead`. Tilt på D2 läses korrekt med `digitalRead`, aldrig med `analogRead`
- Alla baudrates är 9600 överallt (slides + kompendium)
- Inga syntax-fel (semikolon, brace-matchning, etc.) hittade

**Specifika edge cases som granskats och godkänts:**
- Slide 39 / Modul 4 kompendium rad 152-153: bortkommenterad `pinMode(A0, INPUT)` med kommentar "onödigt men inte fel" — pedagogiskt motiverat, projektpolicy enligt CLAUDE.md
- Slides 33 + 35 (flank-mönstret): visar bara loop-snutt utan setup. Setup-detaljerna ligger i presenter-notes (rad 1751-1753, 1977-1980) — pedagogiskt motiverat ("Kärnan i loop()") och kompendium-Modul-3 har full sketch
- Slide 31 (rad 1604-1611): kort `if (digitalRead(knappPin) == LOW)`-snippet utan medföljande pinMode. OK eftersom `pinMode(knappPin, INPUT_PULLUP)` visas direkt på föregående slide (slide 30, rad 1536)
- Active-buzzer-test-sketch i slide 33-presenter-notes (rad 1825-1840): komplett, korrekt setup + loop, korrekt pin (12), korrekt logik. ✓

# B. Pin-mappnings-konsistens — KONSEKVENT genomgående

Verifierad korstabell:

| Komponent | Slides | Kompendium-modul | Bilaga D | Status |
|-----------|--------|------------------|----------|--------|
| Knapp | D9 (slide 30, 32, 34, 35, 47) | D9 (modul 3 rad 81, 121, 169; modul 5 rad 50) | D9 (rad 33) | ✓ |
| Active buzzer | D12 (slide 33, 34, 35, 47) | D12 (modul 3 rad 170; modul 5 rad 51, 112) | D12 (rad 36) | ✓ |
| Tilt-sensor | D2 (slide 44, 45, 47) | D2 (modul 4 rad 132, 182; modul 5 rad 50, 111) | D2 (rad 34) | ✓ |
| Fotocell | A0 (slide 39, 41, 45, 46, 47) | A0 (modul 4 rad 19, 85, 182; modul 5 rad 50, 135) | A0 (rad 35) | ✓ |
| RGB R/G/B | D6/D5/D3 (slide 22, 23, 47) | D6/D5/D3 (modul 2 rad 51-53, 117-119, 187; modul 5 rad 53-55) | D6/D5/D3 (rad 37-39) | ✓ |
| LED_BUILTIN | pin 13 (slide 18-21, 33; modul 1 hela; modul 3 hemma-övning) | LED_BUILTIN och pin 13 används synonymt | n/a | ✓ |

**Ingen avvikelse hittad.** Pin-tilldelningarna är 100 % stabila genom hela materialet.

## Två B-kategori-stylistik-avvikelser (rekommenderad fix)

**B1. Slide 45-46 (`slides.md` rad 2625, 2630): magic number `2` istället för `tiltPin`-konstant**

```cpp
void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT_PULLUP);   // ← magic number
}

void loop() {
  int ljus  = analogRead(A0);
  int tilt  = digitalRead(2);  // ← magic number
  ...
}
```

Bryter mot projektets egna konvention (`const int tiltPin = 2;` används överallt annars). Kompendiet Modul 4 rad 182 säger uttryckligen `tiltPin = 2`. Detta är den första riktiga sketchen där eleverna ser tilt-sensorn — om läraren låter dem skriva av exakt det här blir det en regress jämfört med tidigare moduler.

**Förslag:** Lägg till `const int tiltPin = 2;` överst och byt `2` mot `tiltPin` i båda förekomster:

```cpp
const int tiltPin = 2;

void setup() {
  Serial.begin(9600);
  pinMode(tiltPin, INPUT_PULLUP);
}

void loop() {
  int ljus = analogRead(A0);
  int tilt = digitalRead(tiltPin);
  Serial.print("ljus="); Serial.print(ljus);
  Serial.print(" tilt="); Serial.println(tilt);
  delay(200);
}
```

**B2. Slide 41 presenter-notes (`slides.md` rad 2204-2205): pot-demo-sketch använder magic A0**

```cpp
void setup()  { Serial.begin(9600); }
void loop()   { Serial.println(analogRead(A0)); delay(50); }
```

Detta är pre-koppling-läraren-kör-själv-koden — inte elev-kod. Mindre allvarligt men inkonsistent. Kan accepteras som "demo-snippet, inte production-kod". **Ingen åtgärd nödvändig** men noteras för fullständighet.

# C. Variabel-namn-konsistens

## Huvudkonventioner (etablerade och konsekventa)

- Pin-konstanter: `camelCase` + `Pin`-suffix → `knappPin`, `tiltPin`, `ldrPin`, `buzzerPin`. Konsekvent.
- RGB: `ledR`, `ledG`, `ledB` (utan Pin-suffix). Konsekvent.
- Tröskel: `morkTroskel` i Modul 5 + Bilaga D. Konsekvent.
- Larm-tillstånd: `larmPaslaget` (bool). Konsekvent över alla ytor.
- Ljus-värde: `ljus` (int). Konsekvent.

## En medveten naming-skift mellan Modul 3 och Bilaga D

Modul 3 + slides använder `state` / `lastState`. Bilaga D + Modul 5 kompendium steg 1 använder `knappState` / `lastKnappState`. **Detta är redan dokumenterat** i Bilaga D rad 123-125 (tip-box "Naming-skifte mot Modul 3") med pedagogisk motivering: "i Bilaga D läser flera tillstånd i samma loop, då är `state` för otydligt". Bra.

Modul 5 kompendium steg 2 (rad 119) introducerar dessutom `tiltLutad` som lokal bool — också OK och konsekvent med Bilaga D rad 73.

## En liten dubblett att vara medveten om

I Modul 3 kompendium (rad 122) står `bool larmPaslaget = false;` deklarerat globalt OVANFÖR `void loop()` — men `void setup()` saknas helt i den lilla edge-detection-sketch på rad 121-134. Det är ett trimmat snippet, inte fullständig sketch — fullständig finns i samma kapitel under "Bygg från minnet" (rad 167-189). Pedagogiskt OK eftersom det följs av "Bygg från minnet"-sektionen som visar full sketch.

# D. Comment-konvention

- **Språk: konsekvent svenska.** Inga engelska kommentarer hittade som borde varit svenska.
- Stil: inline `//` dominerar, blockkommentarer används bara för rubrik-band i Bilaga D (de snygga `// ─── … ──`-banden). Konsistent.
- Pedagogisk ton: kommentarerna förklarar VARFÖR (`// edge-detection — annars flippar larmet 10000 ggr/sek` i konceptuell form) eller etablerar pin-roll (`// Modul 3 — digital in`). Inga kommentarer som upprepar koden trivialt.
- Inget barnsligt språk hittat (inga "superkrafter", "magi", "hjärnan", "sinnen", "röntgen" — projektpolicy efterlevs)
- Inga elev/lärar-direktiv ("ropa om du fastnar") i koden eller kommentarerna. (De finns i presenter-notes som naturlig del av lärar-instruktionerna men det är OK eftersom presenter-notes inte är elev-material.)

# E. Code-style-konsistens

- **Indentation: 2 spaces överallt.** Verifierad i alla ~45 block.
- **Brace-stil: `void setup() {` på samma rad** — K&R-stil, konsekvent.
- **Mellanrum efter `if`/`for`/`while`: `if (x)` med space.** Konsekvent.
- **Inga long lines** som spränger slide-bredd. `big-code`-klassen används där koden är förstorad.
- Ternary-operator (`?:`) används konsekvent som `digitalWrite(buzzerPin, larmPaslaget ? HIGH : LOW)` — pedagogiskt motiverat och förklarat när det först införs (slide 33 presenter-notes rad 1747-1749 + Modul 3 rad 246).
- `const int` används konsekvent för pin-nummer och trösklar genom hela materialet (slides + kompendium + Bilaga D). `#define`-debatten finns bara i Bilaga A som pedagogisk diskussion — inte använd i någon faktisk sketch.

# F. Pedagogisk progression

**Mycket bra progression** — koden växer i komplexitet på ett sätt som matchar pedagogiken:

| Modul | Kod-element introducerade |
|-------|---------------------------|
| 1 | `pinMode`, `digitalWrite`, `delay`, `LED_BUILTIN`, `const int` |
| 2 | `analogWrite`, RGB-pin-grupp |
| 3 | `digitalRead`, `INPUT_PULLUP`, `if`/`else`, `bool`, `int` (utan const), edge-detection-mönstret, `!`-operator, ternary `?:` |
| 4 | `analogRead`, `Serial.begin/print/println`, `map()` |
| 5 | Sammanvävning, `else if`, hjälpfunktion `sattFarg()` |

Inga repetitioner som upprepar onödigt. Varje modul bygger vidare. **Slide ↔ kompendium-matchning** är 100 % på pin-tilldelningar och variabel-namn (utöver det medvetna `state` → `knappState`-skiftet i Bilaga D).

Modul 3 kompendium rad 39-47 introducerar konceptet `const` vs `int` explicit — exakt rätt punkt eftersom det är där `bool larmPaslaget` (mutabel) först behövs. Bra pedagogik.

# G. Subtila saker

## Delay-värden — konsekventa

| Värde | Användning | Förekomst |
|-------|-----------|-----------|
| `delay(10)` | Loop-tail mot studs | Slides 33, 35; Modul 3 rad 132, 187; Modul 5 rad 99, 193; Bilaga D rad 105 |
| `delay(50)` | Tilt-debounce efter `digitalRead(tiltPin)` | Slide 44 presenter; Modul 4 rad 134, 239; Modul 5 rad 184, 203; Bilaga D rad 74 |
| `delay(100)` | Serial Monitor-läsning | Modul 4 rad 161; slide 39 |
| `delay(200)` | Slide 45-46 Serial Monitor-loop, debug-print | Slide 46 rad 2635; Modul 5 rad 177 |
| `delay(1000)` | Blink-rytm | Modul 1 + slide 17 |

**Inget magiskt** — alla delay-värden har pedagogisk motivering i texten omkring.

## Serial.print vs Serial.println

Granskat: `println` används korrekt vid radslut, `print` när text+värde ska kombineras. Inkonsekvenser: inga.

## Boolska uttryck

Två stilar förekommer parallellt:
- `digitalRead(pin) == LOW` (komparativt, dominant — slides 31, 32, 35; Modul 3, 4, 5; Bilaga D)
- `(digitalRead(tiltPin) == LOW)` lagrad i `bool tiltLutad` (Modul 5 rad 119, Bilaga D rad 73)
- `state == LOW && lastState == HIGH` (edge-detection — slides 33, 35; Modul 3, 5; Bilaga D)

`!digitalRead(pin)` används **aldrig**. Kursen håller sig konsekvent till explicit `== LOW`-jämförelse, vilket är **rätt val pedagogiskt** (mer läsbart för nybörjare).

## Magic numbers

- `255` (PWM max) förklaras explicit Modul 2 rad 19, slide 23
- `1023` (analogRead max) förklaras Modul 4 rad 19, 45 (10-bits ADC), slide 39 + 40
- `220 Ω` (resistor) förklaras genomgående med Ohms lag (Modul 1 rad 86-90, Bilaga F)
- `9600` (baudrate) förklaras Modul 4 rad 20, 163-164
- `300` (morkTroskel) explicit kommenterat som "kalibrera själv" på alla förekomster (Modul 5 rad 137, 197; Bilaga D rad 43, 117)
- `120, 60, 20` stämningsljus-RGB — används konsekvent i Modul 5 + Bilaga D + Variation 3 (där implicit (S, S/2, S/6) ger samma proportion när S=120)

## #include-direktiv

Inga hittade. Korrekt — Arduino IDE inkluderar `Arduino.h` automatiskt och kursen använder inga externa bibliotek. Bilaga B rad 67-69 förklarar dessutom situationen om någon ser felmeddelandet `'LED_BUILTIN' was not declared`.

# Det som är BRA

- **Pin-konsistens 100 %** över alla tre ytor (slides, modul-kompendium, Bilaga D)
- **Inkrementell uppbyggnad i Modul 5 kompendium** (steg 1 → 2 → 3) är pedagogiskt utmärkt — varje steg är en självständig verifierbar enhet
- **Bilaga D är produktionskvalitet:** hjälpfunktion `sattFarg()`, dokumenterad initialisering av `lastKnappState = HIGH`, kommenterade rubrik-band, alla pinModes på plats, extra Variations som pedagogiskt visar `static`, hysteres, fade-in
- **Variabel-namn-skiftet `state` → `knappState`** i Bilaga D är medvetet och dokumenterat — inte ett fel
- **`delay(50)` för tilt-debounce** är konsekvent placerat i alla sketcher
- **Active buzzer "klisterlappen stannar på"-varning** repeteras på slide 33, Modul 3 rad 159, Bilaga C rad 137-138 — bra att den är överrepresenterad
- **Edge-detection-mönstret** har samma struktur i 4 olika sketcher (slide 33 demo, slide 35 buzzer-larm, Modul 5 steg 1, Bilaga D) — eleverna ser samma mönster återkomma med små variationer
- **Bilaga A** ger formell syntax-grammatik som komplement till slides — alla operatorer, datatyper, scope, funktioner formellt definierade
- **Serial Plotter** introduceras som komplement till Serial Monitor utan att tappa fokus

# Verdict

**SHIP** — kursmaterialets kod är produktionsklart. De två B-kategori-fynden är stylistik (B1: `tiltPin`-konstant istället för magic `2` i slides 45/46) och kan fixas i en 2-minuters edit men blockerar ingenting för dagens pass. Inga elever kommer slå huvudet i något.

Rekommenderad åtgärd före nästa Modul-4-pass: fixa B1 i `slides.md` rad 2622-2637 så att eleverna ser den `const int tiltPin = 2;`-konvention de redan använt i Modul 3 och som de kommer använda i hackathonen. 5-minuters fix.
