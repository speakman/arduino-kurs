// Per-modul PDF: Modul 1 — LED & krets
// Kompileras med: typst compile main-modul-1.typ modul-1.pdf

#import "theme.typ": *

#show: kompendium.with(
  title: "Arduino-kurs · Modul 1 · LED & krets",
  author: "FRO Ånge",
  date: "2026",
)

#set page(numbering: "1")
#counter(page).update(1)

#include "01-modul-1.typ"
