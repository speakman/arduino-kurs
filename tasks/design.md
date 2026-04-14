---
name: Arduino-kurs presentation – design
description: Design-spec för Slidev-presentation till 5-veckors Arduino/elektronikkurs
type: spec
date: 2026-04-13
---

# Arduino-kurs presentation — Design

**Verktyg:** Slidev (senaste version, 52.x)
**Mål:** Proffsig, visuellt polerad, offline-körbar presentation för 5-träffars Arduino/elektronikkurs för nybörjare.
**Kit:** ELEGOO UNO Project Basic Starter Kit (forskning pågår i bakgrunden)

---

## Visuell koncept och genomgående metafor

**Bärande idé:** "5 superkrafter". Varje träff låser upp en ny superkraft — från att tända en lysdiod till att bygga ett fullständigt tjuvlarm.

- Översikts-sliden visar alla 5 superkrafter som **låsta ikoner**.
- Varje träff-divider låser upp nästa superkraft med en kort animation.
- Avslutnings-sliden visar alla 5 upplåsta → grattis.

Detta ger en visuell genomgående linje som knyter ihop hela kursen och skapar framåtdrift mellan träffarna.

## Visuell identitet

| Element | Val |
|---|---|
| **Bakgrund** | Deep charcoal `#0a0e14` (nästan svart, men mjukare för ögonen) |
| **Primär accent** | Elektrisk cyan `#00ffd1` (Arduino-anda, pop på mörkt) |
| **Sekundär accent** | Signal-gul `#ffd400` (för varningar, viktiga moment) |
| **Röd accent** | `#ff3366` (endast för "LARM"-moment, buzzern, varningsrutor) |
| **Text primär** | `#eaeaea` (inte rent vitt — mindre tröttsamt) |
| **Text sekundär** | `#9aa5b1` (för meta-info, labels) |
| **Rubrik-typsnitt** | `Inter` (eller `Space Grotesk`) — stor, luftig, modern |
| **Kod-typsnitt** | `JetBrains Mono` (eller `Fira Code` med ligaturer) |
| **Kod-syntax-tema** | Shiki `one-dark-pro` eller `catppuccin-mocha` |

**Design-principer:**
- Mörkt tema genomgående. Inga vita slides.
- INGA punktlistor på skärmen. Allt bullet-content hamnar i talarnotiser.
- Stor typografi — rubrik minst 5rem, brödtext 1.5rem+. En idé per slide.
- Full-bleed bilder vid dramatiska moment (slutmålet, buzzern, LED-blom).
- Subtila fade-transitions. Magic-move där kod utvecklas över flera slides.
- Små decorationer: monospace-timers, progress-pricks, skenor av cyan-lysande punkter.

## Slide-struktur (≈21 slides totalt)

| # | Typ | Titel | Layout |
|---|---|---|---|
| 1 | Titel | Kursnamn + undertitel + instruktör | `cover` fullbleed |
| 2 | Översikt | 5 superkrafter (alla låsta) | custom `overview` |
| 3 | Inledning | Klassrumsverktyget: röd/grön lapp | `center` |
| 4 | Divider | ⚡ TRÄFF 1 — Ljuset | `section` |
| 5 | Slutmålet | Visuell hook: tjuvlarmet i aktion | `full` bildbg |
| 6 | Hjärnan | Arduino UNO, stor och ensam | `image-left` |
| 7 | Kretsen+vattnet | Krets + vattenanalogi sida vid sida | `two-cols` |
| 8 | Cliffhanger | RGB-LED i lila, "Nästa gång..." | `statement` |
| 9 | Divider | 🎨 TRÄFF 2 — Färger | `section` |
| 10 | Illusionen | RGB → alla färger + gradient | `center` |
| 11 | Power Rails | Breadboard-sidoräls, pilar | `default` |
| 12 | Divider | ⚡ TRÄFF 3 — Sinnen | `section` |
| 13 | INPUT | Öra + knapp-ikon | `statement` |
| 14 | Larmet | Buzzer + klisterlapp-varning | `fact` röd accent |
| 15 | Divider | 🕵️ TRÄFF 4 — Röntgen | `section` |
| 16 | Se i mörkret | LDR + tilt-sensor | `two-cols` |
| 17 | Serial Monitor | Screenshot + kod-overlay | `image-right` |
| 18 | Divider | 🏆 TRÄFF 5 — Grand Finale | `section` |
| 19 | Hackathon | Slutmål + flödesdiagram | `default` |
| 20 | Kods-skelett | Stor kodruta (C++) | `default` kod-fokus |
| 21 | Avslut | Alla 5 superkrafter upplåsta | `end` celebration |

**Talarnotiser**: Allt "LÄRAR-VY / ANTECKNINGAR"-innehåll från outlinen placeras i Slidevs `<!-- -->` notes-block. Syns bara på presenter-vyn.

## Bilder & grafik

**Källor:**
- **Produktfoton:** Elegoo/Wikimedia/Unsplash (pågår via research-agent)
- **Tekniska diagram:** Egenritade SVG:er inline (kretsscheman, vattenanalogi, power rails)
- **Ikoner:** Iconify (gratis, stort bibliotek) — `<carbon:*>`, `<mdi:*>`, `<ph:*>`

**Allt lokalt cachat** i `public/images/`. Inga nätverksberoenden vid körning.

## Leveranspaket

```
~/projects/arduino-kurs/
├── presentation/
│   ├── slides.md              ← all content (en fil)
│   ├── package.json           ← Slidev v52 + dependencies
│   ├── public/images/         ← alla bilder, lokalt
│   ├── components/            ← anpassade Vue-komponenter (t.ex. PowerBadge)
│   ├── snippets/              ← återanvändbara kodbitar
│   ├── style.css              ← custom dark theme overrides
│   ├── README.md              ← svensk körguide
│   └── dist/                  ← byggd statisk version (offline-redo)
├── tasks/
│   ├── design.md              ← detta dokument
│   ├── todo.md                ← arbets-plan
│   └── open-questions.md      ← frågor jag samlar längs vägen
└── research/
    └── elegoo-kit.md          ← research-agentens rapport
```

## Körning i klassrummet

**Alternativ A (rekommenderas):** Byggd statisk version
```bash
cd ~/projects/arduino-kurs/presentation
npm run build
open dist/index.html    # öppnar i standardbrowsern
# Tryck P i browsern → presenter view
```

**Alternativ B:** Dev-server (för live-redigering mellan träffar)
```bash
cd ~/projects/arduino-kurs/presentation
npm run dev
# Öppnar localhost:3030 automatiskt
```

**Presenter-tangenter:**
- `P` — öppna presenter view (två fönster: huvudvy + presenter)
- `F` — fullscreen
- `O` — slide overview
- `D` — draw on slide (pen)
- `B` — black/hide
- `←` / `→` — navigera

## Återstående beslut & öppna frågor

(Se `tasks/open-questions.md`.)

## Framtida iterationer (out of scope nu)

- Eventuell QR-kod med kursmaterial för studenter
- Interaktiva kodblock med live-körning (Monaco embedded)
- Print-vänlig PDF för deltagare som vill ha en papperskopia
