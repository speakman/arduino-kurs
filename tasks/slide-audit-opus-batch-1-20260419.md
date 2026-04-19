# Opus-audit batch 1 — slides 1-9

**Granskare:** Opus max effort, 2026-04-19
**Metod:** Läst slide-01.png till slide-09.png + källa i `presentation/slides.md` (rad 1-1000) + `kompendium/01-modul-1.typ` + `presentation/public/images/arduino-uno-hero.jpg` + `images/ohms-law-cartoon.jpg` (via slide 8-rendering). Krysskoll mot sonnet-audit (`tasks/slide-audit-batch-1.md`) så jag inte dubbelrapporterar.

## 🔴 Kritiska fel (måste fixas)

### Slide 6 — "Mikrokontrollern."
- **Problem:** Hero-bilden `arduino-uno-hero.jpg` visar en **genuin Arduino UNO R3** ("ARDUINO"-logotyp + "MADE IN ITALY"-silkscreen). Men kursen säger explicit att deltagarna får en **ELEGOO UNO R3** (slide 1 bottom-right + hela kursramen). Student som jämför bilden med sitt eget kort kommer se ett annat silkscreen-tryck, annan logga, andra komponent-placeringar. Eftersom denna slide är första gången kortet introduceras bygger det en felaktig visuell förväntan.
- **Bevis:**
  - slides.md rad 275-276: `layout: image-left · image: /images/arduino-uno-hero.jpg`
  - slides.md rad 40-46 (slide 1): `ELEGOO UNO<br/>Basic Starter Kit`
  - slides.md rad 294-297 (eyebrow säger "Arduino UNO R3 · ATmega328P")
  - slides.md rad 317-323 (presenter notes): "Kortet är en ELEGOO UNO R3 — en Arduino-kompatibel klon…"
  - Rendrad bild: `arduino-uno-hero.jpg` är en genuin Arduino (blå, vitt Arduino-logo, "MADE IN ITALY")
- **Föreslagen fix:** Byt till ett foto på en ELEGOO UNO R3 (de är blå men har ELEGOO-logga i övre vänstra hörnet + "Arduino.cc"-ref istället för "MADE IN ITALY"). Alternativt: ändra eyebrow till "UNO R3 (ELEGOO)" och notera i presenter notes att bilden visar en referensdesign (inte kortet de får). Första alternativet är starkare — en genuin Arduino i hero-slot framställer kursen som något den inte är, och riskerar förvirra nybörjare i första 5 minuterna av träffen.

### Slide 4 — "Idag — två timmar."
- **Problem:** Block 4 (Paus) renderar med **opacity 0.7 på HELA wrappen** (`class="flex gap-4 items-start opacity-70"`, rad 204). Eftersom opacity-70 är utanpå blocket blir paus-raden märkbart mörkare än de andra fyra — och samtidigt har den inuti-blocket en `cyan` tidsstämpel som ska framhäva pausen. De två designbesluten motverkar varandra: en cyan höjdpunkt inuti en dimmad container = visuellt brus. Paus ser ut som den är "mindre viktig" när den faktiskt är strukturellt viktig (flaggas till deltagarna att de ska räkna in den).
- **Bevis:** slides.md rad 204: `<div class="flex gap-4 items-start opacity-70">` — till skillnad från raderna 180, 188, 196, 212 som saknar opacity.
- **Föreslagen fix:** Ta bort `opacity-70` på Paus-wrapparen. Den cyan tidsstämpeln räcker för att signalera avvikelse. Eller: behåll dämpningen men ta bort cyan (välj en signal, inte två).

## ⚠️ Inkonsekvenser / kontinuitetsbrott

### Slide 2 — "Fem träffar. Fem moduler."
- **Problem:** Modul 5-kortet säger rubrik **"Integration"** men `sp-sub` säger **"Hackathon: bygg larmet"**. Slide 3 (section-sliden) kallar sin modul "LED & krets" — samma mönster: namn + undertitel. Men i kompendiet heter modul 5 "*Integration · Hackathon*" (rad 9 i `05-modul-5.typ`) och i kompendiets modul-heading och section-slides används det dubbla namnet. Slide 2 reducerar till bara "Integration" vilket är ett av två ord. Minor inkonsekvens mot kompendiets egna namn. Inte ett faktafel men en brand-term som inte stämmer överens.
- **Bevis:** slides.md rad 104-106 vs kompendium `05-modul-5.typ` rad 8-9.
- **Föreslagen fix:** Byt `sp-name` till `Hackathon` eller `Integration · Hackathon` (om plats finns), och `sp-sub` till något mer beskrivande som `Allt tillsammans till ett larm`. Undvik att både namn och subtitle kretsar runt ordet hackathon.

### Slide 4 — "Bygg kretsen & ladda upp Blink" nämns innan Arduino IDE introducerats
- **Problem:** Agendan på slide 4 listar "Bygg kretsen & ladda upp Blink" som första praktiska block (00:35-01:05). Men konceptet "Arduino IDE" / "Blink-exempel" har inte introducerats i någon tidigare slide. Första gången IDE nämns som objekt är i slide 6:s **presenter notes** (dold från publiken) + slide 12 (Bygg kretsen, steg 05: "File → Examples → 01.Basics → Blink"). Två agendapunkter tidigare än det finns där alltså "Blink" som ord utan att deltagaren vet vad det är. Inte showstopper — många känner ordet — men för en FRO-nybörjare som aldrig hört Arduino är det en orphan-referens.
- **Bevis:** slides.md rad 199, 200. Ingen tidigare slide innehåller ordet "Blink" som definition.
- **Föreslagen fix:** Byt "ladda upp Blink" → "ladda upp första programmet". Namnet "Blink" används sedan när det verkligen behövs på slide 12.

### Slide 6 — Hero-specs kan skapa ångest
- **Problem:** Block "16 MHz · 32 KB flash · 2 KB SRAM" står som enda text under huvuddefinitionen. För en FRO-radioamatör är detta OK (de förstår MHz och KB). För en absolut nybörjare är det en lista siffror utan betydelse. Slide 6 är första mötet med kortet — ingen kontext om vad 16 MHz räcker till, vad flash är kontra SRAM etc.
- **Bevis:** slides.md rad 294-297.
- **Föreslagen fix:** Håll specs-raden, men överväg att plocka bort SRAM (den används inte i kursen) och lägga till en jordnära referens: `16 MHz · 32 KB flash · €25` eller `16 MHz · 32 KB · fickstor`. Alternativt: ta bort hela specs-raden från slide 6 — de står redan i presenter notes för den som frågar.

### Slide 8 — Ohms lag-cartoon är informell mot kursens ton
- **Problem:** `ohms-law-cartoon.jpg` visar tre animerade figurer ("Volt", "Ohm", "Amp") — Ohm är en cowboyfigur som stryper en slang. Illustrationen är varm och funkar pedagogiskt, men den är klart barnsligare i ton än resten av slide-decket (som är stramt svart/cyan minimalism). Clashar visuellt med allt annat.
- **Bevis:** Slide 8 PNG vs slide 7, 9, 10 estetiken.
- **Föreslagen fix:** Antingen (a) låt den vara — pedagogisk värme är OK här — eller (b) byt till en enkel SVG-illustration av vattenanalogin (tank + rör + ventil) för att matcha decket. Låg prioritet.

### Slide 9 — "220 Ω i serie" utan att tidigare förklarat varför just 220
- **Problem:** Slide 9 nämner "en resistor på 220 Ω i serie" som lösning — men det specifika värdet 220 har inte motiverats förrän slide 8 (där Ohms lag visas men räkneexemplet är gömt i presenter notes). Kompendiet har en hel sektion "Varför 220 Ω?" (rad 84-96 i `01-modul-1.typ`) — men på slides dyker talet bara upp som ett postulat. Sonnet missade detta som didaktisk lucka.
- **Bevis:** slides.md rad 470 visar "220 Ω" utan härledning; slide 8 visar bara formel, ingen räkning.
- **Föreslagen fix:** Lägg en mikro-härledning på slide 8 eller 9: `5 V − 2 V = 3 V · 3 V / 15 mA ≈ 200 Ω → väljer 220 Ω` i mono-text, inte fullt räkneexempel men tillräckligt att tala bort. Eller ha det i en "v-click"-reveal på slide 8.

## 💡 Polish-förslag

### Slide 1 — logga-placering
- ELEGOO-marken står i övre högra hörnet över ett färgglatt kit-foto (slide 1 PNG visar kit-kartongen). När samma slide också har "ELEGOO UNO / Basic Starter Kit"-text i bottenrätta hörnet blir det dubbel-branding. Ingen regelbrott, men kit-fotot i hörnet är visuellt tungt och konkurrerar med huvudrubriken. Överväg att dämpa fotots opacity ytterligare.

### Slide 3 — "Modul 1: Digital output, Ohms lag"
- "Digital output, Ohms lag" står i cyan/fet som om det är det huvudsakliga tematiska löftet. Men "LED & krets" är den pedagogiska rubriken. Komma-listan är korrekt (matchar slide 2 modul 1-kort), men kunde skrivas som "Digital output · Ohms lag" med mittprick för att matcha övrig eyebrow-stil.

### Slide 6 — tekniska specs i italic/monospace blandning
- Texten "Arduino UNO R3 · ATmega328P / 16 MHz · 32 KB flash · 2 KB SRAM" är i mono-font på mörk bakgrund, vänster ovanför rad. Ser helt OK ut men slide 6:s textkolumn är generellt tätt packad med rubrik + definition + specs på ~50 % yta medan bildkolumnen tar andra 50 %. Skulle må bra av lite mer luft mellan definitionsblocket och specs-raden.

### Slide 7 — kortens vertikala centrering
- De tre grundbegrepps-korten (Spänning / Ström / GND) är pressade mot vänster-nedre delen av canvas. Övre ~40 % är helt tom. Redan flagat av sonnet men värt att upprepa — när rubrik + tre kort passar inom 60 % av ytan kan de centreras vertikalt istället för att sjunka nedåt.

### Slide 8 — "Bilaga F i kompendiet"-referensen
- Formatet "→ Bilaga F i kompendiet" är bra och pekar rätt (framspänningsfall finns i appendix F). Men är det enda slide 1-9 som refererar explicit till en bilaga, och referensen är liten/under triangeln. Överväg att göra den till en konsistent "hänvisning"-box i framtida slides så deltagarna känner igen mönstret.

## ✅ Bekräftat OK

- **Slide 1:** Cover-sliden fungerar. Inga förbjudna ord, inga Lesson/sid-refs.
- **Slide 2:** Faktamässigt korrekt. Modul-namn matchar kompendiet (utom Modul 5 — se ⚠️ ovan).
- **Slide 3:** Section-slide, rent och korrekt.
- **Slide 5:** Larmbeskrivningen ("känner av mörker, lyser upp som stämningsljus och tjuter när någon rör det") matchar kompendiets larmdefinition och senare moduler.
- **Slide 7:** Tre grundbegrepp är faktamässigt korrekta. "En LED tål ca 20 mA" i presenter notes stämmer med datablads-norm.
- **Slide 8:** Ohms lag-triangeln är korrekt orienterad (U topp, R+I botten). Täckningsmetoden ger rätt formler.
- **Slide 9:** Vattenanalogin matchar kompendiets modul 1, tip-sektion (`01-modul-1.typ` rad 49-53).

## Sammanställning

**Kritiskt:** 2 (Slide 6 genuin-Arduino-bild, Slide 4 paus-opacity-konflikt).
**Inkonsekvenser:** 5 (Slide 2 modul-5-namn, Slide 4 Blink-orphan-ref, Slide 6 specs-utan-kontext, Slide 8 cartoon-ton-clash, Slide 9 220Ω-saknar-motivation).
**Polish:** 5 (låg prio).
**OK:** 7 slides (vissa med minor polish noterat).

Inga förbjudna ord (superkraft/magi/hjärna/sinne/sinnesorgan/röntgen) hittades i slides 1-9 eller deras presenter notes. Inga "Lesson N"/"sid N"-refs till ELEGOO-manualen. Inga kodblock i denna batch (setup/loop visas först från slide 14).
