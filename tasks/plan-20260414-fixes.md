# Exekveringsplan — fixar 2026-04-14

Baserad på `handover-morgon-20260414.md`. Läst in på alla 11 punkter. Ordning = risk-först, sedan genomgående sveptjänster, sedan verifiering.

## Fas 1 — Blockers (måste lösas innan audit ger mening)

### 1.1 Typst mono-font ligatures
**Fil:** `kompendium/theme.typ`
**Symptom:** `==` → `⩵`, `!=` → `≠`, `<=` → `⩽`, `>=` → `⩾` pga JetBrains Mono / Menlo programmerings-ligatures.
**Verifierade platser:** `appendix-a-syntax.typ:98-105` (jämförelseoperatorer), `:109-112` (if-exempel), och alla andra ``` ```` block.
**Fix:** Applicera `set text(features: ("liga": 0, "clig": 0, "calt": 0, "dlig": 0))` på de tre ställen där mono-font aktiveras:
  - `theme.typ:199` — `raw.where(block: true)` show-regeln
  - `theme.typ:212` — `raw.where(block: false)` inline-show
  - `theme.typ:372` — `formula()` helper
Alternativt (renare): sätt features globalt via en wrapper `#let mono-text(body) = { set text(font: mono-font, features: (...)); body }` och använd den.
**Verifiering:** Kompilera `appendix-a-syntax.typ` fristående, öppna sida med rad 98-112, bekräfta att `==` renderar som två separata likhetstecken.

### 1.2 Modul 1 sid 7 kod-överflöd
**Fil:** `kompendium/01-modul-1.typ`
**Trolig orsak:** Rad 138, tip-box "Börja enkelt", innehåller lång inline-kod-kedja:
  ```
  `digitalWrite(13, HIGH) / delay(...) / digitalWrite(13, LOW) / delay(...)`
  ```
  Inline-kod bryter inte på `/` — hela backtick-strängen kan sticka utanför sats-bredden.
**Fix:** Dela upp inline-kod-kedjan i separata backtick-segment separerade av vanlig text, ELLER bryt ut till ett fenced code-block. Föredrar alternativ 1 (behåller flyt).
**Verifiering:** Rebuild, öppna `review-pages/m1/p-7.png` och bekräfta textbredd-respekt.

### 1.3 Vertikal alignment kod-kommentarer
**Filer:** Alla ``` ``` ``` block i `kompendium/*.typ` + `presentation/slides.md`.
**Lista från grep:** 03-modul-3.typ (40-44, 83-89, 110-112, 124), 04-modul-4.typ (120-141), 05-modul-5.typ (114-151), appendix-a (~30 block), appendix-b (~10 block), appendix-f (48-52, 79-89, 180-192), appendix-d (redan markerade `cpp`).
**Fix:** Per block: hitta max-kolumn för kod-del, pad alla rader med mellanslag till den kolumnen, lägg sedan `//` + kommentar.
**Verifiering:** Visuell genomläsning av rebuildad PDF.

## Fas 2 — Genomgående innehålls-sveptjänster

### 2.1 Emoji/unicode-ikoner bort
**Ställen (bekräftade):**
  - `appendix-a-syntax.typ:110` (`❌`), `:111` (`✅`)
  - `appendix-b-felmeddelanden.typ:44, 53, 54, 76, 91, 101, 111` (alla `❌`)
  - `theme.typ:220` — `marker: ([•], [◦], [–])` → byt till `([—], [–], [·])` eller standard text-markörer. OBS: `–` är en-dash, inte emoji — OK att behålla om det ser bra ut. `•` och `◦` är de värsta.
  - `slides.md` — 27 `i-carbon-*` ikoner. Regel: behåll där ikonen ger pedagogisk signal (varning, cover-ikon per modul). Ta bort rena dekorationer. Per-rad-beslut krävs — jag presenterar före/efter.
**Fix:** Ersätt `❌`/`✅` i appendix med `Fel:` / `Rätt:` typografiska markörer i `warm`/`cyan`. Uppdatera theme.typ list-marker.

### 2.2 ELEGOO-referenser
**39 förekomster:**
  - kompendium: `01-modul-1.typ` (27, 34, 39, 65), `02-modul-2.typ` (29, 41, 62, 99, 163), `03-modul-3.typ` (30, 31, 71, 132, 138), `04-modul-4.typ` (30, 31, 73, 96, 110), `05-modul-5.typ` (15), `appendix-c-komponenter.typ` (48, 64, 212, 225)
  - slides.md: 7, 43, 56, 352, 376, 1263, 1713, 1858, 1865, 1892, 1909, 2121, 2134, 2310, 2338
**Fix:** 
  - "ELEGOO Lesson X sid Y" → tas bort helt från bildtexter (bilderna talar för sig själva).
  - "Elegoo-kittet" / "Elegoo skeppar" → behåll där det är produktfaktum om kittet. Ändra "Elegoo" → "kittet" där det inte behöver vara explicit produktnamn.
  - `slides.md:376` `elegoo.com/downloads` → ersätts med generell referens eller tas bort.

### 2.3 "Inför nästa träff"-texter
  - `01-modul-1.typ:169` → `Glöm inte dator eller Elegoo-kitet hemma!`
  - `02-modul-2.typ:184` → ta bort "penna och papper"/"anteckningsbok" + använd samma korta format.
  - `03-modul-3.typ:224` → ta bort "Ingen läxa krävs — övningarna ovan räcker som repetition." HELT.
  - `04-modul-4.typ:215` → ta bort "utsövda" och "hungriga". Behåll "hackathon"-begreppet.
**Regel:** Alla modulers "Inför nästa träff" får samma korta format.

### 2.4 Syntax highlighting på kodblock
**Konvertera ` ``` ` → ` ```cpp `:** i alla filer i listan från grep (Fas 1.3). Undantag: appendix-d (redan `cpp`), appendix-b där block är fel-meddelanden från kompilatorn (ska INTE syntax-highlightas — de är stack traces, inte kod).
**Osäkerhet:** Appendix-b är en blandning. Per block-avgörande krävs: är det C++ → `cpp`. Är det kompilator-output → behåll ofärgat men flagga med `text`.
**Verifiering:** Typst med raw language support renderar cpp via syntect. Rebuild och bekräfta färg i en av modul-3 eller modul-4 PDF:erna.

### 2.5 Kod-block radbrytning
**Regel:** Inga radbrott mitt i ett fenced code-block över sidgräns.
**Fix-väg:** Lägg till `breakable: false` på raw-block-show i theme.typ? Det kan tvinga tomrum i slutet av sidor. Alternativ: `#block(breakable: false)[...]` wrappar bara själva kod-blocket. Jag väljer den lokala wrappen i show-regeln.
**Verifiering:** Rebuild, bläddra PDF:er, kolla sidskarvar.

## Fas 3 — Slide-PDF audit

### 3.1 Bekräfta 16:9
`presentation/slides.md:1-24` — saknar explicit `aspect`. Slidev default ÄR 16/9 (1920×1080). Lägg till `aspect: 16/9` explicit i frontmatter för tydlighet.

### 3.2 Sonnet-audit av slide-PDF
Efter rebuild, dispatch-a en sonnet Agent med uppdrag: gå igenom `deliveries/slides-arduino-kurs.pdf` sida för sida via `review-pages/slides/p-*.png` (rendra först). Fokus: overflow vid högerkant/nederkant, layered images (cover-slides, section dividers), jämför mot webbrenderingen.
**Alternativ fix vid overflow:** kör `slidev export --per-slide` för bättre rendering.

## Fas 4 — Verifiering

1. `cd kompendium && bash build.sh`
2. `cp kompendium.pdf modul-*.pdf bilagor-a-f.pdf deliveries/`
3. `cd ../presentation && npm run build && npx slidev export --output ../kompendium/deliveries/slides-arduino-kurs.pdf`
4. Regenerera `review-pages/m1/`, `m2/`, ..., `bilagor/`, `slides/` som PNG.
5. Dispatch **sonnet**-agent (minnesregel: visuella audits → sonnet) per PDF för att verifiera:
   - Ligature-fix syns
   - Ingen emoji kvar
   - Inga ELEGOO-refs kvar i bildtext
   - Kod-block har syntax highlighting
   - Modul 1 sid 7 är inom margin
   - "Inför nästa"-texter är kortade
6. Rapportera resultat till användaren.

## Risker & antaganden

- **Typst features-syntax:** `set text(features: (...))` är rätt API i Typst 0.12+. Om det inte fungerar: fallback till att byta mono-font till IBM Plex Mono eller Fira Code-nonligature-variant.
- **Syntax highlighting i Typst:** Typst använder syntect — supportar `cpp`. Borde funka direkt genom att byta fence från ``` till ```cpp. Verifierar tidigt.
- **appendix-d är hackathon-lösningen:** ligger i bilagor-pdf:en. Inga regressioner förväntade.
- **Slide i-carbon-ikoner:** Subjektivt per ikon. Jag presenterar en lista före/efter-förslag innan jag tar bort dekorativa.

## Filer som rörs

Kompendium:
- `theme.typ` (ligatures, list-marker, raw-block breakable)
- `01-modul-1.typ` t.o.m. `05-modul-5.typ` (alla punkter)
- `appendix-a-syntax.typ`, `appendix-b-felmeddelanden.typ`, `appendix-c-komponenter.typ`, `appendix-f-framspanningsfall.typ`

Presentation:
- `slides.md` (ELEGOO, emoji-ikoner, aspect, kod-alignment, kod-radbrytning)

## Exekveringsordning

```
1.1 Ligature-fix → sanity rebuild → kolla appendix-a
1.2 Modul 1 sid 7 → sanity rebuild → kolla p-7
1.3 Alignment (batch per fil)
2.4 Syntax highlighting (batch)
2.5 Breakable code block
2.1 Emoji rensning (batch)
2.2 ELEGOO rensning (batch)
2.3 Inför nästa-texter
3.1 Slide aspect + kod-sveptjänster
Full rebuild
4 Sonnet-audit per PDF
Rapport
```

Varje steg markerar TaskUpdate in_progress → completed. Sanity-rebuilds sker lokalt för att fånga Typst-kompileringsfel tidigt.
