# Pedagogisk granskning — 2026-04-14

Granskning av slides + kompendium (modul 1–5 + bilagor A–F) för FRO Ånge Arduino-kurs. Fokus: var en vuxen nybörjare riskerar att tappa tråden, få fel mental modell, eller fastna utan väg framåt.

USB-C-kontroll: **inga träffar** för "USB-C" eller "Type-C" i kursmaterialet. Det enda förekommande är `01-modul-1.typ:133` och `appendix-b-felmeddelanden.typ:131` som korrekt skriver "USB Type B, den kvadratiska kontakten". Inget att fixa här.

`digitalWrit`-kontroll: Båda förklaringarna (`01-modul-1.typ:132` och `appendix-b-felmeddelanden.typ:50–57`) lägger korrekt **det primära felet på saknat 'e'**. Skiftläge nämns som *sekundär* parentes ("näst vanligaste"). Förklaringen är teknisk korrekt — kompilatorns fel är att symbolen `digitalWrit` inte finns, oavsett W eller w. ✓

---

## 🚨 Blockers (måste fixas)

### B1. Typo: "internet" → "internt" i Brygga-faktaruta (Modul 3)
**Fil:** `03-modul-3.typ:76`
**Issue:** Faktarutan "Brygga till Modul 4" säger: *"INPUT_PULLUP är i själva verket en färdig spänningsdelare — **internet** till Arduinon, med en pull-up-resistor..."*. Det ska vara "internt". Eftersom rutan ska bygga bro till spänningsdelaren — kursens viktigaste återanvändbara koncept — kommer en student som läser noggrant att stanna upp och försöka tolka "internet" som "över internet"/"online". Mental modellbygge tappar fart.
**Fix:** Ändra `internet` → `internt`.

### B2. Tilt-sensor som "Modul 4-komponent" i hackathon-tabellen — fel referens
**Fil:** `05-modul-5.typ:26` ("En tilt-sensor (Modul 4)") och `05-modul-5.typ:50` (`tiltPin … D2 — Lesson 7`).
**Issue:** Modul 5 säger att tilt-sensorn introducerades i Modul 4 (det stämmer — `04-modul-4.typ:23` och framåt). Men eleven minns kanske inte vilken Lesson, och Modul 5 tabellen kopplar pinnar till Elegoo Lesson 5/6/7/10. Lesson 7 är tilt — det är konsekvent. **Inte en blocker** — togs bort efter dubbelkoll. (Lämnar denna kvar för spårbarhet, men nedgraderar.)

(*Egentligen ingen blocker — flyttad till "Recommendations". Listan i denna sektion fortsätter:*)

### B2 (riktig). Slide-tröskel inkonsekvens "mörker"-värde går inte ihop över materialet
**Filer:**
- `04-modul-4.typ:84–88` — "Hand över ≈ 20–100, Rumsljus ≈ 150–400"
- `05-modul-5.typ:134` — `else if (!larmPaslaget && ljus < 400)`
- `appendix-d-hackathon-losning.typ:43` — `const int morkTroskel = 300;`
- `presentation/slides.md:2703` (instruktörsnoter) — *"Sätt tröskeln på t.ex. 400"*
- `presentation/slides.md:2702` (instruktörsnoter) — *"mörker = A0 LÅG (~100-300). Dagsljus = A0 HÖG (~700-1000)"* — motsäger Modul 4-tabellens 20–100/150–400.

**Issue:** Fyra olika "korrekta" tröskelvärden i samma kursmaterial. En student som läser kompendiet och sedan tittar på Bilaga D blir förvirrad: *"Är det 300 eller 400 jag ska skriva?"* — och instruktörens egna noter motsäger Modul 4 kring vilken siffra som motsvarar mörkt rum.
**Fix:** Välj **en** kanonisk siffra (förslag: behåll 300 i Bilaga D, ändra Modul 5 huvudtext till samma, uppdatera slide-noter att referera "kalibrera själv — i exempelkoden använder vi 300"). Och fixa "100–300 = mörkt" i slide-instruktörsnoterna så det matchar Modul 4:s tabell (20–100 mörker / 150–400 rumsljus).

### B3. Modul 1 hemma-övning 3 förutsätter funktioner som aldrig introducerats
**Fil:** `01-modul-1.typ:117–123`
**Issue:** Övning 3 ("Dina initialer i morse") avslutas med en "Smart sätt"-tip som visar `void dit() { ... }` och `void dah() { ... }`. Men funktioner som koncept introduceras först i Bilaga A — och slidesen för Modul 1 nämner inte själv-definierade funktioner alls. En vuxen nybörjare som kommit hem efter Träff 1 sitter med en tip-ruta som säger "gör en hjälpfunktion" utan att ha sett syntax för att deklarera en. Slidesens Blink-uppgift använder visserligen `blink(tid)` (slide ~995–1001), men det visas utan förklaring av hur funktionen *deklareras* — så självhjälpen finns inte i materialet.
**Fix:** Antingen (a) ta bort "Smart sätt"-tipset från Modul 1 övning 3 och spara funktioner till en senare övning, (b) lägg en mini-ruta i Modul 1 som förklarar `void namn() { ... }`-syntaxen explicit (3 rader räcker), eller (c) gör tipset opt-in: *"Om du redan kan funktioner: gör en hjälpfunktion. Annars: skriv ut alla digitalWrite för hand — det går också."*

---

## ⚠️ Recommendations

### R1. Modul 5 (`05-modul-5.typ:28`) attribuerar tilt-sensor till Modul 4 — bra. Men Bilaga D/Modul 5 attribuerar **fotocellen också** till Modul 4. Det är konsekvent.
*(Detta är inte ett problem — togs upp och avskrivet.)*

### R2. "Bränna CPU:n" / "kortkrets-looping" — felaktig pedagogisk metafor
**Filer:**
- `05-modul-5.typ:67` — *"kort delay för att inte bränna CPU:n"*
- `appendix-d-hackathon-losning.typ:103` — kommentar `// 4. Kort paus mot kortkrets-looping`
- `appendix-d-hackathon-losning.typ:142` — *"Gör att Arduinon inte brinner oss-CPU:n för inget"*

**Issue:** En tight loop på Arduino bränner *inget* — chippet är designat för att köra på 100 % continuously utan skada. Pedagogiskt skapar metaforen en falsk rädsla ("om jag glömmer delay går det sönder"). Den verkliga anledningen att lägga `delay(10)` är (a) debounce-tolerans, (b) Serial Monitor blir inte överöst, (c) framtida `millis()`-baserad timing får ett naturligt grid. "Kortkrets-looping" är dessutom inte ett etablerat begrepp — *kortslutning* har en helt annan teknisk betydelse i kursen (5V mot GND), så det skapar terminologisk förvirring i en kurs som *just* har lärt eleven vad kortslutning är.
**Fix:** Byt formulering till t.ex. *"Kort paus så Serial Monitor inte drunknar och knappen får tid att avstuda"* eller helt enkelt *"Kort paus per loop-varv — gör studs-hanteringen enklare och ger jämnare tempo."*

### R3. Stavfel: "bege" → "benet" i komponentbilaga
**Fil:** `appendix-c-komponenter.typ:33`
**Issue:** *"resistor saknas (lyser en kort stund, sedan bränns upp), **bege** ligger i fel hål på breadboard"*. Borde vara "benet".
**Fix:** Ändra `bege` → `benet`.

### R4. Stavfel: "buzzerN" och "med mer billigare komponenter"
**Fil:** `05-modul-5.typ:173, 194`
**Issue:** Rad 173: *"blinka **buzzerN**"* (versal N mitt i ord). Rad 194: *"i mindre skala och med **mer billigare** komponenter"* (dubbel komparativ).
**Fix:** `buzzerN` → `buzzern`. `mer billigare` → `billigare`.

### R5. Modul 4 övning 2 introducerar `map()` utan föregående exempel
**Fil:** `04-modul-4.typ:172–177`
**Issue:** Hemma-övning 2 ("Proportional RGB") slänger in `analogWrite(ledR, map(ljus, 0, 1023, 255, 0));` med en kort förklaring. `map()` har inte demonstrerats i lektionen, inte i tidigare moduler, och kommer inte heller i appendix A. Eleven förväntas läsa, förstå, omvända intervall, och felsöka samtidigt — tre nya saker i en hemma-övning.
**Fix:** Antingen (a) lägg `map()` i en lektion (Modul 2 eller 4 har plats) som ett 3-raders demo, (b) flytta övning 2 till en "extra credit"-sektion, eller (c) skriv ut räkningen för hand i tipset så eleven ser logiken: `int styrka = (1023 - ljus) * 255 / 1023;` och nämn map() som "ett kortare sätt".

### R6. Modul 3 övning 1 introducerar ternary operator utan föregående exempel
**Fil:** `03-modul-3.typ:175–181`
**Issue:** Övning 1 ("Toggla LED med edge-detection") tipsar om `digitalWrite(LED_BUILTIN, ledPa ? HIGH : LOW)`. Ternary syntax `cond ? a : b` introduceras formellt först i Bilaga A. På samma sätt som B3 ovan: en vuxen nybörjare hemma har inte hjälp att hitta det själv om han inte vet att han ska slå upp Bilaga A.
**Fix:** Lägg en parentes: *"(`?:` är en kort if/else — fullständig förklaring i Bilaga A.)"* — eller skriv ut den långa formen som primärtips och nämn ternary som alternativ.

### R7. "analogRead ger alltid 0 → flyter, men drar mot noll" — fysiskt missvisande
**Fil:** `04-modul-4.typ:187`
**Issue:** *"Pinnen är inte kopplad (flyter, men drar mot noll)"*. En flytande analog pinne ger inte stadigt 0 — den ger brus, ofta i halva intervallet, beroende på närliggande pinnar och kapacitiv koppling. Eleven som litar på den här texten kommer felsöka åt fel håll om han ser värden som darrar runt 200.
**Fix:** Skriv om till: *"Spänningsdelaren är ofullständig — A0 är fortfarande kopplad till GND-sidan via 1 kΩ-resistorn, så pinnen dras mot 0. Kontrollera att fotocellen sitter på 5V-sidan."* (Detta är den faktiskt sannolika orsaken givet kursens koppling.)

### R8. Modul 1 "Bygg från minnet" säger "Lägg undan slidesen" — men sliden hänvisar till "I slidesen"-rutan i samma kapitel
**Fil:** `01-modul-1.typ:86–97` och `01-modul-1.typ:147–149`
**Issue:** "Bygg från minnet"-sektionen är tänkt att kunna göras hemma, men den säger "Lägg undan slidesen". Hemma har studenten ingen slide-deck framför sig — bara kompendiet. Pedagogisk friktion: instruktionen är skriven som om eleven sitter i klassrummet. Samma sektion finns i alla moduler men formuleringen passar olika väl.
**Fix:** Skriv om till *"Stäng kompendiet. Ta fram Arduinon, en LED..."* eller *"Utan att titta på koden: ta fram..."*. Liten förändring, mer naturlig hemmaläsning.

### R9. PWM-frekvens skrivs som "490 gånger per sekund" på en plats, "500 gånger per sekund" i bildtext
**Filer:**
- `02-modul-2.typ:62` — bildtext: "pinnen pulserar 500 gånger per sekund"
- `02-modul-2.typ:71` — text: "växlar runt 490 gånger i sekunden (på de flesta PWM-pinnarna)"

**Issue:** Inkonsistens i samma kapitel. Verkligheten är ännu krångligare: D5/D6 är 980 Hz, D3/D9/D10/D11 är 490 Hz på Uno. Eleven som läser noggrant ser motstridiga tal.
**Fix:** Bildtexten kan ändras till "ungefär 490 gånger i sekunden" så texterna matchar. Behöver inte ta upp 980 Hz för D5/D6 — det är bortom kursens nivå.

### R10. Tilt-sensor: "tiondels sekund" vs `delay(50)`
**Fil:** `04-modul-4.typ:104`
**Issue:** *"kulan bouncar inuti sin hylsa i en tiondels sekund efter en rörelse. En `delay(50);` efter läsningen räcker som debounce"*. En tiondels sekund = 100 ms, men föreslagen debounce är 50 ms. Den observante eleven undrar: *"Om den studsar i 100 ms, varför räcker 50?"*. Svaret är att 50 ms räcker eftersom de flesta studs är klara, men texten motsäger sig själv på två rader.
**Fix:** Antingen (a) sänk siffran: "några tiotals millisekunder", eller (b) höj till `delay(100)`, eller (c) erkänn det: *"Studsar några tiotals millisekunder. `delay(50)` räcker i praktiken — perfektionism väntar tills produkten är i fält."*

### R11. Modul 4: "Bara pinnarna A0–A5 på Uno har ADC-hårdvara" — sant men ofullständigt
**Fil:** `04-modul-4.typ:46`
**Issue:** *"`analogRead` på en digital pinne returnerar skräpvärden."* Faktiskt: `analogRead(D2)` på Uno är ett kompileringsfel/körfel snarare än "skräpvärden" — Uno mappar inte digitala pinnar till ADC-kanaler. För kursens nivå spelar det ingen roll; men "skräpvärden" är felaktigt.
**Fix:** Mild — *"`analogRead` fungerar bara på A0–A5. Försöker du på en digital pinne får du oförutsägbara resultat eller 0."*

### R12. Modul 5 "ord" att "inte stryka" — Bilaga D-hänvisning kommer för sent för "den som fastnar"
**Fil:** `appendix-d-hackathon-losning.typ:13–20` och `05-modul-5.typ:70`
**Issue:** Bilaga D ("titta inte hit för tidigt") är värdefull men risken är att den student som faktiskt fastnar inte vågar gå dit. Den brutala "som att titta på baksidan av ett korsord"-formuleringen kombinerad med "om kursledaren redan har hjälpt tre gånger" sätter en hög tröskel som kan hindra exakt de elever som behöver det.
**Fix:** Mjuka upp: *"Titta hit när du fastnat på samma bug i 10+ minuter och inte ser nästa steg. Halva värdet av hackathonen finns i kampen — men hela värdet försvinner om du sitter och stirrar."*

---

## 💡 Pedagogical observations / suggestions

### O1. Vattenanalogin håller överraskande väl genom hela kursen
Vattenanalogin (5 V = kran, GND = utlopp, resistor = strypventil) introduceras i Modul 1 (`presentation/slides.md:511–531`) och återanvänds smidigt för spänningsdelaren i Modul 4 (`04-modul-4.typ:50–60` och `presentation/slides.md:2218–2245`). Det är pedagogiskt elegant att samma analogi täcker tre olika koncept (Ohms lag → seriekrets → spänningsdelare). Strykt rekommenderat att behålla.

**Mindre observation:** Analogin kan dock börja krackelera när PWM kommer in (Modul 2). En "kran som blinkar 490 gånger per sekund" är en metafor i metaforen, och det blir abstrakt. Modul 2 hanterar det bra genom att inte tvinga in vattenanalogin här — `02-modul-2.typ:20` säger bara *"Den fuskar genom att blinka pinnen väldigt snabbt"* utan att försöka koppla det till kranbilden. Bra beslut.

### O2. Edge-detection-introduktionen är pedagogiskt stark
`03-modul-3.typ:104–124` förklarar problemet (knappen hålls nere → 100 togglingar) **innan** lösningen, med konkret kod, namngivna variabler, och en uttrycklig motivering. Slide-versionen (`presentation/slides.md:1719–1791`) gör samma sak. Det här är en avancerad kognitiv komponent som ofta serveras som "skriv den här koden, oroa dig inte över varför" — ert sätt undervisar **mönstret**, inte bara koden.

### O3. "Klisterlapps-varningen" upprepas på rätt platser
Active buzzer-varningen finns i (a) modul 3 huvudtext, (b) appendix C komponentlista, (c) appendix E säkerhet, (d) modul 3 quickref, (e) presentationssliden med rosa box. Pedagogiskt bra: viktiga säkerhets/komfort-meddelanden ska repeteras tills de fäster. *Behåll redundansen.*

### O4. Bilaga F är det "rätt nördiga djupdyk"-rummet — håller bra som opt-in
Den långa Ohms lag/framspänningsfall-bilagan (`appendix-f-framspanningsfall.typ`) är skriven i en helt annan ton än huvudmodulerna — mycket mer härledningar, mer "varför just 220 Ω". Det är **rätt val** för den FRO-publik som har radioamatör-bakgrund och vill gå djupare. Den som inte vill kan hoppa över den utan att tappa hackathon-förmågan. Strukturerat opt-in är pedagogiskt välgjort.

### O5. Sense-act-loop-formuleringen i Modul 5 är guld
`05-modul-5.typ:60–69` ramar in *hela* embedded-paradigmet i sex punkter:
1. Läs av omvärlden
2. Uppdatera internt tillstånd
3. Bestäm vad som ska hända
4. Styr utvärlden
5. Paus
6. Börja om

Den här strukturen är vad som finns i varenda industriell PLC, varenda motorstyrenhet, varenda gas-sensor. Att ge en nybörjare den tankeramen efter fem veckor är pedagogiskt extraordinärt. *Lyft fram den här rutan ännu mer* — kanske som rubrik/box i slide-stil i stället för en numrerad lista.

### O6. Quickref-block gör kompendiet **användbart** veckan efter kursen
Varje moduls "Snabbreferens"-tabell är pedagogiskt strategiskt: efter kursen kommer studenten att glömma 70 % av detaljerna men minnas att "Modul 3 hade en quickref för INPUT_PULLUP". Det är vad ett kompendium ska göra — bli en första-uppslag-bok, inte en sammanhållen läsning. Behåll mönstret.

### O7. "I slidesen"-rutorna i botten av varje kapitel — sårbar koppling
Varje modul har en `#tip(title: "I slidesen")[Slide 25–34: ...]` ruta. Det är pedagogiskt bra (länkar text till föredrag) **men sårbart**: om slidesen renumreras eller får en ny slide tidigt, blir alla nummer fel utan att någon märker det. Inga kontrollsummor, inga ankare.
**Förslag:** Använd istället ankarnamn i slide-decken (`slide #intro-led`, `slide #pwm-duty-cycle`) och referera dem från Typst — eller åtminstone *namn på sliderna* i stället för nummer: *"I slidesen: Kursöversikt, Ohms lag-triangeln, Bygg kretsen, Din egen rytm."* Skyddar mot framtida driften.

### O8. Hackathon-skelettet säger inkrementell utveckling — bra; men "Skriv INTE allt på en gång" kan vara starkare
`05-modul-5.typ:74–86` har en utmärkt 7-stegsplan för inkrementellt bygge. Detta är **det viktigaste pedagogiska budskapet** i hela hackathon-kapitlet, men det ligger som en av flera underrubriker. Konkurrerar om uppmärksamhet med "Edge-detection är icke förhandlingsbar" och "Ordna koden i block".
**Förslag:** Lyft "Bygg inkrementellt" till första och starkaste rubriken i hackathon-tipsen, kanske med en visuell separator som signalerar "läs detta först".

### O9. "Sträng men kärleksfull"-tonen är bra träffad i Modul 4 ↔ men inte fullt så stark i Modul 1
Modul 4 har formuleringar som *"Arduinon är inte mystisk — den är bara tyst. Gör den pratig"* (`04-modul-4.typ:142`) — det är "kärleksfullt" men direkt. Modul 1 är mer formellt akademiskt. Inte ett fel, men det vore värt att fråga: *vill du att Modul 1 ska ha samma röst som Modul 4?* Nuvarande tonal asymmetri kan kännas som att Modul 4 är skriven av en mer trygg författare än Modul 1 (och det stämmer kanske — Modul 1 har redan körts en gång).

### O10. Färgblandnings-tabellen i Modul 2 är bra men kan ge "Skolgul = R 255 G 200 B 0" vs "Gul = R 255 G 255 B 0"
`02-modul-2.typ:81–93` listar både "Gul" (255/255/0) och "Skolgul" (255/200/0). Pedagogiskt är det smart att visa att det inte finns "den ena gula", men en student som kommer från klassen där instruktören skrev "Skolgul = 255/200/0" kan börja undra om "Gul" är fel. Lägg gärna en mini-notis: *"Båda är 'gula' — och det illustrerar att färg är en preferens, inte ett facit."*

---

## ✅ Strengths

- **USB-C-felet är inte ett fel** — kompendiet är konsekvent korrekt om Type B (`01-modul-1.typ:133`, `appendix-b-felmeddelanden.typ:131`, slidesen instruktörsnoter `presentation/slides.md:354`). Bra.
- **`digitalWrit`-förklaringen är teknisk korrekt** — primärt felet är saknat 'e', skiftläge nämns sekundärt. Inget att fixa.
- **Återanvändning av samma pinnar** genom hela kursen (`05-modul-5.typ:46–55`) — student behöver inte koppla om mellan Modul 3 och hackathon. Stort pedagogiskt vunnet utan extra kostnad.
- **Edge-detection introduceras INNAN problemet hinner uppstå** (Modul 3, slide-version + kompendium-version båda förklarar varför, inte bara hur).
- **Spänningsdelaren bryggas explicit till INPUT_PULLUP** (`03-modul-3.typ:75`) — eleven får två exempel på samma princip, ett "automatiskt" och ett "manuellt".
- **Active vs passive buzzer-distinktionen** är hanterad systematiskt (Modul 3 + Bilaga C + Bilaga E + slide).
- **Bilaga D ("hackathon-lösning")** har medvetet tröghet inbyggd ("titta inte hit för tidigt") — förstår sin egen pedagogiska risk. Den brutala formuleringen är dock i mjukaste laget (se R12).
- **Färgkoder + standardvärden** läggs in i resistor-bilagan (`appendix-c-komponenter.typ:50–52`) så eleven kan slå upp utan att gå tillbaka till slidesen.
- **Bygg från minnet-sektionen** i varje modul (utan kod-mall) tvingar eleven att internalisera mönster snarare än kopiera. Vuxenpedagogiskt utmärkt.
- **"Vanliga fel och snabblösningar"-tabellen i varje modul** är ett guldvärt felsökningsverktyg. Behåll den i exakt nuvarande form.
- **Bilaga A:s `const int` vs `#define`-förklaring** (`appendix-a-syntax.typ:58–75`) löser proaktivt en fråga som annars hade kommit upp i Modul 1 vid `LED_BUILTIN`. Förebygger förvirring.
- **Sense-act-loop-rutan** i Modul 5 är pedagogiskt fenomenal (se O5).
- **Säkerhetskapitlet** (`appendix-e-sakerhet.typ`) har rätt ton: "5 V är ofarligt — slappna av" är sagt två gånger explicit, och de fem varningarna är **icke-skrämmande** men konkreta.

---

## Summary

- **3 hårda fixar (blockers):** typo "internet"→"internt" (Modul 3), inkonsistenta mörker-trösklar (300/400/100-300) över Modul 4/5/Bilaga D/slidesen, och Modul 1 övning 3 förutsätter funktioner som inte introducerats.
- **Inga USB-C-spår** i kursmaterialet — instruktörens flagga är ren. **`digitalWrit`-förklaringen är korrekt** — primärfelet skylls på saknat 'e', inte skiftläge.
- **Tre strukturella förbättringsmöjligheter värda att prioritera:** (R2) "bränna CPU:n"-metaforen är pedagogiskt skadlig och skapar terminologisk konflikt med "kortslutning"; (R5/R6) hemmaövningar i Modul 3 och Modul 4 introducerar `?:`, `map()`, och funktioner utan föregående lektion — vuxen hemma har ingen självhjälp; (O7) slide-nummerreferenser i kompendiet är sköra mot omredigering — använd namn istället.
- **Pedagogiskt starkast i materialet:** Edge-detection-introduktionen (problem före lösning), vattenanalogin som täcker tre koncept, sense-act-loopen som tankeram för embedded, och de återanvända pinnumren som låter studenten bygga vidare utan att koppla om.
- **Tonal asymmetri:** Modul 4–5 är mer "sträng men kärleksfull" i sin direkta röst än Modul 1. Inte ett fel, men värt att överväga om Modul 1 ska skrivas om i samma röst när du ändå är i texten för andra fixar.
