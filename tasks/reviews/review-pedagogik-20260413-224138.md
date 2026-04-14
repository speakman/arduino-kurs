# Pedagogisk review — Arduino-kurs

**Verdict:** FIX_RECOMMENDED
**Reviewer:** Pedagogik (Opus)
**Datum:** 2026-04-13
**Scope:** `presentation/slides.md` (1962 rader), `tasks/design.md`, `tasks/todo.md`, `research/elegoo-kit.md`

---

## Sammanfattning

Kursen har en stark pedagogisk ryggrad i Modul 1 (tydligt slutmål, vattenanalogi, agenda med tidstämplar, fri övning, delresultat, teaser framåt) — men den polishen har inte replikerats över till Modul 2–5. Modul 2–4 är underbyggda på slide-nivå, har inga delresultats-/teaser-moment, saknar agenda, och flera nyckelkoncept (PWM, if/else, variabler, bool-toggle, debounce) lever enbart i speaker notes. Det största pedagogiska problemet är att **Modul 5 (hackathonen) förutsätter koncept som aldrig lärts ut explicit** — deltagarna förväntas skriva en state-toggle, if/else-kedja och tröskellogik med bara en pin-mall som stöd. Det är inte orimligt att lyckas, men det är inte pedagogiskt redigt. Rekommendation: polera Modul 2–4 till samma nivå som Modul 1 och lägg in en "kod-grammatik"-slide i Modul 3 innan ni går vidare till kompendiet.

---

## Kritiska problem (blockerar — måste fixas innan kompendium)

### K1. PWM och `analogWrite` lärs aldrig ut på skärm (Modul 2)
Slides 1110–1271 går från "tre färger, alla färger" → "power rails" → RGB-wiring utan att någonstans på en slide förklara vad PWM är, vad `analogWrite(pin, värde)` gör, eller vad intervallet 0–255 betyder. Det finns **ingen kod-slide** alls för Modul 2 — jämför med Modul 1 som har en dedikerad "setup()/loop()"-slide + en "tre kommandon"-slide. analogWrite finns bara i speaker notes (rad 1230–1236). Detta är kärnbegreppet i hela modulen och måste upp på skärmen som egen slide (analogt mot Modul 1 slides "Kodens anatomi" + "Hela Blink på tre rader").

**Fix:** Lägg till minst två slides i Modul 2:
- "Digital vs PWM" — en-idé-slide som kontrasterar `digitalWrite(HIGH/LOW)` mot `analogWrite(0–255)` (gärna med magic-move från förra veckans Blink-kod).
- "Blanda färg" — kod-slide med tre analogWrite-rader + en uppgift ("hitta lila", "hitta gammelrosa").

### K2. `if`/`else` dyker upp i Modul 3 utan att ha lärts ut
Rad 1316–1345 ("Input ≠ Output") visar två kod-rader för `pinMode` + `digitalRead`, och speaker notes på rad 1342 säger "Uppgift: få knappen att styra lampan". Men själva if/else-satsen finns bara i speaker notes på rad 1444–1459. För en deltagare som inte har programmerat förut är `if (digitalRead(knappPin) == LOW) { ... } else { ... }` en helt ny språk-konstruktion — villkor, jämförelse-operator, block-syntax. Detta är en stor konceptuell sprang som bara smygs in via talarnotiser.

**Fix:** Lägg till en "Att fatta beslut i kod"-slide mellan "Input ≠ Output" och buzzer-varningen. Visa if/else-mönstret visuellt: "om knapp tryckt → gör X, annars → gör Y". Detta ska vara en slide på samma detaljnivå som "Tre kommandon" i Modul 1.

### K3. Modul 5 hackathonen kräver koncept som aldrig lärts ut
Slide 1764–1920 ger deltagarna en pin-tilldelning och tre logik-regler. För att faktiskt bygga larmet måste de skriva:

1. **Edge-detektering på knappen** (toggla en bool när knappen går från HIGH → LOW — annars kommer larmet toggla 50 gånger per sekund så länge knappen hålls nere).
2. **State-variabel** (`bool larmPaslaget` — finns i mallen men tilldelning/flip är aldrig lärd ut).
3. **Tröskel-jämförelse** på LDR (`if (ljus < 400)`).
4. **Debounce på tilt-sensorn** (nämnd i speaker notes rad 1611, men aldrig på en slide).
5. **If/else-kedja eller nested if** som kombinerar larm-state, tilt och LDR.

Inget av detta ligger på en slide någonstans i kursen. Speaker notes på rad 1900–1913 försöker mildra problemet med "felsökningstips", men det är reaktivt — deltagarna snubblar först, instruktören hoppar in efteråt. Det bryter mot scaffolding-principen: vid sista träffen ska deltagarna **tillämpa** det de kan, inte **lära sig** nya koncept under tidspress.

**Fix:** Antingen (a) introducera state-toggle + tröskel + debounce som dedikerade slides under Modul 3 och 4, eller (b) gör Modul 5 mer styrd med ett halvfärdigt kod-skelett där bara 3–4 rader är blanka att fylla i. Alternativ (b) är enklare men mindre "hackathon"-kännande.

### K4. Asymmetrisk modul-polish — Modul 2–4 saknar Modul 1:s struktur
Modul 1 har ett tydligt pedagogiskt skelett:
section → agenda (tidstämplar) → slutmål → teori → kompontenter → bygg → wiring → kod-anatomi → kod-detalj → fri övning → **delresultat** → **teaser framåt**

Modul 2: section → teori → power rails → wiring. **Ingen** agenda, ingen fri övning, ingen delresultat, ingen teaser. 4 innehålls-slides för 2 timmar.

Modul 3: section → "Input≠Output" → button-wiring → buzzer-varning → buzzer-wiring. **Ingen** agenda, ingen if/else-slide, ingen delresultat, ingen teaser.

Modul 4: section → sensorer → fotocell-wiring → tilt-wiring → Serial Monitor. **Ingen** agenda, ingen delresultat.

Det betyder att deltagarna får en helt annan pedagogisk upplevelse i träff 1 (tydligt strukturerad, stolthetsmoment, antydan om nästa träff) än i träff 2–4 (rambla bygge, inget avslut). Delresultats-sliden är väldigt viktig för vuxna nybörjare — den kodifierar "du har klarat det" och bygger kumulativt självförtroende som ska bära fram till hackathonen.

**Fix:** Replikera Modul 1:s mönster i Modul 2–4. Varje modul behöver minst:
- Agenda-slide med 4 tidsblock.
- En kod-slide (inte bara wiring).
- En fri övnings-slide (som morse-uppgiften).
- En delresultat-slide.
- En "nästa gång..."-teaser.

Detta höjer slide-antalet från ~21 till ~35 men varje modul går från "demo av komponent" till "pedagogisk enhet".

### K5. Variabler och `const int` introduceras utan förklaring
`const int KORT = 200;` dyker upp första gången på rad 901 i Modul 1-övningen. Speaker notes på rad 940 hanterar det med "säg att det är 'att ge ett värde ett namn'". Men det finns ingen slide som lär ut variabeldeklaration, datatyper (`int`, `bool`), eller scope. Sen används det genomgående: `bool larmPaslaget = false` på rad 1857 i Modul 5, `int ljus = analogRead(A0)` på rad 1567 i Modul 4. Deltagarna ska alltså läsa och skriva variabler utan att någon slide någonsin har sagt vad en variabel är.

**Fix:** Lägg till en mini-slide "Namngivna värden: `const int` och `int`" antingen i slutet av Modul 1 (före övningen) eller i början av Modul 3 (när variablerna börjar hopa sig).

---

## Viktiga förbättringar (bör fixas)

### V1. Repetitions-hook saknas innan varje modul
Varje träff börjar med en section-divider (rad 1082, 1273, 1494, 1734) men det finns ingen slide som säger "så här långt har ni kommit". Speaker notes på rad 1099–1108 (Modul 2) säger bara "Kort repetition från förra gången" utan stöd på skärm. För vuxna nybörjare som inte har suttit med Arduino på sju dagar är en explicit "förra veckan: Blink + setup/loop/digitalWrite — den här veckan bygger vi vidare" oerhört värdefull.

**Fix:** Lägg till en "Där vi var" eller "Förra veckan"-slide efter varje section-divider i Modul 2–5. Det kan vara en 5-punkts mini-översikt med de kommandon de redan kan.

### V2. Tilt-sensor är fel-klassad som analog
Slide "Knappen var digital. Världen är analog" (rad 1523) listar tilt-sensorn bredvid fotocellen och kallar det "analog input". Men speaker notes på rad 1550 medger direkt att tilt är "Digital: öppen / sluten". Det är konceptuellt förvirrande — sliden säger "analog", praktiken är digital. En vuxen nybörjare kommer undra varför deras `analogRead(tiltPin)` ger konstiga värden.

**Fix:** Dela upp sliden: fotocell = analog (får egen slide med analogRead och 0–1023-intervallet), tilt = bonus digital sensor (får en halvslide eller placeras redan i Modul 3 bredvid knappen, eftersom den är kopplings- och kod-mässigt identisk med en knapp).

### V3. Voltage divider dumpas som en rad speaker-notes
Spänningsdelare är en icke-trivialt koncept — två resistorer i serie, mätpunkt mellan dem, Ohms lag bakom kulisserna. I kursen dyker det upp som rad 1574 ("Bygg spänningsdelaren: fotocell + 1kΩ → pin A0") och en mening i speaker notes på rad 1592–1602. För deltagare som precis lärt sig Ohms lag i Modul 1 är detta ett gyllene återkopplingsmoment som går förlorat.

**Fix:** Lägg in en egen slide "Spänningsdelare" i Modul 4 som återanvänder vattenanalogin från Modul 1 (två strypventiler i serie, vi mäter trycket mellan dem). Detta knyter bakåt till Modul 1, stärker Ohms lag, och förklarar varför 1 kΩ-resistorn är där.

### V4. `setup()` kontra `loop()`-intuition ska förstärkas över kursen
Modul 1 introducerar setup/loop utmärkt (rad 734–803), men därefter tas konceptet för givet. I Modul 3 är det plötsligt självklart att `pinMode(knappPin, INPUT_PULLUP)` ska ligga i setup och `digitalRead` i loop. En visuell återkoppling på varje modul-agenda-slide ("det här går i setup, det här går i loop") skulle cementera mönstret.

**Fix:** Lägg in en liten återkommande visuell hint-box "setup vs loop" i agenda-sliden för varje modul.

### V5. Differentiering finns bara i Modul 1
Endast Modul 1 har explicita "om någon är klar på 5 min"-utmaningar (morse på hela namnet) i speaker notes (rad 946). Modul 2–5 har ingenting. Med ojämna nybörjargrupper kommer 1–2 deltagare att vara klara dubbelt så fort som resten — och under tiden de väntar tappar de koncentrationen. Detta är särskilt akut i Modul 2 ("hitta lila" kan göras på 2 minuter av någon som redan fattat).

**Fix:** Lägg till en "extra-utmaning" i speaker notes för varje modul: Modul 2 = "gör en fade-effekt med for-loop" eller "regnbåge som scrollar". Modul 3 = "gör en kodlås-sekvens med knappen". Modul 4 = "mät hur mörkt det blir i dina handflator över en minut".

### V6. Edge-detektering / debounce på knappen nämns aldrig
I hackathonen måste knappen **toggla** larm-läget — inte **hålla** det i ett läge. Skillnaden är edge-detektering: spara förra knapp-värdet, reagera bara på övergången HIGH → LOW. Detta är en vanlig snubbeltråd för nybörjare och tas inte upp alls.

**Fix:** Antingen lär ut det explicit i Modul 3 med en "Toggla ett tillstånd"-slide, eller dölj problemet genom att göra larmet "håll-knappen"-baserat istället för toggle. Jag skulle rekommendera det första — att lära sig toggle är en fundamental programmerings-skill.

### V7. Modul 5:s tidsfördelning är optimistisk
Speaker notes på rad 1756–1761 ger ramen: "10 min logik, 10 min kod-skelett, 60–75 min bygge, 10 min demo". Det är 90–105 min aktiv byggtid. Med tanke på att deltagarna ska (a) fysiskt bygga om eller sammansätta 5 kretsar på en breadboard, (b) skriva en if/else-kedja, (c) felsöka. Det är stramt för en grupp som är nybörjare. Ingen pausplacering finns.

**Fix:** Lägg in en explicit paus runt 01:00 i agendan, och ge speaker notes en "fallback"-version: om en grupp inte hinner allt, prioritera (a) stämningsljus fungerar, (b) larm-tjut på tilt. LDR kan hoppas över.

### V8. Kompilatorsfel läses ur notes men aldrig på skärm
Speaker notes på rad 951–958 tar upp vanliga fel ("expected ';' before...", "was not declared in this scope"). Detta är en av de viktigaste felsöknings-färdigheterna i hela kursen — men det syns inte på någon slide. En "Att läsa felmeddelanden"-mini-slide skulle göra det till en första-klassens färdighet istället för en bi-produkt.

---

## Mindre förbättringar (nice to have)

- **M1.** Slide "Klassrummets viktigaste verktyg" (rad 132–167) kommer FÖRE "Träff 1"-section-divider, så den ligger lös. Flytta in den i träff 1:s intro eller gör den till sin egen "Innan vi börjar"-sektion.
- **M2.** Slide "Idag — två timmar" (rad 214–268) i Modul 1 har tid 00:00–02:00, bra. Men de andra träffarna har ingen motsvarighet — se V4/K4.
- **M3.** Modul 1:s "Din egen rytm"-övning visar en `void blink(int tid)`-funktion (rad 917) som pedagogiskt är en stor introduktion (funktioner!) men faktiskt bara kommenteras i speaker notes på rad 936–939. Antingen lär ut funktionsdeklaration explicit, eller ta bort exemplet och visa den upprepade digitalWrite-versionen istället så första-träff-nivån hålls.
- **M4.** "Buzzer-varningen" (rad 1378–1467) är visuellt stark men kommer innan knapp-kopplingen är klar i speaker notes-ordning. Kontrollera att instruktören hinner få knappen att funka innan buzzer-introduktionen.
- **M5.** Översikts-sliden "Fem träffar. Fem moduler." (rad 64–129) är bra, men det finns ingen "låst/upplåst"-visualisering som design-spec:et på rad 17–24 föreskriver ("superkrafter som låses upp"). Det är en potent pedagogisk mekanism som inte används. Överväg att lägga in en progress-indikator i varje section-divider: "Modul 01 ✅ · Modul 02 ⚡ · Modul 03 🔒 · ..."
- **M6.** Rad 1316–1319: `pinMode(knappPin, INPUT_PULLUP);` använder `knappPin` som variabel utan att den är deklarerad någonstans i samma slide. Nybörjare kommer undra vart `knappPin` kommer ifrån. Antingen ha en `const int knappPin = 9;` ovanför, eller använd literal `9` och förklara vad konstanten betyder separat.
- **M7.** Slutslide "Tack" (rad 1922–1943) är fin men har inga konkreta nästa-steg. Speaker notes på rad 1954–1958 har bra tips (Hackster, makerspaces) — flytta upp minst ett av dem på sliden så deltagarna har det kvar när presentationen stängs.
- **M8.** Delresultats-sliden i Modul 1 (rad 974–1039) använder "Ett varv runt rummet — visa upp ditt mönster för grannen". Utmärkt. Replikera mönstret för Modul 2–4.

---

## Styrkor att bevara

1. **Modul 1:s "slutmål-först"-demo (rad 270–307).** Instruktören visar det färdiga larmet innan något teori-ord har sagts. Det är hur-man-gör-motivationsförankring i vuxenpedagogik i sin renaste form. Behåll exakt.
2. **Vattenanalogin (rad 454–512).** Klassisk, pricksäker, och återvinningsbar — använd den igen i spänningsdelarsliden (V3).
3. **Agenda med tidstämplar i Modul 1 (rad 214–268).** Ger deltagarna en "jag vet var vi är"-karta. Sätter en förväntan som sänker ångest. **Replikera för alla moduler.**
4. **Grön/röd Post-it-system (rad 132–167).** Skalbart klasslednings-verktyg som är explicit undervisat. Smart.
5. **Aktiv buzzer sticker-varning (rad 1386–1415).** Humoristisk, specifik, fysisk, omöjlig att missa. Perfekt exempel på hur en teknisk varning blir minnesvärd.
6. **INPUT_PULLUP lärs ut ärligt om inverterad logik (rad 1334–1339).** Erkänner "trolleringen" istället för att dölja den. Det är sund pedagogik — nybörjare kommer ändå stöta på det och blir förvirrade om det inte flaggas.
7. **Konsistenta pin-tilldelningar över hela kursen (D6/D5/D3 RGB, D9 knapp, D12 buzzer, D2 tilt, A0 LDR).** Betyder att återanvändning i Modul 5 fungerar rakt av. Mycket bra konstruktion.
8. **Serial Monitor introduceras i Modul 4, inte Modul 5.** Ger deltagarna ett felsöknings-verktyg innan de behöver det mest. Korrekt ordning.
9. **Speaker notes är djupt pedagogiska i Modul 1 — vanliga fel, fallback-fraser, timing-hints.** Detta är guldstandard för instruktörs-stöd. Problemet är bara att samma djup inte finns i Modul 2–4 — se K4.
10. **"Kodens anatomi" + "Tre kommandon" i Modul 1 (rad 734–872).** Perfekt scaffold: minsta möjliga koncept-set för att få blink att gå. Replikera mönstret för Modul 2 (analogWrite + PWM-koncept).
11. **Elegoo-research bakas in i slide-referenser ("sid 42", "Lesson 3").** Betyder att deltagare kan korsreferera mot sin egen manual. Bra för självständig läsning hemma.
12. **Fri övning i Modul 1 ("Din egen rytm") med både lätt och svår variant (morse på hela namnet).** Differentiering på samma slide. Replikera.

---

## Moduler — bedömning per modul

### Modul 1 (LED & krets)
**Status:** Solid. Pedagogisk ryggrad. Detta är referensen de andra modulerna ska mäta sig mot.
**Slides:** ~9 innehålls-slides för 2 timmar.
**Pedagogisk kurva:** Slutmåls-demo → vad är mikrokontroller → V/A/GND → kretsanalogi → komponenter → bygg → wiring-bild → kod-anatomi → tre kommandon → fri övning → delresultat → teaser. **Exemplarisk scaffolding.**
**Problem:** M3 (funktionsexemplet i övningen är ett hopp), K5 (const int utan förklaring), M6 (knappPin saknar deklaration — gäller Modul 3 men pattern sätts redan här).
**Rekommendation:** Små justeringar.

### Modul 2 (PWM & RGB)
**Status:** Underbyggd. Allvarligt glapp mellan vad sliderna säger och vad uppgiften kräver.
**Slides:** 4 innehålls-slides. Färre än halva Modul 1.
**Pedagogisk kurva:** Section → "tre färger" → power rails → wiring. Ingen PWM-slide, ingen kod-slide, ingen övning, ingen delresultat, ingen teaser.
**Problem:** K1 (PWM ej undervisad), K4 (saknar hela strukturen), V5 (ingen differentiering), M8 (ingen delresultat).
**Rekommendation:** **Bygg ut till ~8 slides.** Lägg till: agenda, "digital vs PWM" kontrast-slide, `analogWrite`-kod-slide, fri övning ("hitta lila, gammelrosa, skolgul"), delresultat, teaser. Detta är den modul som behöver mest jobb.

### Modul 3 (Digital input)
**Status:** Funktionell men tunn. Buzzer-varningen är starkast, men if/else-glappet är en minbomb.
**Slides:** 5 innehålls-slides.
**Pedagogisk kurva:** Section → "Input ≠ Output" + kodrader → knapp-wiring → buzzer-varning → buzzer-wiring. Ingen agenda, ingen if/else-slide, ingen delresultat, ingen teaser.
**Problem:** K2 (if/else bara i notes), K4, V6 (edge detection / toggle aldrig lärt), V8 (felmeddelanden).
**Rekommendation:** Lägg till: agenda, "Att fatta beslut med if/else" kod-slide, "Toggla ett tillstånd" slide (sätter upp Modul 5), övning ("knappen styr buzzern via if/else"), delresultat, teaser. **~8 slides totalt.**

### Modul 4 (Analog input)
**Status:** Konceptuellt förvirrande på tilt/fotocell-blandningen. Serial Monitor-introduktionen räddar modulen.
**Slides:** 5 innehålls-slides.
**Pedagogisk kurva:** Section → "digital vs analog" + sensorer → fotocell-wiring → tilt-wiring → Serial Monitor + kod. Ingen agenda, ingen delresultat, ingen teaser (bara en mening i notes om hackathon).
**Problem:** K4, V2 (tilt fel-klassad), V3 (spänningsdelare dumpas), V5 (differentiering saknas). Positivt: Serial Monitor är bra introducerad.
**Rekommendation:** Splitta sensorer. Ge fotocellen sin egen slide med analog-teori + spänningsdelare. Flytta tilt-sensorn till Modul 3 där den pedagogiskt hör hemma (identisk logik med en knapp). Lägg till agenda, övning ("printa både ljus och tilt i Serial Monitor, hitta din tröskel"), delresultat, tydlig hackathon-teaser. **~8 slides totalt efter uppsplittning.**

### Modul 5 (Integration)
**Status:** Risk för att deltagare kör fast på grund av otauta koncept. Hackathon-formatet är bra, men gangplankan är för smal.
**Slides:** 3 innehålls-slides (ingenjörsuppgiften, pin-tilldelning, kod-skelett).
**Pedagogisk kurva:** Section → regler → pin-mall + skelett-kod. Det är det.
**Problem:** K3 (state-toggle, tröskel-jämförelse, debounce lärs aldrig ut explicit), V7 (timing optimistisk, ingen paus).
**Rekommendation:** Antingen (a) flytta state-toggle + tröskel till Modul 3/4 som dedikerade slides, eller (b) publicera ett mer utfört kod-skelett där bara 3–4 rader är tomma att fylla i (stämningsljus-värden, tröskelvärde, "om larm och tilt"-blocket). Lägg in explicit paus i agendan. Ha ett "minimum viable alarm"-fallback: om ni inte hinner allt, få **stämningsljus + tjut på tilt** att funka. LDR är trevligt-att-ha. Delresultats-sliden i slutet bör få en egen "upplåsta superkrafter"-visualisering som design-spec:et lovade (M5).

---

## Rekommendationer inför kompendium

Kompendiet ska vara **bärande där sliderna är tunna** och inte upprepa det sliderna redan gör bra.

### Kompendiet BÖR innehålla (det slide-decket saknar)
1. **En fullständig syntax-referens:** variabler, datatyper (`int`, `bool`), `const`, if/else, jämförelse- och likhets-operatorer, `||`/`&&`, funktioner, scope. Detta är "språk-grammatik" som sliderna inte har plats för men deltagarna måste kunna slå upp.
2. **Spänningsdelaren på djupet** — grafik + Ohms-lag-räkning. Knyt tillbaka till vattenanalogin.
3. **En felmeddelande-cheatsheet.** Vanliga kompilatorsfel, vad de faktiskt betyder, hur man läser dem. Detta är en skill som vuxna behöver stöd för mellan träffarna.
4. **Hackathon-lösning(ar) — kommenterad.** Efter slutträffen vill deltagare ofta se "hur skulle EN lösning se ut". Lägg den sist i kompendiet som efter-läsning så att den inte spoilers hackathonen men finns tillgänglig för den som vill förstå efteråt. Inkludera gärna 2 varianter: en minimal och en mer sofistikerad (med state machine).
5. **Komponent-katalog för kittet** — lista varje komponent, vad den används till, när i kursen den dyker upp, vanliga nybörjar-misstag. Fungerar som uppslagsverk.
6. **Hemläxor / "hemma-experiment" mellan träffarna.** Kursen är en gång i veckan — deltagarna behöver något att göra hemma för att hålla momentum. T.ex. efter Modul 1: "prova 5 olika delay-värden", efter Modul 2: "bygg en färg-cykel", efter Modul 3: "bygg en morse-sändare med buzzer". Dessa bör vara valfria men dokumenterade i kompendiet.
7. **"Säkerhet & goda vanor"-kapitel** — koppla aldrig 5V direkt till GND, stäng av strömmen innan omkoppling, etc. Kort men måste finnas skrivet.
8. **Ett "nästa steg efter kursen"-kapitel** — vad kittet kan användas till, andra projekt, var man lär sig mer. Detta ligger bara i speaker notes på sista sliden.

### Kompendiet BÖR INTE upprepa (sliderna gör det bra)
- Vattenanalogin för kretsar (finns redan visuellt på slide — referera till den, utveckla inte).
- Slutmål-sektionen (det är en uppleveles, inte text).
- Grön/röd Post-it-systemet (det är klassledning, inte kursmaterial).
- Long-form setup/loop-förklaring (sliderna har exakt rätt nivå).
- Wiring-bilderna från Elegoo-manualen — hänvisa bara till sid-nummer. Deltagarna har manualen fysiskt.

### Struktur-förslag för kompendiet
1. Förord + hur kompendiet används
2. Komponent-katalog (uppslag)
3. Modul 1 — teori-djup + hemläxa
4. Modul 2 — teori-djup + hemläxa
5. Modul 3 — teori-djup + hemläxa
6. Modul 4 — teori-djup + hemläxa
7. Modul 5 — utförlig hackathon-spec
8. Appendix A — syntax-grammatik
9. Appendix B — felmeddelande-cheatsheet
10. Appendix C — hackathon-lösning(ar) med kommentarer
11. Appendix D — säkerhet + goda vanor
12. Appendix E — nästa steg

Varje modul-kapitel bör **referera tillbaka till slide-numrering** så att instruktören och deltagaren delar ett gemensamt språk: "se slide 'Tre kommandon' / kompendie §3.2".

---

## Sammanfattande bedömning

Kursen har ben och ryggrad. Modul 1 visar att designern kan pedagogik på seniornivå. Men **Modul 2–5 har inte fått samma behandling** — de är tunna, inkonsistent strukturerade, och Modul 5 förutsätter koncept som aldrig har lärts ut explicit. Detta är klassiskt "första modulen polerades, resten klippkartades"-mönstret.

Skriv **inte** kompendiet förrän Modul 2–5 har lyfts till samma strukturnivå som Modul 1. Om kompendiet skrivs först kommer det att fylla i gapen som egentligen borde finnas på skärm — och då förlorar kursen sitt viktigaste pedagogiska verktyg (den gemensamma, levande upplevelsen i rummet). Kompendiet ska vara **referens**, inte **ersättning**.

**Verdict: FIX_RECOMMENDED.** Fixa K1–K5 först, polera Modul 2–4 till Modul 1:s standard, sedan skriv kompendiet ovanpå.
