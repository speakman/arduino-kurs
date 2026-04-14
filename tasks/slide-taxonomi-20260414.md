# Slide-taxonomi — 2026-04-14

Källa: `presentation/slides.md` (2767 rader). Syfte: underlag för Slidev-idiomatisk omskrivning (Approach 2).

## Räkneregel

Varje `---`-par avgränsar ett slide-block: öppnande `---` (rad N) + frontmatter/innehåll + avslutande `---` (rad M). Slide **#1** är det globala config/frontmatter-blocket (rad 1–25) — det är ingen presentationsslide utan konfiguration, men inkluderas i tabellen som #1 för konsekvens. Slide **#2** är titelsidan (rad 26–64). Slide **#3** (rad 65–132) är kursöversikten "Fem träffar. Fem moduler." med `sp-grid` — **STANNAR**. Slide **#4** (rad 133–169, "Klassrummets viktigaste verktyg") är markerad **BORT** per instruktion.

Totalt: 53 block i tabellen (#1–#53), varav #1 är config. Presentation-slides: 52, varav 1 (#4) raderas → **51 slides kvar efter rensning**.

---

## Tabell

| # | Rad-range | Nuvarande layout + class | Rubrik/sammanfattning | Kluster | Rekommenderad Slidev-layout | HTML-wrappers att stryka | Bevaras | Risk |
|---|-----------|--------------------------|----------------------|---------|----------------------------|--------------------------|---------|------|
| 1 | 1–25 | *(global config frontmatter)* | Global Slidev-konfiguration | `domain-custom` | *(config, ej slide)* | ingen | Hela blocket — det är konfiguration | låg |
| 2 | 26–64 | `cover / (class: cover i frontmatter)` | Kurstitelsida | `cover` | `cover` | `<div class="h-full flex flex-col items-center justify-center text-center">`, `<div class="mb-6 font-mono …">`, `<div class="text-2xl mt-10 …">` | `<div class="absolute bottom-12 left-12 …">` och `<div class="absolute bottom-12 right-12 …">` — absolut-positionerade fotnoter | medel |
| 3 | 65–132 | `default / px-14` | Kursöversikt — fem träffar, fem moduler | `domain-custom` | `default` | `<div class="mb-4 text-sm font-mono tracking-widest uppercase opacity-60">`, `<h1 class="text-6xl mb-4">` (h1 med inline class), `<div class="absolute bottom-12 right-14 text-sm opacity-60 font-mono">` | Hela `<div class="sp-grid mt-14">`-blocket med de fem `<div class="sp">`-korten (`sp-icon`, `sp-number`, `sp-name`, `sp-sub`) — domänspecifika CSS-klasser som definierar kursens översiktsvy | medel |
| 4 | 133–169 | `center / text-center` | **BORT — Klassrummets viktigaste verktyg (Post-it)** | — | **RADERA HELA SLIDEN** | — | — | — |
| 5 | 170–203 | `section / section text-center` | Träff 1-sektionsdivider | `section-divider` | `section` | `<div class="font-mono text-sm …">`, `<div class="text-2xl mt-6 …">` | `<div style="text-align: center"><h1 style="display: inline-block">…</h1></div>` — inline-style för centrering av h1 | medel |
| 6 | 204–263 | `default / px-14` | Dagens upplägg (tidsplan) | `content-bullets` | `default` | `<div class="text-xs font-mono …">`, `<div class="grid grid-cols-2 gap-6 mt-10">` och de fyra inre `<div class="flex gap-4 …">` | ingen — grid-strukturen kan bli markdown-tabell eller behållas som ren CSS-grid | medel |
| 7 | 264–302 | `full / relative` | Slutmålet — bygga larmet | `hero-message` | `center` | `<div class="absolute inset-0 flex items-center justify-center">`, `<div class="text-center">`, `<div class="flex justify-center mb-6">`, `<div class="text-8xl i-carbon-alarm …">`, `<div class="text-xs font-mono …">`, `<div class="text-xl max-w-2xl …">` | carbon-ikonens `i-carbon-alarm`-div | medel |
| 8 | 303–377 | `image-left / pl-4` | Mikrokontrollern — Arduino UNO | `domain-custom` | `image-left` | `<div class="h-full flex flex-col justify-center">`, `<div class="text-xs font-mono …">`, `<div class="text-xl opacity-75 mt-8 …">`, `<div class="mt-10 text-xs …">` | ingen — allt kan bli markdown under `image-left` | låg |
| 9 | 378–425 | `default / px-14` | Spänning, ström, GND | `content-bullets` | `default` | `<div class="text-xs font-mono …">`, `<div class="grid grid-cols-3 gap-6 mt-16">` och de tre inre `<div class="p-6 rounded-2xl …">` med carbon-ikoner | carbon-ikonernas `i-carbon-flash`, `i-carbon-flow`, `i-carbon-earth-filled` | medel |
| 10 | 426–480 | `default / px-14 pt-12` | Ohms lag — triangel SVG | `domain-custom` | `default` | `<div class="text-xs font-mono …">`, `<div class="mt-10 flex items-center …">`, `<div class="text-2xl opacity-80 …">` | Hela SVG-triangeln (`<svg viewBox=…>` + absolut-positionerade `<div class="absolute mono font-bold" style="…">`) samt `<div class="relative" style="width:34rem;height:29.5rem">` | hög |
| 11 | 481–542 | `two-cols-header / (ingen class)` | Kretsen — vattenanalogin | `two-column` | `two-cols-header` | `<div class="mt-4 text-lg leading-relaxed">`, `<div class="flex flex-col items-center justify-center h-full">`, `<div class="text-sm opacity-60 mono …">` | `tip-box`-div med `.tip-title` | låg |
| 12 | 543–638 | `two-cols-header / px-14 pt-12` | LED & resistor — komponenter | `two-column` | `two-cols-header` | `<div class="mt-6">`, `<div class="space-y-2 text-base …">`, `<div class="mt-4 text-xs opacity-60 italic">` | `<div class="mt-6 flex items-center gap-4 p-4 …">` — resistor-färgring-visualiseringen med inline-stilar och hårdkodade färg-`<div>`-blockar | hög |
| 13 | 639–688 | `default / px-14` | Breadboarden — fem hål = en nod | `content-bullets` | `default` | `<div class="text-xs font-mono …">` | `<img>`-taggen med inline-style, `<div class="mt-8 grid grid-cols-2 …" style="font-size:32px;…">` — inline font-size kan behållas eller bli CSS-klass | medel |
| 14 | 689–714 | `default / px-14 text-center` | Felsökningsregel #1 — 90 % ett hål fel | `hero-message` | `center` | `<div class="text-xs font-mono …">`, `<div class="mt-16 text-4xl leading-relaxed max-w-4xl mx-auto">`, `<div class="mt-14 text-2xl opacity-75 max-w-3xl mx-auto">` | ingen | låg |
| 15 | 715–786 | `default / px-14` | Bygg kretsen — steg 1–5 | `content-bullets` | `default` | `<div class="text-xs font-mono …">`, `<div class="mt-8 space-y-4 max-w-5xl">`, samtliga fem `<div class="flex gap-4 items-start">` med inre `<div class="mono cyan …">` | ingen — kan bli numrerad markdown-lista | låg |
| 16 | 787–820 | `default / !p-0` | WiringSlide LED-koppling | `domain-custom` | `default` | redan ren — bara `<WiringSlide …/>` komponent | `<WiringSlide>`-komponenten måste bevaras som-är | låg |
| 17 | 821–891 | `two-cols-header / px-14 pt-12` | setup() och loop() — kodens anatomi | `two-column` | `two-cols-header` | `<div class="text-xs font-mono …">`, `<div class="mt-6 space-y-5 text-base …">`, `<div class="mt-4 text-xs opacity-60">` | ingen — code-blocket på höger sida är redan markdown-fenced | låg |
| 18 | 892–960 | `default / px-14` | Tre kommandon — hela Blink | `code-demo` | `default` | `<div class="text-xs font-mono …">`, `<div class="space-y-7 mt-12">`, samtliga tre `<div class="grid grid-cols-[280px_1fr] …">` | ingen — kan struktureras som definitionslista eller enklare grid | medel |
| 19 | 961–1042 | `default / px-14` | Din egen rytm — uppgift | `content-bullets` | `default` | `<div class="text-xs font-mono …">`, `<div class="mt-10 text-3xl leading-relaxed max-w-4xl">`, `<ul class="mt-10 text-2xl space-y-3 …">` | ingen — `<ul>` kan bli markdown-lista | låg |
| 20 | 1043–1109 | `center / text-center` | Delresultat träff 1 — ni har byggt en blinkare | `hero-message` | `center` | `<div class="text-xs font-mono …">`, `<div class="inline-block px-5 py-2 rounded-full …">`, `<div class="text-lg opacity-75 mb-10 …">`, `<div class="grid grid-cols-3 gap-8 …">` med de tre inre `<div class="flex flex-col items-center">`, `<div class="mt-12 text-lg …">` | ingen | medel |
| 21 | 1110–1155 | `statement / text-center` | Nästa gång — teaser RGB | `hero-message` | `statement` | `<div class="text-xs font-mono …">`, `<div class="mb-10 flex justify-center …">`, `<div class="text-2xl mt-8 …">` | `<div class="rgb-circle rgb-red">` / `rgb-green` / `rgb-blue` — domänspecifika CSS-klasser | låg |
| 22 | 1156–1181 | `section / section text-center` | Träff 2-sektionsdivider | `section-divider` | `section` | `<div class="font-mono text-sm …">`, `<div class="text-2xl mt-6 …">` | `<div style="text-align: center"><h1 style="display: inline-block">…</h1></div>` | medel |
| 23 | 1182–1237 | `center / text-center` | Alla färger av bara tre — RGB intro | `hero-message` | `center` | `<div class="text-xs font-mono …">`, `<div class="mt-4 flex justify-center">`, `<div class="mt-4 text-base opacity-75 …">` | `<img>`-taggen med `mix-blend-mode: screen`, `warn-box`-div med `.warn-title` | medel |
| 24 | 1238–1277 | `default / !p-0` | WiringSlide RGB-koppling | `domain-custom` | `default` | redan ren | `<WiringSlide>`-komponenten | låg |
| 25 | 1278–1333 | `default / px-14 pt-12` | analogWrite — nytt kommando | `code-demo` | `default` | `<div class="text-xs font-mono …">`, `<div class="mt-6 text-2xl leading-relaxed max-w-5xl space-y-4">`, `<div class="mt-6 [&_pre]:!text-3xl …">` (code-block wrapper med overridande CSS) | `[&_pre]:!text-3xl [&_pre]:!leading-relaxed [&_pre]:!p-6` — tailwind-arbitrary selector för att förstora kod; ersätts av `.slidev-layout` CSS-regel | medel |
| 26 | 1334–1363 | `default / px-14` | Duty cycle — PWM-vågform | `content-bullets` | `default` | `<div class="text-xs font-mono …">`, `<div class="grid grid-cols-[1fr_auto] …">`, `<div class="text-2xl space-y-4 …">` | `<img>`-taggen med inline `class="h-96 bg-white rounded p-3"` | låg |
| 27 | 1364–1432 | `default / px-14` | Hitta färgen — övning | `content-bullets` | `default` | `<div class="text-xs font-mono …">`, `<div class="mt-8 grid grid-cols-[1.2fr_1fr] …">`, `<div class="text-lg leading-relaxed space-y-4">`, `<div class="space-y-2 text-base">`, `<div class="flex items-center justify-center">`, `<div class="grid grid-cols-2 gap-3">` | `tip-box`-div, de fyra `<div class="w-28 h-28 rounded-2xl" style="background:#…">` — färgrutorna med inline-stil | hög |
| 28 | 1433–1478 | `default / px-14 pt-14 text-center` | Ni har en pixel — avslut träff 2 | `hero-message` | `center` | `<div class="text-xs font-mono …">`, `<div class="mt-10 flex justify-center items-center gap-6">`, `<div class="mt-10 text-xl opacity-80 …">`, `<div class="mt-12 text-base opacity-60 italic">` | `rgb-circle`-divarna (tre st) | låg |
| 29 | 1479–1503 | `section / section text-center` | Träff 3-sektionsdivider | `section-divider` | `section` | `<div class="font-mono text-sm …">`, `<div class="text-2xl mt-6 …">` | `<div style="text-align: center"><h1 style="display: inline-block">…</h1></div>` | medel |
| 30 | 1504–1567 | `default / px-14 pt-10` | const int och int — variabler | `code-demo` | `default` | `<div class="text-xs font-mono …">`, `<div class="grid grid-cols-2 gap-10 mt-6">`, `<div class="text-base leading-relaxed space-y-4">` | `tip-box`-div med `.tip-title` | låg |
| 31 | 1568–1624 | `statement / text-center` | Input ≠ Output — digitalRead intro | `hero-message` | `statement` | `<div class="text-xs font-mono …">`, `<div class="text-xl mt-6 …">`, `<div class="max-w-2xl mx-auto text-left mt-6">` (code-block wrapper) | `tip-box`-div med `.tip-title` | låg |
| 32 | 1625–1691 | `two-cols-header / px-12` | if / else — beslutslogik | `two-column` | `two-cols-header` | `<div class="text-xs font-mono …">`, `<div class="mt-4 text-base …">`, `<div class="mt-4 text-xs opacity-55 italic">` | `tip-box`-div med `.tip-title` | låg |
| 33 | 1692–1720 | `default / !p-0` | WiringSlide Knapp-koppling | `domain-custom` | `default` | redan ren | `<WiringSlide>`-komponenten | låg |
| 34 | 1721–1794 | `two-cols-header / px-12 pt-10` | Reagera på flanken — edge detection | `two-column` | `two-cols-header` | `<div class="text-xs font-mono …">`, `<div class="mt-4 text-base leading-relaxed space-y-3">` | `tip-box`-div med `.tip-title` | låg |
| 35 | 1795–1881 | `default / px-14` | Active buzzer — varning sticker | `domain-custom` | `default` | `<div class="flex gap-12 mt-8 items-center justify-center">`, `<div class="max-w-xl">`, yttre flex-wrappern | `warn-box`-div med inline style (`padding:28px`, `font-size:30px`), `<div style="margin-top:32px;font-size:26px;…">`, `<img>`-taggen med `ring-2 ring-rose-500/50` | hög |
| 36 | 1882–1907 | `default / !p-0` | WiringSlide Buzzer-koppling | `domain-custom` | `default` | redan ren | `<WiringSlide>`-komponenten | låg |
| 37 | 1908–1956 | `default / px-14 text-center` | Läs knapp, styr buzzer | `hero-message` | `center` | `<div class="text-xs font-mono …">`, `<div class="mt-16 text-3xl leading-relaxed max-w-3xl mx-auto">`, `<div class="mt-16 text-2xl font-mono opacity-80">` | ingen | låg |
| 38 | 1957–1993 | `default / px-14` | Kärnan i loop() — kod-slide | `code-demo` | `default` | `<div class="text-xs font-mono …">`, `<div class="mt-6 [&_pre]:!text-3xl …">` (code-block wrapper) | `[&_pre]:!text-3xl [&_pre]:!leading-relaxed [&_pre]:!p-8` — förstoring-trick | medel |
| 39 | 1994–2026 | `default / px-14 text-center` | Arduinon lyssnar — avslut träff 3 | `hero-message` | `center` | `<div class="text-xs font-mono …">`, `<div class="mt-10 text-xl opacity-80 …">`, `<div class="mt-12 text-base opacity-60 italic">` | ingen | låg |
| 40 | 2027–2052 | `section / section text-center` | Träff 4-sektionsdivider | `section-divider` | `section` | `<div class="font-mono text-sm …">`, `<div class="text-2xl mt-6 …">` | `<div style="text-align: center"><h1 style="display: inline-block">…</h1></div>` | medel |
| 41 | 2053–2114 | `default / px-14 pt-12` | Knappen digital, världen analog — fotocell intro | `content-bullets` | `default` | `<div class="text-xs font-mono …">` | `<div style="margin-top:48px;display:flex;…">` med inline-style flex-layout, `<img>`-taggen med inline `style="width:720px;height:720px;object-fit:cover;…"`, `<div style="font-size:48px;line-height:1.5">` — hela innehålls-blocket har inline-stilar | hög |
| 42 | 2115–2146 | `default / px-14` | analogRead() — Arduinons linjal | `code-demo` | `default` | `<div class="text-xs font-mono …">` | `tip-box`-div med `.tip-title` | låg |
| 43 | 2147–2292 | `two-cols-header / px-12 pt-10` | Spänningsdelaren — vattenanalogin | `two-column` | `two-cols-header` | `<div class="text-xs font-mono …">`, `<div class="mt-6 space-y-4">` | Hela höger-kolumnen: avancerat SVG-inspirerat diagram med font-mono, färgade `<div>`-segment (`text-cyan-400`, `bg-cyan-400`, `bg-rose-500`), GND-symbolens tre avtrappade `<div>`-linjer — måste bevaras som HTML | hög |
| 44 | 2293–2314 | `default / !p-0` | WiringSlide Fotocell-koppling | `domain-custom` | `default` | redan ren | `<WiringSlide>`-komponenten | låg |
| 45 | 2315–2341 | `default / !p-0` | WiringSlide Tilt-sensor-koppling | `domain-custom` | `default` | redan ren | `<WiringSlide>`-komponenten | låg |
| 46 | 2342–2409 | `two-cols / px-14` | Serial Monitor — felsökning | `two-column` | `two-cols` | `<div class="text-xs font-mono …">`, `<div class="text-lg opacity-85 mt-6 …">`, `<div class="mt-6 text-sm opacity-60">`, `<div class="h-full flex items-center justify-center">` (code-block wrapper) | ingen — code-blocket på höger sida är redan markdown-fenced | låg |
| 47 | 2410–2459 | `default / px-14` | Hitta din tröskel — fri övning | `content-bullets` | `default` | `<div class="text-xs font-mono …">`, `<div class="mt-10 text-2xl max-w-5xl">`, `<ul class="mt-8 text-2xl space-y-4 max-w-5xl">` | ingen — `<ul>` kan bli markdown-lista | låg |
| 48 | 2460–2498 | `default / px-14 pt-12` | Koden att köra — Serial Monitor-sketch | `code-demo` | `default` | `<div class="text-xs font-mono …">`, `<div class="mt-4 [&_pre]:!text-2xl …">` (code-block wrapper) | `[&_pre]:!text-2xl`-förstoring | medel |
| 49 | 2499–2528 | `default / px-14 text-center` | Arduinon känner världen — avslut träff 4 | `hero-message` | `center` | `<div class="text-xs font-mono …">`, `<div class="mt-10 text-xl opacity-80 …">`, `<div class="mt-12 text-base opacity-60 italic">` | ingen | låg |
| 50 | 2529–2561 | `section / section text-center` | Träff 5-sektionsdivider | `section-divider` | `section` | `<div class="font-mono text-sm …">`, `<div class="text-2xl mt-6 …">` | `<div style="text-align: center"><h1 style="display: inline-block">…</h1></div>` | medel |
| 51 | 2562–2631 | `default / px-14` | Ingenjörsuppgiften — hackathon-logik | `content-bullets` | `default` | `<div class="text-xs font-mono …">`, `<div class="text-lg opacity-80 …">`, `<div class="mt-10 flex items-center justify-between …">`, de tre inre `<div class="flex-1 flex flex-col …">`, `<div class="mt-10 text-sm opacity-70 …">` | carbon-ikonernas `i-carbon-view`, `i-carbon-chip`, `i-carbon-light`, `i-carbon-volume-up-filled` | medel |
| 52 | 2632–2726 | `default / px-14 pt-10` | Pin-tilldelning — startmall | `content-bullets` | `default` | `<div class="text-lg opacity-70 mb-8">`, `<div class="grid grid-cols-[auto_auto_1fr] …">` — pin-tabellen, `<div class="mt-8 text-2xl font-mono">`, `<div class="mt-8 text-lg opacity-70">` | `<h1 class="text-5xl mb-2">` — h1 med inline class; de inre grid-raderna kan bli markdown-tabell | medel |
| 53 | 2727–2767 | `center / end text-center` | Tack — slutslide | `end` | `end` | `<div class="font-mono text-lg …">`, `<div class="text-4xl opacity-90 …">`, `<div class="mt-24 text-xl opacity-70 font-mono">` | ingen — allt kan bli plain markdown | låg |

---

## Kluster-summering

- `cover`: 1 (slide 2)
- `section-divider`: 5 (slides 5, 22, 29, 40, 50)
- `hero-message`: 10 (slides 7, 14, 20, 21, 28, 31, 37, 39, 49, 53 — inkl. `statement`-layout-slides)
- `content-bullets`: 11 (slides 6, 9, 13, 15, 19, 26, 27, 41, 47, 51, 52)
- `two-column`: 7 (slides 11, 12, 17, 32, 34, 43, 46)
- `code-demo`: 7 (slides 18, 25, 30, 38, 42, 48, 30 — ren kodfokus)
- `domain-custom`: 10 (slides 1, 3, 8, 10, 16, 24, 33, 35, 36, 44, 45)
- `end`: 1 (slide 53)
- **BORT**: 1 (slide 4)

*(Notering: slide 1 är config-block, räknas inte som en presentationsslide. Totalt 53 block i tabellen. Faktiskt antal presentation-slides: 52, varav 1 raderas = 51 kvar.)*

---

## Risk-hotspots

Följande slides har risknivå **hög** och kräver extra uppmärksamhet:

| Slide | Rubrik | Anledning |
|-------|--------|-----------|
| **#10** (rad 426–480) | Ohms lag — triangel SVG | Absolut-positionerade `<div>`-bokstäver inuti en relativ container med hårdkodad `width/height` i rem. SVG:n + absolut-positionering kan inte naivt konverteras till markdown. Kräver dedicated CSS-klass eller bibehållen HTML-struktur. |
| **#12** (rad 543–638) | LED & resistor | Resistor-färgring-visualiseringen: hårdkodade färg-`<div>`-blockar med `style="background:#…"` och specifika pixelbredder. Ren layout-återskapning av resistorns färgkod-band — visuellt beroende av exakta inline-stilar. |
| **#27** (rad 1364–1432) | Hitta färgen — övning | Fyra färgrutor med inline `style="background:#ff00c8"` etc. Tailwind har inte dessa exakta färger som utility-klasser. Inline-stilar måste bevaras eller konverteras till CSS-variabler. |
| **#35** (rad 1795–1881) | Active buzzer — sticker-varning | `warn-box` med blandade inline-stilar (`padding:28px`, `font-size:30px`) och `<div style="margin-top:32px;font-size:26px;…">`. Sliden blandar domänspecifik CSS-klass (`warn-box`) med inline-override — inkonsekvens som måste lösas. |
| **#41** (rad 2053–2114) | Knappen digital, världen analog | Hela innehållsblocket är wrappat i `<div style="…">` med inline `display:flex`, `font-size:48px`, `width:720px;height:720px`. Ingen tailwind-klass alls — ren inline-CSS. Kräver antingen bibehållna inline-stilar eller omskrivning till CSS-klasser. |
| **#43** (rad 2147–2292) | Spänningsdelaren | Höger-kolumnens kretsschemat är ett avancerat HTML-diagram med avtrappade GND-symbol-`<div>`ar, CSS-border-baserade komponentriktanglar och `text-cyan-400`/`bg-rose-500`-klasser. Inte möjligt att konvertera till markdown — måste bevaras intakt. |

---

## Domänspecifika mönster som måste bevaras

| Mönster | Förekommer i slides | Motivation |
|---------|---------------------|------------|
| `<WiringSlide … />` Vue-komponent | #16, #24, #33, #36, #44, #45 | Domänspecifik komponent som renderar kopplingsschema. Kan inte ersättas av markdown-bild. |
| `.sp-grid` / `.sp` / `.sp-icon` / `.sp-number` / `.sp-name` / `.sp-sub` | #3 (Kursöversikten — STANNAR) | **Bevaras — hög prioritet.** Kärnslide som visar kursens fem moduler. CSS-klasserna är definerade i `styles/main.css` och måste behållas intakta i konverteringen. |
| `.rgb-circle` (`.rgb-red`, `.rgb-green`, `.rgb-blue`) | #21, #28 | CSS-klasser för de tre färgcirklarna. Defined i `styles/main.css`. Bevaras. |
| `.warn-box` / `.warn-title` | #23, #35 | Domänspecifik varningsruta. Defined i `styles/main.css`. Bevaras som HTML. |
| `.tip-box` / `.tip-title` | #11, #27, #30, #31, #32, #34, #42 | Domänspecifik tippruta. Defined i `styles/main.css`. Bevaras som HTML. |
| Ohms-triangeln SVG + absolut-positionerade bokstäver | #10 | Visuell pedagogisk hjälp — omöjlig att ersätta med markdown. Hög risk vid konvertering. |
| Resistor-färgring-HTML-visualisering | #12 | Hårdkodade färg-`<div>`-blockar som visar 4-band resistorkod. Måste bevaras. |
| Spänningsdelare-diagram (höger kolumn) | #43 | HTML-baserat kretsschema med GND-symbol och komponent-rektanglar. Måste bevaras. |
| Carbon-ikoner (`i-carbon-*` UnoCSS-klasser) | #7, #9, #35, #51 | Ikoner som laddas via UnoCSS `@iconify/json`. Inga markdown-alternativ. Bevaras. |
| `[&_pre]:!text-Nxl [&_pre]:!leading-relaxed` | #25, #38, #48 | Tailwind arbitrary-selector för att förstora kod-block. Bör ersättas av `.slidev-layout` CSS-regler i `styles/main.css`. |
| `<div style="text-align: center"><h1 style="display: inline-block">` | #5, #22, #29, #40, #50 | Inline-stil på section-rubriker. Bör ersättas av `section`-layoutens inbyggda centrering. |
| Absolut-positionerade footers (`bottom-12`, `right-14`) | #2, #3, #6 | Datum-/platsinformation i hörn. Bevaras som absolut-positionerad HTML eller konverteras till Slidev `v-after`-block. |
