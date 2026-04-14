# Pedagogisk utmaning av förslaget

**Verdict:** APPROVE_WITH_CHANGES (men flera ändringar är icke-förhandlingsbara)
**Reviewer:** Pedagogik-challenger (Opus)
**Datum:** 2026-04-13

## Sammanfattning

Huvudsessionen har hittat 80% av rätt riktning: gate-flaggorna mappas elegant mot fyra elektronik-slides och fas-uppdelningen är sund. Men förslaget gör tre fel som tillsammans riskerar att bryta kursens hands-on-kärna: (1) det räknar inte tidsbudget per modul och Modul 2 kvävs när den växer från 4 till ~10 slides på 2 timmar, (2) det blandar ihop "förklara PWM elektroniskt" med "lära ut analogWrite som verktyg" och placerar därför E4 på fel sida om wiringen, och (3) det säger sig adressera C1 (state-toggle/edge-detection i hackathon) via E2 (pullup) — det är en kategorifel, inte en delvis lösning. Plus en blind fläck: förslaget växer kursen från 34 till ~50 slides utan att fråga om det överhuvudtaget är rätt riktning för en kurs vars guldstandard (Modul 1) blev bra för att den var **disciplinerad**, inte för att den var stor.

## Starkaste delarna av förslaget

1. **E1 Breadboard-anatomi** är en uppenbar vinst. Den löser ett verkligt klassrumsproblem (5-hål-noden), tar 60 sekunder att leverera, och kostar inget pedagogiskt. Behåll exakt som föreslaget.
2. **E3 Spänningsdelare med vattenanalogi-återbruk** är förslagets bästa idé. Den löser V3/I9, ger Modul 4 ett pedagogiskt zenith som matchar Modul 1, och knyter kursen kumulativt bakåt. Återbruket av analogin är precis hur scaffolding ska se ut hos vuxna nybörjare.
3. **Listan över vad som INTE ska läggas till** (transistorer, kondensatorer, oscilloskop, RF, skiftregister, ADC-djup) är disciplinerad och rätt. Den visar att huvudsessionen förstår scope-risken — vilket gör det desto mer förvånande att Modul 2-storleken inte räknades.
4. **Fas-ordningen "fixar först, sedan struktur, sedan live-verifiering, sedan kompendium"** är rätt sekvens. Behåll.
5. **Att E5 markerats valfri** är en korrekt instinkt. Säkerhetsvarningarna är redan i speaker notes och en hel slide om dem riskerar att brytas mot "inga slides utan bygge"-löftet i Modul 1-agendan.

## Svagheter och blinda fläckar

### S1. Tidsbudgeten räknades aldrig — Modul 2 kvävs

Modul 2 är 2 timmar = 120 min. Föreslagen sammansättning efter Fas 2:
- Section divider (1 min)
- Agenda (3 min)
- "Alla färger av tre" (4 min)
- E4 PWM / duty cycle (8 min — ny)
- Power rails (4 min)
- analogWrite-kod-slide (6 min — ny)
- RGB wiring + bygge (25 min)
- Fri övning "hitta lila/gammelrosa/skolgul" (20 min)
- Delresultat (10 min)
- Teaser (3 min)
- **Summa slide-tid: ~84 min**, kvar för felsökning, frågor, paus, drift: 36 min.

På ytan rimligt. Men det är **före**:
- Repetitions-hook från förra veckan (V1 från pedagogik-rapporten — fortfarande oadresserad)
- Buzz mellan slides (vuxna nybörjare = slow context switches)
- Att ny RGB-LED-kabling tar längre tid än Blink-kabling (4 ben istället för 2, common cathode-förvirring)
- Att felsökning av första analogWrite-koden tar minst 10 min för 2-3 grupper

Realistiskt landar Modul 2 på 130-140 min med förslagets sammansättning. **Kursen tappar pausen och hands-on-tiden krymps till 25-30 min**, vilket är under Modul 1:s 50 min. Det bryter mot kursens DNA.

**Konsekvens:** Antingen droppa agenda-sliden (den är en symbol-importerad Modul 1-vana, inte en nödvändighet i en kortare modul), eller slå ihop E4 PWM med analogWrite-kod-sliden till ETT slide ("Digital vs PWM + kod-rad"), eller kapa power rails till en tip-box på wiring-sliden. Förslaget måste välja. Just nu väljer det allt.

### S2. E4 PWM placeras på fel sida av wiringen — bryter discovery learning

Förslaget säger uttryckligen att E4 PWM ska komma **före** RGB-wiringen. Det är fel pedagogiskt, av tre skäl:

(a) **Förlorat aha-moment.** Discovery learning för vuxna nybörjare fungerar bäst när konceptet introduceras EFTER att deltagaren har sett ett mysterium hända. Om de först bygger kretsen, kör `analogWrite(redPin, 128)` som instruktören dikterar, och ser LEDen lysa svagare än med `digitalWrite(redPin, HIGH)` — då har de en konkret upplevelse att hänga teorin på. PWM-förklaringen "490 Hz av/på, ögat blandar ihop det" landar då som ett *svar* på en fråga de redan har. Före wiringen landar den som ännu en abstraktion ovanpå breadboarden.

(b) **Modul 1:s mönster är faktiskt åt andra hållet** — slutmåls-demo (mystik) → vattenanalogi (förklaring efter mystiken). Förslaget gör motsatsen i Modul 2: förklaring först, krets sedan. Inkonsistent.

(c) **Att kalla det "magic-move från digitalWrite till analogWrite"** låter snyggt men missar att magic-moves fungerar pedagogiskt när deltagaren redan har handen på den första formen. Vid Modul 2:s start har de inte rört digitalWrite på 7 dagar.

**Korrekt ordning:** Section → agenda → "Alla färger av tre" → wiring + bygg → kort fri experimentering med `analogWrite(pin, 0)`, `analogWrite(pin, 64)`, `analogWrite(pin, 255)` → **E4 PWM-slide som svar på "varför ser 64 ut som det gör?"** → kod-slide → fri övning ("hitta lila").

### S3. E2 löser INTE C1 — det är önsketänkande

Förslaget skriver: "Delvis C1 (pedagogik/codex): Sätter grund för att förstå state-toggle senare". Detta är ett kategorifel.

- **Pullup** är ett *elektroniskt* fenomen: en resistor som drar en pin till en definierad nivå.
- **Edge-detection** är ett *programmeringsmönster*: spara `lastState`, jämför `currentState != lastState`, agera bara på övergången.
- **State-toggle** är ett *programmerings­mönster*: `larmPaslaget = !larmPaslaget`.

Att förstå pullup hjälper INTE en deltagare att skriva edge-detection. De är ortogonala. C1 kräver fortfarande en dedikerad slide om "Toggla ett tillstånd" och en om "Reagera bara när knappen TRYCKS, inte när den HÅLLS". Förslaget listar visserligen "Toggla ett tillstånd"-slide i Modul 3-Fas 2-listan, men markerar den bara som "del av C1" istället för "C1 löses av denna ena slide". Det är slarvig flaggning som riskerar att Edge-detection-sliden glöms bort när planen exekveras.

**Konsekvens:** C1 kräver minst två slides, inte en. "Toggla ett tillstånd (state-flip)" och "Reagera på flanken (edge-detection)". Den senare saknas helt i förslaget. Utan den havererar Modul 5 fortfarande.

### S4. Tilt-sensorn — false dichotomy och fel ramning

Förslaget presenterar "flytta till Modul 3 ELLER rama om Modul 4-dividern" som de två alternativen och tar inte ställning. Båda är otillräckliga. Den **tredje vägen** är pedagogiskt klart bäst:

**Splitta tilt-introduktionen från tilt-användningen.** Tilten introduceras kort i Modul 3 bredvid knappen ("samma kod, samma INPUT_PULLUP, men trigger är fysisk lutning istället för fingertryck"), men dess **användning i larm-kontexten med debounce** kommer i Modul 4 där den hör hemma som "den sista byggstenen innan hackathonen". Det ger:

- Konceptuell renhet (tilt = digital, intro där digitala sensorer lärs)
- Modul 4 förblir "sensor-katalog + felsökning" utan omraming
- Debounce-pratet får en naturlig hemvist (i Modul 4, när tilten faktiskt ska användas mot riktigt brus)
- Deltagarna får möta tilten två gånger innan hackathonen — vilket är hur scaffolding ska se ut

Att enbart "flytta" som förslaget alternativ A föreslår förlorar Modul 4:s sensor-katalog-känsla. Att enbart "rama om" som alternativ B förlorar konceptuell renhet. Splitta dem.

### S5. Blind fläck: edge-detection saknas helt i förslaget

C1 från gate-verdicten listar fem koncept som hackathonen kräver: edge-detection, state-toggle, tröskel-jämförelse, debounce, nested if/else. Förslaget täcker:
- Tröskel-jämförelse — implicit via E3 spänningsdelare + Serial Monitor (befintlig)
- State-toggle — "Toggla ett tillstånd"-slide i Modul 3-Fas 2
- Nested if/else — "if/else"-slide i Modul 3-Fas 2
- Debounce — inte adresserat alls
- **Edge-detection — inte adresserat alls**

Detta är förslagets största pedagogiska blinda fläck. Edge-detection är **nödvändig** för att knappen ska toggla larm-läge istället för att flippa 50 gånger per sekund. Utan slide-undervisning av detta kommer hackathonen att producera buggade larm — exakt det gate-verdicten varnade för.

### S6. Blind fläck: Modul 1 är inte heller perfekt och förslaget förvärrar den

Förslaget lägger till E1, E5 och I4 (variabel-slide) i Modul 1. Det är 2-3 nya slides i den enda modulen som faktiskt flyter. Modul 1 har idag ~9 innehållsslides på 2 timmar — sweet spot. Förslaget tar den till 11-12. Risken: Modul 1:s berömda "ingen slide utan bygge"-löfte börjar erodera. **I4 (variabel-slide) hör hemma i Modul 3, inte Modul 1**, eftersom det är där `int ljus = analogRead(A0)` och `bool larmPaslaget` faktiskt börjar spränga. Att stoppa in den i Modul 1 är att lägga en torr koncept-slide mellan slutmåls-demo och Blink — exakt det Modul 1 lyckades undvika.

**Pedagogik-rapporten jag skrev tidigare gav en otydlig instruktion** ("slutet av Modul 1 ELLER början av Modul 3"). Jag rättar det här: variabel-sliden hör entydigt hemma i Modul 3. Förslaget bör tvingas att välja, och välja rätt.

### S7. Kumulativ komplexitet — kursen växer, fokus tappas

34 slides → ~50 slides är 47% tillväxt. Förslaget motiverar det inte i termer av deltagar-tid, bara i termer av "varje modul får Modul 1:s struktur". Men Modul 1 fungerar inte för att den har 9 slides. Den fungerar för att varje slide är **omistlig**. Hälften av Modul 1:s slides är handfasta moment ("Bygg kretsen", "Hela Blink", "Din egen rytm"), inte koncept-slides. När förslaget replikerar "agenda + kod-slide + övning + delresultat + teaser" till Modul 2-4 importerar det Modul 1:s **form** utan att fråga om Modul 2-4 har lika många omistliga moment att fylla formen med.

**Den ärliga frågan förslaget inte ställer:** Skulle Modul 2 kunna *kortas* istället för att växa? RGB-modulen kan rimligen levereras som section → "alla färger av tre" → wiring → analogWrite-experimentering (med PWM-förklaring inbakad som tip-box) → fri övning → delresultat. **6 slides, inte 10.** Det är pedagogiskt mer disciplinerat och respekterar 2-timmars­ramen.

### S8. LLM-skrivet vs användar-skrivet innehåll — förslaget undviker frågan

Förslaget listar detta som "antagande att utmana" men presenterar inget ställningstagande. Mitt svar: **E1, E5 och kod-slides kan LLM:en skriva. E2 (pullup-narrativet), E3 (vatten­analogi-återbruket), och C1-slides (edge-detection, state-toggle) måste användaren skriva själv eller kraftigt redigera.**

Skälet: Modul 1:s pedagogiska kvalitet ligger inte i orden — den ligger i de fysiska sambanden mellan vad instruktören gör med händerna och vad sliden säger. ("Håll upp ditt färdiga larm. Släck taklampan."). LLM-genererat innehåll är ord utan kropp. Det fungerar för faktatung material (E1 breadboard-rader, E5 säkerhets­regler) men kollapsar för analogi-driven pedagogik (E3) och för subtila programmerings­mönster där ordvalen styr om en nybörjare fattar (edge-detection). Att låta LLM:en skriva E3 är att riskera att det näst-viktigaste pedagogiska ögonblicket i hela kursen levereras som generisk teknisk text.

## Ställningstaganden på öppna frågor

### Tilt-sensor (flytta vs rama om)
**Splitta** — introduktion i Modul 3 bredvid knappen (samma kod, fysisk trigger), användning + debounce-prat i Modul 4 där hackathon-vinkeln aktualiseras. Se S4. Båda av förslagets alternativ är otillräckliga.

### E4 PWM ordning (före vs efter wiring)
**Efter** wiringen, som svar på en fysisk observation (LED:en lyser svagare när deltagaren skriver `analogWrite(pin, 64)`). Discovery learning > deduktiv förklaring för vuxna nybörjare. Se S2.

### Modul 2-storlek (är 9–10 slides rätt?)
**Nej.** Mål: 6-7 slides. Drop agenda-slide (Modul 1-import som inte motiveras av modul-längden), slå ihop power rails till en tip-box på wiring-sliden, och bake PWM-förklaringen som en kort post-wiring teori-slide istället för en stor pre-wiring koncept-slide. Förslagets 9-10 spränger 2-timmars­ramen och kväver hands-on-tiden. Se S1 och S7.

### LLM-skrivet vs användar-skrivet innehåll
**Splittat ansvar.** LLM skriver: E1 (breadboard), E5 (säkerhet), kod-slides (analogWrite, if/else, edge-detection — eftersom de är mestadels exempel-kod plus minimal omkringliggande text). Användaren skriver eller kraftigt redigerar: E3 (vattenanalogi-återbruket — för känsligt för generisk text) och narrativen runt edge-detection/state-toggle (där ordvalen avgör om det landar). Förslaget måste skrivas om så att detta är explicit, annars kommer ALLT att LLM-genereras och Modul 1:s kvalitet kommer inte att replikeras.

## Rekommenderade ändringar till förslaget

Innan förslaget spikas måste följande ändras:

1. **Lägg till en tidsbudget-räkning per modul** (Modul 2-5) i förslaget och visa att den landar under 110 min för att lämna 10 min buffer + paus. Om en modul överskrider, kapa slides tills den passar.

2. **Krymp Modul 2** från ~10 till ~7 slides. Konkret: drop agenda-slide, baka power rails som tip-box på wiring-sliden, placera E4 PWM EFTER wiringen som ett 2-min teori-svar, behåll analogWrite-kod-slide, behåll fri övning, behåll delresultat, drop separat teaser (en mening i delresultats-sliden räcker).

3. **Lägg till en explicit edge-detection-slide i Modul 3.** Heter t.ex. "Reagera på flanken — inte på hållet". Visar mönstret `if (state == LOW && lastState == HIGH) { ... } lastState = state;`. Detta är icke-förhandlingsbart för C1.

4. **Behåll separat state-toggle-slide** ("Toggla ett tillstånd") som förslaget redan listar — men flagga den explicit som lösning på C1, inte som "del av C1".

5. **Splitta tilt-sensorn** istället för att välja flytta-eller-rama-om. Korta intro i Modul 3, full användning + debounce i Modul 4. Se S4.

6. **Flytta variabel-sliden (I4) från Modul 1 till Modul 3.** Modul 1 är full. Modul 3 är där variabler börjar bli nödvändiga.

7. **Flytta E4 PWM från före till efter wiring.** Se S2.

8. **Specificera vem som skriver vad.** E3 och edge-detection-narrativen markeras "USER WRITES". Resten markeras "LLM DRAFT, USER REVIEWS". Inget får gå direkt från LLM till slide-deck utan minst en manuell pass på de pedagogiskt känsligaste delarna.

9. **Lägg till debounce-prat i tilt-sensor-sliden i Modul 4** (förslaget har det inte explicit som slide, bara som speaker notes). Det räcker med en tip-box: "Tilt skakar — sampla med `delay(50)`". Adresserar I10.

10. **Ompröva om kursen ska växa till 50 slides eller krympas till 30.** Förslaget tog "växa" som givet utan att fråga. Det är värt en 5-min reflektion innan exekvering: vill användaren ha en disciplinerad 30-slide-kurs där varje modul är så slimmad som Modul 1, eller en 50-slide-kurs där Modul 2-4 har Modul 1:s struktur men inte dess disciplin? Båda är legitima val. Men det är ett VAL.

## Vad förslaget får rätt att inte oroa sig för

- **E1 Breadboard-anatomi** — enbart vinst, ingen risk. Lägg till exakt som beskrivet.
- **E3 Spänningsdelare med vattenanalogi** — pedagogiskt stark idé, ska absolut byggas (men av användaren själv, inte LLM:en).
- **E5 Säkerhet & goda vanor som valfri** — korrekt instinkt, OK att hoppa om Modul 1 redan är full.
- **Lista över vad som inte ska läggas till** — disciplinerat och rätt, behåll.
- **Fas 1-fixarna (eyebrow, caption, pulldown→pullup, RGB Lesson 4-referens, slide 14-cleanup)** — alla rena vinster, kör utan vidare diskussion.
- **Kompendium-fördröjning på 2 dagar** — motiverad. Att skriva kompendiet ovanpå nuvarande slides skulle fylla i fel gap.
- **Att inte lägga till transistor/kondensator/oscilloskop-teori** — rätt, även för en FRO-publik. Radioamatörer kan redan det de behöver om elektronik; det de saknar är programmerings­scaffolding, inte mer elektronik.

---

**Sammanfattat:** Förslaget är 80% rätt och 20% pedagogiskt slarv. Det slarvet är fixbart i en redigeringsrunda — men det MÅSTE fixas innan exekvering, för slarvet ligger på de mest belastade ställena (Modul 2-tidsbudget, edge-detection-luckan, E4-ordning). Med ändringarna 1-10 ovan blir förslaget approve_as_is. Utan dem kommer Fas 2 att producera en kurs som ser strukturerad ut men kväver hands-on-tiden och fortfarande havererar Modul 5-hackathonen.
