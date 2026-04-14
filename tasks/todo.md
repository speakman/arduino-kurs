# Arbets-plan: Arduino-kurs presentation

**Start:** 2026-04-13
**Status:** Första leverans klar, väntar på användarfeedback.
**Mål:** Leverera en komplett, proffsig Slidev-presentation för 5-veckors Arduino-kurs.

## Fas 1 — Forskning & setup ✅ KLART
- [x] Klargör riktning med användaren (Slidev valt)
- [x] Skapa projektstruktur
- [x] Kontrollera Node/npm/Slidev-versioner (Node v25.9, Slidev v52.14.2)
- [x] Dispatch research-agent för Elegoo-kittet
- [x] Skriv design-dokument (`tasks/design.md`)
- [x] Skapa package.json + initiera Slidev-projekt
- [x] Skriv slides.md-skelett med alla 21 slides
- [x] Installera dependencies (`npm install` — 663 paket)
- [x] Installera playwright-chromium (för PDF-export)

## Fas 2 — Innehåll & bilder ✅ KLART
- [x] Läs research-rapport från agent (`research/elegoo-kit.md`)
- [x] Ladda ner Wikimedia Commons-bilder till `public/images/`:
  - `arduino-uno-hero.jpg` (5.2 MB, CC0)
  - `breadboard-rails.png` (2.4 MB, CC0)
  - `photoresistors-three.jpg` (622 KB, CC0)
  - `photoresistor-macro.jpg` (4.7 MB, CC BY-SA)
- [x] Kopiera Elegoo-PDF:en till `research/elegoo-basic-kit-tutorial-v1.0.19.7.24.pdf`
- [x] Applicera sidnummer-korrigeringar (RGB, buzzer, photoresistor)
- [x] Korrigera RGB-LED:ens benbeskrivning (pin-ordning, katod-position)
- [x] Byt ut `tone()` mot `digitalWrite()` för active buzzer
- [x] Lägg in tilt-sensor debounce-tips (50ms)
- [x] Fyll alla 12 innehålls-slides + 5 divider-slides + titel + översikt + inledning + avslut
- [x] Skriv alla talarnotiser från outline + research-tillägg
- [x] Definiera custom CSS (`styles/main.css`) med färgpalett och komponenter

## Fas 3 — Design-polering ✅ KLART (första pass)
- [x] Mörkt tema (`#0a0e14` bakgrund, cyan/gul/röd accent)
- [x] Typografi: Inter + JetBrains Mono via Google Fonts
- [x] Superpower-grid med 5 låsta kort (översikt) → 5 upplåsta (avslut)
- [x] Warning-box + Tip-box komponenter
- [x] Section-dividers med stora Iconify-ikoner per träff
- [x] Magic-move code-block i Serial Monitor-sliden (`{all|1|4-6}`)

## Fas 4 — Leverans & test ✅ KLART
- [x] Bygg statisk `dist/`-version (15 MB, 522 moduler, 4.8s)
- [x] Exportera PDF-backup (`presentation-backup.pdf`, 10 MB)
- [x] Skriv `README.md` (svensk körguide med dual-screen setup)
- [x] Bygget går igenom rent utan fel/varningar

## Fas 5 — User review ⏳ VÄNTAR
- [ ] Visa resultat för användaren när de kommer tillbaka
- [ ] Svara på öppna frågor i `tasks/open-questions.md`
  - Kurstitel + instruktör-info på titelbilden
  - Målgrupp och träff-längd (för tempo-cues)
  - Eventuell QR-kod / logga
- [ ] Iterera baserat på feedback
- [ ] Eventuellt lägga till egenfotograferade bilder (buzzer sticker, tilt, färdigt larm)
- [ ] Slutleverans

---

## Leveransstatus

```
~/projects/arduino-kurs/
├── presentation/
│   ├── slides.md              ✅ 21 slides + talarnotiser
│   ├── package.json           ✅ Slidev v52 + playwright
│   ├── package-lock.json      ✅
│   ├── styles/
│   │   ├── main.css           ✅ Custom dark theme
│   │   └── index.js           ✅ CSS loader
│   ├── public/images/
│   │   ├── arduino-uno-hero.jpg      ✅ 5.2 MB CC0
│   │   ├── breadboard-rails.png      ✅ 2.4 MB CC0
│   │   ├── photoresistors-three.jpg  ✅ 622 KB CC0
│   │   └── photoresistor-macro.jpg   ✅ 4.7 MB CC BY-SA
│   ├── dist/                  ✅ Byggd statisk SPA (15 MB)
│   ├── presentation-backup.pdf ✅ 10 MB PDF-backup
│   ├── README.md              ✅ Körguide svenska
│   └── node_modules/          (663 paket)
├── research/
│   ├── elegoo-kit.md          ✅ Research-rapport
│   └── elegoo-basic-kit-tutorial-v1.0.19.7.24.pdf  ✅ 8.1 MB
└── tasks/
    ├── design.md              ✅ Spec
    ├── todo.md                ✅ Denna fil
    └── open-questions.md      ✅ Frågor till användaren
```

---

## Review-sektion

### Vad som är proffsigt 💎
1. **Research-drivna korrigeringar** — 3 sidnummer-fel, RGB LED-beskrivning,
   buzzer-kod (active vs passive) och tilt-debounce rättade mot Elegoo-PDF:en.
2. **Superpower-metaforen** är genomgående — låsta → upplåsta över kursen.
3. **Alla talarnotiser är rika** — pedagogisk struktur, "gör detta nu"-cues,
   felsökningstips, magiska moment.
4. **Offline-säker leverans** — dist/ + PDF. Ingen nätverksberoende i klassrummet.
5. **Dual-screen-setup är dokumenterad** i README med exakta tangentbindningar.

### Kvarvarande polering (post-review)
- Några bilder (buzzer med sticker, tilt-sensor, färdigt larm) kräver
  antingen PDF-extraktion eller egenfotografering. Iconify-placeholders
  används tillfälligt.
- Cover-sliden är en gradient, inte en bild — kan höjas med atmosfärisk
  Arduino-bild från Unsplash om önskas.
- Custom @click-animationer på översikts-sliden kunde läggas till om
  användaren vill ha en mer dramatisk "reveal" av superkrafterna.
