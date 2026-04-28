#import "theme.typ": *

// ═══════════════════════════════════════════════════════════════════
// APPENDIX F · OHMS LAG, FRAMSPÄNNINGSFALL, SPÄNNINGSDELARE
// ═══════════════════════════════════════════════════════════════════

#module-heading(
  "Bilaga F",
  "Ohms lag & framspänningsfall",
  "Den tyngsta bilagan. Här utreder vi varför 220 Ω är 220 Ω och ingenting annat.",
)

== Vad kapitlet handlar om

Det här är inte en rundtitt. Det är ett djupdyk. Om ni satt på träff 1 och undrade "men *varför* 220 Ω?" utan att hinna fråga, är det här svaret. Om ni redan kunnat svaret i detalj, är det en repetition på ert modersmål.

Målet är att efter läsningen ska ni kunna:

+ *Räkna ut* vilken resistor en given LED behöver utan att googla.
+ *Förklara* varför en LED inte följer Ohms lag direkt.
+ *Förstå* vad som händer om resistorn är för liten eller för stor.
+ *Läsa* en spänningsdelar-koppling som fotocellens och veta varför mellanpunkten rör sig när ljuset ändras.

Allt med svenska ord, inga latinska uttryck som jag inte vill förklara.

== Ohms lag — den ultimata tre-storheten

Tre storheter som alltid hör ihop i en elektrisk krets:

#quickref(
  ([*Spänning (U)*], [Tryckskillnaden mellan två punkter. Enhet: volt (V). Exempel: 5 V.]),
  ([*Ström (I)*], [Hur mycket laddning som rör sig per sekund. Enhet: ampere (A). I småsensorik räknas det ofta i milliampere (mA).]),
  ([*Motstånd (R)*], [Hur mycket ett material bromsar strömmen. Enhet: ohm (Ω). Exempel: 220 Ω.]),
)

=== Formeln

#formula[$U = I dot R$]

I ord: *spänningen över en resistor är lika med strömmen genom den, gånger resistorns värde*.

Omformulerat för de gånger du söker annan storhet:

#formula[$I = U / R space.quad space.quad space.quad R = U / I$]

Eller med den klassiska *triangeln*. Rita en pyramid med U på toppen och I och R i botten. Håll över den storhet du vill räkna ut, så ser formeln sig själv.

```
      U
    -----
    I · R
```

Håll för U → ser du $I dot R$. Håll för I → ser du $U / R$. Håll för R → ser du $U / I$. Fungerar *varje gång*.

=== Varför bokstäverna U och I?

*U* kommer från tyskans "Spannung" (spänning). *I* från franskans "intensité du courant" (strömintensitet, Ampères terminologi).

Anglosaxiska böcker använder ibland $V$ för spänning istället för $U$ — samma sak, olika lokala traditioner. I Sverige och Tyskland: $U$. I Storbritannien och USA: $V$.

=== Första räkneexemplet

Om du har en resistor på 220 Ω och strömmen genom den är 15 mA, hur stor är spänningen över den?

#formula[$U = I dot R = 0,015 "A" dot 220 Omega = 3,3 "V"$]

Bra att komma ihåg: *ström ska omvandlas till ampere (inte milliampere) innan du räknar*. 15 mA = 0,015 A.

== Varför en LED *inte* följer Ohms lag

Här kommer det som knyter ihop allt. En resistor är en snäll komponent — den följer Ohms lag slaviskt. Dubbla spänningen, dubbla strömmen. Halvera spänningen, halvera strömmen. Linjärt.

En *LED är inte en resistor*. Den är en halvledar-diod med en trösklad I-V-karakteristik. På en graf av ström mot spänning ser den ut så här (ungefär):

```
      ström (I)
        │
        │                    ╱
        │                   ╱
        │                  ╱
        │                 ╱
        │                ╱
     ───┼────────────────╱──── spänning (U)
        │      0       Vf      5 V
```

*Upp till `Vf`* (framspänningen): nästan ingen ström alls. LED:en lyser inte.

*Vid `Vf`*: LED:en "vaknar" och börjar leda ström. Den lyser.

*Strax över `Vf`*: ström stiger *dramatiskt* med minimal ökning i spänning. Det här är farligt — en liten ökning av spänningen ger stor ökning av strömmen.

Så vad är Vf? Det är *framspänningsfallet* — den spänning LED:en "kräver" för att leda ström. För en röd LED är Vf ungefär 2 V.

=== Konsekvensen

Om du bara kopplar en röd LED till +5 V utan resistor, försöker LED:en dra så mycket ström den kan. Den lägger 2 V över sig själv (sin Vf) och de återstående 3 V har ingenstans att ta vägen — förutom att driva STRÖM genom LED:en. Massiv ström. Dioden bränns upp på under en sekund.

*Lösningen:* en resistor i serie som "äter upp" de återstående 3 V:en och håller strömmen på en säker nivå.

== Räkneexemplet — hur man kommer fram till 220 Ω

Krav:
- Matningsspänning: *5 V* från Arduinons pin 13.
- LED: *röd*, framspänningsfall ≈ *2 V*.
- Önskad ström: *15 mA* = 0,015 A. (Säker nivå långt under LED:ens 20 mA-max.)

Tanken är: resistorn och LED:en ligger i *serie*. Strömmen genom dem är samma. Spänningen fördelas så att LED:en tar sina 2 V och resistorn tar resten. Det ska bli 5 V totalt.

#formula[$U_"resistor" = 5 "V" - 2 "V" = 3 "V"$]

Nu vet vi spänningen över resistorn och strömmen genom den. Ohms lag löser resten:

#formula[$R = U / I = 3 "V" / 0,015 "A" = 200 Omega$]

*Exakt svar: 200 Ω.* Men resistor-värden säljs bara i fasta standardstegstorlekar — E12-serien, som innehåller 100, 120, 150, 180, *220*, 270, 330, 390, 470, osv. Det närmsta tillgängliga värdet över 200 är *220 Ω*.

Kolla vad strömmen faktiskt blir med 220 Ω:

#formula[$I = (5 "V" - 2 "V") / 220 Omega = 13,6 "mA"$]

Lite lägre än vårt ideal på 15 mA. *Det är helt OK.* LED:en lyser fortfarande starkt och håller sig inom säkra gränser. Skillnaden är ungefär som om en lampa kördes på 85 % av sin fulla styrka — synligt, men marginellt.

Det är *därför* 220 Ω valdes. Inget gissningsval — ren matematik.

== Vad händer om resistorn är för *liten*?

Säg att du byter till *120 Ω* istället. Strömmen blir:

#formula[$I = (5 "V" - 2 "V") / 120 Omega = 25 "mA"$]

25 mA > 20 mA (LED:ens max). Den börjar värmas upp, lyser starkare initialt, och tappar ljusstyrka efter någon minut som kiselet inuti degraderar. Efter några timmar eller dagar är den obrukbar — ljuset blir märkbart svagare, slut.

Säg att du använder *ingen resistor alls* (0 Ω). Då begränsar bara LED:ens egen fysik strömmen. Den lägger 2 V över sig själv, men det finns inget som tar upp de andra 3 V — strömmen skenar iväg och LED:en bränns upp på *mindre än en sekund*.

#warning(title: "En LED utan seriemotstånd är en död LED inom fem sekunder")[
  Låt det här vara en av de första reglerna ni lär er utantill. *Varje LED behöver en resistor i serie*. Utan undantag på kursens nivå. När ni sitter hemma och experimenterar och det finns en dag då ni är trötta och stressade och hoppar över resistorn "bara den här gången" — det är dagen ni får köpa nya LED:ar.
]

== Vad händer om resistorn är för *stor*?

Säg att du använder *2,2 kΩ* (2200 Ω) istället för 220. Strömmen blir:

#formula[$I = (5 "V" - 2 "V") / 2200 Omega = 1,4 "mA"$]

Det är tio gånger *mindre* än 15 mA. LED:en lyser — men *svagt*. Ungefär som en stearinlåga i dagsljus. Du kan knappt se att den är tänd. Ingen skada, bara svag.

Om resistorn är ännu större — säg *10 kΩ* — blir strömmen 0,3 mA. LED:en lyser kanske, kanske inte, beroende på LED:ens tröskelström. Osynlig för praktiska ändamål.

Så: *för liten resistor = LED dör*. *För stor resistor = LED lyser svagt eller inte alls*. Mellan dem finns ett lagom intervall på säg 180–330 Ω för röda LED:er på 5 V. 220 Ω ligger mitt i mjuka delen.

== Framspänningsfall för andra färger

En viktig detalj: *olika LED-färger har olika Vf*. Det betyder att räkningen för en grön eller blå LED ger ett annat resistor-värde.

#quickref(
  ([*Röd*], [Vf ≈ 1,8 – 2,0 V. Resistor för 15 mA på 5 V: runt 200 Ω → välj 220.]),
  ([*Gul*], [Vf ≈ 2,0 – 2,2 V. Nästan samma som röd. 220 Ω fungerar.]),
  ([*Grön*], [Vf ≈ 2,0 – 2,2 V (klassisk grön) eller 3,0 – 3,2 V (modern "ren grön"). 220 Ω för den klassiska.]),
  ([*Blå*], [Vf ≈ 3,0 – 3,4 V. Resistor: (5 − 3,2) / 0,015 ≈ 120 Ω. Men 220 Ω fungerar också, bara något svagare.]),
  ([*Vit*], [Vf ≈ 3,0 – 3,4 V (samma som blå, eftersom vita LED:er är blåa med fosforcoating). 220 Ω duger.]),
)

*Varför 220 Ω är ett säkert allroundval:* det är lagom för alla färger i kittet. Röda LED:ar hamnar på ~13 mA (säker). Blåa LED:ar hamnar på ~7 mA (något svaga men fungerar). Ingen färg får för mycket ström.

Om du vill optimera: räkna om med varje LED:s Vf och välj närmaste E12-värde. För kursen: 220 Ω överallt, klart.

== Spänningsdelaren — ohms lag för *två* resistorer

I Modul 4 byggde ni en *spänningsdelare* för att läsa av fotocellens motstånd. Så här fungerar den på papper.

=== Kopplingen

Två resistorer i serie mellan +5 V och GND. Mätpunkten är *mellan* dem.

```
  +5 V
    │
    ┢━━┓
    │  R1
    ┡━━┛
    │──── A0 (mätpunkt)
    ┢━━┓
    │  R2
    ┡━━┛
    │
   GND
```

Strömmen genom hela serien är samma (det är vad "serie" betyder):

#formula[$I = (5 "V") / (R_1 + R_2)$]

Spänningen vid mätpunkten, mätt mot GND, är spänningen *över R2*:

#formula[$V_"mid" = I dot R_2 = (R_2 / (R_1 + R_2)) dot 5 "V"$]

Detta är *spänningsdelar-formeln*. Den säger: andelen av inkommande spänning som hamnar på mätpunkten är samma som andelen $R_2$ i den totala resistansen.

=== Exempel 1 — två lika stora resistorer

Om $R_1 = R_2 = 1$ kΩ:

#formula[$V_"mid" = (1000 / (1000 + 1000)) dot 5 = 0,5 dot 5 = 2,5 "V"$]

Mellanpunkten ligger exakt halva. Intuitivt vettigt: lika bromsning på båda sidorna = spänningen delas lika.

=== Exempel 2 — fotocell i mörker

Fotocell i mörker ≈ 50 kΩ. Fast resistor = 1 kΩ. Fotocellen är R1 (över), 1 kΩ är R2 (under):

#formula[$V_"mid" = (1000 / (50000 + 1000)) dot 5 = 0,0196 dot 5 ≈ 0,098 "V"$]

*A0 visar ett väldigt lågt värde*. Arduinons analog-till-digital-omvandlare mäter 0,098 V → ungefär 20 på 0–1023-skalan.

=== Exempel 3 — fotocell i starkt ljus

Fotocell i starkt ljus ≈ 500 Ω. Fast resistor = 1 kΩ:

#formula[$V_"mid" = (1000 / (500 + 1000)) dot 5 = 0,667 dot 5 ≈ 3,33 "V"$]

*A0 visar cirka 682* (3,33 V / 5 V × 1023 ≈ 682).

=== Så varför pratar ni om siffror som 150 / 400 / 900?

Verkligt rumsljus ligger någonstans mellan mörk och strålande sol. Arduinons ADC är 10-bits (1024 steg) vilket innebär runt 5 mV upplösning. I praktiken:

#quickref(
  ([Mörker, hand över cellen], [A0 ≈ 20–100]),
  ([Rumsljus, taklampa], [A0 ≈ 150–400]),
  ([Direkt bordslampa], [A0 ≈ 500–700]),
  ([Ficklampa direkt], [A0 ≈ 700–900]),
  ([Midsommarsol direkt], [A0 ≈ 900 – 1023 (mättad)]),
)

Dessa är *riktvärden*. Din exakta fotocell, din breadboard, ditt rum — alla påverkar. Kalibrera alltid med Serial Monitor innan du sätter en tröskel i koden.

== Serie-resistorer, parallell-resistorer — snabbregler

För den som vill veta lite mer:

*Två resistorer i serie*: den totala resistansen är summan.
#formula[$R_"total" = R_1 + R_2$]

*Två resistorer parallellt* (ena änden ihop, andra änden ihop): den totala resistansen är *mindre* än den minsta. Formeln:
#formula[$R_"total" = (R_1 dot R_2) / (R_1 + R_2)$]

Ett specialfall värt att komma ihåg: två *lika stora* resistorer parallellt = halva värdet. Två 220 Ω parallellt = 110 Ω.

I kursen använder vi bara resistorer i serie. Men när ni googlar Arduino-projekt online kommer ni stöta på parallell-kopplingar också — nu vet ni vad de betyder.

== Sammanfattning — det mest centrala

+ *Ohms lag:* $U = I dot R$. Tre variabler, en formel, tre omformuleringar.
+ *En LED kräver resistor i serie.* Alltid. Varje gång.
+ *Räkningen för 5 V + röd LED + 15 mA:* `(5 − 2) / 0,015 = 200 Ω` → välj 220 Ω.
+ *Olika färger = olika Vf*, men 220 Ω funkar som allroundval på 5 V.
+ *Spänningsdelaren* delar upp en spänning mellan två seriekopplade resistorer. Mellanpunktens spänning bestäms av förhållandet mellan resistorerna.

Och det viktigaste: *när något inte fungerar i en krets är oftast svaret "räkna om"*. Inte "gissa igen".
