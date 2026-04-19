# Slide-audit batch 1 (slides 1–9)

### Slide 1 — Elektronik & Programmering med Arduino
**Verdikt:** ✅ OK

**Observationer:**
- Layout, typografi och färger korrekta. Eyebrow "NYBÖRJARKURS · 5 TRÄFFAR" i font-mono uppercase — OK.
- Cyan-accent används korrekt på rubriktexten.
- Inga stavfel. Inga förbjudna ord eller manualrefs.

---

### Slide 2 — Fem träffar. Fem moduler.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Stort tomrum i övre ~40 % av canvasen — rubrik + kort hamnar i nedre halvan. Visuellt tyngdpunkten för lågt för en projektorslide.
- Ikonerna renderar vita (inte cyan). Carbon-ikonerna är på plats (i-carbon-light, i-carbon-color-palette etc.) men saknar cyan-färg — kontrasterna mot korten är svaga.
- Eyebrow "KURSÖVERSIKT" i font-mono uppercase — konsekvent med övriga slides. OK.
- Inga stavfel.

**Föreslagna fixar:**
- Minska `mt-14` på `.sp-grid` eller flytta rubrikblocket nedåt så innehållet centreras vertikalt istället för att sjunka mot botten.
- Lägg `cyan`-klass (eller `color: #00ffd1`) på `.sp-icon`-divarna för att matcha accent-konventionen.

---

### Slide 3 — LED & krets (section)
**Verdikt:** ✅ OK

**Observationer:**
- Centrerad section-layout fungerar, stort vitt utrymme ovan/nedan är avsiktligt för section-typ.
- Cyan används korrekt på "Digital output, Ohms lag". Eyebrow "TRÄFF 1 AV 5" — korrekt format.
- Inga stavfel, inga förbjudna ord.

---

### Slide 4 — Idag — två timmar.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Stort tomt utrymme i nedre ~35 % under den sista agenda-raden. Femte blocket (col-span-2) slutar kring vertikalt mitten — resten är svart.
- Paus-raden (01:05–01:10) renderar i cyan för tidsstämpeln, övriga tidsstämplar är vita/opaka. Cy-färgen på paus-raden är avsiktlig per koden (`cyan`-klass), men upplevs som en nivå-inkonsistens jämfört med de andra tidsstämplarna som är `opacity-50` vita.
- Rubriken "Paus" är fetstil precis som övriga block — OK.
- Inga stavfel. Inga förbjudna ord.

**Föreslagna fixar:**
- Öka `gap-6` eller lägg `mt-auto`/`justify-between` på grid-containern för att sprida de fem blocken jämnt över höjden och eliminera det tomma undre utrymmet.
- Överväg om paus-tidsstämpelns cyan är önskad signal (paus = avvikande) eller om det bör vara samma stil som resten av agendan.

---

### Slide 5 — Det här ska vi bygga.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Klocka-ikonen (`i-carbon-alarm`) renderar i vitt/grått, inte cyan. Enligt accent-konventionen borde en primär illustrations-ikon vara cyan.
- Brödtexten ("Ett larm som känner av mörker…") bryter på tre rader med sista raden "någon rör det." — en änka (ensamt kort fragment på sista raden av det centrerade textstycket).
- Stort tomt utrymme under brödtexten (~40 % av canvasen), men avsiktligt för `full`-layouten med centrerad placering.
- Inga stavfel. Inga förbjudna ord.

**Föreslagna fixar:**
- Lägg `cyan`-klass eller `style="color:#00ffd1"` på ikonens div.
- Bredda `max-w-2xl` till `max-w-3xl` (eller `max-w-4xl`) för att undvika treradersbrytningen och änkan.

---

### Slide 6 — Mikrokontrollern.
**Verdikt:** ✅ OK

**Observationer:**
- `image-left` layout balanserad — fotot tar ungefär 50 %, textkolumnen välproportionerad.
- Cyan används korrekt på "mikrokontroller"-termen. Eyebrow "ARDUINO UNO R3" — korrekt format.
- Specs-raden (16 MHz · 32 KB flash · 2 KB SRAM) är tydlig och läsbar.
- Inga stavfel. Inga förbjudna ord eller manualrefs.

---

### Slide 7 — Spänning, ström, GND.
**Verdikt:** ⚠️ Minor

**Observationer:**
- Ikonerna renderar i vitt, inte cyan — samma problem som slide 2. Koden anger `cyan`-klassen men det verkar inte slå igenom på ikonens färg i renderingen.
- GND-ikonen är `i-carbon-earth-filled` (jordglob). En jordglob är semantiskt svag för GND/referenspotential — en krets-GND-ikon (t.ex. `i-carbon-earth` eller en elektrisk GND-symbol) vore tydligare för en nybörjare.
- Stort tomt utrymme under de tre korten (~35 % av canvasen).
- Inga stavfel. Inga förbjudna ord.

**Föreslagna fixar:**
- Kontrollera att `cyan`-klassen appliceras direkt på ikonens `div`-element, alternativt lägg `style="color:#00ffd1"` explicit.
- Byt `i-carbon-earth-filled` mot en elektriskt mer relevant ikon för GND (t.ex. `i-carbon-down-to-bottom` eller liknande).
- Eventuellt centrera korten vertikalt i canvasen med `mt-auto`/`items-center` på grid-wrappern.

---

### Slide 8 — U = R · I (Ohms lag)
**Verdikt:** ⚠️ Minor

**Observationer:**
- Layout-känsligt som väntat: triangeln hamnar i vänster-centrum med mycket tomrum under (~30 % svart under triangeln) och i överkant (eyebrow + formel i övre vänster, stor luftmassa under dem till triangelns topp).
- Triangeln renderar i `#00d9ff` (blå-cyan) — inte i `#00ffd1` (den definierade cyan-accenten). Avvikelse från accent-färgen. U-bokstaven är `#00d9ff`, R och I är vitaktiga — OK som kontrast inom triangeln, men den blå nyansen skiljer sig från övrig cyan-bruk.
- Referensen "→ Bilaga F i kompendiet" är cyan och tydlig — det är en intern kurs-bilaga, inte en "Lesson N"-manualref. Acceptabelt i kontexten.
- Formeln i övre vänster visas i ett cyan-radat kodblock — konsekvent med mono-stilen.
- Inga stavfel. "framspänningsfall" är korrekt svensk term.
- Inga förbjudna ord.

**Föreslagna fixar:**
- Byt `stroke="#00d9ff"` och `color:#00d9ff` i SVG/div till `#00ffd1` för att matcha den globala accent-cyan.
- Minska marginalen ovan triangeln (reducera `mt-10` på flex-containern) för att dra upp innehållet och minska det tomma utrymmet i botten.

---

### Slide 9 — Kretsen — som ett vattensystem.
**Verdikt:** ✅ OK

**Observationer:**
- `two-cols-header`-layouten är välbalanserad. Vänsterkolumnen (brödtext + minnesregel-box) och högerkolumnen (ASCII-flödesdiagram) tar jämt utrymme.
- Cyan används korrekt på "utgångspinne", "GND" i flödet och "pin 13". Röd (`danger`) används korrekt på "LED:en brinner upp" och "GND" i flödesdiagrammet — konsekvent med GND/varning-konventionen.
- Minnesregel-boxen har tydlig rubrik "MINNESREGEL" i font-mono uppercase — korrekt eyebrow-format.
- Tomrummet under minnesregel-boxen (~30 % av canvasen) är litet störande men acceptabelt för en two-cols-layout.
- Inga stavfel. Inga förbjudna ord eller manualrefs.
