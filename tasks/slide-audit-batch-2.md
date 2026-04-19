# Slide Audit — Batch 2 (slides 10–18)

### Slide 10 — LED & resistor
**Verdikt:** ⚠️ Minor

**Observationer:**
- Layout: stort tomt utrymme under innehållet (nedre ~35 % av canvasen är tom). Inte kritiskt men gör att materialet ser glest ut.
- Kolumnbalans: vänsterkolumnen (LED:en) har 4 punkter + 1 italic-not, högerkolumnen (Resistorn) har 3 punkter + resistor-widget. Rimlig balans, inga overflow.
- Resistor-widgeten använder cyan (#00ffd1) för "= 220 Ω" — korrekt accentfärg.
- Ingen röd färg synlig; GND nämns men skrivs bara i löptext, ej markerad röd — kan vara ett medvetet val på denna slide.
- Eyebrow "KOMPONENTERNA" är korrekt font-mono uppercase, men opaciteten är svår att bedöma; verkar OK.
- Inga stavfel, inga förbjudna ord/manualrefs.

**Föreslagna fixar:**
- Överväg att centrera eller komprimera innehållet vertikalt så att det tomma utrymmet minskar, alternativt lägg till en visuell komponent (bild på LED + resistor) för att fylla layouten.

---

### Slide 11 — Fem hål = en nod.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Breadboard-bilden tar upp stor del av canvasen och är tydlig — bra.
- De fyra faktapunkterna under bilden är i ett 2×2-rutnät utan tydlig ram/separator; syntaxen "·" som listmarkör avviker från de fyra svarta kvadraterna (■) som används på slide 10. Inkonsekvent listmarkör-stil.
- Cyan används korrekt för "nod" i texten.
- Eyebrow "BREADBOARDEN, STEG 1" korrekt format.
- "+/−-skenorna" — bindestrecket i "+-skenorna" kan läsas som ett minustecken i tandem, men det är förmodligen avsiktligt (plus/minus-skenorna). Godtagbart.
- Inga stavfel, inga förbjudna ord.

**Föreslagna fixar:**
- Harmonisera listmarkören till ■ (eller behåll · konsekvent på alla slides som använder detta format — kontrollera övriga slides i batchen).

---

### Slide 12 — Kontrollera raden först.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Center-layout, stor rubrik, funkar bra på projector.
- Brödtextrad 2: "är ett hål fel." — saknar mellanslag: borde vara "hål**s**fel" (ett ord) eller åtminstone "ett hålsfel". Som det står nu läses "hål fel" som två separata ord vilket är grammatiskt inkorrekt/otydligt. **Troligt stavfel/ordbrottsfel.**
- Eyebrow "FELSÖKNING · REGEL #1" korrekt format.
- Cyan på "samma rad" — korrekt accentfärg.
- Inga förbjudna ord/manualrefs.

**Föreslagna fixar:**
- Ändra "ett hål fel" → "ett hålsfel" (sammansatt substantiv).

---

### Slide 13 — Bygg kretsen.
**Verdikt:** ⚠️ Minor

**Observationer:**
- 5-stegslist fungerar bra, inga overflow.
- Stort tomt utrymme under steg 05 (nedre ~30 % tom) — samma mönster som slide 10.
- Steg 03 är den längsta punkten och bryter till två rader; indentering på rad 2 är korrekt (hängande indrag).
- Steg 05 innehåller `File → Examples → 01.Basics → Blink` i cyan monospace — konsekvent med accentfärg för kodvägar. Bra.
- Cyan används också för steg-numreringen (01–05) — konsekvent med övriga slides.
- Eyebrow "PRAKTISKT MOMENT" korrekt format.
- Inga stavfel, inga förbjudna ord/manualrefs.

**Föreslagna fixar:**
- Tomrummet under är inte kritiskt, men om andra slides i modulen komprimeras bör denna följa med för konsekvens.

---

### Slide 14 — WiringSlide: LED-koppling
**Verdikt:** ✅ OK

**Observationer:**
- WiringSlide-komponenten renderar korrekt; bilden fyller canvasen proportionerligt med mörk bakgrund.
- Kopplingsschemat är tydligt: röd kabel från D13 till LED anod, svart kabel från GND — röd/svart-konventionen stämmer med kursens färgkod (röd = signal, svart/GND).
- Caption-raden längst ned: "D13 → LED långt ben · LED kort ben → 220 Ω → GND" med cyan för D13 och röd för GND — korrekt färganvändning.
- Eyebrow "MODUL 1 · KOPPLING · LED" korrekt format. Liten text "Elegoo Basic Starter Kit" övre högra hörnet — fungerar som källhänvisning, ej en förbjuden manualref.
- Titeln "Så här ska det se ut." är klar och pedagogisk.
- Inga stavfel, inga förbjudna ord.

---

### Slide 15 — setup() och loop().
**Verdikt:** ⚠️ Minor

**Observationer:**
- Two-cols-header: vänster = förklarande text, höger = kodblock. Balansen är rimlig men höger kolumn är klart tyngre (större visuell vikt). Acceptabelt för denna typ av slide.
- Rubriken använder inline-kod-chips med cyan bakgrund för `setup()` och `loop()` — distinkt och tydlig. Notera att "och" mellan chipsen är i vit sans-serif; stilmässigt något inkonsekvent mot eyebrow-stilen men troligen avsiktligt design-val.
- Kodblocket till höger är välstorleksatt; all kod syns utan scroll.
- Vänster kolumn, stycke för `void setup()`: rad 3 "Serial, etc." — "etc." introduceras utan kontext för vad Serial är. Orphaned begrepp: **Serial** introduceras som exempel men förklaras inte förrän senare i kursen (potentiellt förvirrande för nybörjare).
- Fotnoten "Regel: exakt en setup() och en loop() per Arduino-program ("sketch"). Aldrig fler." — korrekt och värdefull.
- Eyebrow "KODENS ANATOMI" korrekt format.
- Inga stavfel, inga förbjudna ord/manualrefs.

**Föreslagna fixar:**
- Ta bort "hastighet på Serial, etc." eller ersätt med ett annat, redan bekant exempel (t.ex. "vilka pinnar är utgångar") för att undvika att introducera Serial utan förklaring.

---

### Slide 16 — Hela Blink — på tre rader.
**Verdikt:** 🔴 Fix needed

**Observationer:**
- **Typografisk inkonsistens:** brödtexten i botten-paragrafen ("Med bara dessa tre kan ni få en lysdiod att blinka i vilken rytm som helst.") renderas i **monospace-font** (samma font som kodblocket), inte i den vanliga sans-serif-fonten som används på övriga slides. Ser ut som ett oavsiktligt stilläckage från kodmiljön.
- Steg-layouten med tre cyan-kodchips till vänster + förklaringstext till höger är tydlig och pedagogisk.
- `delay(1000)` förklaras som "1000 ms = 1 sekund" — bra.
- Cyan används korrekt för `utgång`, `5 V`, `1000 millisekunder` i förklaringstexterna.
- Tomt utrymme under brödtexten (~30 %) — samma mönster som tidigare slides.
- Eyebrow "TRE KOMMANDON" korrekt format.
- Inga stavfel, inga förbjudna ord/manualrefs.

**Föreslagna fixar:**
- Fixa fonten på slutparagrafen: ta bort monospace-stilsättning och återställ till standardfonten (samma som övriga beskrivningstexter). Troligen ett `<pre>` eller `font-mono`-klass-läckage i källkoden.

---

### Slide 17 — Din egen rytm.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Tip-boxen (SÅ HÄR JOBBAR VI) är välformad med cyan vänsterkant och tydlig eyebrow-label.
- **Färganvändning i tip-boxen:** "Röd lapp" är skriven i rosa/röd (#ff3366 eller liknande) — detta bryter mot konventionen att röd (#ff3366) bara ska användas för GND/varning. Röd lapp är inte GND/varning, det är en pedagogisk instruktion. Risken är att elever associerar rödfärgen med fel/fara istället för "hjälp behövs".
- "grön lapp" är skriven i cyan/grön — det är OK eftersom cyan är accentfärgen, men notera att grön och cyan är nära varandra och kan uppfattas som samma signal.
- Bullet-punkten "Ditt eget tempo — snabb, långsam, oregelbunden" bryter till en änka: "oregelbunden" hamnar ensamt på rad 2 utan att föregås av ett långt ord. Ser lite hängande ut.
- Eyebrow "UPPGIFT" korrekt format.
- Inga stavfel, inga förbjudna ord/manualrefs.
- Bortsett från röd-konventionen är slide-innehållet klart och pedagogiskt bra.

**Föreslagna fixar:**
- Överväg att byta "Röd lapp" från röd till en neutral vit/grå färg, eller använd en annan accentfärg (t.ex. orange/gul) för att skilja den pedagogiska röda lappen från GND/varningsröd.
- Lös änkan på "oregelbunden" genom att antingen förkorta föregående rad eller omformulera punkten.

---

### Slide 18 — Ni har byggt en blinkare.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Center-layout, kraftfull rubrik — fungerar bra som avslutande delresultat-slide.
- De tre kolumnerna (Er första krets / Er första sketch / Er egen rytm) med underrubriker är välbalanserade.
- "Er första sketch" kolumn: undertext "setup, loop, tre kommandon" — bryter till två rader ("setup, loop, tre" / "kommandon"). Änka på "kommandon". Samma problem i "Er egen rytm": undertext "kod som styr fysiska" / "världen" — tydlig änka med bara "världen" på sista raden.
- Subtiteln "Er första rad kod som styr den fysiska världen." fungerar men "första rad kod" (singular) kan uppfattas som om de bara skrivit en enda rad; "Er första kod som styr..." vore tydligare.
- Eyebrow "DELRESULTAT · TRÄFF 1" korrekt format. "KLART"-badge i cyan-kontur — bra.
- Inga stavfel, inga förbjudna ord/manualrefs.

**Föreslagna fixar:**
- Lös änkan i "Er första sketch"-kolumnen: "setup, loop, tre kommandon" → t.ex. "setup · loop · tre kommandon" på en rad, eller justera textstorleken.
- Lös änkan "världen" i "Er egen rytm"-kolumnen: "kod som styr fysiska världen" → "kod som styr den fysiska världen" eller kortare variant.
