#import "theme.typ": *

// ═══════════════════════════════════════════════════════════════════
// APPENDIX B · FELMEDDELANDEN
// ═══════════════════════════════════════════════════════════════════

#module-heading(
  "Bilaga B",
  "Felmeddelanden",
  "Hur du läser Arduino-IDE:ns gnäll, och vad det faktiskt betyder.",
)

== Varför meddelandena ser kryptiska ut

Arduino-IDE:n använder en riktig C++-kompilator under huven (`avr-g++`). Den är ett verktyg för proffs som skrivit miljoner rader kod och accepterat att felmeddelanden ibland ser akademiska ut. De är långa, tekniska, och verkar peka på fel plats — men det finns logik bakom dem.

*Grundregeln:* felmeddelanden pekar på *den rad där kompilatorn insåg att något var fel*, inte nödvändigtvis *den rad där du gjorde misstaget*. Om du glömmer ett semikolon på rad 10 kommer kompilatorn klaga på rad 11.

*Andra grundregeln:* läs alltid det *första* felmeddelandet, inte det sista. Senare fel är ofta följdfel från det första.

== Kompilatorsfel du kommer stöta på

=== `expected ';' before ...`

Det vanligaste felet. Du har glömt ett semikolon.

```cpp
digitalWrite(LED_BUILTIN, HIGH)    // saknar ;
delay(1000);                       // kompilatorn klagar HÄR
```

Kompilatorn läste rad 1, förväntade sig `;` men hittade `delay` istället. Felet pekas ut på rad 2, men fixa rad 1.

=== `'variabel' was not declared in this scope`

En variabel används utan att ha deklarerats — ofta stavfel, eller variabeln är lokal och du försöker nå den någon annanstans.

```cpp
void setup() {
  int temp = 5;
}

void loop() {
  Serial.println(temp);   // FEL: temp finns bara i setup()
}
```

Fixa genom att flytta `int temp = 5;` till global nivå (överst i filen), eller deklarera en ny `temp` i loop.

Eller — oftast — stavfelet. Två varianter av samma fel:

```cpp
digitalWrit(13, HIGH);    // FEL: saknar 'e' på slutet
digitalwrite(13, HIGH);   // FEL: fel skiftläge på 'w'
```

Rätt är `digitalWrite` — med *stort W och e på slutet*. Arduino är *skiftlägeskänsligt*: `digitalwrite` och `DigitalWrite` är olika ord i kompilatorns ögon. Det vanligaste felet är att tappa `e`:t; det näst vanligaste är att glömma skiftläget.

=== `expected '}' at end of input`

Du har glömt att stänga ett block någonstans i filen. Räkna alla `\{` och se till att det finns lika många `\}`.

#tip(title: "Hitta obalanserade klammer")[
  Arduino-IDE:n markerar matchande klammer när du klickar på en. Klicka på ett `\{` — den motsvarande `\}` ska markeras automatiskt. Om det inte finns en, har du hittat problemet.
]

=== `'LED_BUILTIN' was not declared in this scope` (ovanligt)

Brukar bero på att `#include <Arduino.h>` saknas — men det inkluderas automatiskt av Arduino IDE. Ser du det här felet har du sannolikt skapat en fil manuellt utanför en vanlig `.ino`-sketch. Starta en ny sketch från IDE:n istället.

=== `void value not ignored as it ought to be`

En funktion som inte returnerar något (`void`) har använts som om den gav tillbaka ett värde:

```cpp
int x = delay(100);    // FEL: delay returnerar void
```

Rätt är att bara anropa den:

```cpp
delay(100);
```

=== `assignment of read-only variable`

Du har försökt ändra värdet på en `const` variabel:

```cpp
const int ledPin = 13;
ledPin = 12;            // FEL: const går inte att ändra
```

Antingen: ta bort `const` om värdet *ska* kunna ändras. Eller: hitta den riktiga variabeln du menade att ändra.

=== `invalid operands of types ... to binary 'operator'`

Du har blandat inkompatibla typer i ett uttryck:

```cpp
int x = "hej" + 5;      // FEL: sträng + int
```

Arduino är strikt med typer. Du kan inte addera ett tal till en textsträng rakt av. Fixa genom att tänka igenom vad du faktiskt vill göra — oftast menade du någonting helt annat.

=== `too many arguments to function`

Du har skickat in fler argument än funktionen förväntar:

```cpp
digitalWrite(LED_BUILTIN, HIGH, 100);   // FEL: digitalWrite tar bara 2 argument
```

Kolla funktionens signatur. Oftast är det `delay` du egentligen ville ha på slutet:

```cpp
digitalWrite(LED_BUILTIN, HIGH);
delay(100);
```

== Upload-fel (inte kompileringsfel)

Här kör kompilatorn klart, men programmet kan inte överföras till Arduinon.

=== `avrdude: stk500_getsync(): not in sync`

IDE:n kan inte prata med Arduinon. Fyra vanliga orsaker:

+ *Fel port i Tools → Port*. Välj den port som heter något med "Arduino" eller "usbserial".
+ *Fel board i Tools → Board*. Välj "Arduino Uno".
+ *USB-kabeln är en laddkabel, inte en datakabel*. Arduino Uno R3 använder en USB Type B-kontakt (den kvadratiska, "printer-style"). Kontrollera att kabeln faktiskt överför data — många billiga kablar är bara ström.
+ *Arduinon är inte ansluten till datorn*. Låter självklart, men händer.

=== `Serial port 'COMx' not found`

Porten försvann. Koppla ur och i Arduinon, vänta några sekunder, välj porten igen i Tools → Port.

=== `Port busy` eller `Port in use`

Serial Monitor är öppet och blockerar porten. Stäng Serial Monitor innan du uppladdar. IDE:n öppnar den automatiskt igen efter uppladdningen.

== Runtime-beteenden (inte fel — men mystiska)

Ibland kompilerar programmet, laddas upp utan problem, men beter sig inte som du väntar. Här är några klassiker:

=== "Programmet gör ingenting"

Vanligaste orsaker:
+ Du använder fel pinne. Kontrollera att kabeln faktiskt sitter i pin 13 och inte pin 12.
+ Komponenten är inte ansluten. Lös kabel? Har LED:en fallit av breadboarden?
+ Polaritet fel. LED:en vänd åt fel håll? Resistorn saknas?
+ `pinMode` saknas. Alla utgångar måste sättas som `OUTPUT` i `setup`, alla ingångar som `INPUT` eller `INPUT_PULLUP`.

=== "Programmet gör något men inte det jag vill"

Lägg in `Serial.println()` överallt där du misstänker att det går fel. Printa villkorsvariabler, mätvärden, vilken gren av if/else som körs. Arduinon är inte mystisk — den är bara tyst. Gör den pratig.

```cpp
Serial.print("larmPaslaget=");
Serial.print(larmPaslaget);
Serial.print(" ljus=");
Serial.println(ljus);
```

=== "Buzzern tjuter konstant"

En av grenarna i din if/else skriver `HIGH` men ingen återställer till `LOW`. Se till att *varje* gren skriver både `HIGH` och `LOW` på buzzern.

=== "Knappen ger flera tryck åt gången"

Knappens metallblad studsar fysiskt några millisekunder. Lägg en `delay(10)` eller `delay(50)` i slutet av loopen — enklaste formen av debounce.

=== "Serial Monitor är tom"

Tre saker att kontrollera:
+ `Serial.begin(9600);` finns i setup?
+ Baud rate i Serial Monitor står på 9600 (matchar siffran i `Serial.begin`)?
+ Skriver du faktiskt till Serial någonstans (`Serial.print` eller `Serial.println`)?

=== "Serial Monitor visar konstig text"

Baud rate matchar inte. Kontrollera att både `Serial.begin()` och Serial Monitor står på samma siffra. 9600 är kursens standard.

=== "LED-styrkan ändras inte med analogWrite"

Du använder en pinne som inte stödjer PWM. Kolla att det finns `~` framför pin-numret på Arduino-kortet. Giltiga PWM-pinnar på Uno: *3, 5, 6, 9, 10, 11*.

== Felsöknings-checklista

När något inte fungerar, gå igenom i ordning:

+ *Läs felmeddelandet högt*. Ofta räcker det.
+ *Kontrollera första felmeddelandet*, inte det sista.
+ *Kolla pin-numren*. Stämmer de med vad du kopplat?
+ *Kolla polariteten*. LED, RGB-LED, buzzer — alla har riktning.
+ *Kolla att kabeln sitter i rätt hål*. "Samma rad på breadboarden" är en favoritbugg.
+ *Printa allt*. Lägg `Serial.println` i varje gren av varje if/else och läs vad som händer.
+ *Ladda om Arduino IDE*. I sällsynta fall får IDE:n hicka och måste startas om.
+ *Fråga någon*. Inte kursledaren — grannen. Två par ögon hittar fel snabbare än ett.

#tip(title: "Felsökningsfilosofi")[
  När något inte fungerar är det frestande att *gissa*. Det är näst intill alltid fel strategi. *Ta reda på* — printa värden, kolla polariteten, läs felmeddelandet. Varje gång du fixar en bugg genom gissning istället för att verifiera, har du bara haft tur. Verifiera, vinn.
]
