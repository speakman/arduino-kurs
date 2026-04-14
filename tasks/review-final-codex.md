# Final teknisk review (Codex) — 2026-04-14

Scope (”måste vara perfekta”):
- `presentation/slides.md`
- `kompendium/01-modul-1.typ` … `kompendium/05-modul-5.typ`
- `kompendium/appendix-a-syntax.typ` … `kompendium/appendix-f-framspanningsfall.typ`

Verifiering jag körde:
- Sökningar efter pin-mappning / värden / enheter / decimalformat.
- `arduino-cli compile --fqbn arduino:avr:uno` på de kodblock som är kompletta sketchar (samt den splittrade ”startmall”-sliden när blocken kombineras).
- `typst compile kompendium/main.typ` (snabb sanity att Typst fortfarande bygger).

## Summering
- **Blockers hittade:** 6 (åtgärdade i denna pass)
- **Minors hittade:** 6 (åtgärdade i denna pass)
- **Nits hittade:** 3 (rekommendationer)

---

## Blockers (åtgärdade)

### 1) Enheter + decimalformat (mellanslag före enhet, decimal-komma i text)
Problem: flera ställen använde t.ex. `5V`, `220Ω`, `1kΩ`, `+5V`, samt `0.015`/`13.6` i brödtext/anteckningar. Detta bryter kravet “5 V, 220 Ω, 15 mA” och “0,015”.

Exempel och fix:
- `presentation/slides.md:465` — `0.015 A` → `0,015 A`.
- `presentation/slides.md:467` — `13.6 mA` → `13,6 mA`.
- `presentation/slides.md:2128` — `5V → ... → 1kΩ` → `5 V → ... → 1 kΩ`.
- `kompendium/04-modul-4.typ:190` — `+5V` → `+5 V`.
- `kompendium/02-modul-2.typ:163` — `+5V` → `+5 V`.
- `kompendium/appendix-c-komponenter.typ:157` — `5V → ...` → `5 V → ...`.
- `kompendium/appendix-f-framspanningsfall.typ:101` — `+5V` → `+5 V`.

Konsekvent mål efter fix: `5 V`, `+5 V`, `220 Ω`, `1 kΩ`, `3,3 V`, samt decimal-komma i svensk text (kod behåller punkt där det är C++).

### 2) Fotocell-värden (20–100 / 150–400 / 500–700) var inte identiska överallt
Problem: blandning av bindestreck/en-dash och olika spacing (t.ex. `20-100` vs `20–100`, och `20 – 100`).

Exempel och fix:
- `presentation/slides.md:2710` — `20-100 / 150-400 / 500-700` → `20–100 / 150–400 / 500–700`.
- `kompendium/04-modul-4.typ:86` — tabellvärden standardiserade till `20–100`, `150–400`, `500–700`.
- `kompendium/appendix-f-framspanningsfall.typ:233` — `20 – 100` → `20–100` (och samma för 150–400/500–700/700–900).

### 3) 220 Ω färgkod (5-band) saknade sista bandet (tolerans = brun)
Problem: en instruktion listade 5-band för 220 Ω utan sista bandet (brun), vilket bryter ert krav #10.

Fix:
- `presentation/slides.md:733` — `5-band: röd-röd-svart-svart` → `5-band: röd-röd-svart-svart-brun`.

### 4) Teknisk felbeskrivning: `INPUT_PULLUP` som “spänningsdelare”
Problem: `INPUT_PULLUP` beskrevs som en spänningsdelare. Det är en intern pullup-resistor som ger stabil HIGH när knappen är släppt; den ger inte en analog mellannivå som en “riktig” spänningsdelare avsedd för `analogRead`.

Fix:
- `kompendium/03-modul-3.typ:76` — omskrivet till korrekt pullup- förklaring och tydlig kontrast mot Modul 4.
- `presentation/slides.md:2275` — omskrivet i läraranteckningarna (motsvarande bro mellan modulerna).

### 5) Outdated/över-säkert påstående om USB-bryggan (ATmega16U2 vs CH340)
Problem: läraranteckningen påstod att (2024+) kittet använder ATmega16U2 och “inga drivrutiner behövs”, samtidigt som samma block senare nämnde CH340 som möjlighet. Det kan orsaka real-world setup-strul och onödig felsökning.

Fix:
- `presentation/slides.md:355` och `presentation/slides.md:375` — omskrivet till att USB-bryggan kan variera, och att CH340 kan kräva drivrutin.

### 6) Kodsnippet med icke-ASCII identifierare (risk vid copy/paste/kompilering)
Problem: C++-identifierare med `å` kan vara en källa till kompilator-/encoding-strul för nybörjare.

Fix:
- `presentation/slides.md:1597` — `int nivå = ...` → `int niva = ...`.

---

## Minor (åtgärdade)

### A) Tilt-pin-mappning: “vilken digital pinne som helst” underminerade kursens pin-karta
Fix:
- `kompendium/04-modul-4.typ:104` — tydliggjort `D2` “i kursen” + att annan pin kräver ändring i kod.

### B) Språk: engelsk rad i svensk läraranteckning
Fix:
- `presentation/slides.md:2130` — “Bright light” → “Starkt ljus”.

### C) Typos/grammatik + saklighet (säkerhetsbilagan)
Fixar:
- `kompendium/appendix-e-sakerhet.typ:46` — “rättan tid” → “rätt tid”.
- `kompendium/appendix-e-sakerhet.typ:94` — “stänger av av …” → “stänger av p.g.a. …”.
- `kompendium/appendix-e-sakerhet.typ:31` — “rekommenderat 200 mA” → tydliggjort som absolut max (håll dig under).

### D) Pin-namngivning i komponentreferens (konsistens med kursens D*-notation)
Fix:
- `kompendium/appendix-c-komponenter.typ:117` — “pin 9” → `D9`.

### E) Små typografier i läraranteckningar
Fix:
- `presentation/slides.md:2121` — `sid 79-82` → `sid 79–82`.

### F) Du/ni-inkonsistens (synligt i slides + appendix-e)
Fixar:
- `presentation/slides.md:437` — “täck variabeln du söker” → “ni söker”.
- `kompendium/appendix-e-sakerhet.typ:15` — gjort konsekvent “du” i bilagan (matchar underraden i rubriken).

---

## Nit (rekommendationer, ej blockerande)

### i) “pin X” vs “DX” i hela materialet
Det finns både “pin 13/pin 9” och “D13/D9” i olika delar av materialet. Det är inte tekniskt fel, men bestäm gärna en konsekvent stil (t.ex. “D9” i kopplingsinstruktioner, och “pin 9” bara i ren Arduino-folkmun).

### ii) “5 V är helt ofarligt” (absolutformulering)
I `kompendium/appendix-e-sakerhet.typ` är budskapet rätt pedagogiskt, men absoluta formuleringar kan missförstås (t.ex. brännskador vid kortslutning/varma kablar). Ni har redan bra balans genom att skilja på “ofarligt för människor” vs “farligt för utrustning”.

### iii) Splittrade kodblock på ”startmall”-sliden
`presentation/slides.md` har pin-konstanter och `setup/loop` i två separata kodblock på samma slide (tillsammans kompilerar de). Om ni vill maximera copy/paste-säkerhet kan ni antingen:
- lägga en rad “(kombinera med blocket till vänster)” över `setup/loop`-blocket, eller
- ge en komplett “copy-paste”-sketch i kompendiet och bara ha pseudokod i slides.
