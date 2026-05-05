# Spänningsdelar-metaforer — brainstorm + rangordning

Datum: 2026-05-05
Kontext: Modul 4 (FRO Ånge Arduino-kurs). Mål: hitta den pedagogiskt starkaste modellen för spänningsdelaren givet att eleverna kan **EN** sak från Modul 1 — Ohms lag + resistor som "strypventil" i en vatten-metafor.

---

## 1. Brainstormade modeller

### A. Vattenrör med tapp (befintlig — benchmark)
**Vad:** Vertikalt rör, +5 V uppe vid kran, GND nere vid utlopp. Två motstånd är två rörsegment med olika "tajthet". Skarven dem emellan är en mätuttag (tapp). A0 läser trycket vid tappen.
**Kärnpåstående:** "Trycket vid tappen beror på hur stor andel av total bromsning som ligger ovanför vs. nedanför tappen."
**Pedagogisk operation:** Förlänger Modul 1:s strypventil-bild med en till ventil i serie + en mätpunkt mellan.

### B. Lååångt motstånd + potentiometer (användarens kandidat)
**Vad:** Ett enda långt motståndsmaterial där spänningen *faller linjärt* från 5 V i ena änden till 0 V i andra. Två separata motstånd ÄR bara ett långt motstånd "brutet itu" på en specifik punkt. En vridpotentiometer demonstrerar fysiskt: glidande wiper väljer kontinuerligt var i materialet du tar ut spänningen.
**Kärnpåstående:** "Spänningen är en gradient längs materialet. Mätpunkten är var-helst-du-tappar-av."
**Pedagogisk operation:** Reducerar två-motstånd-fall till ETT objekt med en fri parameter (vredvinkel) som kan demonstreras live.

### C. Reostat / dimmer (LED-jämförelse)
**Vad:** Belysningsdimmer på väggen — vrider du den, ändras ljusstyrkan kontinuerligt. Internt ÄR den en spänningsdelare (eller PWM, men den klassiska analoga är en pot).
**Kärnpåstående:** "Hemmadimmern du redan känner är en spänningsdelare." (Föregriper potentiometer-modellen B.)

### D. Cisterner i höjdled (hydrostatiskt tryck)
**Vad:** Två stora vattentankar staplade vertikalt, med en kran i mellangolvet. Tryck mäts vid mellangolvet och beror på hur mycket vatten/höjd som finns ovanför och nedanför.
**Kärnpåstående:** "Mätpunktens tryck = hur fördelad höjden är runt mätpunkten."
**Pedagogisk operation:** Ren hydrostatik, men frikopplar från resistor-som-strypventil-bilden från Modul 1.

### E. Linjal / skala (spänningstermometer)
**Vad:** En vertikal 0–5 V-linjal. Två motstånd är två segment längs linjalen, deras inbördes storlek bestämmer var skarven hamnar. A0 = en pekare som läser av skarvens höjd.
**Kärnpåstående:** "Mätpunkten är en koordinat på en spänningsskala — andelen ovanför vs nedanför avgör koordinaten."
**Pedagogisk operation:** Maximalt visuellt-geometrisk; minimalt med fysik-bagage.

### F. Trappa med olika trappsteg (spänningsfall som steg)
**Vad:** Trapp ner från 5 V till 0 V. Varje motstånd = ett trappsteg. Stora steg = stor spänning över motståndet. Mätpunkten är vilan mellan stegen.
**Kärnpåstående:** "Varje motstånd 'kostar' ett steg ner. Mätpunkten ligger där du står efter första steget."
**Pedagogisk operation:** Bra för att visualisera spänningsfall som diskret minskning, men introducerar "diskret" där fenomenet är kontinuerligt.

### G. Potentiometer som fysisk komponent (live-demo)
**Vad:** En faktisk vridpotentiometer i kittet (ELEGOO har en — 10 kΩ). Tre ben: två yttre = ändarna av motståndsspåret, mittben = wipern. Vrid = mittbenet rör sig längs spåret. Ansluts till A0 = direkt läsbar mellanspänning utan fotocell-mellansteg.
**Kärnpåstående:** "Det här ÄR en spänningsdelare där du kan se båda halvorna med ögonen." Inte en metafor — en *demonstrationsapparat*.

### H. Två kranar i serie (rent hydrauliskt)
**Vad:** En enda vattenslang med två kranar efter varandra. Mätpunkten är slangsegmentet mellan kranarna.
**Kärnpåstående:** "Hur mycket trycket har sjunkit vid mellansegmentet beror på hur mycket första kranen redan tagit av trycket."
**Pedagogisk operation:** Mer "vardaglig" än rörsegment-bilden, men mätpunkten är otydligare visuellt — mellanslang ser bara ut som "slang", inget naturligt "mätställe".

### I. Strömfördelning vs spänningsfördelning (kontrast-modell)
**Vad:** Inte en metafor, utan en regel: "I serie delas SPÄNNINGEN, i parallell delas STRÖMMEN." Visa två kretsar sida vid sida.
**Kärnpåstående:** "Spänningsdelaren är logikens motsats till parallellkoppling."
**Pedagogisk operation:** För avancerat för en första genomgång, men användbart i kompendiet/Bilaga F.

### J. Spänning som balansvåg
**Vad:** En balansvåg/gungbräda där R1 och R2 är vikter på var sin sida. Var balanspunkten landar (= A0) beror på vikternas förhållande.
**Kärnpåstående:** "Mätpunkten är jämviktsläget mellan två krafter."
**Pedagogisk operation:** Smart matematiskt, men metaforen gör spänning till "balans" istället för "tryckskillnad", vilket inte länkar till Modul 1.

---

## 2. Rangordnings-matris

Skala 1–5 (5 = högst). Axlar:
- **FI** = Fysisk intuition (visualiserbarhet utan elektronik-bakgrund)
- **EK** = Elektrisk korrekthet (hur länge håller modellen innan den bryts?)
- **KOMP** = Kompabilitet med Modul 1:s vatten/tryck-metafor
- **BILD** = Visualiserbarhet i en enda ren stillbild

| # | Modell | FI | EK | KOMP | BILD | Σ |
|---|--------|----|----|------|------|---|
| A | Vattenrör m. tapp (befintlig) | 4 | 4 | 5 | 4 | **17** |
| B | Lååångt motstånd + pot | 5 | 5 | 2 | 4 | **16** |
| C | Reostat/dimmer (analog) | 4 | 3 | 2 | 3 | **12** |
| D | Cisterner i höjdled | 4 | 3 | 4 | 3 | **14** |
| E | Linjal/skala | 5 | 4 | 2 | 5 | **16** |
| F | Trappa med trappsteg | 4 | 3 | 2 | 4 | **13** |
| G | Potentiometer-komponent | 5 | 5 | 3 | 5 | **18** |
| H | Två kranar i serie | 3 | 4 | 4 | 2 | **13** |
| I | Ström- vs spänningsfördelning | 2 | 5 | 1 | 2 | **10** |
| J | Balansvåg | 3 | 2 | 1 | 3 | **9** |

**Anmärkningar till poängen:**
- **A** drar nytta av Modul 1-kontinuitet (KOMP = 5) men "tapp på rör" är en något ovan visuell konstruktion (FI = 4). EK fallerar svagt eftersom "rörsegmentens tajthet ≠ spänningsfall över resistor" om man drar metaforen för långt — strömmen *är* samma, ja, men trycket "konsumeras" inte exakt som i ett verkligt rör.
- **B** är fysikaliskt mest *exakt* (det är bokstavligen så ett resistivt material fungerar — Drude-modell, fältfall). EK = 5. Men frikopplar helt från vatten-metaforen → KOMP = 2.
- **G** är inte en metafor — det är *själva sanningen i miniatyr*. EK = 5 per definition. FI = 5 (du ser wipern röra sig). Enda nackdel: inte i samma byggövning som fotocellen, så KOMP = 3 (kontinuiteten är "kits-kontinuitet" inte "modell-kontinuitet").
- **E** (linjal) är konceptuellt elegant och lätt att rita, men utan vatten-koppling.

---

## 3. Topp 3-rangering

**Sammantaget bästa modeller:**

1. **G — Potentiometer som fysisk komponent + live-demo** (18p)
2. **A — Vattenrör med tapp (befintlig)** (17p)
3. **B — Lååångt motstånd + potentiometer** (16p, **i praktiken samman med G**)
3=. **E — Linjal/skala** (16p)

**Är "lååångt motstånd" en av topp 3?** Ja — och det viktiga insikten är att **B och G är samma metafor på två abstraktionsnivåer**. B är den *konceptuella* sidan ("två motstånd är ett brutet långt motstånd"), G är den *fysiska* manifestationen ("här är komponenten som demonstrerar exakt detta"). De ska användas tillsammans.

**Det oväntade som vinner:** Att G (en faktisk komponent) är pedagogiskt starkare än alla metaforer — och att kursen redan har komponenten i kittet (ELEGOO 10 kΩ-pot) men inte använder den i Modul 4. Det är en missad pedagogisk genväg.

---

## 4. Bild-briefer för topp 3

### Brief G — Potentiometer-komponent ("se spänningsdelaren med ögonen")
> Clean technical illustration on off-white background (#fafaf7), photographed from a slight 3/4 angle. A standard blue rotary potentiometer (10 kΩ, three pins, black knob) shown in cross-section: the resistive carbon track (warm tan #d4a574) runs as a circular arc inside the housing, with the wiper (a small dark conductive arm) shown contacting the track at roughly the 2-o'clock position. Two outer pins labeled "+5 V" (top) and "GND" (bottom-right) in monospace, accent color #00747d. The middle pin labeled "A0" with a small voltmeter symbol. Three voltage markers along the arc: "5 V" at top end, "0 V" at bottom end, "≈3,3 V" floating with thin leader line at the wiper's contact point. Subtle dashed arrow showing rotation. No background props, no branding, no humans. Style: textbook-clean, similar tonal palette to existing voltage-divider.png. Aspect 16:9 or 4:3.

### Brief B — Lååångt motstånd ("samma sak, förlängt")
> Side-by-side technical comparison on off-white background (#fafaf7). LEFT: a single elongated horizontal bar representing one long resistor, gradient-colored from warm orange-red (+5 V end) to deep blue (0 V end), with five tick-marks underneath labeled "5 V / 3,75 V / 2,5 V / 1,25 V / 0 V" in monospace, accent #00747d. A small downward arrow above the 2,5 V mark labeled "tapp här = 2,5 V". RIGHT: the same bar but visually "broken" at the midpoint into two separate resistor symbols (standard zigzag), wired in series with a labeled mid-point wire going to "A0". Both halves keep the same color gradient continuity. Caption strip below in muted gray: "Två motstånd = ett långt, brutet på en punkt." No humans, no props, no branding. Aspect 16:9.

### Brief A — Vattenrör med tapp (befintlig — finputs)
> Vertical pipe diagram on off-white background (#fafaf7). A clear vertical pipe with a tap at the top labeled "+5 V" and an outlet at the bottom labeled "GND". Inside the pipe, two visible constriction zones (rendered as crosshatched cylindrical sections, warm tan #d4a574) — the upper one labeled "R1 (fotocell)" and the lower labeled "R2 (1 kΩ)". A small horizontal mid-pipe spigot/tap protrudes from the joint between R1 and R2, labeled "A0" with a thin gauge needle showing "≈2,5 V" in accent color #00747d. Faint blue water-fill aesthetic (just enough to suggest flow direction with a small downward arrow). Three voltage marker labels along the right edge: "5 V" (top), "2,5 V" (midpoint, aligned with tap), "0 V" (bottom). No humans, no branding, no exterior environment. Aspect 4:3.

---

## 5. Den ärliga frågan — byta, lägga till, eller finputsa?

**Mitt råd: lägga till — specifikt G (potentiometer-demo) som en BRYGG-slide INNAN den befintliga vattenrörs-sliden.**

Befintlig vattenrör-modell (A) gör en sak väl: den länkar till Modul 1 och förklarar att spänning DELAS över seriekopplade resistorer. Det är pedagogisk vinst som inte ska kastas.

**Bristen** befintlig modell INTE löser:
- Studenten har aldrig sett "trycket vid en mellanpunkt" i verkligheten. Vatten-metaforen är abstrakt — det finns ingen klassrumsdemo där tappen syns röra sig.
- Spänningsfördelning som *kontinuerligt* fenomen (inte två diskreta tillstånd) saknar manifestation.
- Fotocellen är *redan* en variabel resistor i toppen — men eleven ser den inte ändras kontinuerligt på samma intuitiva sätt som ett vred.

**Vad G/B-paret löser:**
- Visualiserar kontinuerlig variation. Du vrider på ratten, A0 ändras live på Serial Monitor — direkt orsak-verkan.
- "Brutet långt motstånd"-bilden (B) ger den *teoretiska* förståelsen att två-resistor-fallet inte är speciellt — det är bara ett godtyckligt punktval på en kontinuerlig skala.
- Förbereder eleverna för Modul 5 där analogRead på en pot kan användas för parametertuning (tröskel, ljusstyrka, fördröjning).

**Konkret förslag:**
- Lägg in en NY slide *före* nuvarande slide 41, kallad t.ex. "Potentiometer — spänningsdelaren du kan ta i".
- Slide använder bild G + brief B's "brutet långt motstånd"-jämförelse.
- Befintlig slide 41 (vattenrör) behålls oförändrad som *konsoliderande* slide.
- Pedagogisk sekvens blir: konkret komponent → metafor som länkar till Modul 1 → tillämpning på fotocell.

---

## 6. En metafor jag skulle ratta bort

**J — Balansvåg.**

Den är intellektuellt charmig (ratio R1:R2 = balanspunkt) men introducerar tre fel samtidigt:
1. Spänning blir "balans" istället för "tryckskillnad" — bryter Modul 1:s metaforfält helt (KOMP = 1).
2. En balansvåg implicerar att de två sidorna "tävlar" — men resistorerna gör inte det, de samverkar i ström-serien.
3. Mätpunkten på en våg är fysiskt *vridningsaxeln* (fast), medan A0 i kretsen är en *flyttbar* signal. Visuellt motsägelsefullt.

Den enda situationen där balansvåg vore värd att överväga är som rent matematisk illustration av rationer — och då finns enklare verktyg (bråkstreck, tårtdiagram).

Underkänd som primär modell.

---

**RECOMMENDATION:** Lägg till en ny slide *före* nuvarande slide 41 som kombinerar potentiometer-demo (modell G) med "brutet långt motstånd"-bilden (modell B) — detta ger eleven en fysiskt-konkret upplevelse av kontinuerlig spänningsfördelning innan vatten-metaforen abstraherar fenomenet.
