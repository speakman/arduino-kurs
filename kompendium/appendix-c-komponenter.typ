#import "theme.typ": *

// ═══════════════════════════════════════════════════════════════════
// APPENDIX C · KOMPONENTREFERENS
// ═══════════════════════════════════════════════════════════════════

#module-heading(
  "Bilaga C",
  "Komponentreferens",
  "Snabbreferens för varenda bit ni kopplat i kursen.",
)

Denna bilaga är en pek-och-slå-upp-referens. Varje komponent får en kort beskrivning, pinout/polaritet om det spelar roll, vanliga fel, och hur den ska kopplas in mot Arduinon.

== LED (standard, genomskinlig)

#fig(
  "images/elegoo-038-055.png",
  caption: [Lysdiod med markerad anod (+, långt ben) och katod (−, kort ben med platt kant).],
  width: 50%,
)

En lysdiod. Skickar man ström den rätta vägen lyser den. Fel väg: ingenting. För mycket ström: den brinner upp permanent.

#quickref(
  ([*Polaritet*], [Långt ben = anod (+). Kort ben med platt kant = katod (−).]),
  ([*Max ström*], [Ca 20 mA. Över det → bränns upp.]),
  ([*Framspänningsfall*], [Röd ≈ 1,8–2 V. Grön/gul ≈ 2–2,2 V. Blå/vit ≈ 3–3,4 V. Se Bilaga F.]),
  ([*Seriemotstånd*], [Alltid. 220 Ω är ett säkert allround-val för 5 V.]),
  ([*Arduino-koppling*], [Pin 13 → anod. Katod → resistor → GND.]),
)

*Vanliga fel:* LED kopplad baklänges (lyser inte, men går inte sönder), resistor saknas (lyser en kort stund, sedan bränns upp), benet ligger i fel hål på breadboard.

== Resistor

#fig(
  "images/elegoo-039-056.png",
  caption: [Resistor med färgband. Läs från den ände där banden ligger tätast.],
  width: 55%,
)

Passiv komponent som "bromsar" ström. Inget att lysa, inget att blinka — men den är ofta det som skiljer en fungerande krets från en brunnen komponent.

#quickref(
  ([*Polaritet*], [Ingen. Kopplas hur som helst.]),
  ([*Värden i kittet*], [220 Ω, 1 kΩ, 10 kΩ (och några varianter däremellan)]),
  ([*Avläsning*], [Färgband. Räkna först *hur många band* din resistor har — kittet innehåller både 4-bands (normal precision) och 5-bands (1 % precision).]),
  ([*4-band*], [första två siffror · multiplikator · tolerans. 220 Ω = röd-röd-*brun*-guld.]),
  ([*5-band*], [tre siffror · multiplikator · tolerans. 220 Ω = röd-röd-svart-*svart*-brun.]),
  ([*1 kΩ (4-band)*], [brun · svart · röd · guld]),
  ([*1 kΩ (5-band)*], [brun · svart · svart · brun · brun]),
  ([*10 kΩ (4-band)*], [brun · svart · orange · guld]),
  ([*10 kΩ (5-band)*], [brun · svart · svart · röd · brun]),
  ([*Osäker?*], [Mät med multimeter i kontinuitet/Ω-läge. 220 Ω ger exakt "220" på skärmen. Alltid säkrast när du tvivlar.]),
)

#fig(
  "images/elegoo-040-057.png",
  caption: [Färgkodstabell. För 4-band: digit-digit-multiplikator-tolerans. För 5-band (1 %-precision): digit-digit-digit-multiplikator-tolerans. Räkna banden innan du börjar dekoda.],
  width: 70%,
)

*Tabellen för färgkoder* sitter också inuti locket på kittet. Du är välkommen att använda den eller mäta med multimeter. Med tiden lär man sig de vanligaste värdena utan att tänka.

== RGB-LED (common cathode)

#fig(
  "images/elegoo-045-061.png",
  caption: [RGB-LED med de fyra benen markerade. Från platta sidan: röd, katod (längst), grön, blå.],
  width: 55%,
)

Fyra ben, tre kanaler (röd, grön, blå) som delar en gemensam katod. Kittets variant är *common cathode* — det längsta benet går till GND.

#quickref(
  ([*Pin-ordning från platta sidan*], [röd · katod · grön · blå]),
  ([*Katoden*], [Andra benet från platta sidan. Längst av de fyra. Till GND.]),
  ([*De tre andra*], [Via varsin 220 Ω-resistor till PWM-pinne.]),
  ([*Kursens pinnar*], [R → D6, G → D5, B → D3.]),
  ([*Varför PWM?*], [För att kunna variera ljusstyrkan per kanal (0–255).]),
)

*Vanligt fel:* kopplad som common anode (med gemensam + istället för GND). Då fungerar inget. Om du bara får en färg lysa: ett av benen är i fel hål eller saknar resistor.

== Breadboard

#fig(
  "images/elegoo-037-054.png",
  caption: [Breadboard ovanifrån med interna förbindelser markerade: röda/blåa power rails längs sidorna, gröna kolumn-noder i mitten, gapet som bryter förbindelsen.],
  width: 75%,
)

Plastbit med dolda metallklämmor som låter dig koppla ihop komponenter utan att löda.

#quickref(
  ([*Horisontella rader i mitten*], [Fem hål i rad är en nod. Raden bredvid är en egen nod.]),
  ([*Gapet i mitten*], [Bryter förbindelsen mellan övre och nedre halvan.]),
  ([*Power rails (+/−) längs sidorna*], [Hela raden är en enda lång nod. Används för att dela ut 5 V och GND.]),
  ([*Hål diameter*], [Passar genomgångshåls-komponenter och DuPont-kablar (0,6 mm).]),
)

*Vanligaste nybörjarfelet:* ett komponentben och en kabel ligger i olika rader. Kolla först att de *faktiskt sitter på samma rad*.

== Knapp (tactile switch)

#fig(
  "images/elegoo-053-070.png",
  caption: [Tactile switch — fyra ben, men internt bara två noder (A–D hopkopplade, B–C hopkopplade). Tryckning sluter de två noderna.],
  width: 55%,
)

En liten mekanisk brytare med fyra ben. När du trycker ner den kortsluts två par av benen.

#quickref(
  ([*Pinnar*], [Fyra ben, men elektriskt bara två noder: A–D är internt ihopkopplade, B–C likaså. Tryckning kortsluter båda paren.]),
  ([*Koppling i kurs*], [Ena benet → D9, andra benet → GND. Ingen extern resistor.]),
  ([*Läs med*], [`digitalRead(pin)` efter `pinMode(pin, INPUT_PULLUP)`.]),
  ([*Tryckt = LOW*], [På grund av inverterad logik med INPUT_PULLUP.]),
  ([*Studs*], [Fysisk studs några millisekunder. Lägg `delay(10)` eller `delay(50)` för enkel debounce.]),
)

== Active buzzer

#fig(
  "images/elegoo-058-074.png",
  caption: [Active buzzer — svart cylinder med inbyggd oscillator. Klisterlappen på ovansidan *stannar kvar*.],
  width: 45%,
)

En liten svart cylinder som ger ifrån sig ljud när du skickar ström genom den. *Active* betyder att den har en inbyggd oscillator — `digitalWrite(pin, HIGH)` ger direkt pip, ingen `tone()` behövs.

#quickref(
  ([*Polaritet*], [Långa benet = plus (markerat med `+` på ovansidan). Kort ben = minus.]),
  ([*Koppling i kurs*], [`+`-ben (höger, markerat) → `D12`, `−`-ben → `GND`-skenan på breadboarden tillsammans med knappen.]),
  ([*Resistor*], [Behövs inte. Buzzern är självreglerande.]),
  ([*Klisterlappen*], [Stannar på. "Remove after washing" är en dämpare från tillverkningsprocessen.]),
  ([*Frekvens*], [Fast (~2 kHz). Inte ställbar.]),
)

*Varning:* passive buzzer (blå, låg) finns också i kittet och ser liknande ut. Den kräver `tone(pin, frequency)` för att låta. I kursen använder vi active buzzer — svart, hög, med klisterlapp.

== Fotocell (LDR)

#fig(
  "images/elegoo-079-093.png",
  caption: [Fotocell (LDR) — rund skiva med karakteristiskt gult snake-eye-mönster på ovansidan.],
  width: 45%,
)

"Light-dependent resistor". En resistor vars värde ändras beroende på ljuset som träffar den.

#quickref(
  ([*Polaritet*], [Ingen. Kopplas hur som helst.]),
  ([*Motståndsområde*], [Ca 50 kΩ i mörker, ca 500 Ω i starkt ljus.]),
  ([*Måste ha partner*], [Ingår i en spänningsdelare — behöver en fast resistor (1 kΩ) för att bilda mellanpunkten.]),
  ([*Koppling i kurs*], [5 V → fotocell → A0 → 1 kΩ → GND.]),
  ([*Läses med*], [`analogRead(A0)` — ger 0–1023.]),
)

*Mätvärden (ungefärliga, med 1 kΩ mot GND):* mörker ≈ 20–100, rumsljus ≈ 150–400, lampa nära ≈ 500–700, ficklampa direkt ≈ 700–900. Kalibrera alltid själv.

== Tilt-sensor

#fig(
  "images/elegoo-062-079.png",
  caption: [Tilt ball switch — cylindrisk kapsel med lös metallkula inuti.],
  width: 45%,
)

En liten cylinder med en lös metallkula inuti. I upprätt läge rör kulan bara ett ben — kretsen är bruten. Lutad: kulan rullar till det andra benet och kortsluter dem.

#quickref(
  ([*Polaritet*], [Ingen för själva funktionen. Men kopplas som en knapp: ena benet till pinne, andra till GND.]),
  ([*Digital trots att det är en sensor*], [Läses med `digitalRead`, inte `analogRead`. Bara två lägen.]),
  ([*Koppling i kurs*], [Ena benet → D2, andra → GND. Rakt i Arduino-headers.]),
  ([*Pinmode*], [`pinMode(tiltPin, INPUT_PULLUP)`.]),
  ([*Lutad = LOW*], [Inverterad logik från INPUT_PULLUP.]),
  ([*Studs*], [Kulan bouncar. `delay(50)` efter läsningen räcker som debounce.]),
)

== Vridpotentiometer (10 kΩ) — demonstrationskomponent

Kittet innehåller en *blå vridpotentiometer* på 10 kΩ. Ni kopplar den inte själva i kursen — men i Modul 4 visar läraren den som *fysisk modell av en spänningsdelare*, för att göra det konkret vad fotocellen sedan gör automatiskt.

#quickref(
  ([*Vad det är*], [Ett "långt motstånd" där en glidande arm (wiper) kan ställas var som helst längs det inre motståndsmaterialet.]),
  ([*Pinnar*], [Tre ben. Två yttre = ändarna av motståndsspåret. Mittben = wipern.]),
  ([*Demo-koppling*], [Yttre ben → +5 V och GND. Mittben → A0. Vrid → A0 sveper 0–1023 jämnt.]),
  ([*Maxvärde*], [10 kΩ totalt mellan de två yttre benen. Wipern delar upp denna resistans i två andelar.]),
  ([*Läses med*], [`analogRead(A0)`. Ger samma 0–1023 som fotocell-kopplingen.]),
)

Varför den ligger utanför hands-on-laben: en pot löser samma uppgift som en knapp i många nybörjarprojekt (välja ett värde) men introducerar mekanik som tar fokus från koden. Den är dock perfekt som *brygga* till spänningsdelar-konceptet — wipern är mätpunkten, ni kan se den flyttas med handen.

*Vill ni leka mer:* prova att ersätta fotocellen i Modul 4 med pot:en och styra LED-ljusstyrkan med vridning istället för ljus. Allt i Modul 4-koden fungerar oförändrat.

== Arduino Uno R3

Själva styrkretsen. En mikrocontroller i ett "development board"-format med inbyggd USB-kontroller, spänningsreglering och stift-kontakter.

#quickref(
  ([*Processor*], [ATmega328P (16 MHz, 8-bit)]),
  ([*Minne*], [32 KB flash (din kod), 2 KB SRAM (variabler), 1 KB EEPROM (persistent)]),
  ([*Digital-pinnar*], [D0–D13, varav *D3, D5, D6, D9, D10, D11* stödjer PWM (markerade med `~`)]),
  ([*Analoga pinnar*], [A0–A5, kan läsas med `analogRead` (0–1023).]),
  ([*Strömförsörjning*], [USB (5 V) eller externt via DC-jacket (7–12 V → regleras till 5 V internt).]),
  ([*5 V-pin*], [Ger ut 5 V vid USB-strömförsörjning. Totala budgeten är ca 450 mA efter att kortets egna komponenter tagit sitt. Mer än så och USB-portens polyfuse (500 mA) bryter.]),
  ([*3,3 V-pin*], [Ger ut 3,3 V. Användbar för vissa sensorer. Max 50 mA.]),
  ([*GND*], [Tre stift, alla elektriskt samma punkt. Vilken som helst fungerar.]),
  ([*Reset-knappen*], [Startar om din sketch från början. Användbar om den krashar.]),
  ([*Inbyggd LED*], [Pin 13, alltid kopplad till en intern LED. Använd `LED_BUILTIN` i koden.]),
)

== Kabelbröderna — DuPont-kablar

De färgade trådarna du använder för att koppla mellan breadboard och Arduino.

#quickref(
  ([*M-M (hane-hane)*], [Stift i båda ändar. För breadboard-till-breadboard eller breadboard-till-header.]),
  ([*M-F (hane-hona)*], [Ena änden stift, andra änden hylsa. För Arduino-header till breadboard, eller till direkta komponenter som tilt-sensor.]),
  ([*F-F (hona-hona)*], [Hylsa i båda ändar. Används sällan i kursen.]),
  ([*Typisk längd*], [10–20 cm. Inte kritiskt men kortare är snyggare.]),
)

== 74HC595 skiftregister — den komponenten vi inte använder

Kittet innehåller *en* komponent som kursen inte rör: ett 74HC595-skiftregister. Det är en 16-bens IC (integrerad krets) som låter Arduinon styra 8 LED-utgångar med bara 3 pinnar.

#quickref(
  ([*74HC595 skiftregister*], [16-bens DIP-IC. Tre styrpinnar (`data`, `clock`, `latch`) kan styra 8 utgångar. Principen: skiftregistret "kommer ihåg" en 8-bits sekvens du matar in en bit i taget, och håller dem alla samtidigt på sina utgångar.]),
)

Det är en utmärkt första fördjupning efter kursen — prova att blinka åtta LED:ar i ett löpande mönster. Sök efter "74HC595 shift register Arduino" för exempel.

== Vill du ha fler komponenter?

Kittet är medvetet minimalt — de komponenter ni byggt med under fem träffar är i princip precis de som ryms. Om ni vill gå vidare:

- *Utökningskit* (Super Starter Kit, Most Complete Kit) innehåller saker som servomotor, LCD-display, IR-mottagare, temperatursensor, ultraljudsavståndsmätare, m.fl.
- *Lösa komponenter* från Kjell & Company, Electrokit eller liknande när ni har ett specifikt projekt i åtanke. Ofta mer prisvärt än att köpa ett nytt kit.
- *Online-tutorials* — Hackster.io och Instructables förklarar nästan alltid vad de använder och var man får tag på det.
