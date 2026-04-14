// Per-modul PDF: Modul 3 — Digital input
// Kompileras med: typst compile main-modul-3.typ modul-3.pdf

#import "theme.typ": *

#show: kompendium.with(
  title: "Arduino-kurs · Modul 3 · Digital input",
  author: "FRO Ånge",
  date: "2026",
)

#set page(numbering: "1")
#counter(page).update(1)

#include "03-modul-3.typ"
