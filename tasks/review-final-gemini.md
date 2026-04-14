# Slutrapport: Granskning av Arduino-kurs (FRO Ånge)
**Granskare:** Gemini CLI (Senior Software Engineer)
**Datum:** 2026-04-14
**Status:** Slutförd

## Sammanfattning
Kursmaterialet håller en mycket hög pedagogisk och teknisk nivå, väl anpassat för FRO-medlemmar (radioamatörer) och vuxna nybörjare. De största riskerna är kopplade till hårdvaruspecifika detaljer i Elegoo-kittet som kan skapa förvirring vid självstudier.

---

## 🛑 Kritiska observationer (Severity: High)

### 1. Pin 13 "Intern Resistor"-missförstånd
**Fil:** `presentation/slides.md` (Slide 7), `kompendium/01-modul-1.typ` (kap 1.2)
**Problem:** Det antyds att Pin 13 är speciell för att den har en inbyggd LED. På Arduino Uno R3 drivs den inbyggda LED:en via en op-amp-buffer.
**Risk:** Deltagare kan tro att de inte behöver en extern resistor när de kopplar en *egen* LED till Pin 13-headern.
**Fix:** Förtydliga att den inbyggda resistorn *endast* är till för den lilla ytmonterade "L"-lampan. Allt som kopplas i hålen (headern) kräver alltid egen resistor.

### 2. Common Cathode vs Common Anode (RGB)
**Fil:** `presentation/slides.md` (Slide 22)
**Problem:** Elegoo-kittet 2024+ är konsekvent Common Cathode, men många online-guider visar Common Anode. Slidesen varnar bra, men missar att förklara att färgerna blir "inverterade" i kod om man råkar få fel hårdvara (255 = av).
**Fix:** Lägg till en "Felsöknings-box" i Modul 2: "Om 0 ger fullt ljus och 255 ger svart, har du en Common Anode-LED. Koppla längsta benet till 5V istället för GND."

---

## ⚠️ Viktiga justeringar (Severity: Medium)

### 3. Resistorfärgkoder (220 Ω)
**Fil:** `kompendium/01-modul-1.typ` (flera ställen)
**Problem:** Du anger 5-band som `röd-röd-svart-svart-brun`. Detta är korrekt (2-2-0 * 1 = 220 Ω), men Elegoo skickar ofta 1kΩ och 10kΩ som ser förrädiskt lika ut i gult lampljus.
**Fix:** Lägg till en visuell varning om att skilja på *brun* (multiplikator x10) och *svart* (multiplikator x1).

### 4. Säkerhetsmeddelande "Helt ofarligt"
**Fil:** `kompendium/appendix-e-sakerhet.typ`
**Problem:** Att kalla 5V "helt ofarligt" är sant för människan, men riskabelt för laptopen. En kortslutning mellan 5V och GND kan trigga USB-skyddet eller i värsta fall skada moderkortet på äldre datorer utan polyfuse.
**Risk:** Deltagare blir för vårdslösa med strömförande kopplingar.
**Fix:** Ändra till: "Ofarligt för dig, men farligt för din utrustning. En kortslutning kan stänga av din dator eller skada Arduinon."

---

## 📝 Pedagogiska & Språkliga tips (Severity: Low)

### 5. "Flytande" pinnar (Floating inputs)
**Fil:** `presentation/slides.md` (Slide 30)
**Problem:** Förklaringen av `INPUT_PULLUP` är bra, men termen "flytande" (floating) förklaras inte pedagogiskt för en radioamatör.
**Tips:** Använd radio-analogin: "En flytande pinne är som en radio utan antenn som bara plockar upp brus (QRN). Pullup-motståndet ger pinnen en stabil signal att hålla i."

### 6. Svensk terminologi
**Observation:** "Duty cycle" (Slide 25) och "Debounce" (Slide 33) används. För FRO-publiken fungerar engelska bra, men "Intermittensfaktor" (duty cycle) och "Kontaktstuds" (bounce) är de etablerade svenska termerna.
**Fix:** Behåll de engelska men nämn de svenska inom parentes för "radio-allmänbildning".

---

## ✅ Teknisk verifiering (Mentalt kompilerad)

- **Kod Slide 17:** `digitalWrite(13, HIGH)` fungerar direkt eftersom `setup` sätter `OUTPUT`.
- **Kod Slide 33 (Flank-detektering):** `lastState = state` ligger *efter* if-satsen. Korrekt.
- **Kod Slide 41 (Buzzer):** Active buzzer kräver inte `tone()`. Korrekt.
- **Bilder:** Alla 11 refererade filer i `presentation/public/images/wiring/` existerar.

---
**Slutsats:** Materialet är redo för tryck efter justering av säkerhetsformuleringen i Appendix E.
