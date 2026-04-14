# E3 Spänningsdelaren — utkast v1

## Kontext

- Kurs: 5-veckors Arduino-nybörjarkurs för FRO Ånge (radioamatörer, vuxna nybörjare)
- Modul 4: Analog input — fotocell, tilt, Serial Monitor
- Sliden ligger efter "Knappen var digital. Världen är analog." och före fotocellens WiringSlide
- Tonläge genom hela kursen: "sträng men kärleksfull", direkt, Du-form, lagom humor, svensk
- Viktig pedagogisk hake: återbruk vattenanalogin som introducerades i Modul 1 ("Kretsen — som ett vattensystem"). Där var 5V en kran, GND ett utlopp, och en 220Ω-resistor en strypventil som bromsar flödet.
- Layout: two-cols-header eller grid 2-col. Vänster = text + analogi, höger = schematisk visuell + kodsnutt.
- Måste rymmas inom 1920×1080 utan overflow.
- Slidev-syntax: `::left::` / `::right::` för two-cols-header, eller vanlig grid.
- Kompendium-policy: full teknisk djupdykning (formel R2/(R1+R2) · Vin, Kirchhoffs lagar etc) ligger i kompendiets Appendix F. Sliden ska INTE härleda formeln — bara bygga intuitionen.

## Målgruppens nivå

- De har redan förstått: ström, spänning, GND, Ohms lag (ytligt), vattenanalogi, digital input/output, const int, if/else.
- De har INTE hört talas om: spänningsdelare, serie-resistorer som delar spänning, Ohms lag tillämpad på två resistorer i serie.
- Framgångskriterium: efter sliden ska de kunna rita schemat för fotocellkretsen, förstå VARFÖR en till resistor behövs, och förstå att analogRead(A0) ger olika tal beroende på hur mycket ljus som faller på fotocellen.

## Utkast v1

```md
---
layout: two-cols-header
class: px-12 pt-10
---

<div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50 mb-2">
  Nytt koncept · från motstånd till mätvärde
</div>

# Spänningsdelaren.

::left::

<div class="mt-4 text-[0.95rem] leading-relaxed space-y-3">

Minns vattenröret från Modul 1: **5 V är kranen, GND är utloppet**, och en resistor var en strypventil.

Koppla nu **två** strypventiler efter varandra. Trycket (5 V) måste delas upp mellan dem.

Är båda ventilerna lika hårda, ligger trycket i mitten på **halva** — 2,5 V. Är den första mycket hårdare tar den upp mer av trycket, och mellanpunkten sjunker mot 0. Omvänt: svag första, stark andra → mellanpunkten nära 5 V.

Byt nu den första resistorn mot en **fotocell** — en ljuskänslig resistor. Mörker → högt motstånd → mellanpunkten **sjunker**. Ljus → lågt motstånd → mellanpunkten **stiger**.

Arduinons `A0`-pinne mäter just den mellanpunkten. Den läses med <span class="mono cyan">analogRead(A0)</span> och kommer tillbaka som ett tal mellan **0 och 1023**.

</div>

::right::

<div class="flex flex-col items-center justify-center h-full">

<svg width="240" height="280" viewBox="0 0 240 280" class="opacity-95">
  <!-- +5V label -->
  <line x1="120" y1="20" x2="120" y2="60" stroke="#00d9ff" stroke-width="2"/>
  <circle cx="120" cy="16" r="4" fill="none" stroke="#00d9ff" stroke-width="2"/>

  <!-- Fotocell symbol (zigzag resistor with arrows) -->
  <rect x="100" y="60" width="40" height="50" fill="none" stroke="#e8ecf1" stroke-width="2"/>
  <line x1="80" y1="70" x2="95" y2="80" stroke="#ffd400" stroke-width="1.5"/>
  <polygon points="95,80 92,76 92,81" fill="#ffd400"/>
  <line x1="80" y1="90" x2="95" y2="100" stroke="#ffd400" stroke-width="1.5"/>
  <polygon points="95,100 92,96 92,101" fill="#ffd400"/>

  <!-- Wire to A0 -->
  <line x1="120" y1="110" x2="120" y2="150" stroke="#e8ecf1" stroke-width="2"/>
  <line x1="120" y1="130" x2="180" y2="130" stroke="#00d9ff" stroke-width="2"/>

  <!-- 1kΩ resistor -->
  <rect x="100" y="150" width="40" height="50" fill="none" stroke="#e8ecf1" stroke-width="2"/>

  <!-- GND -->
  <line x1="120" y1="200" x2="120" y2="230" stroke="#e8ecf1" stroke-width="2"/>
  <line x1="100" y1="230" x2="140" y2="230" stroke="#e8ecf1" stroke-width="2"/>
  <line x1="108" y1="238" x2="132" y2="238" stroke="#e8ecf1" stroke-width="2"/>
  <line x1="114" y1="246" x2="126" y2="246" stroke="#e8ecf1" stroke-width="2"/>
</svg>

<!-- Labels via HTML so sizing works -->
<div class="mt-3 text-xs opacity-80 mono space-y-1 text-center leading-relaxed">
  <div><span class="cyan">+5 V</span> → fotocell → <span class="cyan">A0</span></div>
  <div><span class="cyan">A0</span> → 1 kΩ → <span class="danger">GND</span></div>
</div>

<div class="mt-5 text-[0.75rem] opacity-65 space-y-1 text-center">
  <div>Mörker: A0 ≈ <span class="mono cyan">150</span></div>
  <div>Rumsljus: A0 ≈ <span class="mono cyan">500</span></div>
  <div>Direkt ljus: A0 ≈ <span class="mono cyan">900</span></div>
</div>

</div>

<!--
PEDAGOGISK POÄNG:
Denna slide är bron mellan "analogRead ger ett tal" och "därför gör 
fotocellskopplingen det den gör". Utan spänningsdelar-begreppet 
framstår kopplingen som magi.

SÄG:
"Ni minns vattenanalogin från Modul 1? Strypventil i serie. 
Idag tar vi två strypventiler i rad. Och trycket — våra 5 volt — 
måste delas upp mellan dem. Vilken som tar mest beror på vem som 
är hårdast."

[Rita upp på whiteboarden: två rektanglar i serie, 5V ovan, GND under, 
pil till mitten märkt A0.]

"Det är en spänningsdelare. Det är därför fotocellen måste ha en 
partner — den där lilla 1 kΩ-resistorn ni sett i Lesson 10-schemat. 
Utan partner skulle det inte finnas någon mellanpunkt att mäta. Utan 
mellanpunkt, ingen mätvärde."

GÅ VIDARE:
Nästa slide visar den faktiska kopplingen (fotocell WiringSlide) och 
sedan Serial Monitor. När ni har läst värdena tillsammans, gå till 
"Hitta din tröskel"-övningen.

FULL FORMEL:
Formeln V_ut = R2 / (R1 + R2) · V_in ligger i kompendiets Appendix F. 
Vi härleder den INTE på sliden — här räcker intuitionen.

VANLIGT MISSFÖRSTÅND:
Någon kommer tro att fotocellen ensam kan läsas av A0. Säg då: 
"A0 mäter SPÄNNING, inte motstånd. Och utan partner har du bara 
kortslutning mellan 5V och GND genom fotocellen. Det blir inget att 
mäta — bara ström som rusar igenom."
-->
```
