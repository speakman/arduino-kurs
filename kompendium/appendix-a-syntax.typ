#import "theme.typ": *

// ═══════════════════════════════════════════════════════════════════
// APPENDIX A · SYNTAX-GRAMMATIK
// ═══════════════════════════════════════════════════════════════════

#module-heading(
  "Bilaga A",
  "Syntax-grammatik",
  "Datatyper, operatorer, scope, funktioner — det lilla språket under Arduinons huva.",
)

== Vad "kod" egentligen är

En Arduino-sketch är ett program skrivet i *C++*. Det är ett fullfjädrat programmeringsspråk med egna regler för hur orden får kombineras — precis som svenska har grammatik och stavningsregler. Felar du mot dem vägrar kompilatorn att översätta din text till något Arduinon kan köra.

Kursens slides presenterar syntax genom exempel, men ingen formell översikt. Den här bilagan är den formella översikten. Den är inte uttömmande — den täcker *det ni använder på kursen*, inte hela C++.

== Variabler och datatyper

=== Deklaration

En variabel är ett namngivet utrymme där du kan lagra ett värde. För att skapa en skriver du dess *datatyp*, dess *namn*, och (valfritt) ett *initialvärde*:

```cpp
int count = 0;
bool larmPaslaget = false;
const int knappPin = 9;
```

- `int` är datatypen — heltal.
- `count` är namnet du hittat på.
- `= 0` är initialvärdet — ditt val.
- `;` avslutar raden. Glömmer du semikolonet klagar kompilatorn.

=== Primitiva datatyper som kursen använder

#quickref(
  ([`int`], [Heltal. −32768 till 32767 på Uno (16-bit). Använd när du räknar något: räknare, mätvärden, pin-nummer.]),
  ([`long`], [Stort heltal. Upp till ±2 miljarder. Använd `unsigned long` för `millis()`-tid eftersom den växer snabbt.]),
  ([`byte`], [Heltal 0–255. Perfekt för PWM-värden, bytes från sensorer, bitfält.]),
  ([`bool`], [Antingen `true` eller `false`. Använd för till/från-tillstånd.]),
  ([`float`], [Decimaltal. 3,14, −0,001 osv. Långsammare än `int`, undvik om du inte måste.]),
  ([`char`], [Ett enstaka tecken, typ `'a'`. Används sällan i denna kurs.]),
)

=== `const` — "det här värdet ändras aldrig"

Prefixet `const` låser värdet efter det tilldelats. Försöker du skriva över det senare, vägrar kompilatorn.

```cpp
const int ledPin = 13;    // bestämt nu, för evigt
int pressCount = 0;       // kan ändras
```

*Använd `const int` för pin-nummer och andra fasta värden.* Det gör koden läsbar och hindrar dig från att råka ändra värdet av misstag.

=== `const int` vs `#define` — samma resultat, olika vägar

I Arduino-exempel ser ni båda skrivsätten:

```cpp
const int ledPin = 13;    // modern C++
#define LED_BUILTIN 13    // äldre C-makro
```

De fungerar ungefär likadant — båda ger namnet `ledPin` eller `LED_BUILTIN` värdet 13 — men under huven är de olika saker.

`const int` deklarerar en *riktig variabel* som lagras i minnet och som har en datatyp (`int`). Kompilatorn vet att det är ett heltal och kan stoppa dig från att använda det fel, till exempel skriva `ledPin = "text"`.

`#define` är ett *textmakro*: preprocessorn går igenom filen innan kompilatorn ser den, och ersätter varje förekomst av `LED_BUILTIN` med `13`. Ingen datatyp, ingen typkontroll. Det är ett äldre C-arv från 70-talet.

#fact(title: "Varför båda?")[
  Arduino-biblioteket (`Arduino.h`) använder `#define` av historiska skäl — makron fanns i C långt innan `const` blev standardiserad och typstark. För *er egen kod* på kursen använder vi `const int`, eftersom det är tydligare, typstarkt, och uppmärksammar dig direkt om du råkar göra något galet. Att Arduino-biblioteket självt använder `#define` är helt OK — det är etablerat och välbeprövat.
]

== Operatorer

=== Aritmetiska

```cpp
a + b     // addition
a - b     // subtraktion
a * b     // multiplikation
a / b     // division (heltal!)
a % b     // modulo — resten efter division
a++       // öka a med 1
a--       // minska a med 1
a += 5    // kortare form av: a = a + 5
```

#warning(title: "Heltalsdivision trickar många")[
  `int a = 5 / 2;` ger `a = 2`, inte `2.5`. Heltal avrundas nedåt. För decimalsvar måste du använda `float`: `float a = 5.0 / 2.0;` ger `2.5`.
]

=== Jämförelse

```cpp
a == b    // lika
a != b    // olika
a < b     // mindre än
a > b     // större än
a <= b    // mindre eller lika
a >= b    // större eller lika
```

*Det vanligaste nybörjarfelet:* att skriva `=` (tilldelning) istället för `==` (jämförelse).

```cpp
if (x = 5) { ... }   // FEL: tilldelar 5 till x, alltid sant
if (x == 5) { ... }  // RÄTT: jämför x med 5
```

Kompilatorn varnar ibland, men inte alltid. Läs raden högt: "om x är lika med 5" = `==`. "Sätt x till 5" = `=`.

=== Logiska

```cpp
a && b    // OCH — båda måste vara sanna
a || b    // ELLER — minst en måste vara sann
!a        // INTE — vänder på sanningsvärdet
```

Används i `if`-villkor och tillstånd:

```cpp
if (larmPaslaget && lutad) {
  // både larm på OCH tilt lutad
}

if (!larmPaslaget || ljus > 500) {
  // larm AV, ELLER det är ljust
}
```

`!` framför en variabel är *logisk inversion* — det "motsatta". `!true` = `false`, `!false` = `true`. Används ofta för att toggla: `larmPaslaget = !larmPaslaget;`.

== Villkorssatser

=== `if` / `else`

```cpp
if (villkor) {
  // kör om villkor är sant
} else {
  // annars
}
```

Flera alternativ kedjas med `else if`:

```cpp
if (ljus < 200) {
  // kolsvart
} else if (ljus < 500) {
  // halvmörkt
} else {
  // ljust
}
```

Körs i ordning — första matchande gren vinner, resten hoppas över.

=== Kort if-syntax (ternär)

```cpp
int värde = (villkor) ? omSant : omFalskt;

// exempel:
digitalWrite(LED_BUILTIN, larmPaslaget ? HIGH : LOW);
```

Läses: "om larmPaslaget, sätt HIGH, annars sätt LOW". En rad istället för fyra.

== Loopar

=== `for` — upprepa ett bestämt antal gånger

```cpp
for (int i = 0; i < 10; i++) {
  // kör tio gånger, med i = 0, 1, 2, ..., 9
}
```

Tre delar, åtskilda med semikolon:
+ *Initiering*: `int i = 0` — körs en gång innan loopen.
+ *Villkor*: `i < 10` — testas före varje varv. När det blir falskt, avslutas loopen.
+ *Uppdatering*: `i++` — körs efter varje varv.

Användbart för till exempel att tona en LED från släckt till tänd:

```cpp
for (int v = 0; v <= 255; v++) {
  analogWrite(ledR, v);
  delay(10);
}
```

=== `while` — upprepa tills något ändras

```cpp
while (villkor) {
  // körs så länge villkor är sant
}
```

Kursens `void loop()` är i själva verket ett inbyggt `while`-loop som aldrig avslutas. Du skriver det inte själv, Arduino-ramverket gör det åt dig.

== Funktioner

En *funktion* är ett namngivet stycke kod du kan anropa. `setup` och `loop` är funktioner. Så är `digitalWrite` och `delay`. Du kan skriva egna också:

```cpp
void blink(int tid) {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(tid);
  digitalWrite(LED_BUILTIN, LOW);
  delay(tid);
}
```

Delar:
- `void` är *returtypen* — vad funktionen ger tillbaka. `void` betyder "inget".
- `blink` är namnet.
- `(int tid)` är *parameterlistan* — värden som funktionen tar emot. Här ett heltal som heter `tid`.
- `{ ... }` är funktionens kropp — koden som körs.

Anropa den senare med `blink(200);` eller `blink(1000);`.

En funktion som *ger tillbaka* ett värde har annan returtyp:

```cpp
int dubbelt(int x) {
  return x * 2;
}

// Användning:
int y = dubbelt(7);   // y blir 14
```

== Scope — var en variabel syns

Variabler deklarerade *inne i* en funktion är *lokala* — de syns bara där.

```cpp
void setup() {
  int temp = 5;
  // temp finns bara här inne
}

void loop() {
  // temp finns INTE här — kompilerings-fel om du försöker använda det
}
```

Variabler deklarerade *utanför* alla funktioner — längst upp i filen — är *globala* och syns överallt.

```cpp
int tryckCount = 0;    // global — syns i både setup och loop

void setup() {
  tryckCount = 5;   // OK
}

void loop() {
  tryckCount++;     // OK
}
```

*Regeln för kursen:* deklarera `const int` för pin-nummer och andra konstanter globalt, överst i filen. Deklarera tillståndsvariabler (`larmPaslaget`, `lastState`) globalt så att de överlever mellan `loop`-varv. Tillfälliga hjälpvärden (räknare, nuvarande mätvärde) deklareras lokalt där de behövs.

#tip(title: "Varför 'lokal'?")[
  Lokala variabler försvinner när funktionen återvänder — minnet frigörs för nya variabler. Globala lever hela programmets livstid. Det är därför `int state = digitalRead(knappPin);` kan stå inne i loop — den skapas på nytt varje varv, används, och kastas bort. `lastState` däremot måste vara global så att den överlever mellan varven.
]

== Kommentarer

```cpp
// En en-rads-kommentar. Allt efter // på raden ignoreras.

/*
  En flera-rads-kommentar.
  Allt mellan tecknen ignoreras.
*/
```

Använd dem för att förklara *varför* något görs, inte *vad* koden gör — det ser man ändå. Bra kommentar: `// edge-detection — annars flippar larmet 10000 ggr/sek`. Dålig: `// sätt pin 13 till HIGH`.

== Arduino-specifika konstanter

Några värden Arduino-biblioteket definierar åt dig och som ni redan sett:

#quickref(
  ([`HIGH`, `LOW`], [De två logiska nivåerna. Används med `digitalWrite` och `digitalRead`.]),
  ([`INPUT`, `OUTPUT`, `INPUT_PULLUP`], [Används med `pinMode`.]),
  ([`LED_BUILTIN`], [Vanligtvis pin 13 — där den inbyggda LED:en sitter.]),
  ([`A0` – `A5`], [Analoga pinnar, används med `analogRead`.]),
  ([`true`, `false`], [Booleska värden.]),
)

Dessa är `#define`-s i `Arduino.h` — samma historiska arv som diskuterades tidigare. Du kan inte ändra dem, bara använda dem.

== Vanliga kompilatorsfel

#quickref(
  ([`expected ';' before...`], [Glömt semikolon på föregående rad. IDE:n pekar på *nästa* rad — felet är raden innan.]),
  ([`'foo' was not declared in this scope`], [Stavfel, eller variabel används utanför sitt scope. Kontrollera att variabeln är global eller lokal där den används.]),
  ([`expected '\}' at end of input`], [Glömt stänga ett block. Räkna måsvingarna — varje `\{` måste ha en `\}`.]),
  ([`left operand of ',' has no effect`], [Du har skrivit `,` istället för `;` mellan två uttryck.]),
  ([`invalid operands of types 'const char*' and 'int'`], [Du har försökt göra matematik på en sträng. Kontrollera vad du skriver in i operatorn.]),
)

En uttömmande genomgång av felmeddelanden finns i Bilaga B.
