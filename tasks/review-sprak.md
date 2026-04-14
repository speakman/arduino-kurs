# Språkgranskning — 2026-04-14

Granskare: native svensk teknisk redaktör. Källor: `kompendium/*.typ` + `presentation/slides.md`.

Övergripande omdöme: Texten håller mycket hög kvalitet. Tonen "sträng men kärleksfull" sitter genomgående, idiomet är i 95 % av fallen som en svensk elektroniklärare faktiskt skulle prata, och tekniska termer hanteras klokt. De tunga problemen är **Du/Ni-blandning** (systematisk, inte slarv) och en handfull små grammatik-/typografi-detaljer.

---

## 🚨 Grammatiska/stav-fel (hårda fel)

| Fil:rad | Fel | Fix |
|---|---|---|
| `01-modul-1.typ:129` | `2,2 kΩ (10× för hög)` — `kΩ` ska ha hårt mellanslag, men felet är att `2,2 kΩ` är **10×** så hög som 220 Ω, det stämmer (220 → 2200). OK egentligen, men formuleringen "10× för hög" är slarvig — det är tio gånger för stor, inte "för hög". | "tio gånger för stor" |
| `03-modul-3.typ:76` | "internt till Arduinon" står som "*internet* till Arduinon" | "internt i Arduinon" (eller "inbyggt i Arduinon") |
| `03-modul-3.typ:128` | "Knappens metallbladen studsar" — dubbel bestämdhet | "Knappens metallblad studsar" |
| `03-modul-3.typ:203` | Samma fel: "Knappens metallbladen studsar" | "Knappens metallblad studsar" |
| `04-modul-4.typ:188` | `+5V` saknar mellanslag (annars 5 V genomgående) | `+5 V` |
| `05-modul-5.typ:173` | "blinka buzzerN" — felaktig versal mitt i ord | "blinka buzzern" |
| `05-modul-5.typ:194` | "med mer billigare komponenter" — dubbelkomparativ | "med billigare komponenter" |
| `05-modul-5.typ:39` | "i samma ordlista" — oklar metafor; menar troligen "ordförråd" | "med samma ordförråd" |
| `appendix-a-syntax.typ:74` | "på historiska skäl" är anglicism (*for historical reasons*) | "av historiska skäl" |
| `appendix-b-felmeddelanden.typ:64` | "borde högljus den motsvarande" — verbfel, ska vara "highlighta/markera". "Högljus" finns inte. | "ska markera den motsvarande" |
| `appendix-c-komponenter.typ:33` | "bege ligger i fel hål" — stavfel, ska vara "benet" | "benet ligger i fel hål" |
| `appendix-d-hackathon-losning.typ:142` | "Arduinon inte brinner oss-CPU:n" — "oss" är troligen en överbliven dikteringsfel/typo | "inte bränner CPU:n i onödan" |
| `appendix-e-sakerhet.typ:44` | "med en tjock tunnare en bränd spårledning" — meningen havererar mitt i | omformulera: "med en tjock kabel kan du få en bränd spårledning på breadboarden" |
| `appendix-e-sakerhet.typ:59` | "högljuddare" — fel komparativform | "högre" eller "mer högljudd" |
| `appendix-e-sakerhet.typ:65` | "Torrt vinterluft" — kongruens (vinterluft är n-genus → torr) | "Torr vinterluft" |
| `appendix-f-framspanningsfall.typ:24` | "latiniska uttryck" — adjektivet är *latinska* | "latinska uttryck" |
| `appendix-f-framspanningsfall.typ:154` | "mitt i mjuka delen" — sär-/bestämdhetsfel; menar "mitt i den mjuka delen" eller idiomet "mitt i prick" | "ligger mitt i prick" |
| `slides.md:1212` | `mix-blend-mode: screen;` på `<img>` är CSS — inte språk. OK. | — |
| `slides.md:519` | "trycket (5V) hamna över turbinen" — `5V` utan mellanslag. Inkonsistens mot resten av deck:et som har `5 V`. | `5 V` |
| `slides.md:617` | "(220Ω, 330Ω, 1kΩ, 10kΩ)" — saknade mellanslag före enhet | `220 Ω, 330 Ω, 1 kΩ, 10 kΩ` |
| `slides.md:1288` | "220Ω seriemotstånd" | `220 Ω-seriemotstånd` |
| `slides.md:1707` | `pinMode(knappPin, INPUT_PULLUP)` (talar-not, OK) men `tilta` används som verb i not 2327 | bättre: "när du lutar den" (slides.md:2325 har denna form, så bara 2327 sticker ut) |
| `slides.md:2467` | "lutta tilten" — `lutta` är inte svenska | "luta tilt-sensorn" |
| `slides.md:1734` | "blinkar mellan av/på som en stroboskop" — *stroboskop* är ett n-ord (ett stroboskop). Bör vara "som ett stroboskop". | "som ett stroboskop" |

---

## ⚠️ Du/Ni-inkonsistens (största kategori)

**Mönstret:** Rubriken är *"Vad **du** lärde dig idag"* (singular), men brödtexten halkar omedelbart över i *"Ni byggde / Ni kopplade / era program"* (plural). Detta upprepas i varenda modul. Effekten är att texten känns som om den växlar mellan att tala till en enskild läsare hemma vid köksbordet och att tala till klassen som grupp i salen — vilket är förvirrande för en person som läser kompendiet ensam efter kursen.

**Rekommendation:** Bestäm en regel och håll den. Kompendiet är en text **läsaren öppnar ensam efter en träff**. Då ska *allt* vara `du`-form. Slidesen (där läraren talar till hela gruppen) får vara `ni`. Detta är också vad rubrikerna lovar.

| Fil:rad | Kontext | Rekommendation |
|---|---|---|
| `01-modul-1.typ:13` vs `:23` | "Vad **du** lärde dig idag" → "**Ni** kopplade blink-kretsen" | byt till "Du kopplade blink-kretsen ... laddade upp ... och ändrade sedan koden" |
| `02-modul-2.typ:10` | Undertitel: "...en pixel som **ni** programmerar själva" | "som du programmerar själv" |
| `02-modul-2.typ:13` "Vad **du** lärde dig" → `:22` "skärmen **ni** sitter framför" / "Alla färger **ni** ser" / `:25` "**Ni** kopplade RGB-LED:en ... experimenterade" / `:99` "Samma koppling som **ni** byggde" | hela modulen | konsekvent `du` |
| `03-modul-3.typ:13` "**du** lärde dig" → `:15` "**era** program ... fick programmen läsa av" / `:25` "**Ni** byggde två kretsar" / `:38` "I Modul 1 mötte **ni**" / `:48` "Datatyper **ni** sett" / `:67` "Varje gång **ni** läser koden" / `:76` "kommer **ni** bygga" | hela modulen | konsekvent `du` |
| `04-modul-4.typ:13` "**du** lärde dig" → `:25` "**Ni** byggde spänningsdelaren" / `:90` "vilka värden **ni** ser" / **`:114` "kommunicera tillbaka till er. Fram till nu har ni varit envägs..."** / `:215` "alla fyra moduler" | hela modulen | konsekvent `du` |
| `05-modul-5.typ:19` "Vad **du** gjorde i dag" → hela texten i `ni`-form (`:21, :23, :39, :57, :108, :168, :194, :196, :200, :201, :203`) | hela modulen | konsekvent `du`. Notera att Modul 5:s "Efter kursen"-text på `:194–:203` är **särskilt iögonfallande** — den läses ensam efter kursen, men säger "ni". |
| `appendix-a-syntax.typ:17, :60, :74, :291` | bilagan i övrigt `du`-form, men dessa fyra ställen "ni" | byt till `du` |
| `appendix-c-komponenter.typ:10, :206` | "**ni** kopplat", "Det **ni** inte använder" | "du kopplat", "Det du inte använder" |
| `appendix-f-framspanningsfall.typ:15, :17, :141, :154, :174, :228, :254` | systematisk `ni`-form i en bilaga som annars börjar i `du`-form (`:18` "kunna *du* räkna ut...") | hela bilagan ska vara `du` |
| `main.typ:88, :90, :94` | Förordet växlar **inom samma stycke**: "det **ni** gick igenom i klassrummet när det där ordet **du** behövde försvann igen". Värsta fallet i hela kompendiet. | välj `du`. "Ni är radioamatörer" på `:94` är OK eftersom det adresserar gruppen som identitet — men då bör meningen typografiskt brytas ut tydligare. |

**Slidesen** är generellt OK med `ni` (det är klassrumstal), men kontrollera att kompendiet och slides inte oavsiktligt korsar varandras konventioner i citerade kodbitar/captions.

---

## 💬 Klumpiga eller onaturliga fraser

| Fil:rad | Original | Förslag |
|---|---|---|
| `01-modul-1.typ:15` | "Den första träffen handlade om att få något — vad som helst — att hända." | OK — bra! Inget att fixa. (Lägger den här som referens för tonen som *funkar*.) |
| `02-modul-2.typ:20` | "Tekniken heter *PWM*, Pulse Width Modulation." | Smidigare: "Tekniken heter *PWM* — pulsbreddsmodulering (Pulse Width Modulation)". Du har en ham-radio-publik som tål svensk översättning. |
| `02-modul-2.typ:37` | "Ditt första möte med en komponent som INTE tål att kopplas baklänges utan att krångla." | Kapitaliserat "INTE" känns skrik-aktigt och bryter tonen. Föreslår: "Ditt första möte med en komponent som *inte* tål att kopplas baklänges utan vidare." |
| `03-modul-3.typ:25` | "den läser något från omvärlden, bestämmer sig för något, och agerar därefter" | "den läser av omvärlden, fattar ett beslut, och agerar". Mer levande svenska. |
| `04-modul-4.typ:114` | "Fram till nu har ni varit envägs-kommunicerande" | Klumpig hopslagning. "Fram till nu har kommunikationen gått åt ett håll" |
| `04-modul-4.typ:142` | "Arduinon är inte mystisk — den är bara tyst. Gör den pratig." | Bra! Behåll. |
| `05-modul-5.typ:39` | "Grattis — ni kan nu beskriva grunderna för allt från disktermometrar till enkla RC-bilar i samma ordlista." | "...med samma grundbegrepp" eller "...på samma språk". |
| `05-modul-5.typ:194` | "i mindre skala och med mer billigare komponenter" | "i mindre skala och med billigare komponenter" |
| `appendix-a-syntax.typ:15` | "Felar du mot dem vägrar kompilatorn att översätta din text till något Arduinon kan köra." | Bra mening — behåll. |
| `appendix-b-felmeddelanden.typ:15` | "som skrivit miljoner rader kod och accepterat att felmeddelanden ibland ser akademiska ut" | Litet ordfel: "ser ut som akademisk text" eller "är skrivna i akademisk ton" — *ser akademiska ut* haltar. |
| `appendix-d-hackathon-losning.typ:142` | "Gör att Arduinon inte brinner oss-CPU:n för inget." | Helt obegripligt. Föreslår: "Hindrar Arduinon från att bränna CPU-tid i onödan." |
| `appendix-d-hackathon-losning.typ:222` | "Och om något här känns onödigt komplicerat — *skit i det*." | Bra. Behåll — perfekt "sträng men kärleksfull"-ton. |
| `appendix-e-sakerhet.typ:44` | "en tjock tunnare en bränd spårledning" | Helt brutet. "med en tjockare kabel kan en spårledning på breadboarden brännas". |
| `appendix-e-sakerhet.typ:88` | "(nej, bara skämt — torka upp det)" | Skämt landar inte riktigt — *droppa vatten på breadboardet* är en sak du **inte** ska göra. Föreslår: ta bort hela skämtet, eller ändra till "(nej, gör inte det)". |
| `appendix-f-framspanningsfall.typ:15` | "är en repetition på ert modersmål" | Bra mening, men "ert" är `ni`-form. Byt till `ditt`. |
| `appendix-f-framspanningsfall.typ:24` | "Allt med svenska ord, inga latiniska uttryck som jag inte vill förklara." | "...inga latinska uttryck som inte förklaras." |
| `slides.md:1734` | "som en stroboskop" | "som ett stroboskop" |
| `slides.md:1818` | "kommer era öron att blöda och jag kastar ut er" | Skämt — funkar i klassrum, men på print kan det läsas hårt. Behåll i talar-noter, OK på slide eftersom det presenteras muntligt. Ingen ändring. |
| `slides.md:2467` | "lutta tilten" | "luta tilt-sensorn" |

---

## 📐 Typografi-detaljer

| Fil:rad | Issue | Fix |
|---|---|---|
| **Tusentalsavgränsare** | Hela kompendiet använder konsekvent svensk decimalkomma (`3,3 V`, `13,6 mA`, `0,015 A`). Bra. Inga `3.3 V`-fel hittade. | — |
| **Mellanslag före enhet** | Genomgående bra (`5 V`, `220 Ω`, `15 mA`). Undantag: | se nedan |
| `slides.md:519` | `5V` utan mellanslag i talar-not | `5 V` |
| `slides.md:617, 1288` | `220Ω`, `330Ω`, `1kΩ`, `10kΩ` i talar-noter | mellanslag före enhet |
| `slides.md:401, 410, 446, 463–467, 1316, 1331, 2092, 2117, 2293` | Många `5V`, `4.88 mV`, `13.6 mA` i slides — engelsk decimalpunkt och saknat mellanslag | använd `5 V`, `4,88 mV`, `13,6 mA` |
| `04-modul-4.typ:188` | `+5V` | `+5 V` |
| `appendix-c-komponenter.typ:153` | `5V → fotocell` | `5 V → fotocell` |
| `05-modul-5.typ:181` | `5V → fotocell → A0 → 1 kΩ → GND` (i snabbref) | `5 V → fotocell → A0 → 1 kΩ → GND` |
| **Tankestreck vs bindestreck** | Kompendiet använder konsekvent `—` (em-streck) för parenteser och `–` (en-streck) för intervall (`50 kΩ`, `0–1023`). Korrekt svensk standard. | — |
| **Minustecken** | `−` (riktig minus, U+2212) används korrekt i `−32768`, `5 V − 2 V`. Bra. | — |
| `appendix-a-syntax.typ:39` | `−32768 till 32767` — bra | — |
| `slides.md:441, 463` | `(5 V − 2 V) / 15 mA` — bra | — |
| **Snedstreck** | `slash`-formler i Typst använder `slash`-keyword. OK matematiskt, men `$U slash R$` ser ut som `U/R` i print. Korrekt. | — |
| **Citationstecken** | Texten använder raka `"..."` istället för svenska `»...»` eller `"..."`. Inkonsekvent men inte fel — ingen rättning krävs om det är medvetet val. Notera dock: blanda inte med `'...'`. Hittade inga blandningar. | — |
| **`3,5 V` vs `3.5 V`** | Inga `3.5 V`-fel. Bra. | — |
| `slides.md:464, 466` | `0.015 A`, `13.6 mA` — engelsk decimalpunkt | `0,015 A`, `13,6 mA` |
| **Bindestreck i sammansättningar** | "embedded-system", "edge-detection", "pull-up-resistor" — bra konsekvent svensk-engelsk hybrid. Inga felaktiga särskrivningar hittade. | — |

---

## 🔧 Terminologi-konsekvens

Bra konsekventa val genomgående:
- **kit / kitt**: kompendiet använder `kittet` (försvenskat). Konsekvent. OK för svensk publik.
- **sketch**: behållet engelska. Konsekvent. OK.
- **pull-up / pullup**: blandat (`pullup-resistor`, `pull-up-resistor`, `INPUT_PULLUP`). **Välj en form.** Föreslår `pullup` (utan bindestreck) som matchar Arduino-konstanten.
  - `03-modul-3.typ:20` "intern pullup-resistor"
  - `03-modul-3.typ:63` "*pullup-resistor*"
  - `03-modul-3.typ:76` "pull-up-resistor" ← inkonsekvent
  - `appendix-a-syntax.typ:295` etc.
- **breadboard / breadboarden**: alltid engelska. Konsekvent. OK.
- **PWM / pulsbreddsmodulering**: nästan alltid `PWM`. Bra. En enstaka översättning på `02-modul-2.typ:20` skulle göra det helt klart för en nybörjare.
- **resistor / motstånd**: blandat men medvetet (`resistor` för komponenten, `motstånd` för värdet/begreppet). Detta är **korrekt svensk konvention**. Behåll.
- **spänning / volt**: konsekvent svenska. Bra.
- **IDE:n / Arduino-IDE:n / IDE:ns**: blandning i kompendiet och slides. Inget fel — alla varianter är OK svenska — men man kunde landa på `IDE:n` genomgående. Inte kritiskt.
- **edge-detection**: behållet engelska konsekvent. Bra val (svenska "flankdetektering" är klumpigare).
- **debounce**: behållet engelska. Bra.

---

## ✅ Strengths

- **Tonen sitter.** "Sträng men kärleksfull" är genomgående träffsäker. Meningar som "Arduinon är inte mystisk — den är bara tyst. Gör den pratig" (`04-modul-4.typ:142`) och "Och om något här känns onödigt komplicerat — *skit i det*" (`appendix-d:222`) är exakt rätt nivå för en vuxen radioamatör.
- **Tekniska metaforer landar.** Vattenanalogin, "strypventil", "Arduinons sinnesorgan", "tre tuber målarfärg" — alla är levande och tekniskt korrekta utan att vara barnsliga.
- **Bilaga F är inte akademisk** trots längden. Den lyckas hålla samma röst som modulkapitlen genom hela utredningen av framspänningsfall. Det är svårt och välgjort.
- **Konsekventa enhetsformat** (decimalkomma, mellanslag före enhet) i kompendiet. Slidesen släpar efter där.
- **Lagom humor utan att forcera.** "Klisterlappen stannar på" upprepas tre gånger i tre olika tonlägen. Funkar.
- **Felmeddelande-bilagan** översätter kompilator-jargong till mänsklig svenska utan att förlora tekniskt djup. Mönsterexempel.
- **Snabbreferenstabellerna** är skrivna i samma röst som brödtexten — inga torra "se manual" här.

---

## Sammanfattning av åtgärdsprioritet

1. **(Mest impact)** Sweep alla `.typ`-filer för Du/Ni och bestäm: kompendium = `du`, slides = `ni`. Detta är inte slarvfix, det kräver ett medvetet val per textstycke. Räkna med ~40 ändringar i kompendiet.
2. **(Hårda fel)** Fixa de 18 grammar/stav-felen i tabellen ovan — många är typos från diktering eller copy-paste, ingen är konceptuell.
3. **(Konsekvens)** Slides.md: kör `5V → 5 V`, `220Ω → 220 Ω`, `0.015 A → 0,015 A` på alla siffror i talar-noter och slide-text. Sökersätt-jobb.
4. **(Liten)** Bestäm `pullup` vs `pull-up` och kör konsekvent.
5. **(Liten)** Skämtet om vatten på breadboarden i `appendix-e:88` — antingen ta bort eller fixa.

Inga större ton-problem, inga akademiska glidningar i Bilaga F, ingen barnslighet, ingen arrogans. Det här är välskrivet material från någon som faktiskt kan både svenska och Arduino. Felen är detaljarbete, inte omskrivning.
