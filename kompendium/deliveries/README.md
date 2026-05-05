# Arduino-kurs leveranser

Alla filer i den här mappen är tänkta att distribueras till kursdeltagarna eller skrivas ut på FRO-lokalen.

> **TL;DR för digital distribution:** se `distribution/` — där ligger allt färdiguppdelat per dag (inklusive spoiler-skydd för hackathon-lösningen). Öppna `distribution/README.md`.

## Per-modul-PDF:er (skriv ut före varje träff)

Varje kapitel är ~10 sidor, svart-vit printervänligt.

| Fil | När | Innehåll |
|---|---|---|
| `modul-1-led-krets.pdf` | Före träff 1 | LED, resistor, Ohms lag, Blink, breadboard, Kretsen, hemma-övningar |
| `modul-2-pwm-rgb.pdf` | Före träff 2 | `analogWrite`, PWM duty cycle, RGB common-cathode, färgblandning, hemma-övningar |
| `modul-3-digital-input.pdf` | Före träff 3 | `digitalRead`, `INPUT_PULLUP`, if/else, edge-detection, active buzzer, hemma-övningar |
| `modul-4-analog-input.pdf` | Före träff 4 | `analogRead`, spänningsdelare (höjdskala-analogi), fotocell, tilt, Serial Monitor, hemma-övningar |
| `modul-5-hackathon.pdf` | Före träff 5 | Hackathon-struktur, pin-karta, sense-act-loop, referens-sketch, efter-kursen-rekommendationer |

Lämna dem vid varje plats innan kursen börjar — deltagarna tar hem sin efter träffen.

## Bilagorna

Tre varianter finns:

| Fil | När | Innehåll |
|---|---|---|
| `bilagor-tidiga.pdf` | Med Dag 1 | Bilaga A (syntax), B (felmeddelanden), C (komponenter), E (säkerhet), F (Ohms lag) — **ingen spoiler** |
| `bilaga-d-hackathon-losning.pdf` | Efter Dag 5 | Fullständig kommenterad referens-sketch för tjuvlarmet |
| `bilagor-a-f.pdf` | Efter kursen | Alla sex bilagor samlade (A–F) |

## Fullständigt kompendium

`kompendium.pdf` — alla fem moduler + alla sex bilagor i ett samlat dokument (17 MB, ~90 sidor). Skicka som en enda PDF till deltagarna efter kursen via e-post, eller tryck upp som ringpärm-referens till FRO-biblioteket.

## Slide-deck backup

`slides-arduino-kurs.pdf` — statiskt PDF-snapshot av hela Slidev-presentationen. Behövs inte för undervisning (kör hellre `npm run dev` i `presentation/`-katalogen) men fungerar som snapshot att mejla till deltagare som vill ha projektions-varianten.

### Per-dag-uppdelning

`slides-per-dag/slides-dag-N.pdf` — decket splittat vid varje *Träff N av 5*-divider. Användbart om en deltagare missat en träff och bara vill ha den dagens slides, eller om du vill maila ut en dag i taget.

| Fil | Sidor | Innehåll |
|---|---|---|
| `slides-dag-1.pdf` | 1–19 | Omslag + kursöversikt + Träff 1 (LED & krets) |
| `slides-dag-2.pdf` | 20–26 | Träff 2 (PWM & RGB) |
| `slides-dag-3.pdf` | 27–37 | Träff 3 (Digital input) |
| `slides-dag-4.pdf` | 38–48 | Träff 4 (Analog input) |
| `slides-dag-5.pdf` | 49–53 | Träff 5 (Hackathon) |

## Varför inga slide-referenser i kompendiet?

Tidigare versioner hade `#tip("I slidesen")[Slide 25–34: ...]`-boxar i varje modulkapitel. Dessa är *borttagna* i den slutliga versionen eftersom:

1. *Kompendiet är den auktoritativa, fylligare källan* — allt från slides finns där, plus mer. Det är inte en kompletterande referens till slides, utan omvänt.
2. *Slide-numren driftar* varje gång decket redigeras — referenserna blir snabbt stale.
3. *Deltagarna läser kompendiet ensamma hemma* — de har inte slides framför sig samtidigt.

Vill du ändå ha cross-refs: se `slides-arduino-kurs.pdf` som kompletterande artefakt. Den har samma innehåll fast i slide-format.

## Bygga om filer från källa

Alla PDF:er byggs från `.typ`-källfiler i kompendium-mappen:

```
cd kompendium
bash build.sh         # bygger alla 7 PDF:er + full kompendium
```

Slide-decket byggs separat:

```
cd presentation
npm run build             # produktion-bygge (dist/)
npm run dev               # dev-server med live reload
npx slidev export         # exportera PDF-snapshot
```
