# Elektronik & Programmering med Arduino

**5-träffars nybörjarkurs** byggd kring ELEGOO UNO Basic Starter Kit. Studenterna lär sig elektronik och C-programmering genom att stegvis bygga ett fungerande tjuvlarm — sense + act, en bit i taget.

**🌐 Live kurssite för deltagare:** https://speakman.github.io/arduino-kurs/  
&nbsp;&nbsp;&nbsp;&nbsp;Slides (live HTML + PDF), kompendium per modul, kodexempel och kuraterade resurser för fortsatt lärande.

Allt material — slides, kompendium, illustrationer, övningar — finns i det här repot. Licensierat under CC BY-SA 4.0 så att andra föreningar och lärare fritt kan återanvända, anpassa och distribuera vidare.

---

## Vad finns i repot

```
.
├── presentation/         Slidev-deck (52 slides, light-mode, projektor-prio)
│   ├── slides.md         Hela decket i en Markdown-fil
│   ├── styles/           CSS-tokens, Shiki-tema, light-mode-design
│   ├── public/images/    Illustrationer, Fritzings, fotos
│   └── README.md         Slidev-specifik dev-guide
│
├── kompendium/           Typst-baserade kurshandouts (5 modul-PDF:er + 6 bilagor)
│   ├── *.typ             Källfiler för alla moduler och bilagor
│   ├── build.sh          Bygger alla 9 PDF:er
│   ├── images/           Fritzings, ELEGOO-extrakt
│   └── deliveries/       Distribution-färdiga PDF-paket per kursdag
│
├── docs/                 GitHub Pages-site för deltagare (vanilla HTML/CSS)
│   ├── index.html        Landing + dag-kort
│   ├── dag/{1..5}.html   Per-träff-sidor med kod, bilder, kompendium-länkar
│   ├── nedladdningar.html · resurser.html · 404.html
│   ├── slides/           Slidev-bygge (auto-genererad — se REFRESH.md)
│   ├── assets/{css,img,pdf,code}/
│   └── REFRESH.md        Sync-instruktioner när källmaterial ändras
│
├── research/             ELEGOO-referensmaterial (PDF + extraherade bilder, gitignored)
├── tasks/                Designspecs, audits, reviews, render-artifakter
└── CLAUDE.md             Projekt-specifika dev-konventioner (AI-assistant-config)
```

---

## Bygga materialet

### Slides (Slidev)

```bash
cd presentation
npm install              # första gången
npm run dev              # dev-server på localhost:3030
npm run build            # statisk build → dist/
npm run export           # PDF-export
```

Se `presentation/README.md` för fullständig dev-guide inkl. presenter-view och klassrums-setup.

### Kompendium (Typst)

```bash
cd kompendium
bash build.sh            # bygger alla 9 PDF:er
```

Kräver [Typst](https://typst.app/) ≥ 0.14 installerat. Output hamnar i `kompendium/*.pdf`. Distribution-färdiga paket per kursdag finns i `kompendium/deliveries/distribution/dag-N-innan/`.

---

## Kursupplägg (sammanfattning)

| Träff | Modul | Innehåll |
|-------|-------|----------|
| 1 | LED & krets | LED, resistor, Ohms lag, Blink, breadboard |
| 2 | PWM & RGB | `analogWrite`, duty cycle, RGB-LED, färgblandning |
| 3 | Digital input | `digitalRead`, `INPUT_PULLUP`, if/else, knapp, buzzer |
| 4 | Analog input | `analogRead`, spänningsdelare, fotocell, tilt, Serial Monitor |
| 5 | Hackathon | Sense-act-loop, integration, bygg det fungerande larmet |

Den röda tråden från första lampan på pin 13 till ett komplett tjuvlarm går genom alla fem träffar.

---

## Licens

[Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/) — se [LICENSE](LICENSE).

Du får använda, anpassa och distribuera materialet vidare, även kommersiellt, så länge du:
1. Anger ursprung (attribution).
2. Distribuerar vidare under samma licens (sharealike).

Arduino® och ELEGOO® är respektive företags varumärken; komponentbilder från ELEGOO-tutorialen används som pedagogisk referens.

---

## Kontext

Kursen togs fram för FRO Ånge (Frivilliga Radioorganisationen) våren 2026. Materialet är optimerat för klassrumssituation med projektor + tryckt kompendium som referensbok, men funkar lika bra som hemstudie-paket.

Frågor och förslag tas tack emot via issues.
