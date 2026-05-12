# Arduino-kurs — Presentation

Slidev-baserad presentation för 5-veckors Arduino/elektronikkurs.
Ljus tema (light-mode-only, projektor-anpassat), stor typografi, fem moduler som bygger vidare på varandra.

## Snabbstart (för klassrummet)

### Alternativ A — Byggd statisk version (rekommenderas)

Säkrast i klassrummet. Ingen server, inga nätverksberoenden.

```bash
cd ~/projects/arduino-kurs/presentation
npm install          # bara första gången
npm run build        # bygger dist/
open dist/index.html # öppnas i standardbrowsern
```

Tryck **`P`** i browsern för att öppna presenter view i ett nytt fönster.
Dra det fönstret till din datorskärm — huvudvyn hamnar på projektorn.

### Alternativ B — Dev-server (för iteration mellan träffar)

```bash
cd ~/projects/arduino-kurs/presentation
npm run dev
```

Öppnar `localhost:3030` automatiskt. Redigerar du `slides.md` så uppdateras
sliden live — perfekt när du vill finslipa något mellan träffarna.

---

## Tangentbindningar under presentationen

| Tangent | Funktion |
|---|---|
| `→` `Space` | Nästa slide / nästa animation |
| `←` | Föregående slide |
| `↑` `↓` | Hoppa över animationssteg |
| **`P`** | **Öppna presenter view** (nytt fönster med anteckningar) |
| `F` | Fullscreen |
| `O` | Slide overview (rutnät) |
| `D` | Draw on slide (penna — bra för live-skisser på kretsschema) |
| `B` | Svart skärm (pausa visuellt) |
| `G` | Hoppa till specifik slide (skriv nummer) |
| `Esc` | Stäng fullscreen |

### Presenter view-layout

När du trycker `P` öppnas ett nytt fönster med fyra paneler:
- **Stor:** nuvarande slide (samma som projektorn ser)
- **Liten:** nästa slide
- **Text:** dina talarnotiser (allt från `<!-- -->`-blocken)
- **Timer:** tid sedan start

Drag detta fönster till din datorskärm. Huvudvyn (original-tabben) kör på projektorn.

---

## Dual-screen setup på Mac

1. Koppla in projektorn via HDMI/USB-C.
2. `Systeminställningar → Skärmar → Arrangemang` → **avmarkera "Spegla skärmar"**.
3. Starta presentationen i Chrome på huvudskärmen.
4. Tryck `P` → presenter view poppar upp i nytt fönster.
5. Drag presenter view-fönstret till datorskärmen.
6. Gör huvudtabben fullscreen (`F` eller Cmd+Ctrl+F) → projektorn visar bara sliden.

> Tips: använd Chrome, inte Safari. Chrome hanterar dual-screen fullscreen bättre.

---

## Filstruktur

```
presentation/
├── slides.md           ← all content + talarnotiser (redigera denna)
├── package.json        ← Slidev + deps
├── styles/
│   ├── main.css        ← light-mode tokens, modul-kort, warn-box
│   └── index.js        ← laddar main.css
├── public/
│   └── images/         ← produktfoton (Arduino, breadboard, LEDs...)
├── components/         ← custom Vue-komponenter (WiringSlide m.fl.)
├── snippets/           ← återanvändbara kodbitar
└── dist/               ← byggd statisk version (genereras av `npm run build`)
```

---

## Redigera innehåll

All content ligger i **`slides.md`**. Varje `---` är en ny slide.

### Talarnotiser

Allt mellan `<!-- -->` i slutet av en slide är talarnotiser och syns
endast på din skärm i presenter view — aldrig på projektorn.

```markdown
# Slide-rubrik

Brödtext här.

<!--
Dessa anteckningar ser bara du.
Det är här pedagogiska tips och manus-rader ligger.
-->
```

### Byta ut en bild

Lägg bilden i `public/images/<filnamn>.jpg` och referera till den med:

```markdown
layout: image-left
image: /images/arduino-uno-hero.jpg
```

(`/images/...` upplöses till `public/images/...`.)

### Lägga till en slide

Kopiera en befintlig slide (inklusive dess `---` separatorer) och ändra innehållet.

---

## Bygga en PDF-backup

```bash
npm run export
```

Genererar `slides-export.pdf` med alla slides. Ta med på USB-sticka som
fallback ifall datorn krånglar i klassrummet.

---

## Exportera talarnotiser separat

```bash
npm run export-notes
```

Skapar en PDF med bara talarnotiserna. Bra att skriva ut och ha bredvid
datorn som back-up.

---

## Felsökning

| Problem | Lösning |
|---|---|
| Fonts laddas inte | Kör `npm run build` med internet påslaget första gången — fonterna cachas i `dist/` sedan |
| Ikoner visar inte | Kör `npm install` igen, Iconify-paketen måste finnas |
| Presenter view öppnas inte | Chrome blockerar popup-fönster → tillåt popups för `localhost` / `file://` |
| Slides ser udda ut på projektor | Kör i fullscreen (`F`), inte fönsterläge |
| Build-fel om saknad komponent | Kontrollera att alla `<i-carbon-*>`-ikoner är stavade rätt |

---

## Credits

- **Verktyg:** [Slidev](https://sli.dev) av Anthony Fu
- **Ikoner:** [Iconify](https://iconify.design) (Carbon-set)
- **Typsnitt:** Inter + JetBrains Mono (Google Fonts)
- **Kit:** ELEGOO UNO Project Basic Starter Kit
