# Djävulens advokat på förslaget

**Verdict:** APPROVE_WITH_CHANGES (med skarp prioriteringsändring — se Slutsats)
**Reviewer:** Djävulens advokat (Opus)
**Datum:** 2026-04-13

## Sammanfattning

Förslaget är välskrivet, internt konsekvent, och löser exakt de problem som fyra LLM-reviewers identifierade — men det är ett **klassiskt fall av "lös problem som existerar på papper innan du har data från riktiga deltagare"**. Det tyngsta argumentet mot förslaget i en mening: **du står i begrepp att fördubbla slidedäcket och försena kompendiet med 2 dagar baserat på en eko-kammare av LLM-reviewers, utan att en enda människa eller projektor har sett materialet ännu** — och kompendiet, som var det ursprungliga målet, är just det artefakt som mest sannolikt skulle exponera vilka av de 7 "blockers" som faktiskt spelar roll.

## Hypoteser testade

### H1: Löser förslaget fel problem? — STÄMMER_DELVIS

Förslaget formulerar sin egen ledstjärna explicit i Fas 2-rubriken: *"lyfter Modul 2–4 till Modul 1:s nivå"*. Det är **en hypotes som behandlas som ett axiom**. Inget i gate-verdicten bevisar att Modul 1:s djup är rätt nivå — bara att den är **mer polerad** än de andra. Det är ett relativt påstående, inte ett absolut.

Två konkurrerande hypoteser som förslaget aldrig testar:
1. **Modul 1 är överproducerad.** 12+ slides för session 1 (cover → vattenanalogi → komponenter → bygg → wiring → kodens anatomi → tre kommandon → hela Blink → fri övning → delresultat → teaser → differentiering) är mycket för 2 timmar med vuxna nybörjare som aldrig sett en breadboard. En realistisk replikering över 5 moduler ger **~60 slides totalt**, vilket är för många för en hackathon-kurs. Den naturliga reaktionen blir att skära Modul 1, inte växa Modul 2–5.
2. **Asymmetri är feature, inte bug.** Modul 1 *behöver* mer scaffolding eftersom det är där allt är nytt. Modul 2–4 kan med rätta vara tunnare eftersom rituallerna (post-it, agenda, delresultat-ceremoni) redan är **etablerade i rummet**. Att repetera dem fyra gånger till kan kännas patroniserande för vuxna.

Förslaget har inte argumenterat varför symmetri > asymmetri pedagogiskt. Det har antagit det.

### H2: LLM-skriver generisk pedagogik? — STÄMMER, och risken är konkret

E2 (Flytande pin & pullup) och E3 (Spänningsdelare) är **exakt** den typ av text där LLM-svenska driftar mot generisk amerikansk MOOC-stil:
- **Terminologi-risker:** "pull-up resistor" vs "pullup-motstånd" vs "uppåtdragsmotstånd" — svensk radioamatör-jargong är inte enhetlig och en LLM väljer i regel den mest engelsk-influerade. SSA:s certifikatkurser använder ofta **"pull-up-motstånd"** med bindestreck. En vuxen FRO-radioamatör som ser "pullup-resistor" rakt av kommer registrera det som "amerikaniserat".
- **Vattenanalogin för spänningsdelare:** två strypventiler i serie är en svensk översättning av en engelsk pedagogisk klyscha. På svenska är det inte uppenbart om "tryck" = "spänning" eller "flöde" = "ström" — analogin är **redan på gränsen i Modul 1** och kommer kollapsa när den används rekursivt på en spänningsdelare. En LLM kommer inte fånga detta utan trial-and-error i rummet.
- **PWM "duty cycle":** svensk teknisk svenska säger oftast "pulskvot" eller bara "PWM-kvot". Att skriva "duty cycle" rakt av är OK för el-ingenjörer men en nybörjare i Ånge fattar inte direkt.
- **Modul 1:s pedagogiska guldstandard är troligen skriven av en människa (du).** Att försöka få en LLM att replikera den över 12 nya slides utan att man hör skillnaden är en kvalitetsfälla.

Var risken är störst: **E2:s text om brus och flytande pin**. Det är ett område där fel mental modell (statisk laddning vs antenneffekt vs intern impedans) lätt smyger in.

### H3: Eko-kammare i gate-verdict? — STÄMMER

Detta är förslagets svagaste punkt och förslaget medger det inte alls. Av fyra reviewers är **fyra LLM** (tre Claude Opus-instanser plus codex/GPT). Det är inte fyra oberoende perspektiv — det är **tre kopior av samma modell plus en kusin**. Specifikt:
- C5 ("asymmetrisk modul-polish") och C6 ("eyebrow oläslig") är typiska LLM-fynd: estetik-symmetri och kontrast-floors. En människa hade kanske flaggat C6 efter att faktiskt ha sett det på projektor — men inte C5. C5 är "AI ser asymmetri och blir orolig".
- C1 ("hackathonen kräver koncept som aldrig lärts ut") är i sin tur en **klassisk LLM-överlasthypotes**: vi antar att deltagarna måste *härleda* state-toggle från noll istället för att *parkoppla* en idé med instruktören live i hackathonen. Det är vad hackathon **är** — guidad upptäckt, inte ren tillämpning.
- C2 (tilt fel-klassad) är reell, men **trivialt en mening att fixa**. Det är inte en blocker i någon meningsfull bemärkelse.
- I1 ("pulldown" → "pullup") är ett riktigt fel. Bra fångst. **Den enda av de 7 blockers som en människa garanterat hade flaggat.**

Hade en mänsklig peer (säg en gymnasielärare i teknik som sett kursen köra en gång) flaggat C5 och C6? **C6 ja, C5 nej**. Människan hade sagt "du har lite spretig struktur men det märks knappt på podiet". Människan hade troligen lagt mest energi på *innehåll i talarstöd*, inte *strukturell symmetri mellan modulerna*.

**Förslagets blinda fläck:** det behandlar 4 LLM-röster som 4 oberoende observationer. Bayesianskt är det närmare **1.3 oberoende röster**.

### H4: Kursen fungerar redan? — STÄMMER

Detta är förmodligen den viktigaste poängen. Gate-verdicten själv listar 15 explicita styrkor och säger ordagrant: *"inga faktafel som skadar hårdvara, ingen direkt vilseledning, och Modul 1 är pedagogiskt exemplarisk"*. Vad är då det egentliga argumentet för att inte **leverera kursen som den är, samla in feedback från första gruppen, och iterera baserat på riktig data**?

Förslaget ger noll svar på den frågan. Det hoppar direkt från "reviewers identifierade saker" till "vi måste fixa allt innan kompendium". Mellansteget — *"är dessa fix värdefulla eller är de fantomer"* — saknas helt.

**Konkret risk om förslaget körs:** du investerar 2.5 dagar i att fixa LLM-genererade flaggor, levererar till första gruppen, och upptäcker att de **verkliga problemen** var helt andra (ström-tillgång till alla bord, någon glömde sin laptop, breadboarden var dålig kvalitet, hälften missade första passet pga jobbet, etc.). Det här är de problem som faktiskt fäller workshops i praktiken, och inget av dem syns på en slide.

### H5: Svårt att skriva elektronik-svenska? — STÄMMER

Se H2. Specifikt:
- "Flytande pin" är direktöversättning av "floating pin" och fungerar dåligt på svenska — det är inte ett etablerat svenskt begrepp. "Lös pinne", "obunden ingång", eller bara "ingång utan koppling" är mer korrekt svenska. En LLM väljer "flytande pin" i 9 fall av 10.
- "Duty cycle" har inte en pricksäker svensk översättning och olika svenska elektronik-läroböcker använder olika ("pulslängdsförhållande", "pulskvot", "tjänstecykel" — den sista är skratt-tråkig). En LLM kommer inte fatta vilken som passar FRO.
- Det finns en **god anledning** att skriva elektronik-slidesna **på svenska först av en människa** och sedan låta LLM polera, inte tvärtom.

### H6: Scope-creep dödar kompendie-målet? — STÄMMER

Tidsbudgeten är **avgörande** här och förslaget glider över den. Räknat:
- Fas 1: 0.5–1 dag
- Fas 2: 1–2 dagar
- Fas 3: live-test (kräver fysisk plats, ett halv-dags fönster)
- Fas 4: kompendium (ursprungligen "snart")

Det betyder att kompendiet börjar **dag 3–4** istället för **dag 1**. Och inom dag 3–4 är risken hög att nya gate-issues uppstår från Fas 2-tilläggen själva (10+ nya slides = 10+ nya potentiella problem).

**Mer elegant ordning:**
1. Fas 1 (mekaniska fixar, 0.5 dag) — gör det idag
2. **Skriv kompendiet** — och låt skrivprocessen fungera som **automatisk gap-detektor**. Om du inte kan förklara something i kompendiet utan att det blir krångligt → då har du faktisk evidens för att en slide saknas. Idag har du LLM-evidens.
3. Fas 2 — bara de slides som kompendie-skrivandet bevisade behövs
4. Fas 3 — live-test

Detta är **inverterad scope** och löser scope-creep-problemet av sig självt.

### H7: E2 är överkill? — STÄMMER

Förslagets formulering: *"FRO-publiken sannolikt har radioamatörer som vill förstå elektroniskt varför, inte bara vad."* Detta är ett **icke-belagt antagande**. En radioamatör som kan sin Ohms lag behöver inte 5 minuter på en flytande-pin-slide — hen fattar det av en mening. En nybörjare som inte vet vad en resistor är behöver inte 5 minuter på flytande pin — hen behöver veta att INPUT_PULLUP är trolleriet som gör det krångliga onödigt.

Den ärligare versionen av E2 är **två meningar i talarstöd + en pil-bild på slidesidan**. Inte en hel slide.

Pedagogisk ekonomi: varje slide kostar uppmärksamhet. E2 betalar inte tillbaka för en blandad publik.

### H8: Tilt-omflyttning onödig? — STÄMMER

Tre reviewers flaggade samma sak vilket låter som hög signal — men det är **samma typ av reviewer som flaggar samma typ av sak**. Den ärliga fix:en är **en (1) mening** i talarstöd: *"Tilt-sensorn är digital trots att den är en sensor — inte alla sensorer är analoga, och det är poängen idag: vi lär oss att läsa fakta om en komponent innan vi antar."*

Det är till och med en **bättre** pedagogisk poäng än att rama om eller flytta. Att flytta sensorn är **defensiv design för kritik som inte kommer materialiseras i rummet**.

### H9: Projektor-test först? — STÄMMER, kraftigt

Detta är förslagets **enda** verkliga blinda fläck och samtidigt det mest värdefulla single move i hela planen. Nuvarande Fas 3 ("kör på projektor") är listad **efter** all design-fix-arbete. Det är fel ordning.

Korrekt ordning:
1. **Idag:** ta laptopen + projektorn till FRO-lokalen, kör hela decket en gång, fota varje slide där du inte kan läsa något från bakre raden.
2. **Foton = source of truth** för C6, C7, I3 — inte LLM-spekulation om kontrastvärden.
3. Resten av fixarna prioriteras enligt vad fotona faktiskt visar.

Varför: tre av sju "kritiska blockers" är **rena läsbarhetsclaim** (C6, C7, och delvis C5 via "pedagogisk upplevelse"). Alla tre kan **falsifieras eller bekräftas på 30 minuter** med ett projektortest. Att hoppa över det och bygga en 2-dagars fix-plan är den största avkastnings-möjligheten i hela ärendet.

## Det som inte kommer sägas av mainstream-reviewers

1. **De flesta av kursens framgång eller misslyckande beror på saker som inte är på sliderna.** Strömuttag, breadboard-kvalitet, USB-kablar (Elegoo-kit har notoriskt sköra), om deltagarna har laptop med admin-rättigheter för Arduino IDE, om en deltagare blockerar en hel rad. **Inget av detta står på en gate-flagga.** Tid spenderad på slide-polish är tid inte spenderad på dessa.

2. **Vuxna nybörjare hatar för mycket scaffolding.** "Agenda → teori → komponenter → bygg → wiring → kod-anatomi → kod-detalj → fri övning → delresultat → teaser" är en pedagogisk mall för **tonåringar i klassrum**. Vuxna i en frivilligorganisation vill ha *mindre* ceremoni, *mer* göra-saker. C5:s "replikera Modul 1:s mönster" kan vara aktivt skadligt.

3. **Kompendiet är troligen viktigare än sliderna för långsiktigt värde.** Sliderna lever 5×2h. Kompendiet lever på hyllan i åratal och refereras när någon glömt något. Att försena kompendiet för slide-polish är att optimera för engångs-händelse istället för bestående artefakt.

4. **C1 ("hackathonen kräver koncept som aldrig lärts ut") är möjligen önskvärt.** Hackathon **ska** kräva sammansättning av delar man inte sett ihop förut. Det är skillnaden mellan en övning och en hackathon. Att lära ut state-toggle som en egen slide tar bort just det som gör Modul 5 till en hackathon. Den ärligare fixen: gör Modul 5:s `loop()` mer utbyggd som **fallback** för dem som fastnar, inte som default — och låt de snabba deltagarna upptäcka state-toggle själva med instruktörsstöd.

5. **Fyra LLM-reviewers + noll människor är ett process-fel, inte bara ett missat datapoäng.** Hela planeringspipen är just nu en sluten LLM-loop. Det fixas inte med ännu en LLM-djupdykning (som denna). Det fixas med **att fråga en levande FRO-instruktör eller motsvarande** att titta 30 minuter på decket.

## Alternativa planer som förslaget inte övervägde

### Alt A: "Leverera först, iterera baserat på data" (radikalt)
1. Idag: Fas 1 mekaniska fixar (4 timmar, inkluderar I1 pullup, eyebrow-storlek, RGB-referens)
2. Imorgon: kompendie-utkast i 1-dags-version (skelett + Modul 1-Modul 5 grundtext, ej polerad)
3. Vecka 1 av kursen: kör Modul 1 live, observera vad som faktiskt går fel
4. Mellan vecka 1 och 2: iterera **bara på det som verkligen brast**
5. Slide-fördjupning (Fas 2 i förslaget) sker först **efter kursen** baserat på riktig data
**Bästa fall:** kompendiet är klart nästa vecka, kursen levererar, du har riktig data inom 7 dagar.
**Värsta fall:** några slides är suboptimala under första rundan men deltagarna märker knappt.

### Alt B: "Kompendiet som gap-detektor" (medelradikalt)
1. Idag: Fas 1 mekaniska fixar
2. Imorgon-i övermorgon: skriv kompendiet i sin helhet
3. När en sektion i kompendiet känns krånglig att skriva — DÅ vet du att en slide saknas. Lägg den till.
4. Live-test i FRO-lokalen med projektor sist
**Vinst:** slide-tillägg drivs av faktisk pedagogisk friktion, inte LLM-flaggor. Färre slides, högre signal.

### Alt C: "Mänsklig review innan mer LLM-arbete" (försiktigt)
1. Idag: Fas 1 mekaniska fixar
2. Imorgon: be **en (1) mänsklig peer** (annan FRO-instruktör, en lärare, en tekniker) köra igenom decket på 1 timme
3. Jämför mänsklig review mot LLM-reviewers. Räkna överlappet.
4. Bara fix de issues där människan **också** flaggade, plus de få LLM-fynd som är objektivt fakta-fel (I1 pullup).
5. Skriv kompendiet
**Vinst:** kalibrerar din LLM-pipeline. Om mänsklig review ger 70% överlapp → fortsätt lita på LLM. Om <30% → all LLM-review är brus och bör avmonteras.

## Slutsats

Förslaget är inte fel — det är **för tidigt**. Specifikt:

**Behåll från förslaget:**
- Fas 1 i sin helhet (alla mekaniska fixar, särskilt I1 pullup som är en faktiskt bugg)
- E1 (breadboard-anatomi) är en ärlig vinst — låg risk, hög pedagogisk avkastning
- E4 (PWM/duty cycle) på slide är legitim eftersom Modul 2 idag saknar en kod-slide över huvud taget — det är ett objektivt hål

**Skjut upp eller skrota:**
- E2 (flytande pin) — gör om till två meningar i talarstöd, ingen egen slide
- E3 (spänningsdelare) — vänta tills kompendiet är skrivet och se om analogin håller på papper först
- E5 (säkerhet) — talarstöd räcker
- "Replikera Modul 1:s skelett över Modul 2–4" (C5-fixen) — **stoppa och be om mänsklig validering innan**
- Tilt-omflyttning — fixa med en mening, inget mer
- Modul 5 utbyggd skelett-kod — låt hackathonen vara en hackathon, ha fallback i talarstöd

**Lägg till som icke-förhandlingsbar förstaprioritet (ingenstans i förslaget):**
- **Idag innan något annat: kör decket på riktig projektor i FRO-lokalen, fota allt som inte syns från bakre raden.** Detta omdefinierar Fas 1.
- **Inverterad ordning:** Fas 1 → kompendie-utkast → Fas 2 (drivet av kompendie-friktion) → live-test
- **En (1) mänsklig review innan ytterligare LLM-arbete.** Kalibrera pipelinen.

Verdict: **APPROVE_WITH_CHANGES**, men ändringarna är substantiella nog att de bör behandlas som en **förslag-revision**, inte en signoff. Huvudsessionen bör skriva om Fas-strukturen med projektor-test som steg 0 och kompendiet som steg 2, och tona ner den strukturella symmetri-ambitionen tills det finns mänskliga ögon på materialet.

Det viktigaste tar jag igen: **fyra LLM-reviewers är inte fyra reviewers.** Bygg inte 2.5 dagars arbete på det datat utan att kalibrera mot minst en människa eller ett projektortest först.
