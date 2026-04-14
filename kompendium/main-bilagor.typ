// Per-kapitel PDF: Alla bilagor (A–F)
// Kompileras med: typst compile main-bilagor.typ bilagor.pdf

#import "theme.typ": *

#show: kompendium.with(
  title: "Arduino-kurs · Bilagor",
  author: "FRO Ånge",
  date: "2026",
)

#set page(numbering: "1")
#counter(page).update(1)

#include "appendix-a-syntax.typ"
#include "appendix-b-felmeddelanden.typ"
#include "appendix-c-komponenter.typ"
#include "appendix-d-hackathon-losning.typ"
#include "appendix-e-sakerhet.typ"
#include "appendix-f-framspanningsfall.typ"
