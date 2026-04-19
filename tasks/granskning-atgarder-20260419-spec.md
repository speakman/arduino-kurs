# Spec: Åtgärder från Gemini-granskning 2026-04-19

**Källa:** `GRANSKNINGSRAPPORT-ARDUINO-KURS.md` (Gemini 3.1 Pro, 2026-04-19)
**Scope:** Tre mindre textfixar + en kodfix i Appendix D. Inga pedagogiska omskrivningar.
**Princip:** Minsta möjliga ändring per problem, men full konsistens över alla material.

---

## Problem 3 — "Pin 14" (viktighet 1/5)

### Vad
Felsökningstexten i Modul 1 hänvisar till "pin 14", som inte finns som header på Arduino Uno. Hålet bredvid pin 13 är `GND`.

### Åtgärd
**Fil:** `kompendium/01-modul-1.typ`, rad 162

**Före:**
```
([*`Blink` kompilerar men inget händer*], [Kabeln till pin 13 sitter i pin 12 eller pin 14. Räkna hålen.]),
```

**Efter:**
```
([*`Blink` kompilerar men inget händer*], [Kabeln till pin 13 sitter i pin 12 eller GND (hålet precis bredvid pin 13). Räkna hålen.]),
```

### Kaskad
Ingen. "Pin 14" förekommer bara på denna enda rad i hela projektet.

---

## Problem 1 — Serial Monitor introduceras tyst i Modul 3 (viktighet 2/5)

### Vad
Modul 3:s valfria hemma-övning säger till eleven att använda `Serial.begin` och `Serial.println`. Modul 4 påstår sedan att Serial Monitor "öppnades för första gången". Motsägelse.

### Åtgärd (två ställen)

**A. `kompendium/04-modul-4.typ`, rad 25**

**Före:**
```
Ni byggde spänningsdelaren med fotocellen, öppnade Serial Monitor för första gången, och såg siffrorna ändra sig i realtid när ni höll handen över cellen. Det var Arduinons första riktiga mätinstrument.
```

**Efter:**
```
Ni byggde spänningsdelaren med fotocellen, öppnade Serial Monitor tillsammans för första gången i klassrummet, och såg siffrorna ändra sig i realtid när ni höll handen över cellen. Det var Arduinons första riktiga mätinstrument.
```

(Tillägget "tillsammans … i klassrummet" gör det sant även för elever som testat i hemma-övningen.)

**B. `presentation/slides.md`, rad 2335 (presenter note i Modul 4:s Serial Monitor-slide)**

**Före:**
```
Detta är första gången kursen verkligen öppnar dörren för felsökning.
```

**Efter:**
```
Detta är första gången i klassrummet som kursen verkligen öppnar dörren för felsökning.
```

**C. `kompendium/03-modul-3.typ`, rad 198 (förtydliga hemma-övningens preview-status)**

**Före:**
```
Skriv en sketch som räknar antalet knapptryckningar (med edge-detection) och skriver ut det totala antalet på Serial Monitor varje gång någon trycker. Du behöver lägga till `Serial.begin(9600);` i setup och `Serial.println(tryckCount);` i rätt del av loopen.
```

**Efter:**
```
Skriv en sketch som räknar antalet knapptryckningar (med edge-detection) och skriver ut det totala antalet på Serial Monitor varje gång någon trycker. Du behöver lägga till `Serial.begin(9600);` i setup och `Serial.println(tryckCount);` i rätt del av loopen. (Serial Monitor gås igenom ordentligt nästa vecka i Modul 4 — den här övningen är en förhandstitt.)
```

### Kaskad
- Bara ovanstående tre ställen. Modul 3:s brödtext nämner inte Serial Monitor (bara hemma-övningen). Andra moduler är opåverkade.

---

## Problem 2 — Tilt debounce saknas i kodfacit (viktighet 2/5)

### Vad
Text och slides på sex ställen säger "`delay(50)` efter `digitalRead(tiltPin)`". Appendix D:s facit saknar raden.

### Åtgärd

**Fil:** `kompendium/appendix-d-hackathon-losning.typ`

**1. Koden (rad 73 i källan, rad 42 i rendered code block)**

**Före (källa rad 72–74):**
```cpp
  int  knappState = digitalRead(knappPin);
  bool tiltLutad  = (digitalRead(tiltPin) == LOW);
  int  ljus        = analogRead(ldrPin);
```

**Efter:**
```cpp
  int  knappState = digitalRead(knappPin);
  bool tiltLutad  = (digitalRead(tiltPin) == LOW);
  delay(50);  // debounce tilt — kulan bouncar i hylsan
  int  ljus        = analogRead(ldrPin);
```

**Motivering för oconditionell `delay(50)`:** Matchar texten bokstavligen ("lägg delay(50) efter läsningen"). I praktiken kostar det 50 ms per loop-varv — knapp-responsen går från ~10 ms till ~60 ms worst case, vilket är omärkbart för människan. Trigger-grenen innehåller redan `delay(100) + delay(100)`, så den påverkas proportionellt sett ännu mindre.

**2. Rad-referenser i "Rad-för-rad-förklaring" (skiftas +1 p.g.a. ny rad)**

| Sektion | Före | Efter |
|---|---|---|
| Edge-detection | `(rad 45–50)` | `(rad 46–51)` |
| Tre grenar av if/else | `(rad 54–72)` | `(rad 55–73)` |
| `delay(10)` sist | `(rad 76)` | `(rad 77)` |

Ändringar i källan:
- Rad 128: `=== Edge-detection (rad 45–50)` → `=== Edge-detection (rad 46–51)`
- Rad 134: `=== Tre grenar av if/else (rad 54–72)` → `=== Tre grenar av if/else (rad 55–73)`
- Rad 140: `=== \`delay(10)\` sist (rad 76)` → `=== \`delay(10)\` sist (rad 77)`

### Varför koden, inte texten
Texten är konsekvent på sex ställen — ändra dem alla skulle vara mycket större kaskad med risk för missad förekomst. Att lägga en rad i facit matchar det elever faktiskt förväntas skriva, och validerar deras instinkt.

### Kaskad
- `Pin-tilldelning (rad 2–8)`, `morkTroskel (rad 12)`, `lastKnappState (rad 16)`, `sattFarg() (rad 19–23)` — alla **opåverkade** (före loop-funktionen).
- Inga slide-ändringar — slides säger redan "delay(50) efter läsningen", vilket nu stämmer med koden.

---

## Problem 4 — Ingen latching (viktighet 1/5)

**Åtgärd: Ingen.** Gemini bedömer det som "helt rätt beslut pedagogiskt". Inget att fixa.

---

## Implementationsordning

1. **Modul 1 Pin 14-fix** (en rad, noll risk) — warm-up.
2. **Modul 3 hemma-övning preview-notis** (en mening).
3. **Modul 4 "första gången i klassrummet"** (en fras).
4. **Slide 2335 "första gången i klassrummet"** (en fras).
5. **Appendix D kod: lägg till delay(50)** (en rad).
6. **Appendix D rad-referenser +1** (tre rader).
7. **Bygg om PDF:er** via `kompendium/build.sh`.
8. **Verifiera**: öppna varje PDF, sök efter gamla värden ("pin 14", "för första gången" i Modul 4, "rad 76"), bekräfta nya värden.

## Verifikation

**Efter bygge, kör dessa sökningar och förvänta noll träffar:**
```
grep -r "pin 14" kompendium/*.typ
grep -rn "rad 76" kompendium/appendix-d*.typ
grep -rn "rad 54–72\|rad 45–50" kompendium/appendix-d*.typ
```

**Förvänta fortsatta träffar (dessa ändrar vi INTE):**
- Alla text-omnämnanden av `delay(50)` som debounce — finns kvar på 6+ ställen, nu i linje med koden.

**Manuell genomläsning:**
- Modul 1 felsökningstabell — nya formuleringen "GND (hålet precis bredvid pin 13)".
- Modul 3 hemma-övning 2 — preview-notisen.
- Modul 4 första stycket under "Kvällens nyheter" — "tillsammans ... i klassrummet".
- Appendix D loop-koden — `delay(50)` på rätt rad med korrekt kommentar.
- Appendix D rad-referenser — alla tre uppdaterade.

## Rollback

Git är kontrollen. Om bygge eller granskning hittar problem:
```
git checkout -- kompendium/01-modul-1.typ kompendium/03-modul-3.typ \
  kompendium/04-modul-4.typ kompendium/appendix-d-hackathon-losning.typ \
  presentation/slides.md
```
Sedan rebuild.

## Explicit UTANFÖR scope

- Alla övriga "delay(50)" omnämnanden i texten — de stämmer efter denna fix, rör dem inte.
- Latching-larmet (Gemini punkt 4) — pedagogiskt korrekt som-det-är.
- PDF:erna i `deliveries/` — regenereras från build.sh.
- Slide-kodexemplet (slides.md rad 2305) — det är Modul 4:s isolerade Serial Monitor-exempel, inte tilt-koden. Opåverkat.
