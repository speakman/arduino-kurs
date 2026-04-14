#import "theme.typ": *

// ═══════════════════════════════════════════════════════════════════
// APPENDIX E · SÄKERHET
// ═══════════════════════════════════════════════════════════════════

#module-heading(
  "Bilaga E",
  "Säkerhet",
  "De saker som gör att du inte bränner dig, LED:en, eller Arduinon.",
)

== Ofarligt för dig — farligt för utrustningen

Spänningen du jobbar med på kursen är *5 V*. Det är samma spänning som en USB-kabel. *För människor är det helt ofarligt* — du kan hålla båda ledningarna mellan tummen och pekfingret och känna ingenting alls. Du jobbar inte på vägguttags-nivå.

Men *din utrustning* — laptopen, Arduinon, komponenterna — är inte lika robust. En kortslutning mellan `+5 V` och `GND`, en LED utan resistor, en pinne som dras över sin maxgräns — alla är saker som kan stänga av USB-porten (bra) eller rosta komponenter (mindre bra). Fem små saker att veta:

== 1. LED:en är riktad — kontrollera polariteten

Skickar du ström åt fel håll genom en LED: den lyser inte. Skickar du för mycket ström åt rätt håll: den brinner upp på mindre än en sekund.

- *Långt ben = plus (anod)*. Mot signal-pinnen.
- *Kort ben + platt kant på plastkuddens rand = minus (katod)*. Mot GND.
- *Seriemotstånd är obligatoriskt*. 220 Ω duger för 5 V.

Utan resistor går mer än 20 mA genom LED:en, och den hinner lysa i högst några sekunder innan den bränns upp permanent. Den är inte farlig för dig — men du får byta. Kittet har ett par extra, men regeln är enkel: *aldrig en LED utan seriemotstånd*.

== 2. Ingen pinne tål hur mycket ström som helst

Arduinons digitala pinnar har en *rekommenderad maxström på 20 mA per pinne* (absolut maximum enligt databladet är 40 mA, men det sliter på chippet). Totalt genom chippet (alla pinnar tillsammans): absolut max är *200 mA* — håll dig klart under det. Drar du mer bränner du en liten effekttransistor inne i chippet. Det märks inte direkt — men efter ett tag slutar pinnen svara på `digitalWrite`.

*För kursen är det inget problem.* En LED via 220 Ω drar ca 13 mA. En RGB-LED med alla tre kanaler full = ca 40 mA. En buzzer = ca 30 mA. Allt med god marginal.

*Fel att undvika:*
- En LED direkt till 5 V utan resistor → drar 25+ mA direkt, bränner pinnen eller LED:en eller båda.
- Två LED:ar parallellt på samma resistor → delar strömmen olika, en tar skada.
- Försök driva en motor direkt från pinnen → motorer drar hundratals mA, Arduinon överlever inte.

*Regel:* om du kopplar något som inte är uttryckligen beskrivet i kursen, räkna om strömmen med Ohms lag först.

== 3. Kortslut inte 5 V och GND

Om du direkt kopplar `+5 V` till `GND` med en ren kabel, börjar Arduinon dra hela strömmen den kan leverera. Kabeln blir varm; i värsta fall smälter dess isolering eller en spårledning på kortet bränns.

*Det låter allvarligare än det är.* USB-porten har en skyddskrets som bryter vid ca 500 mA. Men: kabeln blir VÄLDIGT varm, laptop-varningen poppar upp, och du får koppla ur i rätt tid.

*Vanligaste sättet att göra det av misstag:*
- En lös kabel som hamnar i GND-raden och rör plus-raden på breadboardens power rails.
- En resistor med brutna ben där ena änden rör plus och andra änden rör minus utanför kretsen.
- Förvirrande fingerplats när du sticker in en kabel.

Om du märker att Arduinon blir varm — *koppla ur USB:n direkt*. Kolla vart du senast drog en kabel.

== 4. Buzzer-klisterlappen (det är seriöst)

*Dra inte av klisterlappen* på den aktiva buzzern i kittet. Etiketten säger "REMOVE AFTER WASHING". Den är *inte* en skyddsfilm att ta bort för användning. Det är en *fabriksdämpare* från tillverkningsprocessen.

Tekniskt fungerar buzzern utan den, men den blir *mycket* högre. Tillräckligt för att ge dig ringningar i öronen under en hackathon.

*Lös rätt:* låt lappen sitta kvar. Det är ingen del av "korrekt montering". Det är bara en tillverknings-detalj som råkade hamna i slutprodukten.

== 5. Statisk elektricitet är en verklig sak

Torr vinterluft + nyfallen snö + syntetiska tröjor → du bygger upp några tusen volt statisk elektricitet på kroppen. När du rör Arduino-chippets pinnar med ett finger kan det ladda ur sig genom chippet och permanent skada det.

*Det är en liten risk på Arduino Uno* (den är byggd för att vara robust), men risken finns för andra IC-komponenter. I kursen är det sällsynt att detta händer, men värt att veta.

*Förebygg:* ta tag i något jordat (en metallkran, värmeelementet, laptopens USB-kontakt) innan du börjar koppla om du misstänker att du är uppladdad. Eller: *rör aldrig bara själva metall-pinnarna på chipen* — håll i plastkanterna eller i själva kretskortet.

*För kursens komponenter* spelar det mindre roll. LED, resistor, knapp, buzzer, fotocell — ingen av dem är känslig för statisk. Men IC-kretsar som 74HC595 *är*.

== Säker felsökning

När något inte fungerar är det ibland frestande att "testa med att snabbt koppla fram och tillbaka". *Koppla inte om medan Arduinon är strömförsörjd.* Dra ur USB:n, koppla om, koppla i igen. Det skyddar mot oväntade kortslutningar och gnistor.

*Ordning:*
+ Koppla ur USB.
+ Ändra kopplingen.
+ Kontrollera att inget oväntat är kortslutet (titta, tänk efter).
+ Koppla i USB.
+ Ladda upp ny kod om det behövs.

Det tar 5 extra sekunder per iteration och sparar miljoner sekunder av felsökning.

== Och till slut: ofarligt för människan

*Säg det högt en gång till:* 5 V via USB är inte farligt för *dig*. Du kan hålla båda ledningarna, röra vid chipet med handen, droppa vatten på breadboardet (nej, bara skämt — torka upp det), och inget händer med dig. Det är komponenterna och laptopen man skyddar — inte fingrarna.

Det värsta som kan hända på kursens kompetensnivå är:

#block(breakable: false)[
+ En LED brinner upp → du får byta till en av de andra i kittet.
+ En USB-port i laptopen stänger av p.g.a. överskydd → du kopplar i igen.
+ En Arduino slutar svara på en pinne → byt till en annan pinne och anteckna det.

Ingenting brinner. Ingen skadas. Värsta utfallet är att du får köpa en ny 29-kronors LED från Kjell & Company. *Slappna av. Bygg.*
]
