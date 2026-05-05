Här är min granskning av implementationsplanen och designspecen, med strikt fokus på implementation, risker och pedagogik.

### 🔴 Blocking Concerns (Måste åtgärdas i planen)

**F. Dolda risker (PDF-rasterisering i Task 4)**
Planen förenklar `html.print`-blocket (rad 252-270) genom att ta bort `html.print .slidev-layout.cover { background-image: none !important; }` med motiveringen att fotot "är OK i light".
*Risken:* Chromium print-to-PDF är notoriskt dåligt på att rasterisera `linear-gradient` ovanpå `url()` (särskilt med `color-mix` involverat). Det leder ofta till kraftig bandning (streaking) och massiv filstorlek på den exporterade PDF:en. Originalförfattaren tog bort hero-bilden i print-mode för att undvika rasteriseringsbuggar, inte enbart för att det var dark mode.
*Lösning:* Återställ regeln `html.print .slidev-layout.cover { background-image: none !important; }` i Task 4 för att garantera en ren PDF-export.

**A. Task-ordning (Task 1 vs Task 2)**
Att medvetet skapa ett "failing-test-mellantillstånd" (Commit 1 byter frontmatter och bryter slides, Commit 2 byter CSS och lagar dem) är antipattern för presentation-as-code. Om någon gör `git bisect` i framtiden och hamnar på Commit 1 kommer presentationen vara visuellt trasig.
*Lösning:* Slå ihop Task 1 och Task 2 till **en** atomisk commit. `colorSchema: 'light'` (som styr Shiki/Slidev-internals) och `:root`-tokens (som styr dina färger) är strukturellt beroende av varandra för att rendera en vy.

### 🟡 Improvements

**E. Codex-review (Task 16)**
Planen anropar en "consult-codex"-skill för att granska 52 PNG-bilder. Om detta verktyg är mappat mot en standard text-tung LLM, eller en äldre multimodal modell, kommer den sannolikt att krascha på context limit (52 högupplösta bilder) eller hallucinera visuella detaljer.
*Lösning:* Eftersom Gemini (speciellt 1.5 Pro) är byggd från grunden för storskalig multimodal batching (1M+ context), bör planen ändras till att explicit använda en Gemini-baserad granskning (`consult-gemini`) för den visuella passagen.

**C. PNG-rendering (Task 15)**
Jag har verifierat Slidev's CLI i er nuvarande workspace (`v52.14.2`). Flaggan `--format png` stöds *nativt* och fungerar robust via inbyggd Playwright.
*Lösning:* Du kan stryka Playwright-fallback-skriptet (Step 2 i Task 15). Kommandot `npm run export -- --format png` är tillräckligt.

**B. Spec-coverage (Kompendium-pipelinen)**
Designspecen (§10C) anger att kompendium-pipelinen ska verifieras (vilket den inte görs i planen), medan planen korrekt placerar den under "Out-of-Scope". Detta är arkitektoniskt rätt (olika pipelines), men tänk på att marginalerna i `slides-light.pdf` kan diffa marginellt mot dark-versionen när skuggor (code-wrappers) reduceras/försvinner. Detta *kan* påverka layouten i kompendiets Typst-dokument. Inget saknas i planen, men kompendium-bygget bör triggas omedelbart efter merge.

### 🟢 Nits & Pedagogisk koherens

**D. Chip-design CSS & UnoCSS (Task 9 & 11)**
Din `color-mix()`-syntax är 100% korrekt. CSS-variabler i inline `style="--bg:#XXX"` är helt trygga och en utmärkt strategi här. Även `ring-[var(--ak-border)]` i Task 11 kommer fungera perfekt tack vare UnoCSS JIT-kompilering som stöder arbitrary properties.

**G. Pedagogisk koherens (RGB-slide 21)**
Ersättningen av `mix-blend-mode: screen` med en svart `.rgb-demo` box är ett pedagogiskt genidrag. I stället för ett hack som trollar bort bakgrunden simulerar det nu en fysisk skärm eller ett mörkt rum i kontexten av en ljus omgivning. Det bevarar logiken kring additiv färgblandning utan att kännas som ett CSS-trick.

**H. "Chip-on-words" (Slide 25)**
Som svar på din fråga: Ja, detta är en pedagogisk *förbättring*, inte bara en tillgänglighets-fix. Att läsa färgad text introducerar en mild kognitiv belastning (Stroop-effekten, även om ordet matchar färgen). Ett färgchip med högkontrasterande svart/vit text inuti efterliknar formatet hos färgkartor, motståndsband och datablad. Du kan tryggt argumentera för en pedagog att detta mappar bättre mot hur fysiska komponenter avläses.
