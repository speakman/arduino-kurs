// Per-kapitel PDF: Bara Bilaga D (hackathon-lösning)
// Delas ut EFTER hackathonen (dag 5) — innehåller fullständig referens-sketch.
// Kompileras med: typst compile main-bilaga-d.typ bilaga-d-hackathon-losning.pdf

#import "theme.typ": *

#show: kompendium.with(
  title: "Arduino-kurs · Bilaga D",
  author: "FRO Ånge",
  date: "2026",
)

#set page(numbering: "1")
#counter(page).update(1)

#include "appendix-d-hackathon-losning.typ"
