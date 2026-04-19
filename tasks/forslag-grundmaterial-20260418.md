# Förslag på förfiningar i grundmaterialet

**Författare:** Opus 4.7
**Datum:** 2026-04-18
**Scope:** Hela kursen (modul 1–5 + appendix A/E), med särskilt fokus på dag 1 eftersom den är kört en gång.
**Läsning som ligger bakom:** modul 1–5 kompendium i sin helhet, dag 1-slides (section "LED & krets" till "Nästa gång..."), appendix A och E, design.md.
**Tidigare reviews:** det finns en bunt från 2026-04-14 — detta är NYA observationer ovanpå dem.

---

## TL;DR — topp 8 prioriterade

1. **Dag 1 tidsbudget saknar explicit paus** — agenda-sliden visar 00:00–02:00 utan pauskryss, men talarnoten säger "runt 01:00". Fix: gör pausen synlig på agenda-sliden.
2. **Övning 3 (morse-initialer) är betydligt svårare än övning 1–2** — trappan är 1 (enkel) → 2 (medium) → 3 (STOR jump). Lägg en mellan-övning.
3. **Modul 4: "Varför just 1 kΩ under fotocellen?" saknas** — viktigaste designbeslutet i modulens viktigaste krets nämns bara implicit.
4. **LED_BUILTIN dyker upp i snabbreferens utan att förklaras i brödtexten** — nybörjare som läser linjärt blir förbryllad.
5. **Modul 5 visar den färdiga lösningen i ett block — inte den inkrementella byggprocessen** som kompendiet själv rekommenderar.
6. **Ohms lag: "15 mA"-siffran kommer utan motivering** i modul 1. En halv mening räcker.
7. **Inkonsekvent du/ni** — förord använder "du", brödtext använder "ni kopplade". Välj en.
8. **Appendix-hänvisningar är ojämna** — ibland "Bilaga A", ibland "Appendix A", ibland "slidesen". Hitta en form.

---

## Del 1 — Dag 1 (modul 1) · djup-granskning

### 1.1 Tidsbudgeten är tajt och saknar explicit paus

Slide "Idag — två timmar" visar:

| Block | Tid | Uppgift |
|---|---|---|
| 00:00–00:15 | 15 min | Slutmål & Arduinon |
| 00:15–00:35 | 20 min | Krets, spänning, ström |
| 00:35–01:10 | 35 min | Bygg kretsen & ladda upp Blink |
| 01:10–02:00 | 50 min | Din egen rytm & delresultat |

Problem:
- **Ingen synlig paus.** Talarnoten säger "runt 01:00 passande paus-läge". Men det står inte i de fyra blocken. Vid verklig körning är risken stor att pausen försvinner och tempot bryter.
- **35 min för "bygg + ladda upp Blink"** är optimistiskt för rena nybörjare. Port-pick, drivrutinsstrul, CH340 vs. ATmega16U2-varianter är lätta att underskatta. Om en enda deltagare fastnar på port kan det ta 10+ min bara där.
- **50 min till "Din egen rytm + delresultat"** — presentatören säger sedan "Låt dem jobba 15–25 minuter" i talarnoten för rytm-övningen, plus 5–10 min delresultat. Det blir 20–35 min totalt, så 50-minuters-blocket är faktiskt rimligt med luft. Men det står inte.

**Konkret förslag:** utöka agenda-sliden till 5 block med pausen på:

```
00:00 – 00:15  Slutmålet & Arduinon
00:15 – 00:35  Krets, spänning, ström
00:35 – 01:05  Bygg kretsen & ladda upp Blink
              ▬ PAUS ▬  (5 min)
01:10 – 02:00  Din egen rytm & delresultat
```

Sliden blir inte längre; pausen får sin egen smala rad.

### 1.2 Övning 3 (morse) är ett stort svårighetshopp

Övningarna nu:

- **Övning 1** — hjärtslag (2 snabba + lång paus). Konkret, bildlig, ~5 rader kod.
- **Övning 2** — flytta siffror till `const int`-variabler. Refaktorerings-övning.
- **Övning 3** — dina initialer i morse. Kräver: slå upp morsealfabetet, förstå dit/dah-timing, skriva 20+ rader repetitiv kod för 2–3 bokstäver.

Svårighetskurvan är 1 (mjuk) → 2 (mjuk) → 3 (BRATT). Radioamatör-målgruppen klarar det, men det kommer bli en avgörande fil för vem som fortsätter och vem som stannar vid "jag klarade inte hemuppgiften".

**Konkret förslag — lägg till en mellan-övning 2.5:**

> **Övning 2½ — Mamma-igenkänning**
> Ge lampan ett mönster som är tydligt skiljt från "vanlig blink": tre snabba blink (100 ms på, 100 ms av) följt av en lång paus (1500 ms). Det är en hjärnvänlig introduktion till att *klustra* blink tillsammans innan du går vidare till morse. Använd `const int kort = 100;` `const int lang = 1500;` från övning 2.

Tre korta blink är exakt en morse-S. Det blir en naturlig bro till övning 3.

### 1.3 LED_BUILTIN förklaras inte i brödtexten

Snabbreferensen säger:

> `LED_BUILTIN` — Arduinons inbyggda namn på pin 13. En liten ytmonterad LED (med eget seriemotstånd på kortet) är kopplad dit fabriksvägen…

Första gången ordet nämns i modulen. Problem: en första-timer som läser kompendiet linjärt har sett sin egen LED blinka OCH den inbyggda L-lampan blinka i takt på pin 13 (slidens talarnot nämner det). De kommer undra "vad var den där inbyggda för — behöver jag verkligen min egen LED?"

**Konkret förslag:** lägg till 2 meningar i slutet av sektionen "`digitalWrite` och `pinMode`":

> Arduinon har en liten LED inbyggd på kortet (märkt "L"), permanent kopplad till pin 13 via sin egen resistor. När ni blinkar pin 13 blinkar både er externa LED och den inbyggda. Vi kopplade en extern LED så att ni får se en krets ni själva byggt, inte bara en fabrikskopplad. I senare moduler kommer `LED_BUILTIN` att räcka för snabba "skriv ut status"-hack.

### 1.4 Ohms lag: "15 mA"-siffran kommer utan motivering

Sektionen "Varför 220 Ω?" säger:

> `R = (5 V − 2 V) / 15 mA = 200 Ω`

Men 15 mA kommer från ingenstans. En nybörjare som följer härledningen kommer undra: varför just 15? Varför inte 20? Varför inte 5?

**Konkret förslag:** en halv mening räcker:

> 15 mA är ett säkert riktvärde för en synligt lyst men mjuk röd LED. Datablad säger ofta "typ 20 mA, max 30 mA" — vi siktar under typ för att ha marginal mot variation i LED-exemplar och Arduino-pinne.

### 1.5 Sense–act-loop-konceptet läggs i modul 3, men kunde föraviseras i modul 1

Modul 5 kallar själv "sense–act-loop" för arkitektur-principen för alla embedded-system. Modul 1 är ett renodlat *act*-case (bara output). Modul 3 introducerar sense. Mellan ligger en röd tråd som aldrig nämns.

**Konkret förslag:** avsluta "Vad du lärde dig idag" i modul 1 med en kort mening:

> Idag var rent "utåt" — Arduinon pratade till omvärlden via pinnen. Från och med modul 3 lär vi den också *lyssna*. Då börjar det som kommer att kallas *sense–act-loopen* — det mönster som alla embedded-system i världen följer.

Då har man redan sått ordet när modul 3 drar upp det ordentligt och modul 5 namnger det.

### 1.6 "Bygg från minnet" saknar tempo-hint

Sektionen säger "lägg undan slidesen, bygg". Bra. Men ingen indikation på *när* i kursen deltagaren ska göra det. Mellan träffarna? Under träff 1? Hemma innan träff 2?

**Konkret förslag:** en inledande mening:

> *När:* gärna samma kväll som träffen, eller senast kvällen efter. Muskelminnet åldras snabbt.

### 1.7 Felsökning av upload kommer i "Vanliga fel" i slutet

Ett vanligt scenario dag 1: deltagaren har byggt kretsen, klickat Upload, fått `avrdude: stk500_getsync()`, och fastnat innan något alls blinkar. "Vanliga fel" med rätt svar finns på sidan — men långt efter byggsidan.

**Konkret förslag:** lägg en minimal 3-stegs upload-felsökning precis under sektionen "`digitalWrite` och `pinMode`" (eller i en mindre box på "Bygg kretsen"-slide):

> **Om Upload inte går igenom:**
> 1. Tools → Port → välj /dev/cu.usbmodem*, /dev/cu.wchusbserial* eller COM*. 2. Byt USB-kabel (vissa är enbart strömkablar). 3. Tools → Board → "Arduino Uno".

---

## Del 2 — Dag 2 (modul 2) · spotlights

### 2.1 Färgblandning: additiv vs subtraktiv får en pyttebit

Kompendiet säger "Precis som en pixel på skärmen" och visar bild 047-063 (additiv RGB). Men för deltagare som har målat — eller haft kvinsäker barnbild där gult + blått = grönt — är det en verklig tankenötuppfattning.

**Konkret förslag:** en `#fact`-box direkt efter pin-tabellen:

> **Tänk skärm, inte färgburk.** RGB-LED:ens färgblandning är *additiv*: du lägger till ljus och närmar dig vitt. Målarens färglära är *subtraktiv*: du lägger till pigment och närmar dig svart. Därför blir röd + grön = *gul* på din LED, men *brun-mudd* i akvarell. Bygger du intuition åt fel håll här, fastnar du i modul 5.

### 2.2 `for`-loopen i övning 3 introduceras kallt

Kompendiet skriver `for (int i = 0; i <= 255; i++)` och säger "fullständig förklaring finns i Bilaga A". För övning 3 är det OK, men syntaxen (`int i = 0;`, `i <= 255;`, `i++`) är tre nya saker i en enda rad.

**Konkret förslag:** Bryt ut raden i en kort anatomi:

> `for (int i = 0; i <= 255; i++)` — tre delar separerade med semikolon:
> - `int i = 0` → **start:** skapa räknaren `i` och sätt till 0.
> - `i <= 255` → **villkor:** kör så länge detta är sant.
> - `i++` → **steg:** efter varje varv, öka `i` med 1.

---

## Del 3 — Dag 3 (modul 3) · spotlights

### 3.1 `INPUT_PULLUP`-inversionen förtjänar ett visuellt minne

Kompendiet säger "tänk högt: LOW betyder tryckt" — bra. Men det är *fortfarande* det största greppet på modulen. Behövs en mental krok.

**Konkret förslag:** ett mini-diagram i kompendiet:

```
släppt knapp → pinne dras upp till +5 V av intern pullup → HIGH
tryckt knapp → pinne dras ner till GND av knappen       → LOW
```

Eller en tip-box: **Översättningsregel:** när du läser en `INPUT_PULLUP`-pinne, byt mentalt ut `LOW` mot "tryckt" och `HIGH` mot "släppt" INNAN du läser resten av raden.

### 3.2 Edge-detection förklaras mekaniskt, men inte *varför just stigande/fallande flank*

Kompendiet visar `state == LOW && lastState == HIGH` utan att säga "det är *fallande flanken* — övergången från släppt till tryckt". Radioamatörer kan begreppet från digital elektronik och skulle uppskatta terminologin.

**Konkret förslag:** en mening direkt efter kodblocket:

> Uttrycket fångar *fallande flanken* — ögonblicket när pinnen går från HIGH (släppt) till LOW (tryckt). Samma teknik i digital elektronik: man reagerar på flanken, inte på nivån.

---

## Del 4 — Dag 4 (modul 4) · det största hål jag hittar

### 4.1 "Varför 1 kΩ som fast motstånd under fotocellen?" saknas helt

Detta är den viktigaste designfrågan i den viktigaste kretsen i modulen. Svaret är icke-triviellt (det handlar om var man placerar mätintervallets "mitt" i fotocellens arbetsområde). Men kompendiet säger bara "i serie med en fast 1 kΩ-resistor" utan att förklara varför.

Varför inte 10 kΩ? (Skulle ge mer signal i ljus, men mindre i mörker.)
Varför inte 220 Ω? (Skulle mätta i ljus.)

**Konkret förslag:** en `#fact`-box i sektionen "Spänningsdelaren":

> **Varför just 1 kΩ?**
> Fotocellen går från ~50 kΩ (mörker) till ~500 Ω (ljust). Med 1 kΩ som motvikt hamnar mätvärdet mitt i A0:s 0–1023-skala för *rumsljus* — det som deltagarna faktiskt jobbar i. 10 kΩ skulle pressa det mesta mot toppen, 220 Ω skulle pressa allt mot botten. 1 kΩ är helt enkelt den storleksordning som ger bäst läsbarhet för ljusnivåerna ni möter i klassrummet.

### 4.2 `map()` dyker upp i övning 2 utan att ha introducerats

Övning 2 skriver `analogWrite(ledR, map(ljus, 0, 1023, 255, 0))` med en enradig förklaring. Funktionen är extremt användbar (och spar mental energi) men förtjänar en egen liten plats i snabbreferensen OCH i brödtexten, inte bara i övningstexten.

**Konkret förslag:** lägg till en `=== map() — skala om ett tal`-sektion i repetitions-blocket med ett minimal-exempel (analogRead → PWM) innan övningen kommer. Blir 5 rader i kompendiet.

### 4.3 Tilt-sensorn — terminologi-slafs

Modul 4 kallar komponenten "tilt-sensor". Den korrekta elektroniska termen är **ball-tilt switch** — den är *digital* som kompendiet korrekt påpekar, men "sensor" är ett vilseledande ord eftersom moderna "tilt-sensorer" oftast är accelerometer-baserade IMUer. Radioamatör-målgruppen kommer undra varför kursen kallar den "sensor" när den bara är en kontakt.

**Konkret förslag:** första gången den nämns:

> Komponenten heter i elegoo-manualen *tilt-sensor*, men är tekniskt en **ball-tilt switch** — en kula i en hylsa, inte en accelerometer. Vi följer manualens term för enkelhet, men tänk på den som en knapp som gravitationen trycker.

---

## Del 5 — Dag 5 (modul 5) · en stor möjlighet

### 5.1 Kompendiet säger "bygg inkrementellt" — men visar färdig lösning

Modul 5 förklarar brilliant hur man ska bygga steg-för-steg: först knapp + print, sedan toggla, sedan tilt, etc. Men i kompendiet kommer *hela den färdiga loopen* i ett kodblock direkt efter.

Det är en pedagogisk asymmetri. Deltagaren läser "bygg inkrementellt" och ser sedan den färdiga soppan.

**Konkret förslag:** vänd på det. Visa först steg 1 (bara knapp + `Serial.print` av toggling), sedan steg 2 (+tilt), sedan steg 3 (+ljussensor + stämningsljus), som tre separata korta kodblock. Låt den färdiga lösningen flyttas till **Bilaga D** (där den redan är nämnd). Gör det till en *faktisk iteration* i läsupplevelsen.

Detta är minst konkret återgiven, men av alla förslag i dokumentet — störst pedagogisk vinst per rad.

### 5.2 "Bygg vidare"-listan vet inte hackathonens tidsbudget

Listan föreslår dubbelt pip, dimning, hysteres, förvarning, morse. Men det finns ingen hint om *hur lång* hackathonen är. 2h? 3h? 4h? Det är omöjligt att prioritera som läsare.

**Konkret förslag:** lägg till en rad ovanför listan:

> Hackathonen är ungefär 3 timmar. Räkna med 90 minuter till grundlösningen och 60–90 minuter till ett valfritt "bygg vidare" för den som vill gå djupare. De flesta förslag nedan är 15–30 minuter isolerat.

---

## Del 6 — Globala observationer

### 6.1 Tempusinkonsekvens: "ni kopplade" vs "du"

Förordet säger "jag antar att du är en vuxen människa". Modulerna säger "ni kopplade blink-kretsen". Läses det högt låter det lite svajigt.

Min rekommendation: **behåll "ni" i brödtexten (det är ett kursavsnitt, gruppen gjorde det tillsammans)**, och ändra förordet till "jag antar att ni är vuxna människor". Eller tvärtom — viktigast är att valet är medvetet.

### 6.2 Hänvisningsform till appendix varierar

I texten: "Bilaga A", "Bilaga F", "Appendix A" (i beskrivningar). I slide-talarnoter: "kompendiets Appendix A". Välj en form och byt globalt. "Bilaga" är svenskare; "Appendix" är etablerat i tech-dokumentation.

### 6.3 Hänvisningar till slidesen i kompendiet

Modul 5 säger "Skelettet finns i slidesen". Som referensdokument efter kursen är det en brant koppling — deltagaren har inte slides i hand. Ersätt med konkret sidhänvisning inom kompendiet eller med ett minimal-skelett inline.

### 6.4 Ingen FAQ per modul

"Vad folk alltid frågar"-boxar kunde vinna mycket. Exempel modul 1:
- "Varför blinkar Arduinon redan när jag kopplar in USB?" (Blink är fabriksladdat.)
- "Varför är pin 13 speciell?" (LED_BUILTIN.)
- "Spelar det roll åt vilket håll resistorn sätts?" (Nej — symmetrisk komponent.)

Modul 3:
- "Varför inverteras logiken med INPUT_PULLUP?" (Redan förklarat, men frågan bör stå klar.)
- "Kan jag använda vilken digital pinne som helst för knappen?" (Ja.)

Detta är *svar på de frågor du hör från studenten vid skrivbordet* — när de finns i kompendiet slipper du svara dem igen nästa kurs.

### 6.5 Säkerhetsbilagan upprepas i brödtext

Modul 3 tar klisterlappen. Bilaga E tar den igen. Viss upprepning = betoning. Men just klisterlappen får tre (!) nämnanden (modul 3 not, modul 3 brödtext, bilaga E). Ett par räcker. Lämna det i modul 3 + bilaga E och stryk det tredje.

### 6.6 Ingen explicit "fem superkrafter"-metafor i kompendiet

Slides har det (superkrafterna-hero-sliden, section-dividers numrerade 1 av 5 osv). Kompendiet har det *inte*. Det är en missad chans: en liten "superkraft"-badge på varje modul-opener (💡 / 🎨 / 👂 / 👁 / 🏆) skulle binda ihop material mellan medium.

### 6.7 "Testpilot"-granskning

Detta är mitt enda meta-förslag. Allt material har lästs av lärare, Opus och Sonnet. Ingen har läst det *utan* förförståelse av Arduino. Det som känns självklart för författaren/reviewern är ofta det som fastnar i klassrummet.

**Konkret förslag:** innan nästa kurskörning, hitta en person från målgruppen (radioamatör, vuxen, nybörjare i Arduino) och be dem läsa modul 1 + bygga blink ensam från kompendiet. Notera var de stannar upp. Det är mer värt än ytterligare 10 AI-reviews.

---

## Prioriteringsmatris

| Förslag | Impact | Ansträngning | Gör innan nästa kurskörning? |
|---|---|---|---|
| 1.1 Explicit paus på agenda | ⭐⭐⭐ | 5 min | Ja |
| 1.2 Mellan-övning 2½ | ⭐⭐⭐ | 15 min | Ja |
| 1.3 LED_BUILTIN-förklaring | ⭐⭐ | 10 min | Ja |
| 1.4 15 mA-motivering | ⭐⭐ | 5 min | Ja |
| 1.5 Förvarna sense–act | ⭐ | 5 min | Om tid finns |
| 2.1 Additiv vs subtraktiv | ⭐⭐ | 10 min | Ja |
| 2.2 for-loop anatomi | ⭐⭐ | 10 min | Ja |
| 3.1 INPUT_PULLUP visuell | ⭐⭐ | 15 min | Ja |
| 3.2 "Fallande flanken"-term | ⭐ | 5 min | Om tid finns |
| **4.1 Varför 1 kΩ?** | **⭐⭐⭐** | 15 min | **Ja — störst hål** |
| 4.2 map() i brödtext | ⭐⭐ | 15 min | Ja |
| 4.3 Ball-tilt switch | ⭐ | 5 min | Om tid finns |
| **5.1 Inkrementell modul 5** | **⭐⭐⭐** | 45 min | **Ja — störst pedagogisk vinst** |
| 5.2 Hackathon-tidsram | ⭐⭐ | 5 min | Ja |
| 6.1 Du/ni-beslut | ⭐ | 15 min | Senare |
| 6.2 Bilaga vs Appendix | ⭐ | 10 min | Senare |
| 6.3 Slides-hänvisning | ⭐⭐ | 15 min | Ja |
| 6.4 FAQ per modul | ⭐⭐ | 60 min | Senare (separat pass) |
| 6.5 Klisterlapp-trippel | ⭐ | 5 min | Senare |
| 6.6 Superkrafter i kompendium | ⭐⭐ | 30 min | Senare (visuellt pass) |
| **6.7 Testpilot-läsning** | **⭐⭐⭐** | 90 min + person | **Ja — mest värdefull insikt** |

---

## Summering

Materialet är som helhet imponerande välskrivet. Tonen är direkt, pedagogiken är kloka val (vattenanalogin, "bygg från minnet", sense–act-loopen som röd tråd). Det här är inga kritik-punkter — det är finslip på något som redan fungerar.

**De tre förslag som ger mest värde per minut investerat:**

1. **4.1 — "Varför 1 kΩ?"** (hål i kompendiet)
2. **5.1 — Inkrementell byggprocess i modul 5** (matcha pedagogikens ord med form)
3. **6.7 — Testpilot-läsning** (hittar det ingen review kan hitta)

De tre kan implementeras inom ett par timmar totalt (exklusive testpilot-tid).
