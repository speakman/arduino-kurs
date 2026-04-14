// Per-modul PDF: Modul 2 — PWM & RGB
// Kompileras med: typst compile main-modul-2.typ modul-2.pdf

#import "theme.typ": *

#show: kompendium.with(
  title: "Arduino-kurs · Modul 2 · PWM & RGB",
  author: "FRO Ånge",
  date: "2026",
)

#set page(numbering: "1")
#counter(page).update(1)

#include "02-modul-2.typ"
