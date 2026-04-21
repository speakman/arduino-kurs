// Per-kapitel PDF: Bilagor som kan delas ut tidigt (A, B, C, E, F)
// Bilaga D är utelämnad eftersom den spoilar hackathon-lösningen.
// Kompileras med: typst compile main-bilagor-tidiga.typ bilagor-tidiga.pdf

#import "theme.typ": *

#show: kompendium.with(
  title: "Arduino-kurs · Bilagor (A, B, C, E, F)",
  author: "FRO Ånge",
  date: "2026",
)

#set page(numbering: "1")
#counter(page).update(1)

#include "appendix-a-syntax.typ"
#include "appendix-b-felmeddelanden.typ"
#include "appendix-c-komponenter.typ"
#include "appendix-e-sakerhet.typ"
#include "appendix-f-framspanningsfall.typ"
