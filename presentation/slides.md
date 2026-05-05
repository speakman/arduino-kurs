---
# === Global config ===
theme: default
title: Elektronik & Programmering med Arduino
info: |
  ## En kurs i fem träffar — från första kretsen till ett fungerande tjuvlarm
  Baserad på ELEGOO UNO Project Basic Starter Kit.

highlighter: shiki
lineNumbers: true
transition: fade
mdc: true
aspectRatio: 16/9
canvasWidth: 1920

fonts:
  sans: 'Inter'
  mono: 'JetBrains Mono'
  provider: 'google'

class: cover
drawings:
  persist: false
colorSchema: 'light'
---

<div class="h-full flex flex-col items-center justify-center text-center">

<div class="mb-6 font-mono text-xs tracking-widest uppercase opacity-60">
  Nybörjarkurs · 5 träffar
</div>

# Elektronik & <br/> Programmering <br/> med Arduino

<div class="text-2xl mt-10 opacity-80 font-light">
  Fem träffar. Fem moduler. Ett fungerande larm.
</div>

<div class="absolute bottom-12 left-12 text-sm opacity-60 font-mono">
  FRO Ånge · 13 april 2026 · FRO-lokalen
</div>

<div class="absolute bottom-12 right-12 text-sm opacity-60 font-mono text-right">
  ELEGOO UNO<br/>Basic Starter Kit
</div>

</div>

<!--
VÄLKOMNA!

Presentera dig själv kort (ca 30 sek): vem är du, varför tycker du detta är 
kul, vad gör du till vardags.

Ram för kursen:
- 5 träffar, en gång i veckan
- Varje deltagare får en ELEGOO UNO Basic Starter Kit
- Ingen förkunskap behövs — nollnivå till fungerande tjuvlarm
- Hands-on från minut 5 — vi pratar inte teori utan att göra saken

Säg INTE för mycket nu. Bara: "Vi kommer bygga det här tillsammans." 
Peka sedan framåt mot översikts-sliden.
-->

---
layout: default
class: px-14
---

<div class="mb-4 text-sm font-mono tracking-widest uppercase opacity-60">
  Kursöversikt
</div>

<h1 class="text-6xl mb-4">Fem träffar. Fem moduler.</h1>

<div class="sp-grid mt-14">
  <div class="sp">
    <div class="sp-icon i-carbon-light"></div>
    <div class="sp-number">Modul 01</div>
    <div class="sp-name">LED &amp; krets</div>
    <div class="sp-sub">Digital output, Ohms lag</div>
  </div>
  <div class="sp">
    <div class="sp-icon i-carbon-color-palette"></div>
    <div class="sp-number">Modul 02</div>
    <div class="sp-name">PWM &amp; RGB</div>
    <div class="sp-sub">analogWrite, färgblandning</div>
  </div>
  <div class="sp">
    <div class="sp-icon i-carbon-touch-1"></div>
    <div class="sp-number">Modul 03</div>
    <div class="sp-name">Digital input</div>
    <div class="sp-sub">Knapp, buzzer, logik</div>
  </div>
  <div class="sp">
    <div class="sp-icon i-carbon-chart-line"></div>
    <div class="sp-number">Modul 04</div>
    <div class="sp-name">Analog input</div>
    <div class="sp-sub">Sensorer, Serial Monitor</div>
  </div>
  <div class="sp">
    <div class="sp-icon i-carbon-chip"></div>
    <div class="sp-number">Modul 05</div>
    <div class="sp-name">Integration</div>
    <div class="sp-sub">Hackathon: bygg larmet</div>
  </div>
</div>

<div class="absolute bottom-12 right-14 text-sm opacity-60 font-mono">
  Varje träff bygger vidare på den föregående.
</div>

<!--
Det här är kursens röda tråd: fem moduler som bygger vidare på varandra.

Säg: "Varje träff lägger ni till en ny modul. När alla fem är på plats 
har ni byggt ett fullständigt tjuvlarm med stämningsljus som känner av 
mörker och tjuter om någon rubbar det."

Peka på varje kort:
1. LED & krets — grunden. Digital output, Ohms lag.
2. PWM & RGB — pulsbreddsmodulering, färgblandning.
3. Digital input — knapp, buzzer, tillståndslogik.
4. Analog input — fotocell, Serial Monitor, felsökning.
5. Integration — hackathon, allt tillsammans.

Varje modul bygger vidare på den föregående. De som redan har viss 
elektronikkunskap kommer känna igen grunderna — fokus ligger på hur 
Arduinon styr dem i mjukvara.
-->

---
layout: section
class: section text-center
---

<div class="font-mono text-sm tracking-widest uppercase opacity-60 mb-4">
  Träff 1 av 5
</div>

# LED & krets

<div class="text-2xl mt-6 opacity-80 font-light">
  Modul 1: <span class="cyan font-bold">Digital output, Ohms lag</span>
</div>

<!--
Välkomna till träff 1 av 5.

Dagens mål: en lysdiod som blinkar i en rytm varje deltagare själv 
bestämmer. Ingen förkunskap behövs — vi bygger från grunden.

Pedagogisk logik idag:
1. Visa slutmålet (hela larmet) så de vet vart de är på väg.
2. Rama in vad en mikrokontroller är — och hur den skiljer sig från en dator.
3. Kort teori: spänning, ström, GND, Ohms lag.
4. Bygg den första kretsen: LED + 220 Ω + pin 13.
5. Förklara programstrukturen: setup/loop + tre kommandon.
6. Fri övning: deltagarna skriver en egen blinkrytm.
7. Delresultat: alla visar upp sin blinkare.

Tempo: ca 2 timmar med paus. Håll teori-inslagen korta. Prioritera 
hands-on — deltagarna lär sig snabbast genom att göra.
-->

---
layout: default
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Dagens upplägg
</div>

# Idag — två timmar.

<div class="grid grid-cols-2 gap-6 mt-10">

  <div class="flex gap-4 items-start">
    <div>
      <div class="text-xs mono opacity-50 tracking-widest">00:00 — 00:15</div>
      <div class="text-lg font-bold mt-1">Slutmålet & Arduinon</div>
      <div class="opacity-70 text-sm mt-1">Vi tittar på det färdiga larmet och ramar in vad ett Arduino-kort egentligen är.</div>
    </div>
  </div>

  <div class="flex gap-4 items-start">
    <div>
      <div class="text-xs mono opacity-50 tracking-widest">00:15 — 00:35</div>
      <div class="text-lg font-bold mt-1">Krets, spänning, ström</div>
      <div class="opacity-70 text-sm mt-1">Kort genomgång av vad en krets är och varför LED:en behöver en resistor.</div>
    </div>
  </div>

  <div class="flex gap-4 items-start">
    <div>
      <div class="text-xs mono opacity-50 tracking-widest">00:35 — 01:05</div>
      <div class="text-lg font-bold mt-1">Bygg kretsen & ladda upp första programmet</div>
      <div class="opacity-70 text-sm mt-1">Praktiskt: LED + resistor på breadboarden, första uppladdningen från IDE:n.</div>
    </div>
  </div>

  <div class="flex gap-4 items-start opacity-70">
    <div>
      <div class="text-xs mono opacity-60 tracking-widest">01:05 — 01:10</div>
      <div class="text-lg font-bold mt-1">Paus</div>
      <div class="opacity-70 text-sm mt-1">Vatten, WC, sträck. Tillbaka fem minuter senare.</div>
    </div>
  </div>

  <div class="flex gap-4 items-start col-span-2">
    <div>
      <div class="text-xs mono opacity-50 tracking-widest">01:10 — 02:00</div>
      <div class="text-lg font-bold mt-1">Din egen rytm & delresultat</div>
      <div class="opacity-70 text-sm mt-1">Fri övning: ändra delay-värdena till ett eget mönster. Alla visar upp.</div>
    </div>
  </div>

</div>

<!--
Kort genomgång av upplägget. Räkna med att tiderna glider ±10 minuter — 
det är normalt. Håll teorin kort och prioritera bygget.

Säg:
"Dagens träff är strukturerad så ni ska ha något handgripligt klart 
redan efter första passet. Ingen slide utan bygge. Efter en paus mitt 
i skriver ni en egen rytm och visar upp för varandra."

Lämpligt pausläge: runt 01:00 när kretsen är uppe och Blink snurrar. 
Vatten, WC, mingel. Efter pausen kör vi kod-teorin och fria övningen.
-->

---
layout: full
class: relative
---

<div class="absolute inset-0 flex items-center justify-center">
  <div class="text-center">
    <div class="flex justify-center mb-6">
      <div class="text-8xl i-carbon-alarm warn animate-pulse"></div>
    </div>
    <div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
      Slutmålet
    </div>
    <h1 class="text-7xl mb-8">Det här ska vi bygga.</h1>
    <div class="text-xl max-w-3xl mx-auto opacity-75">
      Ett larm som känner av mörker, lyser upp som stämningsljus och tjuter när någon rör det.
    </div>
  </div>
</div>

<!--
[GÖR DETTA NU]:
Håll upp ditt färdigbyggda larm. Släck taklampan så stämningsljuset lyser 
upp i mörkret. Luta den sedan skarpt så buzzern tjuter (tilt-sensorn 
triggar på lutning, inte på skakning).

SÄG:
"Om fem veckor kommer ni alla att ha byggt en likadan maskin. Den 
känner av mörker. Den har ett stämningsljus. Och den tjuter om någon 
försöker rubba den.

För att komma dit ska vi gå igenom fem moduler, en per träff. Idag 
bygger vi den första biten: en lysdiod som ni själva styr från koden."

Ta dig tid här. Låt dem se larmet, höra det, uppleva det. När de vet 
vart de ska komma blir resten av kursen en jakt på varför varje del 
finns.
-->

---
layout: image-left
image: /images/arduino-uno-hero.jpg
class: pl-4
---

<div class="h-full flex flex-col justify-center">

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Arduino UNO R3
</div>

# Mikrokontrollern.

<div class="text-xl opacity-75 mt-8">
  En <span class="cyan">mikrokontroller</span> — processor, minne<br/>
  och in-/utgångar på ett chip.<br/>
  Kör ett enda program, helt förutsägbart.
</div>

<div class="mt-10 text-xs opacity-50 font-mono">
  Arduino UNO R3 · ATmega328P<br/>
  16 MHz · 32 KB flash · 2 KB SRAM
</div>

</div>

<!--
DEFINITION:
"En mikrokontroller är en liten dator på ett enda chip: processor, 
minne och in-/utgångar i samma hölje. Till skillnad från en laptop 
som kör ett operativsystem och kan göra allt, kör en mikrokontroller 
ett enda program — det ni själva laddar upp — och gör bara det. 
Förutsägbart, i realtid, ofta i åratal utan omstart."

TEKNISKT:
- ATmega328P från Microchip (tidigare Atmel)
- 16 MHz klockfrekvens (långsamt jämfört med en PC, snabbt jämfört 
  med den fysiska världen runt omkring)
- 32 KB flash för programmet, 2 KB RAM för variabler
- 14 digitala pinnar + 6 analoga ingångar
- Strömförsörjs via USB eller extern 7–12 V

Kortet är en ELEGOO UNO R3 — en Arduino-kompatibel klon med öppen 
referensdesign. Pin-, kod- och USB-kompatibelt med original-Arduino. 
Till skillnad från billigare clones använder ELEGOO den äkta 
ATmega16U2 USB-chippen, samma som genuine Arduino. Drivrutiner är 
inte ett problem: kortet dyker upp direkt i IDE:ns Port-meny som 
"Arduino Uno" på macOS, Linux och moderna Windows.

[GÖR DETTA NU — bara förberedelse, själva uppladdningen sker efter 
 att kretsen är byggd]:
1. Alla öppnar Arduino IDE på sin laptop.
2. USB-kabel från laptop → Arduinons USB-B-port.
3. Tools → Board → "Arduino Uno".
4. Tools → Port → välj rätt port (Mac: /dev/cu.usbmodem* · Windows: COM*).
5. File → Examples → 01.Basics → Blink (öppna exemplet så det är redo).

Vi laddar upp först efter att den fysiska kretsen är byggd (slide 
"Bygg kretsen"). Detta för att deltagarna ska se sin egen LED blinka, 
inte bara den inbyggda "L"-lampan.

[FELSÖKNING — port]:
- "Port not found" → pröva en annan USB-kabel. Vissa är bara 
  strömkablar och saknar data-ledare.
- Kortet blinkar redan när ni kopplar in → det körde Blink från 
  fabrik. Normalt. Vi laddar upp en egen version senare för att se 
  att det är vår kod som styr.
-->

---
layout: default
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Tre grundbegrepp
</div>

# Spänning, ström, GND.

<div class="grid grid-cols-3 gap-6 mt-16">

  <div class="p-6 rounded-2xl border border-[var(--ak-border)] bg-[var(--ak-bg-raised)] text-center">
    <div class="text-5xl i-carbon-flash cyan mb-3 mx-auto"></div>
    <div class="text-sm mono uppercase tracking-widest opacity-60">Spänning</div>
    <div class="text-3xl font-bold mt-2">Volt · V</div>
  </div>

  <div class="p-6 rounded-2xl border border-[var(--ak-border)] bg-[var(--ak-bg-raised)] text-center">
    <div class="text-5xl i-carbon-flow cyan mb-3 mx-auto"></div>
    <div class="text-sm mono uppercase tracking-widest opacity-60">Ström</div>
    <div class="text-3xl font-bold mt-2">Ampere · A</div>
  </div>

  <div class="p-6 rounded-2xl border border-[var(--ak-border)] bg-[var(--ak-bg-raised)] text-center">
    <div class="text-5xl i-carbon-earth-filled cyan mb-3 mx-auto"></div>
    <div class="text-sm mono uppercase tracking-widest opacity-60">GND</div>
    <div class="text-3xl font-bold mt-2">0 V · referens</div>
  </div>

</div>

<!--
De flesta FRO-medlemmar har stött på spänning och ström förut som 
radioamatörer, men det är värt att rama in termerna eftersom vi kommer 
använda dem stenhårt resten av kursen.

SÄG:
"Tre begrepp vi återkommer till:
  SPÄNNING — tryckskillnad mellan två punkter, mätt i volt.
              Arduinons 5 V-pinne ligger på 5 V relativt GND.
  STRÖM    — laddning per sekund, mätt i ampere.
              En LED tål ca 20 mA. Mer → den brinner upp.
  GND      — nollpunkten all elektronik mäts mot.
              Varje krets behöver en retur till GND."
-->

---
layout: default
class: px-14 pt-12
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-3 text-center">
  Ohms lag
</div>

<div class="text-center mono font-bold mb-6" style="font-size:3.2rem;color:var(--ak-accent)">
  U = R · I
</div>

<div class="flex items-center justify-center gap-12">

  <div class="flex flex-col items-center">
    <img src="/images/ohms-law.png" class="rounded-xl" style="width:26rem" />
    <div class="text-base opacity-60 mt-3">
      <span class="cyan">Volt</span> trycker · <span class="cyan">Ohm</span> stryper · <span class="cyan">Amp</span> flödar
    </div>
  </div>

  <div class="flex flex-col items-center">
    <img src="/images/ohms-triangle.png" style="width:18rem" />
    <div class="text-base opacity-60 mt-3 mono">täck variabeln ni söker</div>
  </div>

</div>

<div class="mt-8 text-center text-lg opacity-70">
  Räkneexempel och framspänningsfall: <span class="cyan">→ Bilaga F i kompendiet</span>
</div>

<!--
Ohms lag är det som motiverar resistorn vi ska koppla i nästa steg.
En vanlig röd LED har ett spänningsfall på ca 2 V och vill ha ca 15 mA.
Arduinon levererar 5 V på pin 13. Räkningen blir:
  R = (5 V − 2 V) / 0,015 A = 200 Ω
Vi väljer 220 Ω eftersom det är det närmaste standardvärdet — strömmen 
hamnar då på ca 13,6 mA. Säkert och ljust.

VARIANTER av formeln:
  U = R · I   ·   I = U / R   ·   R = U / I
Triangeln gör alla tre självklara — täck variabeln ni söker.

HISTORIA (om någon frågar):
U från tyskans "Spannung" (spänning), I från franska 
"intensité du courant" (strömintensitet). Europeisk konvention 
sedan 1800-talet. Full förklaring i Bilaga F.

Du behöver inte köra räkningen live — men visa triangeln så att de som 
redan kan den känner sig sedda. De som inte kan den får en teaser till 
varför just 220 Ω.
-->

---
layout: default
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Kretsen
</div>

# Kretsen — som ett vattensystem.

<div class="mt-6 text-lg max-w-4xl">

Strömmen går ut från en <span class="cyan">utgångspinne</span> (t.ex. pin 13 när den är HIGH), genom komponenterna, och tillbaka till <span class="cyan">GND</span>.

Utan bromsning: **<span class="danger">LED:en brinner upp</span>**.

Lösningen: en **strypventil** — en resistor på 220 Ω i serie.

</div>

<div class="tip-box mt-8 max-w-4xl">
  <div class="tip-title">Minnesregel</div>
  <div>Ingen krets utan väg tillbaka till GND. Strömmen måste kunna fullborda varvet — annars händer ingenting.</div>
</div>

<!--
VATTENANALOGIN:
"Tänk er ström som vatten i ett rör. Arduinons utgångspinne (när den 
är HIGH) är kranen, GND är utloppet. Vattnet måste kunna rinna tillbaka — annars står det 
stilla och ingenting händer.

LED:en är som en liten turbin längs röret. Men den tål bara en viss 
mängd flöde. Utan något som bromsar skulle hela trycket (5 V) hamna 
över turbinen, och den skulle brinna upp. Därför sätter vi en 
strypventil — 220 Ω-resistorn — i serie med den. Den 'äter upp' en del 
av trycket och begränsar flödet till något LED:en klarar av."

VISA: peka fysiskt på en resistor och läs färgringarna högt. 
VIKTIGT: kittet innehåller BÅDE 4-bands och 5-bands resistorer — räkna 
banden först. 220 Ω är röd-röd-brun-guld (4-band) ELLER 
röd-röd-svart-svart-brun (5-band, 1%-precision). Mät med multimeter 
om du är osäker.

Den tekniska poängen är att ström är seriellt: samma mängd ström går 
genom LED:en OCH resistorn. Så genom att välja resistorns värde väljer 
vi också strömmen (via Ohms lag från förra sliden).
-->

---
layout: two-cols-header
class: px-14 pt-12
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Komponenterna
</div>

# LED & resistor.

::left::

<div class="mt-6">

### LED:en

<div class="space-y-2 text-base opacity-85 mt-4">

- **Har polaritet.** Kör du den baklänges lyser den inte.
- **Långt ben = anod (+)** → till signalpinnen (pin 13).
- **Kort ben + platt kant = katod (−)** → till GND.
- Tål ca **20 mA**. Mer → den brinner upp permanent.

</div>

<div class="mt-4 text-xs opacity-60 italic">
  Kör du den baklänges går den inte sönder — den lyser bara inte. Bara att vända.
</div>

</div>

::right::

<div class="mt-6">

### Resistorn

<div class="space-y-2 text-base opacity-85 mt-4">

- **Passiv komponent.** Ingen polaritet — koppla hur du vill.
- Värdet läses på **färgringarna**.
- **220 Ω** (4-band) = <span class="mono">röd · röd · brun</span> + guld.<br/>**220 Ω** (5-band) = <span class="mono">röd · röd · svart · svart</span> + brun.

</div>

<div class="mt-6 flex items-center gap-4 p-4 rounded-xl border border-[var(--ak-border)] bg-[var(--ak-bg-raised)]">
  <img src="/images/resistor-220ohm.png" class="flex-shrink-0" style="width:200px;height:auto" />
  <div class="text-xs mono opacity-80 leading-tight">
    röd · röd · brun<br/>
    2 · 2 · ×10¹<br/>
    = <span class="cyan font-bold">220 Ω</span>
  </div>
</div>

</div>

<!--
LED-polariteten missförstås ofta. Säg det tydligt:

"Lysdioden är riktad. Det LÅNGA benet är plus (anoden). Det KORTA benet 
— och det sitter alltid vid en liten PLATT kant i plasthöljet — är 
minus (katoden). Kör du den baklänges lyser den inte alls. Men den går 
inte sönder heller. Bara att vända."

Fysiskt tips: låt dem ta upp en LED ur kittet och känna efter den 
platta kanten med tummen. Det är snabbaste sättet att identifiera 
katoden när benen har kapats till samma längd.

RESISTORN:
OBS: räkna ANTAL band först. kittet har både 4-band och 5-band.

För en 4-band-resistor:
Färgkoden läses från den ände där ringarna ligger tätast. För en 4-
ringars resistor:
  - Ring 1 = första siffran
  - Ring 2 = andra siffran
  - Ring 3 = multiplikator (antal nollor)
  - Ring 4 = tolerans (guld = ±5%)
  220 Ω (4-band) → röd (2) · röd (2) · brun (×10¹) · guld (±5%)
  220 Ω (5-band) → röd (2) · röd (2) · svart (0) · svart (×1) · brun (±1%)

kittet har flera värden (220 Ω, 330 Ω, 1 kΩ, 10 kΩ). Få dem att 
plocka ut rätt sort själva — det är en viktig färdighet. Färgkod-
tabellen sitter inuti locket på kittet om de kör fast.

Resistorn saknar polaritet — det spelar ingen roll åt vilket håll den 
kopplas. Det är bara LED:en som är riktad.
-->

---
layout: default
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Breadboarden, steg 1
</div>

# Fem hål = en nod.

<img src="/images/breadboard-internals.png" class="breadboard-diagram" style="max-height:540px;width:auto;margin:0 auto;display:block" />

<div class="mt-8 grid grid-cols-2 gap-x-12 gap-y-5" style="font-size:32px;line-height:1.5">
<div>· <strong>Fem hål i rad</strong> = en <span class="cyan">nod</span></div>
<div>· Gapet i mitten <strong>bryter</strong></div>
<div>· Raden bredvid = <strong>egen</strong> nod</div>
<div>· <span class="mono text-red-400">+</span>/<span class="mono text-blue-400">−</span>-skenorna går hela vägen</div>
</div>

<!--
Den här sliden är en tyst men viktig pedagogisk fond innan vi kopplar 
något alls. Deltagarna har sett en breadboard, men få har fattat att 
den är helt platt invändigt — bara en massa klämmor.

SÄG (sakta, peka på bilden):
"Titta på en breadboard. Ovanifrån ser det ut som en massa hål. Under 
plasten finns små metallklämmor. FEM HÅL I RAD är fysiskt 
sammankopplade. De är samma elektriska punkt — en 'nod'. 

Raden bredvid är en HELT ANNAN nod, inte kopplad. Och det finns ett 
gap i mitten av brädan som bryter förbindelsen mellan övre och nedre 
halvan — det är där er IC kommer att sitta senare i livet, inte idag.

Längs sidorna syns två långa röda och blåa linjer: det är 'power 
rails'. Hela röda linjen är en enda lång nod. Hela blåa linjen är en 
annan. Vi kommer använda dem som plus- och minus-skenor i Modul 2."

POÄNG:
Merparten av alla 'min LED lyser inte'-fel är att ett ben sitter i 
fel hål, eller att man trott att raden fortsätter över gapet. Plantera 
mönstret "kontrollera raden" redan nu, så slipper ni skilja tio 
händer senare.

DIDAKTISK POÄNG: de tre koncepten (rad = nod, gap bryter, power rails) 
är det enda som spelar roll idag. Håll det enkelt.
-->

---
layout: center
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-6">
  Felsökning · regel #1
</div>

# Kontrollera raden först.

<div class="mt-16 text-4xl max-w-4xl mx-auto">
  <strong>90 %</strong> av alla nybörjarfel <br/>
  är ett hål fel.
</div>

<div class="mt-14 text-2xl opacity-75 max-w-3xl mx-auto">
  Kabeln och komponentbenet måste sitta på <strong class="cyan">samma rad</strong>.
</div>

<!--
Plantera detta som eget mantra — inte fotnot. När en LED inte lyser
är felkällan nästan alltid att kabel och komponentben hamnat på olika
rader. Den här sliden är referens-mantrat: "kontrollera raden".
-->

---
layout: default
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Praktiskt moment
</div>

# Bygg kretsen.

<div class="mt-8 space-y-4 max-w-5xl">

<div class="flex gap-4 items-start">
  <div class="mono cyan text-sm mt-1 flex-shrink-0 w-6">01</div>
  <div>Sätt LED:en på breadboarden. <strong>Långt ben</strong> i en ledig rad, <strong>kort ben</strong> i raden bredvid.</div>
</div>

<div class="flex gap-4 items-start">
  <div class="mono cyan text-sm mt-1 flex-shrink-0 w-6">02</div>
  <div>Kabel från <strong>pin 13</strong> på Arduinon → samma rad som långa benet.</div>
</div>

<div class="flex gap-4 items-start">
  <div class="mono cyan text-sm mt-1 flex-shrink-0 w-6">03</div>
  <div><strong>220 Ω-resistor</strong> (4-band: röd-röd-brun; 5-band: röd-röd-svart-svart-brun). Ett ben i samma rad som korta LED-benet. Andra benet i valfri ledig rad.</div>
</div>

<div class="flex gap-4 items-start">
  <div class="mono cyan text-sm mt-1 flex-shrink-0 w-6">04</div>
  <div>Kabel från resistorns andra ben → <strong>GND</strong> på Arduinon.</div>
</div>

<div class="flex gap-4 items-start">
  <div class="mono cyan text-sm mt-1 flex-shrink-0 w-6">05</div>
  <div>Ladda upp <span class="mono cyan">File → Examples → 01.Basics → Blink</span>. Lampan ska börja blinka.</div>
</div>

</div>

<!--
Gå igenom bygget långsamt. Klicka fram stegen ett i taget (v-click). 
Ge alla tid att koppla innan du klickar vidare.

SÄG:
"Jag visar ett steg i taget. Ni gör parallellt. Luta er tillbaka när 
ni är klara — så ser jag att alla hänger med, och sen fortsätter vi 
till nästa steg."

[SERIE-NOTIS — om någon undrar]:
Resistorn kan sitta på endera sidan av LED:en. I en seriekrets är 
strömmen densamma överallt, så det spelar ingen roll om det är 
pin13 → resistor → LED → GND eller pin13 → LED → resistor → GND. 
Vi kör resistorn på kortsidan (efter LED:en) för konsistens — men 
båda varianterna fungerar identiskt.

[FELSÖKNING]
- LED lyser inte alls → polariteten fel, vänd LED:en.
- Både inbyggda L-lampan och er egen LED ska blinka i takt efter 
  uppladdning. Pin 13 är hårdkopplad till den inbyggda LED:en också.
- Upload misslyckas → Tools → Port → välj /dev/cu.usbmodem* eller COM*.
- Upload gick bra men externa lampan blinkar inte → kabel från pin 13 
  kan ha glidit ur. Dra lätt i ändarna.
- Resistorn känns varm → felkopplad. Koppla bort strömmen direkt.

När alla har en blinkande LED: detta är passande plats för pausen som 
agendan hänvisar till. Vatten, WC, prat. Efter pausen dyker vi ner i 
koden.
-->

---
layout: default
class: "!p-0"
---

<WiringSlide
  eyebrow="Modul 1 · Koppling · LED"
  title="Så här ska det se ut."
  img="/images/wiring/led-fritzing.png"
  caption='<span class="mono cyan">D13</span> → LED långt ben · LED kort ben → 220 Ω → <span class="mono cyan">GND</span>'
/>

<!--
Lägg upp denna bild när deltagarna börjar koppla i föregående slide.
Standard Fritzing-illustration av Blink-kretsen.

Peka på brädan och gå igenom pin för pin:
1. Pin 13 på Arduinon → hopptråd → samma rad som LED:ens LÅNGA ben.
2. LED:ens korta ben i raden bredvid.
3. 220 Ω-resistor i samma rad som korta benet, andra änden i en 
   ledig rad.
4. Hopptråd från resistorn → GND på Arduinon.

Säg:
"Följ bilden. Om det inte ser ut EXAKT så här: felsök. Byt kabel. 
Byt rad."

[FELSÖKNING vid bilden]:
- LED lyser inte → vänd LED:en (polaritet).
- LED lyser SVAGT → resistorn kan vara fel värde, kolla färgbanden.
- LED lyser FULLT men blinkar inte → upload misslyckades, testa igen.
-->

---
layout: two-cols-header
class: px-14 pt-12
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Kodens anatomi
</div>

# `setup()` och `loop()`.

::left::

<div class="mt-6 space-y-5 text-base">

<div>
  <div class="text-lg font-bold cyan">void setup()</div>
  <div class="opacity-80 mt-1">Körs <strong>en gång</strong> när Arduinon startar eller när ni laddar upp. Används för konfiguration: vilka pinnar är utgångar, hastighet på Serial, etc.</div>
</div>

<div>
  <div class="text-lg font-bold cyan">void loop()</div>
  <div class="opacity-80 mt-1">Körs <strong>om och om igen</strong>, så länge kortet har ström. Här bor logiken: läs, reagera, vänta, upprepa.</div>
</div>

<div class="mt-4 text-xs opacity-60">
  Regel: exakt en <span class="mono">setup()</span> och en <span class="mono">loop()</span> per Arduino-kod. Aldrig fler.
</div>

</div>

::right::

```cpp
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);  // körs en gång vid uppstart
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);  // körs om och om igen
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
```

<!--
Det här är det första strukturella koncept de behöver förstå i Arduinos 
C++-variant. Håll det enkelt.

SÄG:
"Varje Arduino-program har exakt två funktioner: setup och loop.

setup() körs EN gång — när kortet får ström eller när ni laddar upp. 
Här säger vi till Arduinon hur saker ska bete sig: vilka pinnar som 
är ut- respektive ingångar, hastigheten på serieporten, och så vidare.

loop() körs OM OCH OM IGEN, resten av kortets liv. När den når slutet 
av loop() börjar den om från första raden automatiskt. Det är vår 
arbetshäst. Allt som ska hända upprepat ligger här."

Visa i IDE:n att Blink-exemplet faktiskt har exakt den här strukturen. 
Peka på setup och peka på loop. "Alla Arduino-program ni någonsin 
kommer skriva har den här formen."

Om någon undrar: ja, det finns också 'före setup' (globala variabler, 
#include-rader). Vi tar det när vi behöver det.
-->

---
layout: default
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Tre kommandon
</div>

# Hela Blink — på tre rader.

<div class="grid grid-cols-[max-content_1fr] gap-x-10 gap-y-6 items-center mt-12">

```cpp
pinMode(LED_BUILTIN, OUTPUT);
```

<div class="opacity-85 text-base">
  "<span class="mono">LED_BUILTIN</span> är en <span class="cyan">utgång</span>." Arduinons alias för <span class="mono">pin 13</span> — där den inbyggda LED:en sitter. Körs i <span class="mono">setup()</span>.
</div>

```cpp
digitalWrite(LED_BUILTIN, HIGH);
```

<div class="opacity-85 text-base">
  "Sätt pinnen till <span class="cyan">5 V</span>." <span class="mono">HIGH</span> = tänd (5 V), <span class="mono">LOW</span> = släckt (0 V). Körs i <span class="mono">loop()</span>.
</div>

```cpp
delay(1000);
```

<div class="opacity-85 text-base">
  "Vänta <span class="cyan">1000 millisekunder</span>." 1000 ms = 1 sekund. Arduinon pausar allt annat under tiden.
</div>

</div>

<div class="mt-10 text-sm opacity-60 max-w-3xl">
  Med bara dessa tre kan ni få en lysdiod att blinka i vilken rytm som helst.
</div>

<!--
Förklara varje kommando för sig. Använd whiteboarden vid behov.

pinMode(pin, läge):
"Innan Arduinon kan styra en pinne måste den veta om den ska vara in- 
eller utgång. OUTPUT = vi skickar ut ström. INPUT = vi läser av. 
Idag är det OUTPUT som gäller — vi skickar ström till LED:en."

digitalWrite(pin, läge):
"När pinMode är satt kan vi sätta pinnen PÅ (HIGH = 5 V) eller AV 
(LOW = 0 V). Det är det digitalWrite gör. Bara två lägen — helt 
digitalt. Idag."

delay(ms):
"Arduinon kör på 16 MHz — 16 miljoner klockcykler i sekunden. En blink 
skulle vara osynligt kort utan en paus. delay(ms) säger 'vänta X 
millisekunder'. 1000 ms = 1 sekund. 200 ms = en snabb blink. 
Under en delay väntar huvudprogrammet — Arduinon gör ingenting annat 
i sekvensen. Det blir viktigt i senare träffar."

Koppla tillbaka till Blink-exemplet de just laddat upp. Peka på de tre 
kommandona i den faktiska koden. "Det är EXAKT dessa tre ni använder — 
inget mer. Tre kommandon räcker för dagens bygge."

Sedan: låt dem ändra delay-värdet (från 1000 till 200, eller 50, eller 
2000) och ladda upp igen. De ska själva se att lampan svarar på deras 
kod.
-->

---
layout: default
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Uppgift
</div>

# Din egen rytm.

<div class="mt-8 text-3xl max-w-6xl">

Ändra `Blink` till ett mönster du själv väljer.

</div>

<ul class="mt-8 text-2xl space-y-3 max-w-6xl">
<li><strong>SOS-rytm:</strong> · · · — — — · · ·</li>
<li><strong>Ditt eget tempo</strong> — snabb eller långsam, ojämn</li>
<li><strong>Hjärtslag</strong> — två snabba, sen paus</li>
</ul>

<div class="tip-box mt-8 max-w-4xl text-left">
  <div class="tip-title">Tips för bygget</div>
  <div>Lägg tider i <code>const int</code>-variabler — då slipper du ändra många siffror när du justerar tempot. SOS växlar mellan kort blink (200 ms) och lång blink (600 ms), separerade av paus.</div>
</div>

<!--
Kvällens huvuduppgift. Låt dem jobba 15–25 minuter beroende på tempo. 
Full lösning med SOS-sketch (const int, blink(tid)-funktion) finns 
i kompendiet, Hemma-övning 2–3.

TIPS (säg muntligt): lägg tider i const int-variabler så slipper 
man ändra många siffror varje gång. Förklaringen och alternativet 
#define finns i Bilaga A.

SÄG:
"Nu är det er tur. Ändra Blink så att lampan blinkar i en rytm ni 
själva bestämmer. SOS är en klassiker — tre korta, tre långa, tre 
korta — men ta gärna något eget."

PEDAGOGISKA POÄNGER:
- De introduceras försiktigt till att faktorisera ut en funktion 
  (blink(tid)). Det är inte obligatoriskt — uppgiften går att lösa med 
  upprepade digitalWrite + delay — men det är ett naturligt nästa steg 
  för dem som vill djupare.
- const int är deras första möte med namngivna konstanter. Säg att det 
  är "att ge ett värde ett namn så man inte behöver skriva samma siffra 
  överallt". Snabbar upp framtida justeringar.
- OM NÅGON PÅPEKAR att Arduino IDE:ns inbyggda Blink-exempel använder 
  `#define LED_BUILTIN 13` istället för `const int`: säg att båda är 
  giltiga. `#define` är ett äldre C-makro som textersätter innan 
  kompileringen, `const int` är modern typ-säker C++. Vi använder 
  `const int` i kursen för att det är tydligare — Arduino-biblioteket 
  självt använder `#define` av historiska skäl. Hela förklaringen 
  finns i kompendiets Bilaga A.
- Uppmuntra många uppladdningar — ju fler gånger de trycker Upload 
  desto tryggare blir flödet.

OM NÅGON ÄR KLAR PÅ 5 MIN:
Utmaning: "Kan du få lampan att morsa dina initialer? Eller hela ditt 
namn i morse?" morsetabell på whiteboarden om det behövs.

OM NÅGON SITTER FAST EFTER 10 MIN:
Sätt dig bredvid. Fråga: "vad vill du ska hända?" Dela upp i mini-steg. 
Låt dem skriva raderna själva — peka bara på platsen.

VANLIGA KOMPILATORSFEL att öva felsökning mot:
- Glömd semikolon efter ett kommando → röd rad i IDE:ns felpanel, 
  "expected ';' before..." Läs meddelandet högt för deltagaren.
- Osparad fil före upload → IDE:n varnar.
- Felstavad funktionsnamn → "'blinck' was not declared in this scope."
Läsningen av felmeddelandet är den enda felsökningsmuskeln vi bygger 
idag — lär dem att det inte är något att vara rädd för.

MORSE-NOTIS (om någon radioamatör kommenterar):
Koden producerar en SOS-igenkännbar rytm men är inte strikt morsetiming. 
I riktig CW är pausen mellan dits/dahs inom en bokstav alltid lika med 
en dit (1 enhet), inte lika med själva tecknet. Funktionen blink(tid) 
gör LOW lika länge som HIGH för enkelhets skull — O:t låter därför som 
tre separata T:n för ett tränat öra. Det är medvetet förenklat för 
dagens nivå; strikt CW-timing kan vi köra som sidouppdrag senare. 
Erkänn det om frågan kommer.
-->

---
layout: center
class: text-center
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-4">
  Delresultat · Träff 1
</div>

<div class="inline-block px-5 py-2 rounded-full border border-[var(--ak-accent)] bg-[var(--ak-accent-soft)] mb-6">
  <span class="mono text-xs tracking-widest uppercase cyan">Klart</span>
</div>

<h1 class="text-6xl mb-4">Ni har byggt en blinkare.</h1>

<div class="text-lg opacity-75 mb-10 max-w-2xl mx-auto italic">
  Er första rad kod som styr den fysiska världen.
</div>

<div class="grid grid-cols-3 gap-8 max-w-4xl mx-auto mt-4">

  <div class="flex flex-col items-center">
    <div class="font-bold">Er första krets</div>
    <div class="text-sm opacity-70 mt-1">LED + resistor + GND</div>
  </div>

  <div class="flex flex-col items-center">
    <div class="font-bold">Er första kod</div>
    <div class="text-sm opacity-70 mt-1">setup · loop · tre rader</div>
  </div>

  <div class="flex flex-col items-center">
    <div class="font-bold">Er egen rytm</div>
    <div class="text-sm opacity-70 mt-1">kod som styr världen</div>
  </div>

</div>

<div class="mt-12 text-lg opacity-75 max-w-2xl mx-auto">
  Ett varv runt rummet — visa upp ditt mönster för grannen.
</div>

<!--
KVÄLLENS STOLTHETSÖGONBLICK. Ta dig tid här.

SÄG:
"Stopp en minut. Titta på vad ni precis gjorde. Ni har:
- Byggt en elektrisk krets från grunden på en breadboard.
- Skrivit kod som styr fysiska världen.
- Laddat upp den till en mikrokontroller.
- Ändrat koden och sett hur lampan beter sig annorlunda direkt.

För två timmar sedan var det här okänt territorium för flera av er. 
Nu kan ni det — på riktigt. Vi ska titta på varje deltagares lampa 
en i taget."

[VISNINGSRUNDA]
Visning av allas rytmer — 5–10 sekunder per person. Även den som
fastnat visar upp sin vanliga Blink. Korta kommentarer ("smart lösning",
"fint tempo") cementerar självförtroendet de precis byggde upp.

Pedagogisk poäng: ingen lämnar träff 1 utan en lampa som blinkar.

Timing: 5–10 minuter totalt, beroende på antal deltagare.
-->

---
layout: statement
class: text-center
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-6">
  Nästa träff
</div>

<div class="mb-10 flex justify-center items-center gap-4">
  <div class="rgb-circle rgb-red"></div>
  <div class="rgb-circle rgb-green"></div>
  <div class="rgb-circle rgb-blue"></div>
</div>

# Nästa gång...

<div class="text-2xl mt-8 opacity-75 max-w-5xl mx-auto">
  Ni kan tända en lampa i en egen rytm.<br/>
  Nästa steg: blanda <span class="cyan">färg</span> ur rött, grönt och blått.
</div>

<!--
Avsluta träff 1 här.

SÄG:
"Ni kan nu tända och släcka en lysdiod i en rytm ni själva bestämmer. 
Bra jobbat. Nästa träff lägger vi till en RGB-LED och lär Arduinon 
att blanda färg. Samma kod-struktur som idag, men med ett nytt 
kommando som styr hur mycket ström pinnen skickar ut. Vi ses då."

En kort, lockande antydan om nästa träff skapar förväntan att komma 
tillbaka. Håll det kort — deltagarna är nöjda och trötta.

PRAKTISKT INNAN DE GÅR:
- Påminn: *varje deltagare har fått sitt EGNA kitt*. Kittet och 
  Arduinon är deras — experimentera gärna hemma.
- Till nästa träff: *ta med ALLT — laptop, Arduino, breadboard, 
  hela kittet*. Vi har bara EN breadboard var, så den måste följa 
  med varje gång. Demontera gärna blink-kretsen hemma så är det 
  lättare att starta om från scratch i Modul 2.
- Tipsa om Blink-varianter de kan prova hemma (SOS, egna initialer, 
  fade-effekt som vi tar senare).
- Nämn när nästa träff är.
-->

---
layout: section
class: section text-center
---

<div class="font-mono text-sm tracking-widest uppercase opacity-60 mb-4">
  Träff 2 av 5
</div>

# PWM & RGB

<div class="text-2xl mt-6 opacity-80 font-light">
  Modul 2: <span class="cyan font-bold">analogWrite &amp; färgblandning</span>
</div>

<!--
Välkommen tillbaka! 

Kort repetition från förra gången: blink-kretsen, vattenanalogin, PLUS→MINUS.

Idag: RGB. Vi lär Arduinon blanda alla färger.

Ny koncept idag: `analogWrite` — istället för bara PÅ/AV (digitalWrite) 
kan vi styra HUR MYCKET. 0-255. Det är vad som gör blandning möjlig.
-->

---
layout: center
class: text-center
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-6">
  Tre kanaler, alla färger
</div>

# Alla färger, av bara tre.

<div class="mt-4 flex justify-center">
  <img src="/images/rgb-color-mixing.png" class="rgb-demo" />
</div>

<div class="mt-4 text-base opacity-75 max-w-2xl mx-auto">
  Skärmen ni tittar på just nu har <span class="cyan">miljoner pixlar</span>, 
  och varje pixel är bara en röd, en grön och en blå punkt.
  Idag programmerar vi <span class="cyan">er egen pixel</span>.
</div>

<div class="warn-box mt-3 inline-block text-left">
  <div class="warn-title">Viktigt — RGB-LED:en</div>
  <div>
    <strong>Common Cathode.</strong> 4 ben i rad.<br/>
    Ordning från platta sidan: <span class="mono">Röd · <span class="cyan">Katod</span> · Grön · Blå</span><br/>
    Katoden är <strong>längst</strong>, sitter <strong>andra från platta sidan</strong>, och går till <span class="danger">GND</span>.
  </div>
</div>

<!--
TEORI:
"Hur skapar skärmen ni tittar på just nu alla de här färgerna? Genom tre 
färger: Röd, Grön och Blå. RGB. Det är det enda skärmen egentligen kan.

Resten är en illusion — ögat blandar ihop de tre punkterna till det vi 
uppfattar som en färg. Idag ska ni programmera er egen pixel."

VARNING — RGB-LED:ens benkonfiguration (väldigt viktigt, säg på skarpen):

"Er RGB-LED har FYRA ben i rad. Titta noga:
- Den ena sidan av plasthöljet är PLATT (en liten avfasning).
- Det längsta benet är KATODEN — och det sitter som ANDRA benet 
  från den platta sidan.
- Ordning från platta sidan: RÖD, KATOD, GRÖN, BLÅ.
- Katoden går till GND. De tre andra går via 220 Ω-resistorer till varsin 
  PWM-pinne (märkta med `~` på Arduinon — pin 3, 5, 6, 9, 10, 11)."

Detta kallas "Common Cathode" — motsatsen till common anode-RGB, där 
PLUS är gemensamt istället. Om du kopplar den som en common anode 
funkar den inte.

REFERENS: kompendiet Modul 2, sektion "RGB-LED:ens pinout".
-->

---
layout: default
class: "!p-0"
---

<WiringSlide
  eyebrow="Modul 2 · Koppling · RGB LED"
  title="Koppla RGB-LED:en."
  img="/images/wiring/rgb-fritzing.png"
  caption='<span class="text-red-400">R → D6</span> · <span class="text-green-400">G → D5</span> · <span class="text-blue-400">B → D3</span> · katod → GND · varje färg via egen <span class="mono cyan">220 Ω</span>. <br/><span class="opacity-70">Gör detta först: dra en kabel från Arduinons GND till <span class="mono cyan">minus-skenan</span> på breadboarden. Då har alla komponenter en minus-väg.</span>'
/>

<!--
Stanna på denna bild medan deltagarna kopplar. Fritzing-vy av 
RGB-kopplingen.

[GÖR DETTA FÖRST — repetition från Modul 1 breadboard-anatomin]:
Dra EN kabel från Arduinons GND till minus-skenan (blå linje) på 
breadboarden. Från nu av går allt minus dit. Tre GND-pinnar på 
Arduinon räcker inte när man kopplar mer än en komponent — power 
rails löser det.

PIN-VARNING — deltagarna kommer blanda ihop det:
Den RGB-LED som kommer i kittet är en COMMON CATHODE. Det längsta 
benet är katoden — den ska till GND, INTE till +5 V. De tre andra benen 
är R, G, B.

Matcha pins exakt mot kod-mallen som används i Modul 5 (hackathon):
  R = D6, G = D5, B = D3
Då kan deltagarna återanvända samma koppling rakt av i slutbygget.

Varje färgben får en egen 220 Ω seriemotstånd — skyddar LED-chippet 
och jämnar ut ljusstyrkan mellan de tre färgerna.

Säg:
"Titta på den längsta tråden på LED:en. Det är katoden — minus. 
Den ska till GND. De andra tre går via resistorer till pin 6, 5 
respektive 3. Tre utgångar, tre färger, en GND. Det är allt."
-->

---
layout: default
class: px-14 pt-12
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Nytt kommando · mellan av och på
</div>

# `analogWrite`.

<div class="mt-6 text-2xl space-y-4">

`digitalWrite` kunde bara två saker: <span class="mono cyan">HIGH</span> eller <span class="mono cyan">LOW</span>.

`analogWrite` tar ett tal från <span class="mono cyan">0</span> till <span class="mono cyan">255</span>. Allt däremellan = <span class="cyan">PWM</span>.

</div>

<div class="big-code mt-6">

```cpp
const int ledR = 6, ledG = 5, ledB = 3;

analogWrite(ledR, 200);  // röd  hög
analogWrite(ledG,   0);  // grön av
analogWrite(ledB, 200);  // blå  hög  → lila
```

</div>

<!--
Efter att de har kopplat RGB-LED:en — visa detta. Discovery learning: 
de såg precis PWM i kretsen, nu förklarar vi vad det är.

PWM-PINNAR (säg muntligt, finns i kompendiet § PWM och duty cycle):
  Bara pinnar märkta ~ (3, 5, 6, 9, 10, 11) stödjer analogWrite.
  Full sketch finns också där.

SÄG:
"Ett nytt kommando: analogWrite. Det enda som skiljer från digitalWrite 
är att det tar ett tal — mellan 0 och 255 — istället för bara HIGH/LOW. 
0 är helt av. 255 är helt på. 128 är halvstyrka.

Men Arduinon kan inte GÖRA halvstyrka på riktigt. Den fuskar: den 
blinkar pinnen jättesnabbt, kanske 500 gånger i sekunden, med kortare 
eller längre PÅ-tider. Ögat hinner inte med, så det ser ut som olika 
ljusstyrka. Det heter PWM — Pulse Width Modulation."

Full sketch (setup + loop med de tre analogWrite-raderna) ligger i 
kompendiet. Behövs inte på sliden. Visa bara essensen: de tre raderna 
som faktiskt skapar färgen.

INTERAKTIVT:
Bygg in rubriker av röd (255,0,0), grön (0,255,0), blå (0,0,255) live 
på projektorn. Låt dem kopiera.
-->

---
layout: default
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  PWM
</div>

# Duty cycle.

<div class="grid grid-cols-[1fr_auto] gap-12 mt-6 items-center">

<div class="text-2xl space-y-4">
  <div><span class="mono cyan">0</span> → alltid LOW → släckt</div>
  <div><span class="mono cyan">128</span> → 50 % PÅ-tid → halvstyrka</div>
  <div><span class="mono cyan">255</span> → alltid HIGH → full styrka</div>
</div>

<img src="/images/pwm-waveform.png" class="h-[34rem]" />

</div>

<!--
Grafen visar PWM-vågformen vid olika duty cycles. 
Arduinons PWM-frekvens är ~490 Hz på de flesta pinnar (980 Hz på 5/6).
Ögat hinner inte med så det ser ut som olika ljusstyrka.
Finns i kompendiet § PWM och duty cycle.
-->

---
layout: default
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Övning
</div>

# Hitta färgen.

<div class="mt-8 grid grid-cols-[1.2fr_1fr] gap-10">

<div class="text-lg space-y-4">

Experimentera med värden <span class="mono cyan">0–255</span> på varje kanal. Ladda upp, titta, justera.

<div class="space-y-2 text-base">
<div>· <span class="color-chip" style="--bg:#b400dc;--fg:#fff">Lila</span> — röd + blå, ingen grön</div>
<div>· <span class="color-chip" style="--bg:#ff8cb4;--fg:#000">Gammelrosa</span> — mycket röd, lagom blå, lite grön</div>
<div>· <span class="color-chip" style="--bg:#ffd400;--fg:#000">Skolgul</span> — full röd, lagom grön, ingen blå</div>
<div>· <span class="color-chip" style="--bg:#00e0ff;--fg:#000">Cyan</span> — ingen röd, full grön + blå</div>
</div>

<div class="tip-box mt-5">
  <div class="tip-title">Strategi</div>
  <div>Prova flera kombinationer — färgerna är ofta överraskande.</div>
</div>

</div>

<div class="flex items-center justify-center">
  <div class="grid grid-cols-2 gap-3">
    <div class="w-28 h-28 rounded-2xl" style="background:#b400dc"></div>
    <div class="w-28 h-28 rounded-2xl" style="background:#ff8cb4"></div>
    <div class="w-28 h-28 rounded-2xl" style="background:#ffd400"></div>
    <div class="w-28 h-28 rounded-2xl" style="background:#00e0ff"></div>
  </div>
</div>

</div>

<!--
Detta ÄR lektionen. Minst 15 minuter, helst 20. Låt dem bara leka.

SÄG:
"Nu är det er tur. Ni har tre kanaler — röd, grön, blå — och varje 
kanal tar ett tal mellan 0 och 255. Era uppgifter: försök hitta lila, 
gammelrosa, skolgul, cyan. Och sen — vad för en färg som helst ni 
gillar."

PEDAGOGISK POÄNG:
Experimentet lär dem att PWM-värden INTE är linjära mot vad ögat 
uppfattar. 128 är inte "hälften så ljust" — det är mycket ljusare. Och 
färgerna de får är ofta överraskande (lite röd + mycket blå ≠ vad de 
förväntar). Låt dem upptäcka det.

KAMRATSPRIDNING:
När någon hittar en spännande färg sprider den sig naturligt — 
"hur fick du DEN färgen?" är en självgående fråga. Kunskapen flyttar 
sig från LED till LED utan central styrning.

OM NÅGON ÄR KLAR PÅ 5 MIN:
Utmaning: "Kan du få den att LÅNGSAMT glida från rött till blått?" 
Det kräver en for-loop — inte obligatoriskt, men en bra teaser för 
dem som vill djupare. Lösning finns i kompendiets Modul 2 som 
hemma-övning 3 ("Långsam övergång").
-->

---
layout: center
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-4">
  Efter träff 2
</div>

# Ni har en pixel.

<div class="mt-10 flex justify-center items-center gap-6">
  <div class="rgb-circle rgb-red"></div>
  <div class="rgb-circle rgb-green"></div>
  <div class="rgb-circle rgb-blue"></div>
</div>

<div class="mt-10 text-xl opacity-80 max-w-3xl mx-auto">
  Ni kan blanda <span class="cyan">alla färger</span> ur tre kanaler, och ni har lärt Arduinon att leverera något <em>mellan</em> helt av och helt på.
</div>

<div class="mt-12 text-base opacity-60 italic">
  Nästa gång: vi <span class="cyan">läser av världen och svarar</span>. Knapp + buzzer.
</div>

<!--
Avsluta Modul 2 här. Samma tonläge som Modul 1-avslutningen: kort, 
berömmande, lockande teaser.

SÄG:
"Bra jobbat. Ni kan nu blanda färger. Ni har skrivit kod som styr HUR 
MYCKET ström en pinne ger ifrån sig, inte bara OM. Det är ett stort 
kliv.

Nästa gång ska vi göra det motsatta: lyssna på världen. Ni får en 
knapp — Arduinons första sensor. Och en buzzer, så att den kan 
säga ifrån. Vi ses."

PRAKTISKT INNAN DE GÅR:
- Be dem experimentera hemma om de vill — RGB-LED:en och tre 
  motstånd kan sitta i breadboarden till nästa gång.
- Påminn att kittet är deras.
- Tipsa om hemma-övning 3 ("Långsam övergång") i kompendiet 
  (Modul 2) för dem som vill mer.
-->

---
layout: section
class: section text-center
---

<div class="font-mono text-sm tracking-widest uppercase opacity-60 mb-4">
  Träff 3 av 5
</div>

# Digital input

<div class="text-2xl mt-6 opacity-80 font-light">
  Modul 3: <span class="cyan font-bold">Knapp, buzzer, logik</span>
</div>

<!--
Träff 3.

Hittills har Arduinon bara OUTPUT:at — skickat ström till LED:ar.

Idag: INPUT. Knappen läser av världen (input). Buzzern gör ljud (output). Idag har vi båda.

Nytt kommando idag: `digitalRead()` för att läsa en knapp. Och `pinMode(x, INPUT_PULLUP)` för den smarta vägen.
-->

---
layout: default
class: px-14 pt-10
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Namngivna värden
</div>

# `const int` och `int`.

<div class="grid grid-cols-2 gap-10 mt-6">

<div class="text-base space-y-4">

Ni har redan använt `const int` — för pin-nummer.

Nu behöver ni också `int` (utan <span class="mono">const</span>) — för värden som **ska kunna ändras under tiden programmet kör**: räknare, tillstånd, sensormätningar.

<div class="tip-box mt-4">
  <div class="tip-title">Tumregel</div>
  <div><span class="mono cyan">const int</span> = sätts en gång, aldrig mer. <br/><span class="mono cyan">int</span> = kan ändras. <br/><span class="mono cyan">bool</span> = sant eller falskt.</div>
</div>

</div>

<div>

```cpp
const int knappPin = 9;    // ändras aldrig
int lastState = HIGH;      // kan ändras
bool larmPaslaget = false; // kan togglas
```

<div class="mt-4 text-xs opacity-55 italic">
  Full förklaring av datatyper, scope och operatorer i kompendiets Bilaga A.
</div>

</div>

</div>

<!--
Denna slide introducerar variabler som kan ändras — fundamentet för 
all logik vi ska skriva resten av kursen.

SÄG:
"Hittills har ni använt const int för pin-nummer. De ändras aldrig — 
pin 6 är pin 6 hela tiden. Men idag kommer ni behöva värden som KAN 
ändras. Till exempel: är larmet på? Vad var knappens förra läge? 
Det är vanliga int (utan const). Och för ja/nej-värden finns bool — 
sant eller falskt."

EXEMPEL live i IDE:n:
  int count = 0;
  count = count + 1;  // eller count++;
Visa att värdet faktiskt ändras mellan loop-varven.

OM NÅGON FRÅGAR om knappPin = 9 och PWM-pinnarna (3, 5, 6, 9, 10, 11):
Pin 9 stöder PWM, men vi använder den här digitalt för knappen. Det är 
helt OK — pin-val för digitala inputs är fritt. PWM-stödet ligger bara 
där oanvänt när vi digitalRead på den.

VIKTIG SUBTILITET (för den som frågar):
Global variabel vs lokal variabel. Det tar vi i kompendiet. På sliden 
håller vi det enkelt: "deklarera högst upp, utanför setup(), så går 
det bra".
-->

---
layout: statement
class: text-center
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-6">
  Digital input
</div>

# Input &ne; Output.

<div class="text-xl mt-6 opacity-75 max-w-3xl mx-auto">
  Hittills har Arduinon bara <span class="opacity-60">skickat</span> ström ut (OUTPUT).<br/>
  Nu läser den av ett tillstånd <span class="cyan">in</span> (INPUT).
</div>

<div class="max-w-3xl mx-auto text-left mt-6">

```cpp {all}
pinMode(knappPin, INPUT_PULLUP);
// digitalRead(knappPin):
//   LOW = tryckt, HIGH = släppt
```

</div>

<div class="tip-box mt-5 max-w-2xl mx-auto text-left">
  <div class="tip-title">Varför pullup?</div>
  <div>En pinne som bara "lyssnar" utan koppling till plus eller minus <em>flyter</em> — läsningen blir slumpmässig. <span class="mono cyan">INPUT_PULLUP</span> låter Arduinon själv dra pinnen till HIGH. När du trycker dras den till GND (LOW). Därför: <strong>tryckt = LOW</strong>, släppt = HIGH.</div>
</div>

<!--
TEORI:
"Fram till nu har Arduinon bara SKICKAT ström — OUTPUT. Nu ska den 
LYSSNA — INPUT. Och den första sensorn vi kopplar in: en knapp."

Visa `pinMode(pin, INPUT_PULLUP);` live i IDE:n.

Förklara hur INPUT_PULLUP fungerar:
"Normalt när ni ansluter en knapp behöver ni en 'pullup-resistor' 
(eller en pulldown, beroende på koppling) för att knappen ska fungera 
stabilt. INPUT_PULLUP gör att Arduinon bygger in en pullup inuti sig 
själv — samma funktion, ingen extern komponent. En rad kod — och det 
bara funkar."

INVERTERAD LOGIK VARNING:
"En liten trollering: med INPUT_PULLUP blir logiken BAKLÄNGES. 
- Tryckt knapp = 0
- Släppt knapp = 1
Varför? För att pullup:en drar pinnen till HIGH (1) när inget händer. 
När du trycker, dras den till GND (0)."

UPPGIFT:
Få knappen att styra den inbyggda lampan (pin 13):
- Tryck = lampan tänds
- Släpp = lampan släcks
-->

---
layout: two-cols-header
class: px-12
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Fatta beslut
</div>

# `if` / `else`.

::left::

<div class="mt-4 text-base space-y-4">

Läs ett värde → jämför → agera olika beroende på resultatet.

Operatorerna: <span class="mono cyan">==</span> lika, <span class="mono cyan">!=</span> olika, <span class="mono cyan">&lt;</span> mindre, <span class="mono cyan">&gt;</span> större.

<div class="tip-box mt-4">
  <div class="tip-title">Vanligaste nybörjarfelet</div>
  <div><span class="mono">=</span> tilldelar värde. <br/><span class="mono cyan">==</span> jämför. <br/>Glöm inte andra likhetstecknet.</div>
</div>

</div>

::right::

```cpp
if (digitalRead(knappPin) == LOW) {
  // knappen är tryckt
  digitalWrite(LED_BUILTIN, HIGH);
} else {
  // släppt
  digitalWrite(LED_BUILTIN, LOW);
}
```

<div class="mt-4 text-xs opacity-55 italic">
  Fler operatorer (<span class="mono">&&</span>, <span class="mono">||</span>, <span class="mono">!</span>) <br/>
  och kedjade if/else i kompendiets Bilaga A.
</div>

<!--
Detta är den första "riktiga" logik-sliden. Håll tempot.

SÄG:
"Hittills har era program bara kört rakt fram, rad för rad. Nu lägger 
vi till något nytt: att programmet fattar olika beslut beroende på 
vad som händer. Det heter if/else.

Läs det högt: 'OM digitalRead på knappPin är lika med LOW, gör det 
här. ANNARS, gör det där.' Två vägar. Koden väljer en varje varv i 
loop."

POÄNG OM JÄMFÖRELSE VS TILLDELNING:
"Observera — två likhetstecken för att jämföra. Ett likhetstecken 
betyder 'sätt värdet till'. Det är den vanligaste buggen i nybörjar-
kod: att skriva `if (x = 5)` när man menar `if (x == 5)`. Titta 
efter det när ni felsöker."

Peka på att LED_BUILTIN är Arduinons eget namn på pin 13. Det är 
samma sak som `const int ledPin = 13;`, fast redan definierad av 
Arduino-biblioteket med `#define` — vi såg det i Modul 1.
-->

---
layout: default
class: "!p-0"
---

<WiringSlide
  eyebrow="Modul 3 · Koppling · Knapp"
  title="Koppla knappen."
  img="/images/wiring/button-fritzing.png"
  caption='Vi använder bara <span class="mono cyan">knapp A → D9</span> · andra benet till GND. Ingen pulldown-resistor — <span class="mono cyan">INPUT_PULLUP</span> sköter det internt.'
/>

<!--
Enkel koppling: knapp A → D9 + GND. Inga pulldown-resistorer — 
pinMode(knappPin, INPUT_PULLUP) gör jobbet internt. Som output 
använder vi Arduinons inbyggda LED (LED_BUILTIN på pin 13).

Peka på knappen i bilden och säg:
"Titta på mitten av brädan. Knappen är bara två ben som kortsluter när 
ni trycker. Ena benet går till pin 9, andra till GND. Det är hela 
kopplingen. Pulldown-resistorn sitter inuti Arduinon."

Tryckta knappar är stökiga. Ta med i åtanke att deltagarna kan få 
studsig input om ni tar upp debounce i Modul 5.
-->

---
layout: two-cols-header
class: px-12 pt-10
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Pedagogiskt kritisk
</div>

# Reagera på flanken.

::left::

<div class="mt-4 text-base space-y-3">

En knapp som **hålls nere** skulle toggla hundratals gånger per sekund. Resultat: larmet blinkar mellan av/på som ett stroboskop.

Lösningen: agera inte på att knappen *är* nere. Agera på att den **just nu gick från HIGH till LOW** — flanken.

<div class="tip-box mt-4">
  <div class="tip-title">Mönstret</div>
  <div>Spara förra värdet. Jämför med nuvarande. Om det ändrats åt rätt håll → det är en flank → agera en gång.</div>
</div>

Inbyggda LED:en (pin 13) speglar `larmPaslaget` — så ni *ser* när larmet växlar.

</div>

::right::

```cpp
bool larmPaslaget = false;
int lastState = HIGH;

void loop() {
  int state = digitalRead(knappPin);
  if (state == LOW && lastState == HIGH) {
    larmPaslaget = !larmPaslaget;       // flank → toggla
  }
  digitalWrite(LED_BUILTIN, larmPaslaget ? HIGH : LOW);
  lastState = state;
  delay(10);  // mot studs
}
```

<!--
Detta är den viktigaste nya sliden i Modul 3. Utan edge-detection 
havererar hackathonens larm-toggling — man trycker en gång och 
larmet flimrar för att knappen hålls nere över flera loop-varv.

SÄG (sakta, visa):
"Här kommer en liten fälla. Ni vill att en knapptryckning ska slå 
om larmet — av eller på. Så ni skriver:

  if (digitalRead(knappPin) == LOW) {
    larmPaslaget = !larmPaslaget;
  }

Ser bra ut. Men: med `delay(10)` kör loopen ca hundra varv per sekund, 
och en knapptryckning varar flera tiotals loop-varv. Ni släpper — 
men var larmet av eller på? Slumpmässigt.

Lösningen: spara förra värdet. Jämför. Agera bara i det ÖGONBLICK 
då värdet ändras. Det kallas en flank — från digital elektronik."

NOT UPPREPA:
`!larmPaslaget` — utropstecken = logisk inversion. Om larmPaslaget 
var false blir det true och tvärtom. Koncept: 'det motsatta'.

`delay(10)` är en enkel debounce — knappen studsar fysiskt några 
millisekunder, delay gör att loopen läser av efter att studsen lagt 
sig. Ofullständigt men räcker för kursen.

LED_BUILTIN-VISUALISERING:
Sista raden i loopen — `digitalWrite(LED_BUILTIN, larmPaslaget ? HIGH : LOW);` 
— gör att Arduinons inbyggda LED (pin 13) lyser när larmet är på och 
slocknar när det är av. Utan den här raden ser eleverna inte att 
edge-detection faktiskt fungerar; togglandet sker tyst i en bool. 
Med den ser de larmet växla i realtid.

`larmPaslaget ? HIGH : LOW` är en kort if/else (ternär): "om 
larmPaslaget är true, skriv HIGH, annars LOW". Läs den högt så 
för eleverna första gången.

Setup() behöver två pinModes:
  pinMode(knappPin, INPUT_PULLUP);
  pinMode(LED_BUILTIN, OUTPUT);

På sliden "Kärnan i `loop()`" byter vi `LED_BUILTIN` mot `buzzerPin` 
— då hör de larmet istället för att se det. Samma mönster, ny utgång.

Kort debounce-diskussion i kompendiet, Modul 3 kapitel (avsnitt "Edge-detection").
-->

---
layout: default
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Active buzzer
</div>

# En varning först.

<div class="flex gap-12 mt-8 items-center justify-center">

<div class="max-w-xl">

<div class="warn-box" style="padding:28px">
  <div class="warn-title" style="font-size:26px"><span class="i-carbon-warning inline-block align-[-0.15em] mr-1"></span>Extremt viktigt</div>
  <div style="font-size:30px;line-height:1.5;margin-top:16px">
    <strong>Dra absolut inte av</strong> den lilla klisterlappen<br/>
    <span class="mono opacity-80">"REMOVE SEAL AFTER WASHING"</span><br/>
    på er buzzer.
  </div>
</div>

<div style="margin-top:32px;font-size:26px;opacity:0.9">
  Utan lappen är buzzern <span class="danger">obehagligt högljudd</span>. 
  Lappen är vår ljuddämpare — den stannar på.
</div>

</div>

<img src="/images/active-buzzer-sticker.jpg" class="max-h-[32rem] rounded-xl ring-2 ring-[color-mix(in_srgb,var(--ak-danger)_50%,transparent)] shadow-md" />

</div>

<!--
[VÄLDIGT VIKTIGT — säg på skarpen]:
"Titta på era buzzrar. Ser ni den lilla vita klisterlappen ovanpå där det 
står 'REMOVE SEAL AFTER WASHING'? DRA INTE AV DEN.

Den där lappen är en fabriksdämpare från tillverkningsprocessen. Tekniskt 
sett funkar buzzern utan — men den blir ENORMT mycket högre. Jag lovar: 
era öron kommer inte tacka er. Lappen stannar på."

(Detta är ett skämt som är på fullaste allvar. Buzzern ÄR obehagligt hög 
utan dämparen. Och ja — sticker:en är bara limmad över ovansidan; den 
skyddar inte mot vatten som texten antyder.)

KOD — VIKTIGT om buzzer-typ:
Kittet har en ACTIVE buzzer (med inbyggd oscillator). Det betyder:
  digitalWrite(buzzerPin, HIGH);  // → pip
  digitalWrite(buzzerPin, LOW);   // → tyst
Du behöver INTE `tone()`. Faktum är att `tone()` fungerar på en active 
buzzer men är onödigt komplicerat. Håll det enkelt.

UPPGIFT:
Koppla in buzzern enligt kompendiets Modul 3.
  - Buzzerns lång ben / + (markerat med +) → pin 12
  - Buzzerns kort ben → GND
(Använd F-M DuPont-kablarna — buzzern pluggas direkt i Arduino-headers, 
inte breadboarden.)

Kod: först en kopplingstest med enkel If/Else (NOT larm-mönstret — 
det kommer på sliden "Kärnan i `loop()`" med flank-detektion). Det 
här bekräftar bara att buzzern är kopplad rätt.
  const int buzzerPin = 12;   // buzzer
  const int knappPin  = 9;    // knapp A

  void setup() {
    pinMode(knappPin, INPUT_PULLUP);
    pinMode(buzzerPin, OUTPUT);
  }

  void loop() {
    if (digitalRead(knappPin) == LOW) {  // LOW = tryckt med INPUT_PULLUP
      digitalWrite(buzzerPin, HIGH);
    } else {
      digitalWrite(buzzerPin, LOW);
    }
  }
Knappen ner = pip, släpp = tyst. När det fungerar, gå vidare till 
sliden "Kärnan i `loop()`" där vi ersätter den enkla If/Else med 
flank-mönstret från "Reagera på flanken" så att buzzern *togglar* 
istället för att hållas nere.

TEASER:
"Nu kan Arduinon läsa digital input. Nästa träff lägger vi till 
analoga sensorer och Serial Monitor för felsökning."
-->

---
layout: default
class: "!p-0"
---

<WiringSlide
  eyebrow="Modul 3 · Koppling · Buzzer"
  title="Koppla buzzern."
  img="/images/wiring/buzzer-fritzing.png"
  caption='Långt ben (<span class="warn">+</span>) → <span class="mono cyan">D12</span> · kort ben → <span class="mono cyan">GND</span>. Rakt in i Arduino-headerna. Ingen breadboard, ingen resistor.'
/>

<!--
Buzzer-kopplingen.

Active buzzer är plug-and-play: plusbenet (långt, markerat +) till 
pin 12, minusbenet till GND. Ingen resistor behövs — buzzern har 
inbyggd oscillator.

Säg:
"Två kablar. Pluggen sitter rakt i Arduinon. Ingen breadboard. 
digitalWrite(buzzerPin, HIGH) = ljud. digitalWrite(buzzerPin, LOW) = 
tyst. Det är hela grejen."

-->

---
layout: center
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Sätt ihop allt
</div>

# Läs knapp. Styr buzzer.

<div class="mt-16 text-3xl max-w-3xl mx-auto">
  Tryck → larm på (buzzern tjuter).<br/>
  Tryck igen → tyst.
</div>

<div class="mt-16 text-2xl font-mono opacity-80">
  INPUT  →  <span class="cyan">flank</span>  →  OUTPUT
</div>

<!--
REFERENSLISTA (säg muntligt om behov finns):
  · pinMode(knappPin, INPUT_PULLUP) från förra sliden
  · pinMode(buzzerPin, OUTPUT) — nytt idag
  · flank-mönstret från "Reagera på flanken"-sliden (state, lastState, larmPaslaget)
  · digitalRead läser, digitalWrite styr

Detta är Modul 3:s höjdpunkt på slides. Visa sketchen live i IDE:n 
efter sliden — men på sliden själv visar vi bara kärnan ("Kärnan i `loop()`"-sliden).

SÄG:
"Nu sätter vi ihop de två sakerna ni lärt er idag. På 'Reagera på 
flanken'-sliden togglade ni en LED med flank-detektion — tryck en 
gång, lampan tänds. Tryck igen, släcks. Nu byter vi LED:en mot 
buzzern. Exakt samma mönster — bara en utgång till. Tryck en gång 
→ larmet är på och tjuter. Tryck igen → tyst.

Det är det första programmet som faktiskt har en 'sense-act'-loop med 
*minne* — Arduinon kommer ihåg om larmet är på eller av mellan 
loop-varven. Det är det vi gör resten av kursen."

UPPGIFT (live):
Skriv sketchen tillsammans. Jag skriver i IDE:n på projektorn, ni 
skriver parallellt. Ta loopen från "Reagera på flanken"-sliden, byt 
`LED_BUILTIN` mot `buzzerPin`. Ladda upp. Tryck. Det tjuter — och 
stannar på tills ni trycker igen. Vi har byggt vår första reaktiva 
krets med tillstånd.

FALLBACK för grupper som strular med edge-detection:
Den enklaste varianten — knappen tryckt = pip, släppt = tyst — utan 
flank, utan minne:
  if (digitalRead(knappPin) == LOW) digitalWrite(buzzerPin, HIGH);
  else                              digitalWrite(buzzerPin, LOW);
Den fungerar men är inget larm — den behöver att man håller knappen 
nere konstant. Säg det rakt ut: "Det här är inte ett larm, men det 
är ett bra första steg om flank-mönstret krånglar."
-->

---
layout: default
class: px-14 pt-12
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Sätt ihop allt · larm-mönstret
</div>

# Kärnan i `loop()`.

<div class="big-code mt-6">

```cpp
int state = digitalRead(knappPin);
if (state == LOW && lastState == HIGH) {
  larmPaslaget = !larmPaslaget;          // flank → toggla
}
digitalWrite(buzzerPin, larmPaslaget ? HIGH : LOW);
lastState = state;
```

</div>

<div class="mt-10 text-2xl opacity-80 italic">
  Samma mönster som "Reagera på flanken" — <span class="mono">LED_BUILTIN</span> bytt mot
  <span class="mono">buzzerPin</span>. Active buzzer: <span class="mono">HIGH</span> = pip,
  <span class="mono">LOW</span> = tyst.
</div>

<!--
Det HÄR är larm-mönstret som hackathonen i Modul 5 bygger på. 
Skillnaden mot "Reagera på flanken"-sliden: utgången är buzzerPin 
istället för LED_BUILTIN. Allt annat är identiskt — flank-detektion, 
toggle, spegling av tillståndet på en utgång.

Tre rader är värda att peka på:
  1. `if (state == LOW && lastState == HIGH)` — fallande flanken.
     Bara sann i ett enda loop-varv per knapptryck.
  2. `larmPaslaget = !larmPaslaget;` — toggle. ! inverterar bool.
  3. `digitalWrite(buzzerPin, larmPaslaget ? HIGH : LOW);` — speglar 
     tillståndet. ?: är kort if/else: "om larmPaslaget true → HIGH, annars LOW".

UPPGIFT (live): skriv hela sketchen tillsammans i IDE:n. Setup behöver 
`pinMode(knappPin, INPUT_PULLUP);` och `pinMode(buzzerPin, OUTPUT);`. 
Globala variabler högst upp: `bool larmPaslaget = false;` och 
`int lastState = HIGH;`. Ladda upp. Tryck. Det tjuter — och stannar 
på tills ni trycker igen.

VARNING (förvänta er att det händer): När larmet är på tjuter buzzern 
*konstant*. Det är inte trevligt i klassrummet. Demonstrera, låt två 
elever testa, sen toggle av. I hackathonen kombineras larmet med 
tilt-sensorn så det bara tjuter när någon rör vid larmet — inte 
konstant. Bilaga D visar den fullständiga lösningen.

Full sketch (med setup + globala variabler) finns i kompendiet, 
kapitel 3 (§ Edge-detection och § Övning 1) samt Bilaga D.
-->

---
layout: center
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-4">
  Efter träff 3
</div>

# Arduinon lyssnar.

<div class="mt-10 text-xl opacity-80 max-w-3xl mx-auto">
  Ni har byggt Arduinons första <span class="cyan">sensor</span> — en knapp — och gett den en <span class="cyan">röst</span> — buzzern.<br/>
  Arduinon läser den ena — och styr den andra.
</div>

<div class="mt-12 text-base opacity-60 italic">
  Nästa gång: <span class="cyan">analoga sensorer</span>. Mörker, rörelse, mätvärden. Serial Monitor.
</div>

<!--
Avsluta Modul 3 här.

SÄG:
"Ni har Arduinons första sensor — en knapp som läser världen — 
och en röst — en buzzer som svarar. Läsa och reagera. Det är 
grunden för allt inbyggt.

Nästa gång blir världen mer analog. Inte bara tryckt/inte-tryckt, 
utan hur mycket, hur ljust, hur lutat. Ni får sensorer och Serial 
Monitor — ett fönster mot vad Arduinon läser av just nu. Vi ses."
-->

---
layout: section
class: section text-center
---

<div class="font-mono text-sm tracking-widest uppercase opacity-60 mb-4">
  Träff 4 av 5
</div>

# Analog input

<div class="text-2xl mt-6 opacity-80 font-light">
  Modul 4: <span class="cyan font-bold">Sensorer &amp; Serial Monitor</span>
</div>

<!--
Träff 4. Den näst sista.

Hittills har allt input varit DIGITALT — PÅ eller AV, 1 eller 0.

Idag: ANALOGT input. Ett värde mellan 0 och 1023 som berättar 
*hur mycket* ljus, *hur mycket* lutning, *hur mycket* av något.

Och ett nytt verktyg: Serial Monitor — vårt fönster in i Arduinons minne.
-->

---
layout: default
class: px-14 pt-12
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Analog input
</div>

# Knappen var digital. Världen är analog.

<div style="margin-top:48px;display:flex;gap:64px;align-items:center">

  <img src="/images/photoresistors-three.jpg" style="width:720px;height:540px;object-fit:contain;flex-shrink:0;border-radius:20px" />

  <div style="font-size:48px;line-height:1.5">
    <div style="margin-bottom:24px">Knappen: <strong>PÅ eller AV.</strong></div>
    <div>Ljuset: <strong>halvmörkt, starkt, svagt.</strong></div>
    <div style="opacity:0.7;font-size:28px;margin-top:32px"><span class="mono cyan">analogRead(A0)</span> ger 0–1023</div>
  </div>

</div>

<!--
TEORI (slide A):
"Knappen vi jobbade med förra träffen var DIGITAL. Bara två värden: 
PÅ eller AV. 1 eller 0.

Men världen är analog. Ljuset kan vara halvmörkt, starkt, svagt, fullt. 
Vi behöver ett kommando som läser AV något — inte bara PÅ/AV.

Det är det `analogRead()` gör. Den ger oss ett tal mellan 0 och 1023.
- 0 = noll spänning på pinnen
- 1023 = full 5 V
- Allt däremellan = mellanting"

BYGG SPÄNNINGSDELAREN:
"Fotocellen är en resistor som ändrar sitt motstånd baserat på ljus. 
För att läsa det måste vi bygga en 'spänningsdelare' — den delar upp 
5 V mellan fotocellen och en fast 1 kΩ-resistor. Arduinon mäter spänningen 
mellan dem på pin A0.

Koppling:
  5 V → fotocell → pin A0 → 1 kΩ → GND

Starkt ljus → fotocellens motstånd är LÅGT (~500 Ω) → A0 läser HÖGT värde.
Mörker → fotocellens motstånd är HÖGT (~50 kΩ) → A0 läser LÅGT värde."

TILT-SENSORN kommer senare i modulen (egen wiring-slide). Nämn bara 
kort att det finns en andra sensor att kolla in — detaljerna tas då.
"Vi har också en tilt-switch i kittet, men den tittar vi på senare.

Tips: tilt-sensorn 'studsar' — kulan bouncar inuti plåthylsan. För att få 
stabila avläsningar: `delay(50);` efter varje `digitalRead()`."

Tilt-sensorn pluggas också direkt i Arduino-headers (pin + GND) med 
F-M DuPont-kablarna, inte via breadboarden. Vi återkommer till den 
senare — först fotocellen.
-->

---
layout: two-cols-header
class: px-12 pt-10
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Nytt kommando
</div>

# `analogRead()` — Arduinons linjal.

::left::

```cpp
int ljus = analogRead(A0);
```

<div class="mt-8 text-xl space-y-3">
  <div><span class="mono cyan text-2xl">0</span> &nbsp;→&nbsp; 0 V &nbsp;→&nbsp; helt mörkt</div>
  <div><span class="mono cyan text-2xl">1023</span> &nbsp;→&nbsp; 5 V &nbsp;→&nbsp; fullt ljus</div>
  <div class="opacity-70 mt-2">Allt däremellan = mellanting.</div>
</div>

::right::

<div class="tip-box text-xl">
  <div class="tip-title">Gör detta nu</div>
  <div class="mt-2">Bygg <strong>spänningsdelaren</strong>:<br/>fotocell + 1 kΩ → pin <span class="mono cyan">A0</span></div>
</div>

<div class="mt-6 text-sm opacity-70 italic">
Fotocell (LDR): 50 kΩ i mörker · 500 Ω i solljus.<br/>
Starkt ljus → A0 läser högt värde.
</div>

<!--
analogRead() ger ett tal mellan 0 och 1023:
- 0 = noll spänning på pinnen
- 1023 = full 5 V
- Allt däremellan = mellanting

Specdata (finns i kompendiet § Analog vs digital):
  Fotocell (LDR): 50 kΩ i mörker · 500 Ω i solljus
  Starkt ljus → låg resistans → A0 läser HÖGT värde
  Mörker → hög resistans → A0 läser LÅGT värde
-->

---
layout: two-cols-header
class: px-12 pt-10
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Brygga · ett motstånd → två
</div>

# Tänk dig ett <span class="cyan">lååångt</span> motstånd.

::left::

<div style="display:flex;justify-content:center;margin-top:0">
  <img src="/images/long-resistor.png" style="width:780px;max-width:100%" alt="Fyrpanels-diagram: kolfilm med spänningsgradient, ett långt motstånd med tapp, två motstånd brutet med A0, vridpotentiometer i genomskärning" />
</div>

::right::

<div class="mt-4 space-y-5 text-lg leading-relaxed">

Inuti motståndet sitter en **kolfilm** kring en keramisk kärna. Strömmen kämpar sig igenom — och spänningen sjunker **linjärt** längs vägen.

<v-click>

**Två motstånd i serie = samma sak, bara delat i två.** Skarven är mätpunkten. `A0` läser spänningen där.

</v-click>

<v-click>

En **vridpotentiometer** är detta i hårdvara: tre ben, och ratten flyttar wipern längs det inre motståndsspåret. Vrid → `A0` sveper jämnt 0–1023.

</v-click>

</div>

<!--
LIVE-DEMO (om tid och om pot pre-kopplad):

Pre-koppling (gör FÖRE passet — testa att det funkar):
  Pot vänster ben → +5 V
  Pot höger ben → GND
  Pot mittben (wiper) → A0

Sketch (kan vara igång på Arduinon redan):
  void setup()  { Serial.begin(9600); }
  void loop()   { Serial.println(analogRead(A0)); delay(50); }

Öppna Serial Monitor + Serial Plotter (Verktyg → Serial Plotter) — 
plottern är pedagogiskt starkare här, kurvan sveper visuellt.

DEMO-PROTOKOLL (60–90 sekunder):

1. [Vrid ratten åt vänster, hela vägen]
   "Här är wipern i botten. A0 läser noll. Hela motståndsmaterialet 
   ligger ovanför mätpunkten."

2. [Vrid till mitten, peka på siffran]
   "Mittläge — runt 512. Halva motståndet ovanför, halva nedanför. 
   Detta är 2,5 V."

3. [Vrid till topp]
   "Wipern i topp. 1023. Inget motstånd ovanför, allt under. A0 ligger 
   direkt mot 5 V."

4. [Vrid långsamt fram och tillbaka]
   "Det här är en spänningsdelare där wipern flyttas av handen. I er 
   koppling om en stund flyttas wipern istället av LJUSET — fotocellens 
   motstånd ändras med belysningen, och 'wipern' förskjuts i takt med 
   det. Samma fysik, annan styrning."

KOPPLA TILL NÄSTA SLIDE:
"Och det är exakt det vi nu ska bygga med fotocell + 1 kΩ."

OM POT INTE FINNS PRE-KOPPLAD:
Säg ändå hela "wiper = mätpunkt"-resonemanget verbalt och peka på 
bilden. Demon är förstärkning, inte förutsättning.

PEDAGOGISK BAKGRUND:
"Lååångt motstånd"-modellen tillför mekanism-lagret som vatten-metaforen 
i nästa slide saknar: VARFÖR sjunker spänningen? Svar: linjärt fall 
genom resistivt material. Två i serie är inte ett separat fenomen — 
bara samma kontinuum delat på en specifik punkt. Pot:en konkretiserar 
detta som fysisk komponent.

VAR METAFOREN BRYTS (om någon frågar):
- "Längd" är en proxy för "andel av total resistans". En kort tjock 
  resistor och en lång tunn kan ha samma värde. Det som räknas är 
  R-andelen, inte fysiska centimetrar.
- Linjärt fall förutsätter att ström flyter. Tas lasten bort finns 
  inget fall. (För vår A0 räcker det dock — A0 har hög ingångsimpedans.)
-->

---
layout: two-cols-header
class: px-12 pt-10
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Nytt koncept · från motstånd till mätvärde
</div>

# Spänningsdelaren.

::left::

<div class="mt-6 space-y-4">

Tänk dig ett **vattenrör som höjdskala**: `+5 V` är uppe, `GND` är nere. Två motstånd i serie är två rörsegment; skarven mellan dem är en tapp — där mäter `A0`.

- Lika stora → skarven mitt på → `A0 ≈ 2,5 V`.
- Mer motstånd **ovanför** → skarven pressas ner → `A0` **sjunker**.
- Mer motstånd **nedanför** → skarven dras upp → `A0` **stiger**.

*Fotocellen* är det övre motståndet. Mörker → högt → `A0` sjunker. Ljus → lågt → `A0` stiger. <span class="mono cyan">analogRead(A0)</span> ger **0–1023**.

</div>

::right::

<div style="display: flex; justify-content: center">

<img src="/images/voltage-divider.png" style="width: 600px; max-width: 100%" alt="Spänningsdelare-schema: +5V → fotocell → A0 → 1 kΩ → GND med typiska värden" />

</div>

<!--
E3 SPÄNNINGSDELAREN — skriven via codex + gemini konsultation.

SÄG (långsamt, peka på bilden):
"Minns vattenröret från Modul 1? Kran, resistor, utlopp. Idag lägger 
vi in en till ventil. Två strypventiler i rad.

Det som är viktigt att förstå: i en seriekrets är FLÖDET — strömmen 
— exakt lika stort genom båda ventilerna. Det kan inte vara något 
annat; vattnet har ingenstans att ta vägen emellan. Men TRYCKET, 
våra fem volt — de delas upp. Varje ventil äter en del av trycket. 
Hur mycket beror på hur tajta de är i förhållande till varandra."

[Peka på mellanpunkten:]
"Där, precis mellan ventilerna, finns en mätpunkt. Om båda ventilerna 
är lika tajta, ligger trycket där på halva — 2,5 V. Om den övre är 
mycket hårdare, tar den upp större delen av trycket och mätpunkten 
sjunker närmare noll. Om den undre är hårdare — tvärtom."

[Byt ut övre resistorn mot fotocell:]
"Byt nu ut den övre ventilen mot vår fotocell. En resistor som ändras 
med ljuset — hög i mörker, låg i ljus. Då flyttar sig mätpunkten 
ALLTEFTER hur mycket ljus som träffar cellen. Arduinons A0 är vår 
tryckmätare — den läser mellanpunktens spänning och ger oss ett tal 
mellan 0 och 1023."

POÄNG 1 — A0 är en VOLTMETER, inte en resistansmätare:
"Arduinon mäter bara spänning, inte motstånd. Därför MÅSTE det finnas 
en partner-resistor — utan den finns ingen mellanpunkt att mäta på. 
En ensam fotocell ger ingen mätbar mellanpunkt, oavsett hur mycket ni 
trycker A0 mot den."

POÄNG 2 — 10-bits linjal:
"0 till 1023 är 1024 steg. Arduinon delar upp 0–5 V i 1024 bitar. 
Det betyder ungefär 5 millivolt per steg — fin upplösning. Ni kommer 
se att siffrorna 'darrar' lite även när ljuset är stilla — det är 
bruset i den sista biten."

POÄNG 3 — ordningen spelar roll:
"Om ni byter plats på fotocellen och 1 kΩ-resistorn inverteras skalan. 
Då blir MÖRKT ett HÖGT värde. Inget fel i sig, men ni får tänka på 
det i logiken. I vår koppling: fotocell på toppen, 1 kΩ mot GND — 
mörker ger LÅGT värde."

SIFFER-DISCLAIMER:
De typiska värdena (20–100 / 150–400 / 500–700) är ESTIMATES för 
en typisk fotocell (~50 kΩ mörk, ~500 Ω ljus) med 1 kΩ mot GND. 
De varierar mellan exemplar. Poängen är att visa SPANNET, inte 
exakta tal. Kompendiets kapitel 4 har formeln
  V_ut = R_(1 kΩ) / (R_foto + R_(1 kΩ)) · 5 V
och räkneexempel för dem som vill djupdyka.

BRYGGA TILL MODUL 3:
"Ni har sett den här principen förut — `INPUT_PULLUP` i Modul 3 är 
i själva verket en intern pullup-resistor som ger pinnen ett stabilt 
HIGH när knappen är släppt. Skillnaden: där handlar det om två digitala 
lägen (HIGH/LOW). Här bygger vi en riktig spänningsdelare som kan ge en 
mellanspänning vi kan mäta med `analogRead`."

HYSTERES-REFERENS (om någon frågar):
"Om ljuset ligger precis på tröskeln (säg 300) — vad händer när 
värdet darrar 299, 301, 299, 301? Larmet kommer ticka av och på. 
Lösningen kallas hysteres: olika trösklar för av/på. Full 
beskrivning finns i kompendiets Modul 5 och Bilaga D."

REFERENS: kompendiet Modul 4 + Bilaga F (framspänningsfall + 
spänningsdelare, full härledning).
-->

---
layout: default
class: "!p-0"
---

<WiringSlide
  eyebrow="Modul 4 · Koppling · Fotocell"
  title="Koppla fotocellen."
  img="/images/wiring/photocell-schematic.png"
  caption='Spänningsdelare: <span class="mono cyan">5 V → fotocell → A0 → 1 kΩ → GND</span>. Mörker ger lågt värde, ljus ger högt värde.'
/>

<!--
Visa denna bild när deltagarna börjar bygga fotocellskretsen.
Peka på spänningsdelaren: "två resistorer i serie från 5 V till GND, 
och vi mäter mitten med A0". Fotocellen är den övre resistorn, 
1 kΩ den undre.

Fullständig härledning av spänningsdelar-formeln i kompendiet 
Bilaga F.
-->

---
layout: default
class: "!p-0"
---

<WiringSlide
  eyebrow="Modul 4 · Koppling · Tilt-sensor"
  title="Koppla tilt-sensorn."
  img="/images/wiring/tilt-photo.png"
  caption='Rakt in i Arduino-headerna med <span class="mono cyan">långa kablar</span> så du kan vicka på sensorn: <span class="mono cyan">ena benet → D2, andra benet → GND</span>. Kräver ingen breadboard. <span class="opacity-70">Digital sensor — öppen/sluten, precis som en knapp. Läses med <span class="mono">digitalRead</span>, inte <span class="mono">analogRead</span>. Tinkercad har ingen tilt-modell, så den ritas som en cylinder — i verkligheten är det en liten metallburk.</span>'
/>

<!--
Tilt-sensorn kopplas INTE via breadboarden. Den sticks rakt in i 
Arduinons headers med två F-M DuPont-kablar (hon-till-han).

Säg:
"Det är bara en kontakt. Ena benet till pin D2, andra benet till GND. 
När ni lutar den rullar en liten metallkula inuti och kortsluter de 
två benen — precis som en knapp, fast styrd av gravitation."

INPUT_PULLUP så får ni LOW = lutad, HIGH = upprätt. Debounce med 
delay(50) efter läsning för att undvika studs.
-->

---
layout: two-cols
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Felsökning
</div>

# Serial Monitor.

<div class="text-lg opacity-85 mt-6">

Hur ser vi vilka värden Arduinon <span class="cyan">läser</span>?

Vi låter den skriva ut dem till datorn över <span class="cyan">USB</span>.

</div>

<div class="mt-6 text-sm opacity-60">
  Öppna <span class="mono cyan">förstoringsglaset</span> uppe till höger i Arduino IDE.
</div>

::right::

<div class="h-full flex items-center justify-center">

```cpp
void setup() {
  Serial.begin(9600);
  // analoga pinnar är INPUT som default —
  // följande är onödigt men inte fel:
  // pinMode(A0, INPUT);
}

void loop() {
  int ljus = analogRead(A0);
  Serial.println(ljus);
  delay(100);
}
```

</div>

<!--
TEORI:
"Hur vet vi vad Arduinon ser? Hur vet vi om 'mörker' är 50 eller 400 
eller 800 på Arduinons skala? Vi måste få den att skriva ut sina mätvärden 
till datorn så vi kan läsa dem."

Det verktyget heter SERIAL MONITOR.

[GÖR DETTA NU]:
1. Visa var förstoringsglaset sitter i IDE:n (uppe till höger).
2. Klicka → en ny ruta öppnas → där kommer siffror rulla.
3. Lägg till `Serial.begin(9600);` i setup().
4. Lägg till `Serial.println(ljus);` i loopen.
5. Uppladda.

NYCKELMOMENT:
"Håll handen över fotocellen och titta på siffrorna — de ändras i realtid. 
Detta är ert fönster in i vad Arduinon faktiskt mäter."

Detta är första gången i klassrummet som kursen verkligen öppnar dörren för felsökning. 
Serial Monitor är det enda sättet att förstå vad en Arduino 'tänker' 
när något går fel. Det är deras viktigaste verktyg framöver.

TEASER:
"Ni har nu alla byggstenar. Nästa vecka... HACKATHON. 
Vi sätter ihop allt till tjuvlarmet. Kom hungriga."
-->

---
layout: two-cols-header
class: px-12 pt-10
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Felsökning · variant
</div>

# Serial Plotter.

::left::

<div class="mt-4 space-y-5 text-lg leading-relaxed">

Samma <span class="mono cyan">Serial.println(...)</span>-data — men ritad som **rörlig kurva** istället för rader av siffror.

<v-click>

Håll handen över fotocellen → **linjen dippar**. Vrid potentiometern → **linjen sveper**. Signalen blir synlig.

</v-click>

<v-click>

<div class="tip-box mt-2">
  <div class="tip-title">Öppna</div>
  <div class="mt-1"><span class="mono cyan">Verktyg → Serial Plotter</span></div>
</div>

</v-click>

<v-click>

**Plotter** = se signalen. **Monitor** = läsa exakta tal + statusmeddelanden (<span class="mono">"LARM!"</span>).

</v-click>

</div>

::right::

<div class="mt-2 flex justify-center">
  <img src="/images/serial-plotter.png" style="width:580px;max-width:100%" alt="Serial Plotter visar fotocell-värdet som rörlig kurva — kurvan ligger högt vid rumsljus, dippar skarpt när handen täcker cellen, stiger tillbaka när handen tas bort" />
</div>

<!--
SERIAL PLOTTER — varför det är värdefullt här:

Modul 4:s kärnpåstående är "knappen var digital, världen är analog". 
Plotter gör analog-konceptet bokstavligt synligt — en rullande kurva 
som dippar och toppar med ljuset. Inget annat verktyg i kursen visar 
analoga signaler så viscerellt.

GÖR DETTA NU (om Serial Monitor redan körs och deltagarna är med):
1. Verktyg → Serial Plotter (eller Tools → Serial Plotter på engelsk IDE)
2. En ny ruta öppnas med en rullande linjegraf
3. Håll handen över fotocellen — kurvan dippar
4. Ta bort handen — kurvan stiger
5. Lys med ficklampa — kurvan toppar mot 1023

VIKTIGT: Plotter och Monitor kan inte vara öppna SAMTIDIGT i samma 
session — endast en lyssnar på serial-porten åt gången. Stäng den 
ena innan du öppnar den andra.

NÄR PLOTTER vs MONITOR:
- Plotter: utforska sensorbeteende, se trender, visualisera pot/wiper-svep
- Monitor: läsa exakta värden för tröskel-kalibrering, skriva 
  statusmeddelanden ('LARM!', 'tröskel nådd'), debug if/else-flöde

Plotter rendrar bara TAL. Om du blandar text och tal — t.ex. 
Serial.print("ljus="); Serial.println(ljus); — får du parse-fel i 
Plotter. Använd Monitor för det fallet.

MULTI-SERIES (för den nyfikne):
Modern IDE stödjer flera samtidiga linjer: 
  Serial.print(ljus); Serial.print(' '); Serial.println(tilt);
ger två separata kurvor i samma plot, automatiskt färgkodade.

KOPPLA TILL POT-DEMON (slide 41):
Om du körde pot-demon med Plotter där: deltagarna har redan sett 
detta verktyg. Här bekräftar vi bara att samma sak fungerar för 
fotocellen.
-->

---
layout: default
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Fri övning
</div>

# Hitta din tröskel.

<div class="mt-10 text-2xl max-w-5xl">

Printa **både** ljus och tilt till Serial Monitor. Jämför siffrorna mot omgivningen.

</div>

<ul class="mt-8 text-2xl space-y-4 max-w-5xl">
<li>Täck fotocellen — vilket värde?</li>
<li>Lys på den — vilket värde?</li>
<li>Luta tilt-sensorn — ser du <span class="mono">HIGH → LOW</span>?</li>
</ul>

<!--
Detta är en LEK-slide, inte en teori-slide. Låt dem bara hålla 
fotocellen i olika belysning, luta tilten, och titta på siffrorna 
som ramlar ner i Serial Monitor.

TIPS att säga muntligt (finns i kompendiet § Typiska A0-värden):
  "Börja vid 300 som riktvärde och testa — höj eller sänk tills 
  larmet reagerar lagom i rumsmörker. Det numret används som 
  morkTroskel i Modul 5."

SÄG:
"Innan vi bygger larmet nästa vecka: lär känna era egna siffror. 
Vilket tal ska vi kalla 'mörkt'? Det beror på rummet ni sitter i. 
Därför måste ni hitta ERT värde. Täck fotocellen med handen, titta 
på siffran. Lyft undan, titta igen. Notera siffran där ni tycker 
'här tänds stämningsljuset'."

POÄNG:
Detta etablerar att sensor-trösklar är en kalibrering man gör på 
plats, inte ett förinställt tal från tillverkaren. Grunden för all 
embedded-utveckling.

OM NÅGON FRÅGAR om tilt-sensorns siffror: 
"Tilten är digital — ni får antingen 1 (HIGH, upprätt) eller 0 
(LOW, lutad med INPUT_PULLUP). Ingen mellannivå. Det är som 
knappen, bara med gravitation som trigger."
-->

---
layout: default
class: px-14 pt-12
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Fri övning · koden
</div>

# Koden att köra.

<div class="mt-4">

```cpp
const int ldrPin  = A0;
const int tiltPin = 2;

void setup() {
  Serial.begin(9600);
  pinMode(tiltPin, INPUT_PULLUP);   // tilten kopplas som knappen
}

void loop() {
  int ljus = analogRead(ldrPin);
  int tilt = digitalRead(tiltPin);
  Serial.print("ljus=");
  Serial.print(ljus);
  Serial.print(" tilt=");
  Serial.println(tilt);
  delay(200);
}
```

</div>

<!--
Denna slide visas samtidigt som eleverna kör koden. Peka på 
Serial.print-raderna — "det är dem ni tittar på i Serial Monitor".

NOTERA: pinMode för tilten ÄR nödvändig (digital pin behöver pinMode), 
till skillnad från A0 som är default INPUT. Tilten kopplas som knappen 
i Modul 3 — INPUT_PULLUP, lutad ger LOW. Påminn om Modul 3-mönstret 
om någon undrar varför inte INPUT.
-->

---
layout: center
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-4">
  Efter träff 4
</div>

# Arduinon känner världen.

<div class="mt-10 text-xl opacity-80 max-w-3xl mx-auto">
  Ni kan läsa <span class="cyan">ljus</span> med en fotocell, <span class="cyan">lutning</span> med en tilt-sensor, och <span class="cyan">titta in</span> i Arduinons minne via Serial Monitor.
</div>

<div class="mt-12 text-base opacity-60 italic">
  Nästa vecka: <span class="cyan">hackathon</span>. Ni sätter ihop allt till ett fungerande tjuvlarm. Kom hungriga.
</div>

<!--
Avsluta Modul 4 här.

SÄG:
"Ni har nu alla bitar. Digital output från Modul 1. PWM och färg från 
Modul 2. Knapp och buzzer från Modul 3. Fotocell, tilt och Serial 
Monitor från idag. Nästa vecka är det HACKATHON — ni bygger larmet. 
Ingen ny teori, bara integration. Ta med kitten, ta med laptoppen, 
ta med hunger. Vi ses."
-->

---
layout: section
class: section text-center
---

<div class="font-mono text-sm tracking-widest uppercase opacity-60 mb-4">
  Träff 5 av 5
</div>

# Integration

<div class="text-2xl mt-6 opacity-80 font-light">
  Modul 5: <span class="cyan font-bold">Hackathon — bygg larmet</span>
</div>

<!--
Sista träffen. Hackathon.

Ingen ny teori idag. Allt ni behöver kan ni redan. Idag ska ni SÄTTA IHOP det.

AGENDA (runt 2 timmar):
- 00:00–00:10  Välkomna + genomgång av logiken (nästa slide)
- 00:10–00:20  Kod-skelettet (slide efter) + frågor
- 00:20–01:00  Fritt bygge — runda 1
- 01:00–01:15  PAUS (15 min) — vatten, sträck, luftar
- 01:15–01:50  Fritt bygge — runda 2 (sista spurten)
- 01:50–02:00  Demo-runda: varje grupp visar sitt larm i ett mörklagt rum

Lyser taklampan under bygget så det är lätt att koppla — släcks sista 
5 min för demos.
-->

---
layout: default
class: px-14
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Hackathon
</div>

# Ingenjörsuppgiften.

<div class="text-lg opacity-80 mt-4 max-w-3xl">
  Ingen manual att kopiera. Ni har alla delar. <span class="cyan">Sätt ihop dem.</span>
</div>

<div class="mt-10 flex items-center justify-between gap-4">

<div class="flex-1 flex flex-col items-center text-center">
  <div class="text-6xl i-carbon-view cyan mb-2"></div>
  <div class="font-bold text-lg">INPUT</div>
  <div class="opacity-60 text-xs">Knapp · LDR · Tilt</div>
</div>

<div class="text-4xl opacity-40 px-2">→</div>

<div class="flex-1 flex flex-col items-center text-center">
  <div class="text-6xl i-carbon-chip cyan mb-2"></div>
  <div class="font-bold text-lg">LOGIK</div>
  <div class="opacity-60 text-xs">Arduino &amp; kod</div>
</div>

<div class="text-4xl opacity-40 px-2">→</div>

<div class="flex-1 flex flex-col items-center text-center">
  <div class="flex gap-3 mb-2">
    <div class="text-5xl i-carbon-light warn"></div>
    <div class="text-5xl i-carbon-volume-up-filled warn"></div>
  </div>
  <div class="font-bold text-lg">OUTPUT</div>
  <div class="opacity-60 text-xs">RGB-LED · Buzzer</div>
</div>

</div>

<div class="mt-10 text-sm opacity-70 max-w-3xl">
  <span class="cyan font-mono">Regler:</span> Knappen togglar larm-läge. 
  Larm PÅ + tilt rörd = tjut + rött blink. 
  Larm AV + mörkt = stämningsljus.
</div>

<!--
Logiken att skriva på whiteboarden INNAN de börjar koda:

1. Knappen aktiverar LARM-läget (toggle av/på).
2. Om LARM = PÅ och tilt-sensorn rörs → TJUT + blinka RÖTT.
3. Om LARM = AV och LDR är mörk → tänd stämningsljus mysigt.
4. Annars → var tyst och mörkt.

Säg:
"Välkomna till ingenjörslivet. Idag finns det ingen manual att kopiera 
rakt av. Ni har alla delar. Ni ska sätta ihop dem.

Det finns inga färdiga svar. Det blir delar som inte fungerar. Det är
POÄNGEN. Varje gång ni fastnar och kommer vidare växer ni."

Efter genomgången av logiken: visa kod-skelettet (nästa slide). Låt 
sliden ligga uppe hela resten av lektionen.
-->

---
layout: default
class: px-14 pt-10
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Startmall · pins
</div>

<h1 class="text-5xl mb-2">Pin-tilldelning</h1>

<div class="text-lg opacity-70 mb-8">
  Samma pinnar som ni använt i varje lektion.
</div>

<div class="grid grid-cols-[auto_auto_1fr] gap-x-10 gap-y-3 text-2xl font-mono max-w-5xl">
  <div class="opacity-60 text-base uppercase tracking-widest self-end">Variabel</div>
  <div class="opacity-60 text-base uppercase tracking-widest self-end">Pin</div>
  <div class="opacity-60 text-base uppercase tracking-widest self-end">Modul</div>

  <div>knappPin</div>   <div class="cyan">D9</div>      <div class="opacity-60 text-xl">Modul 3</div>
  <div>tiltPin</div>    <div class="cyan">D2</div>      <div class="opacity-60 text-xl">Modul 4</div>
  <div>ldrPin</div>     <div class="cyan">A0</div>      <div class="opacity-60 text-xl">Modul 4</div>
  <div>buzzerPin</div>  <div class="cyan">D12</div>     <div class="opacity-60 text-xl">Modul 3</div>
  <div>ledR / G / B</div><div class="cyan">6 / 5 / 3</div><div class="opacity-60 text-xl">Modul 2</div>
</div>

<div class="mt-8 text-2xl font-mono space-y-2">
  <div><span class="opacity-60">bool</span> larmPaslaget <span class="opacity-60">=</span> false;</div>
  <div><span class="opacity-60">const int</span> morkTroskel <span class="opacity-60">=</span> 300; <span class="opacity-50 text-lg">// startvärde — kalibrera själv</span></div>
</div>

<div class="mt-8 text-lg opacity-70">
  → Inkrementell uppbyggnad i tre steg: <strong>Modul 5</strong> · komplett referens-sketch (Bilaga D) delas ut efter hackathonen.
</div>

<!--
Peka på sliden och låt den ligga uppe resten av lektionen.

LOOP-SKELETT (visa muntligt, finns i Bilaga D):
  void loop() {
    1. Läs inputs (knapp, tilt, ldr)
    2. Flank → toggla larmPaslaget (se Modul 3)
    3. Bestäm utfall:
         larm + tilt → buzzer tjuter
         !larm + mörkt → RGB stämningsljus
    delay(10);
  }


MINIMUM VIABLE ALARM — fallback för grupper som inte hinner allt:
Om en grupp inte hinner med hela systemet: prioritera i den här 
ordningen:
  1. Stämningsljus fungerar (LDR → RGB med lågt ljus)
  2. Larm-tjut på tilt (tilt → buzzer HIGH)
  3. LDR-delen kan hoppas över helt om tiden är knapp
  4. Knapp-toggle är det första som kan offras om edge-detection 
     strular — hårdkoda larmPaslaget = true så att tilt direkt 
     triggar buzzern.
Detta räddar grupper från att stå med inget alls att dema. Bättre 
hälften som funkar än en halvfärdig helhet som ingenting gör.

PIN-TILLDELNING (viktigt — matchar exakt era tidigare lektioner):
- RGB LED: R=D6, G=D5, B=D3     (Modul 2)
- Knapp:   D9                    (Modul 3)
- Buzzer:  D12                   (Modul 3)
- Tilt:    D2                    (Modul 4)
- Fotocell: A0                   (Modul 4)

Detta betyder att studenterna kan ÅTERANVÄNDA sina kopplingar från 
respektive lektion — de behöver bara montera allt på samma breadboard 
samtidigt, inte bygga om från scratch.

FELSÖKNINGSTIPS (säg när folk trasslar):
- "Nybörjare försöker klistra in `void setup()` tre gånger. Det får bara 
  finnas EN setup() och EN loop() i hela programmet."
- "Debouncing (studs): när tilt-sensorn rör sig kan den ge 5 'tryckningar' 
  på en tiondels sekund. Lägg in `delay(50);` direkt efter läsningen 
  för att undvika det."
- "Serial Monitor är din bästa vän. Printa ut allt du läser av (`Serial.println`). 
  Då ser du vad Arduinon 'tänker' i realtid."
- "Buzzern: använd `digitalWrite(buzzerPin, HIGH);` — den är ACTIVE buzzer, 
  ni behöver inte `tone()`."
- "Fotocellen: mörker (hand över) = A0 ≈ 20–100. Rumsljus ≈ 150–400. Lampa nära ≈ 500–700. 
  Sätt tröskeln på 300 som startvärde för 'det är mörkt' och 
  justera efter kalibrering i Modul 4."
- "RGB-LED:en: kom ihåg att KATODEN (andra benet från platta sidan, det 
  längsta) ska till GND. De tre andra benen till PWM-pinnarna via 220 Ω."

AVSLUTNING (sista 10 min):
1. Demo-runda: varje grupp visar sitt larm.
2. Stäng av taklampan i rummet sista 5 min.
3. Låt alla larm och nattlampor gå loss — det är en liten ljud- och ljusshow.
4. Stående ovation. Något byggt från noll förtjänar det.
-->

---
layout: default
class: px-14 pt-12
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Efter kursen
</div>

# Vart härifrån?

<div class="mt-6 mb-6 text-2xl opacity-90 max-w-4xl">
  Ni byggde ett fungerande tjuvlarm. Det var målet. Ni klarade det.
</div>

<div class="mt-8 space-y-6 max-w-5xl">

<div class="p-6 rounded-xl border border-[var(--ak-border)] bg-[var(--ak-bg-raised)]">
  <div class="flex items-baseline gap-4 mb-2">
    <div class="text-2xl font-bold cyan">TinkerCAD Circuits</div>
    <div class="mono text-sm opacity-60">tinkercad.com/circuits</div>
  </div>
  <div class="opacity-85 text-lg leading-relaxed">
    Gratis online-simulator för Arduino. Bygg kretsen i browsern, skriv samma kod som i IDE:n, tryck play — <strong>hela kretsen simuleras</strong>, inklusive LED:ar, sensorer och Serial Monitor. Perfekt för att prova idéer utan att ha kittet framför sig.
  </div>
</div>

<div class="grid grid-cols-2 gap-6">
  <div class="p-5 rounded-xl border border-[var(--ak-border)]">
    <div class="text-xl font-bold mb-2">Online-projekt</div>
    <div class="opacity-80 text-base">
      Hackster.io · Instructables · Make: — recept från väderstationer till MIDI-instrument. Kopiera något enkelt, förstå vad du kopierade.
    </div>
  </div>

  <div class="p-5 rounded-xl border border-[var(--ak-border)]">
    <div class="text-xl font-bold mb-2">Ert eget hem</div>
    <div class="opacity-80 text-base">
      Vad skulle ni vilja automatisera? Lampa i hallen. Brevlåde-notis. Kaffebryggar-timer. Ett litet verkligt problem slår varje tutorial.
    </div>
  </div>
</div>

</div>

<div class="mt-8 text-sm opacity-60 italic">
  Fullständig lista i kompendiets Modul 5-avslutning.
</div>

<!--
TinkerCAD är det enskilt bästa verktyget för att fortsätta labba efter
kursen. Ingen hårdvara behövs — allt simuleras i browsern. Några
praktiska poänger:

- Fungerar på Mac, Windows, Linux, iPad — vilken browser som helst.
- Gratis, men kräver ett Autodesk-konto (gratis det också).
- Man kan dela länkar till sina kretsar — bra för att hjälpa varandra.
- Simulatorn är inte 100% verklighetstrogen (timing, brus), men
  räcker gott för att testa logik och koppling.

Säg:
"Om ni har bussresor till jobbet eller sitter på en flygplats och vill
labba vidare — TinkerCAD Circuits räcker. Ni kan bygga och testa precis
det ni gjort i kursen. Kittet ligger kvar där ni lämnat det."

Övriga resurser är i kompendiets Modul 5. Peka dit om någon vill ha
mer detaljer.
-->

---
layout: center
class: end text-center
---

<div class="font-mono text-lg tracking-widest uppercase opacity-75 mb-10">
  Efter fem träffar
</div>

<h1 class="text-8xl mb-12">
  Tack.
</h1>

<div class="text-4xl opacity-90 max-w-5xl mx-auto">
  Ni har byggt ett system som <span class="cyan">läser av omvärlden</span><br/>
  och <span class="cyan">reagerar på den</span>.<br/>
  Grunden i inbyggda system.
</div>

<div class="mt-24 text-xl opacity-70 font-mono">
  FRO Ånge · 2026
</div>

<!--
Final message. Säg det med känsla:

"För fem veckor sedan visste ingen av er vad en GND-pin var. Idag har ni 
byggt en sak som känner världen och reagerar på den. 

Det ni gjorde idag är exakt vad proffsen gör — bara i mindre skala. 
Ni läste sensorer, ni byggde logik, ni debuggade. Ni skrev kod.

Det finns en enorm värld bortom det här kittet. Nästa steg: 
- Prova Arduino-projekt online (Hackster, Instructables)
- Gå med i lokala makerspaces 
- Bygg något som löser ett litet problem i ert eget hem

Ni är redo."

[Stående ovation. Klart.]
-->
