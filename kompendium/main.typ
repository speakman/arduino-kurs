// main.typ
// Entry point för Arduino-kursens kompendium.
// Kompileras med: typst compile main.typ kompendium.pdf

#import "theme.typ": *

#show: kompendium.with(
  title: "Arduino-kurs · Kompendium",
  author: "FRO Ånge",
  date: "2026",
)

// ═══════════════════════════════════════════════════════════════════
// TITELSIDA
// ═══════════════════════════════════════════════════════════════════

#set page(header: none, numbering: none)

#v(5cm)

#align(center)[
  #text(font: sans-font, size: 10pt, fill: cyan, tracking: 3pt)[
    #upper[FRO Ånge · Nybörjarkurs · Våren 2026]
  ]

  #v(1.5cm)

  #text(font: sans-font, size: 46pt, weight: "bold", fill: ink)[
    Elektronik &
  ]
  #v(-0.4em)
  #text(font: sans-font, size: 46pt, weight: "bold", fill: ink)[
    Programmering
  ]
  #v(-0.4em)
  #text(font: sans-font, size: 46pt, weight: "bold", fill: ink)[
    med Arduino
  ]

  #v(1cm)

  #text(font: sans-font, size: 14pt, fill: muted)[
    Kompendium · fem träffar · från första kretsen till fungerande tjuvlarm
  ]

  #v(1.2cm)

  #line(length: 4cm, stroke: 1.2pt + cyan)

  #v(0.4cm)

  #text(font: sans-font, size: 10pt, fill: muted)[
    Baserat på ELEGOO UNO Project Basic Starter Kit
  ]
]

#v(1fr)

#align(center)[
  #text(font: sans-font, size: 9pt, fill: muted, tracking: 1.5pt)[
    #upper[FRO Ånge · 2026]
  ]
]

#pagebreak()

// ═══════════════════════════════════════════════════════════════════
// FÖRORD
// ═══════════════════════════════════════════════════════════════════

#set page(header: none, numbering: none)

#v(3cm)

#block[
  #set text(font: sans-font, size: 9pt, fill: cyan, weight: "medium", tracking: 2pt)
  #upper[Förord]
]
#v(-4pt)
#block[
  #set text(font: sans-font, size: 24pt, weight: "bold")
  Detta är ditt kompendium.
]
#v(4pt)
#line(length: 4cm, stroke: 1.2pt + cyan)
#v(1cm)

Det du håller i handen är inte en lärobok i elektronik. Det är inte heller en bruksanvisning till Arduino. Det är en *referens* — den plats där du slår upp det ni gick igenom i klassrummet när det där ordet du behövde försvann igen.

Kompendiet följer samma struktur som de fem träffarna. Varje modulkapitel börjar med vad ni gjorde den kvällen, repeterar de viktigaste begreppen, och ger dig tre hemma-övningar att öva på i lugn och ro vid köksbordet. Sist i varje kapitel finns en snabbreferens du kan peka på när något trasslar.

Efter modulerna följer sex bilagor — en fördjupning av saker som inte fick plats på slidesen: syntax-grammatik (vad `const int` egentligen betyder), hur du läser felmeddelanden (Arduino-IDE:s felpanel är din bästa vän), en komponentlista med gotchor, en fullständig hackathon-lösning för den som fastnar, en säkerhets-checklista, och en ordentligt genomtänkt förklaring av Ohms lag och framspänningsfall.

Tonläget är avsiktligt direkt. Jag antar att du är en vuxen människa som kan lite redan, som inte är rädd för att ha fel, och som hellre får svaret rakt än paketerat i floskler. Ni är radioamatörer. Ni klarar det.

Om något är oklart: fråga vid nästa träff. Eller öppna Serial Monitor, skriv ut värdet, och se med egna ögon vad Arduinon faktiskt tänker. Det sista är ofta det som löser gåtan.

#v(1cm)

#align(right)[
  #text(font: sans-font, size: 10pt, style: "italic", fill: muted)[
    — kursledaren, april 2026
  ]
]

#pagebreak()

// ═══════════════════════════════════════════════════════════════════
// INNEHÅLLSFÖRTECKNING
// ═══════════════════════════════════════════════════════════════════

#set page(header: none, numbering: none)

#v(2cm)

#block[
  #set text(font: sans-font, size: 9pt, fill: cyan, weight: "medium", tracking: 2pt)
  #upper[Innehåll]
]
#v(-4pt)
#block[
  #set text(font: sans-font, size: 24pt, weight: "bold")
  Vad du hittar var.
]
#v(4pt)
#line(length: 4cm, stroke: 1.2pt + cyan)
#v(1cm)

#outline(title: none, depth: 2, indent: 1.2em)

#pagebreak()

// ═══════════════════════════════════════════════════════════════════
// MODULKAPITEL
// ═══════════════════════════════════════════════════════════════════

#set page(numbering: "1")
#counter(page).update(1)

#include "01-modul-1.typ"
#include "02-modul-2.typ"
#include "03-modul-3.typ"
#include "04-modul-4.typ"
#include "05-modul-5.typ"

// ═══════════════════════════════════════════════════════════════════
// BILAGOR
// ═══════════════════════════════════════════════════════════════════

#include "appendix-a-syntax.typ"
#include "appendix-b-felmeddelanden.typ"
#include "appendix-c-komponenter.typ"
#include "appendix-d-hackathon-losning.typ"
#include "appendix-e-sakerhet.typ"
#include "appendix-f-framspanningsfall.typ"
