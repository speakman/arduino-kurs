// Per-modul PDF: Modul 5 — Integration / Hackathon
// Kompileras med: typst compile main-modul-5.typ modul-5.pdf

#import "theme.typ": *

#show: kompendium.with(
  title: "Arduino-kurs · Modul 5 · Hackathon",
  author: "FRO Ånge",
  date: "2026",
)

#set page(numbering: "1")
#counter(page).update(1)

#include "05-modul-5.typ"
