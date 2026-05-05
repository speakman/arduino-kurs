# Pedagogisk utvärdering: "Lååångt motstånd + potentiometer-demo" som brygga till spänningsdelaren

Kontext: 5-träffars Arduino-nybörjarkurs, vuxennybörjare, blandad bakgrund. Modul 4 går live om några timmar. Föreliggande arkitektur använder vatten-metaforen i två lager: Modul 1 etablerar resistor = "strypventil" + ström = vatten + spänning = tryck. Modul 4 slide 41 utvidgar till "vattenrör som höjdskala" med två segment och en tapp där A0 mäter.

## 1. Starkare, svagare eller ekvivalent?

**Komplementär — inte starkare, inte svagare.** Befintlig metafor och "lååångt motstånd" angriper olika kognitiva flaskhalsar.

Vatten-höjdskala-modellen är *funktionell*: den förklarar VAD som händer vid mätpunkten och HUR förhållandet R1/R2 bestämmer A0. Men den lämnar en fråga obesvarad som många nybörjare faktiskt har: *Varför* sjunker spänningen vid skarven? Varför "äter" en resistor spänning? "Tappen pressas ner" är beskrivning, inte mekanism.

"Lååångt motstånd" angriper exakt detta gap. Det säger: spänningen sjunker *gradvis och linjärt* från +5 V till 0 V över resistivt material. Två resistorer är bara två segment av samma kontinuum — skarven mellan dem är bokstavligen platsen där den linjärt fallande spänningen råkar befinna sig efter R1. Det förvandlar "delningen" från en svart-låd-regel till något geometriskt synligt.

Netto-tillskott: ett mekanism-lager *under* tappen-modellen. För studenter som accepterar "skarven flyttar sig" utan friktion tillför det inget. För dem som tyst undrar "varför fungerar det så?" tillför det allt. Eftersom den senare gruppen sällan flaggar sig själv är netto-värdet positivt på populationsnivå.

Risk: två konkurrerande visuella modeller på samma sida (rörsegment + linjärt fall) kan kollidera. Det måste vara introducerande, inte parallellt.

## 2. Var bryts metaforen?

Tre allvarliga brott:

**(a) Längd ≠ resistans.** En kort tjock kolfilms-resistor och en lång tunn har samma 220 Ω. Studenter som internaliserar "längden bestämmer fallet" får problem när de senare ser fysiska resistorer av varierande storlek med samma värde, eller två 1 kΩ-resistorer där den ena är fysiskt mindre. Lösning: säg explicit *resistivt material per ohm är konstant*, inte per centimeter. Använd "andel av total resistans" som styrande språk.

**(b) Strömberoende.** Spänningen sjunker linjärt över material *när det går ström*. Tas lasten bort (öppen krets) finns inget linjärt fall. Detta krockar med Modul 4 där A0 har extremt hög ingångsimpedans — strömmen genom delaren är typiskt mikroampere. Sant ändå för 1 kΩ + fotocell, men metaforen suggererar oberoende av last. Inte kritiskt på Modul 4, men kommer skava i Modul 5 om reläer/buzzer dras direkt från delaren.

**(c) "Mätpunkt på en kontinuerlig skala" → man kan mäta var som helst.** Detta är faktiskt sant för en pot men *falskt* för en två-resistor-delare där mätpunkten är fysiskt fixerad vid skarven. Studenter som tar metaforen för bokstavligt kan fråga "kan jag flytta A0 längs resistorn?" — svaret är nej för fast resistor, ja för pot. Det är just därför pot-demon är kraftfull pedagogiskt, men också där förvirring kan uppstå om brytpunkten inte adresseras.

## 3. Vad tillför pot-demon konkret?

Pot-demon är **den enda demonstrationen i hela kursen där studenten ser den kontinuerliga spänningsskalan i realtid**. Allt annat är diskreta tillstånd (HIGH/LOW, on/off, mörker/ljus). När läraren vrider ratten och Serial Monitor sveper 0 → 256 → 512 → 1023 jämnt, blir abstraktionen "10-bits linjal över 0–5 V" konkret på ett sätt som ingen statisk slide klarar.

The moment of insight: när läraren stannar ratten halvvägs och säger "här är A0 på exakt 2,5 V — och det är samma fysik som händer i din fotocell-koppling, fast där är det ljuset som vrider på ratten åt dig." Det broar potentiometer (deterministisk, lärar-styrd) → fotocell (sensor-styrd, samma princip). Den brygga är pedagogiskt guld eftersom studenten just har sett pot-skalan med egna ögon och får fotocellen "gratis" som specialfall.

Distraktionsrisk: om pot introduceras som ny komponent med eget pin-out, breadboard-koppling och kod, förlorar man poängen i wiring-overhead. Måste vara **lärar-pre-kopplad demo**, inte studentövning. Ratten + Serial Monitor projicerad. Inga handouts om pot. Hinner inte.

Värt komplexiteten? **Ja om disciplinerat — nej om det blir en mini-modul.** En 90-sekunders demo med förberedd hårdvara: hög vinst, låg kostnad. Om det börjar dras ut till "och nu kan vi också använda pot för att..." är det en distraktion.

## 4. Bästa insättnings-punkt

**(c) Inuti slide 41 som intro-frame, med pot-demo som muntlig komponent.** Motivering:

- (a) Modul 1: för tidigt. Ohms lag är gränsen för vad som ryms i öppningskvällen. Att lägga in en spatial-fall-modell innan studenten ens har sett en resistor i en blinkande LED bygger kognitiv skuld.
- (b) Mellan 39 och 41: tappar momentum. Slide 39 etablerar analogRead, slide 41 introducerar delaren. En ny mellan-slide är en kontextväxling som inte ger värde — pedagogiken behöver vara *del av* delar-introduktionen, inte föregå den.
- (c) Inuti 41: rätt nivå. En `<v-click>` som öppnar med "tänk dig först ett enda lååångt motstånd ..." och sedan fäller in den befintliga rörsegment-bilden som "samma sak, bara delat". Pot-demon kommer som muntligt avslut: "och detta är vad vridpotentiometern i kittet är — vi använder den inte i kursen, men låt mig visa principen." 60–90 sekunder.
- (d) Bilaga F bara: missar den verbala/visuella demon. Bilagan är referens, inte möte.
- (e) Demo only: lämnar ingen artefakt för efter-läsning. Slide-anteckning + minimal slide-text + demo är bättre.

## 5. Idag-live-frågan

**Idag är fel session att fälla in den fulla versionen.** Skäl:

1. Otestat material i live-pass = varianter av brott i punkt 2 som lärare måste improvisera kring.
2. Pot-demon kräver att hårdvaran är pre-kopplad och Serial Monitor är projicerad. Det är ett extra moment att förbereda samma morgon som passet körs.
3. Slide 41 är redan informationsrik (höjdskala + tre regler + fotocell-mappning + bild). Att skohorna in en intro-frame som ingen testat klassrumsförsökt med = risk för att passet drar över.
4. CLAUDE.md säger "stop and re-plan" — det här förslaget förtjänar en design-iteration, inte en panik-implementation.

**Minsta lyft med maximal vinst för dagens pass:** två sub-bullets till slide 41:s vänsterspalt under "vattenrör som höjdskala"-stycket: en kort mening om att "spänningen sjunker linjärt genom resistivt material — två motstånd är bara samma kontinuum delat i två" + en presenter-note som påminner läraren att verbalt nämna pot:en *om tid finns* utan att kräva att den är kopplad. Noll bildrisk, noll wiring-risk, lägger till mekanism-lagret. 10 minuter att skriva, 0 minuter att verifiera visuellt.

Den fulla versionen (egen intro-frame + pot-demo + Bilaga F-utvidgning) hör hemma efter dagens pass, med klassrumsfeedback i loopen.

## 6. Den djärva frågan: behövs det alls?

**Ärligt: nej, slide 41 klarar jobbet för majoriteten.** Befintlig metafor är välbeprövad, har inre logik (tre regler täcker alla fall: lika, mer ovan, mer under), och kompletteras av Bilaga F:s formella härledning för dem som vill djupdyka. Studenter som klarar fotocell-laben utan att fråga "men varför sjunker spänningen?" är inte underbetjänade — de har en funktionell modell.

Argumentet *för* tillägget vilar på en hypotes: att en mätbar minoritet kommer ha ett tyst "varför?" som blockerar internalisering, och att den minoriteten inte själv flaggar det. Den hypotesen är rimlig men oprövad i denna specifika kohort. Det finns en risk att man designar för en studentprofil som kanske inte sitter i rummet.

Empirisk strategi: kör Modul 4 som det är *idag*, lyssna aktivt efter "varför?"-frågor under labbpasset, och låt observerade missförstånd driva nästa iterations design. Det är billigare och mer evidensbaserat än att gissa fram en pedagogisk förbättring innan man sett friktionen.

---

**RECOMMENDATION:** Lägg ingen ny slide idag — fäll in en mening om "linjärt fall genom resistivt material" i slide 41:s vänsterspalt + en presenter-note om pot:en, observera Modul 4 live, och fatta beslut om full intro-frame + pot-demo *efter* passet baserat på faktiska studentfrågor.
