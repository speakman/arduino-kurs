# Slidev-idiomatisk omskrivning — implementationsplan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Konvertera `presentation/slides.md` från HTML+utility-tungt tillstånd till ett Slidev-idiomatiskt mönster där inbyggda layouts och central CSS bär stilen.

**Architecture:** Iterativ kluster-konvertering i 3 faser. Fas 0 = cheap wins. Fas 1 = centraliserar typografi i `main.css`. Fas 2 = per-kluster slide-omskrivning (6 delsteg, visuell verifiering mellan varje). Fas 3 = finputs. Commit per fas-steg för rollback-punkter.

**Tech Stack:** Slidev (latest), UnoCSS, Vue 3, Playwright Chromium (för export).

**Källdokument:**
- Spec: `tasks/spec-slidev-idiomatisk-20260414.md`
- Taxonomi: `tasks/slide-taxonomi-20260414.md`
- Handover (föregående pass): `tasks/handover-slides-cleanup-20260414-final.md`

**Verifiering:** Slidev är inte test-driven. "Verify" = `cd presentation && npm run export` + visuell inspektion av `slides-export.pdf`. För kluster-konverteringar används sonnet-subagent med `model=sonnet` som jämför before/after-PDF-sidor.

**Arbetskatalog för alla kommandon:** `/Users/daniel/projects/arduino-kurs`

---

## Task 1: Fas 0 — Cheap wins (radera slide 4 + strip leading-relaxed)

**Files:**
- Modify: `presentation/slides.md` (rad 133-169 raderas, 28 `leading-relaxed` strippas)

- [ ] **Step 1: Baseline snapshot**

Spara nuvarande PDF som baseline före ändringar:

```bash
cd /Users/daniel/projects/arduino-kurs
cp kompendium/deliveries/slides-arduino-kurs.pdf tasks/baseline-before-fas0.pdf
```

- [ ] **Step 2: Läs slide 4 för att bekräfta radintervall**

Använd Read på `/Users/daniel/projects/arduino-kurs/presentation/slides.md` med `offset: 130, limit: 45`. Bekräfta att rad 133 = `---`, rad 134 = `layout: center`, rad 135 = `class: text-center`, rad 136 = `---`, och att rad 169 är sista raden i sliden (troligen `-->` eller `---`).

- [ ] **Step 3: Radera slide 4**

Använd Edit för att ta bort hela blocket från och med `---` på rad 133 till OCH INKLUSIVE det avslutande `-->` (eller sista raden före nästa slide-start). Det avslutande `---` som startar NÄSTA slide måste lämnas kvar.

Konkret: `old_string` = hela blocket rad 133-169, `new_string` = "" (tom sträng). Efter edit ska raden som var 170 (`---` + nästa slide) vara direkt efter rad 132.

- [ ] **Step 4: Verifiera raderingen**

```bash
cd /Users/daniel/projects/arduino-kurs
grep -c "Klassrummets viktigaste verktyg" presentation/slides.md
```

Expected: `0`

```bash
wc -l presentation/slides.md
```

Expected: ~2730 rader (nuvarande 2767 - 37).

- [ ] **Step 5: Strip leading-relaxed**

Använd Edit med `replace_all: true` för att ta bort alla ` leading-relaxed` (med ledande space) från `presentation/slides.md`:

```
old_string: " leading-relaxed"
new_string: ""
replace_all: true
```

- [ ] **Step 6: Verifiera strip**

```bash
cd /Users/daniel/projects/arduino-kurs
grep -c "leading-relaxed" presentation/slides.md
```

Expected: `0`

- [ ] **Step 7: Export PDF**

```bash
cd /Users/daniel/projects/arduino-kurs/presentation
npm run export
```

Expected: kommando lyckas, `slides-export.pdf` uppdaterad.

- [ ] **Step 8: Flytta exporten till deliveries**

```bash
cd /Users/daniel/projects/arduino-kurs
mv presentation/slides-export.pdf kompendium/deliveries/slides-arduino-kurs.pdf
```

- [ ] **Step 9: Visuell sanity-check**

Dispatch sonnet-agent (`model=sonnet`) som jämför `tasks/baseline-before-fas0.pdf` och `kompendium/deliveries/slides-arduino-kurs.pdf` sida för sida. Förväntat: endast skillnaderna att (a) slide 4 saknas, (b) slides med leading-relaxed har minimal-till-ingen skillnad i radavstånd. Inga andra förändringar får finnas.

Om drift upptäcks → STOPP, rapportera till user innan commit.

- [ ] **Step 10: Commit**

```bash
cd /Users/daniel/projects/arduino-kurs
git add presentation/slides.md kompendium/deliveries/slides-arduino-kurs.pdf
git commit -m "chore(slides): remove post-it slide and purge redundant leading-relaxed"
```

---

## Task 2: Fas 1 — main.css typografi-centralisering

**Files:**
- Modify: `presentation/styles/main.css`

**Kontext:** main.css har redan `.slidev-layout.section` (rad 157-170), `.slidev-layout h1/h2/h3`, och `.big-code pre { font-size: 0.85em !important }` (rad 215 — sätter *mindre* storlek, vilket är ett bugg namne). Vi lägger till / uppdaterar typografi-regler så att default-layouts bär sig själva utan per-slide hjälp.

- [ ] **Step 1: Läs nuvarande main.css**

Använd Read på `/Users/daniel/projects/arduino-kurs/presentation/styles/main.css`. Notera exakt radnummer för: `.slidev-layout.section` (ca 157), `.big-code pre` (ca 215), och var `.slidev-layout.center` skulle passa in (efter `.slidev-layout.default` rad 52).

- [ ] **Step 2: Lägg till .slidev-layout.center-regler**

Infoga efter `.slidev-layout.two-columns`-blocket (ca rad 63):

```css
/* Center-layout för hero-message slides: stor rubrik + subtitle i plain markdown */
.slidev-layout.center {
  display: flex;
  flex-direction: column;
  justify-content: safe center;
  align-items: center;
  text-align: center;
}
.slidev-layout.center h1 {
  font-size: 5rem;
  margin: 0 0 1.5rem 0;
}
.slidev-layout.center > p {
  font-size: 2.2rem;
  opacity: 0.8;
  max-width: 48rem;
  margin: 0.5rem auto;
  line-height: 1.5;
}
```

- [ ] **Step 3: Lägg till .slidev-layout ul/ol-regler**

Infoga efter `.slidev-layout p`-blocket (rad 46-49):

```css
.slidev-layout ul,
.slidev-layout ol {
  font-size: inherit;
  margin: 0.8em 0;
  padding-left: 1.5em;
}
.slidev-layout li {
  margin: 0.5em 0;
  line-height: 1.5;
}
```

- [ ] **Step 4: Fixa .slidev-layout.section h1-centrering**

Uppdatera `.slidev-layout.section h1` (ca rad 166-170). Befintlig regel:

```css
.slidev-layout.section h1 {
  font-size: 5.5rem;
  color: var(--ak-accent);
  margin: 0.5rem 0;
}
```

Ersätt med:

```css
.slidev-layout.section h1 {
  font-size: 5.5rem;
  color: var(--ak-accent);
  margin: 0.5rem auto;
  display: block;
  text-align: center;
}
```

- [ ] **Step 5: Uppdatera .big-code pre**

Hitta raden med `.big-code pre` (ca rad 215). Befintlig:

```css
.big-code pre { font-size: 0.85em !important; line-height: 1.45 !important; }
```

Ersätt med:

```css
.big-code pre { font-size: 1.25em !important; line-height: 1.5 !important; }
```

(Motivering: 0.85em gör kodblock MINDRE, men de 3 slides som använder `[&_pre]:!text-Nxl` vill ha STÖRRE. Vi ändrar `.big-code` till korrekt semantik så att klassens namn stämmer överens med intent.)

- [ ] **Step 6: Export PDF**

```bash
cd /Users/daniel/projects/arduino-kurs/presentation
npm run export
cd /Users/daniel/projects/arduino-kurs
mv presentation/slides-export.pdf kompendium/deliveries/slides-arduino-kurs.pdf
```

- [ ] **Step 7: Spara Fas 1-baseline**

```bash
cp /Users/daniel/projects/arduino-kurs/kompendium/deliveries/slides-arduino-kurs.pdf /Users/daniel/projects/arduino-kurs/tasks/baseline-after-fas1.pdf
```

- [ ] **Step 8: Visuell verifiering**

Dispatch sonnet-agent som jämför `tasks/baseline-before-fas0.pdf` (minus slide 4) mot ny PDF. Förväntat: inga synliga regressioner på slides som redan var OK. Nya CSS-regler aktiveras först när slides konverteras i Fas 2, så denna fas ska vara visuellt nära neutral.

Om section-divider-slides förändras pga h1-centrerings-fixet → verifiera att det är korrekt förändring (h1 ska nu vara auto-centrerad utan inline workaround).

- [ ] **Step 9: Commit**

```bash
cd /Users/daniel/projects/arduino-kurs
git add presentation/styles/main.css kompendium/deliveries/slides-arduino-kurs.pdf
git commit -m "style(presentation): centralize layout typography in main.css"
```

---

## Task 3: Fas 2a — section-divider cleanup (5 slides)

**Files:**
- Modify: `presentation/slides.md` — slides 5, 22, 29, 40, 50 (ny slide-numrering efter taxonomi)

**Pattern som ska bort:** `<div style="text-align: center"><h1 style="display: inline-block">…</h1></div>`-workaround runt section-rubriken. CSS-fixet i Fas 1 (`.slidev-layout.section h1 { text-align: center; display: block }`) gör denna workaround överflödig.

- [ ] **Step 1: Läs taxonomi-rader för slides 5, 22, 29, 40, 50**

```bash
cd /Users/daniel/projects/arduino-kurs
awk -F'|' '$2 ~ /^[ ]*(5|22|29|40|50)[ ]*$/' tasks/slide-taxonomi-20260414.md
```

Notera rad-ranges för varje slide.

- [ ] **Step 2: För varje av de 5 section-slides — iterera**

För varje slide (5, 22, 29, 40, 50):

1. Read slide-blocket (offset + limit baserat på rad-range).
2. Hitta `<div style="text-align: center">`-wrappern runt h1.
3. Använd Edit för att byta:
   ```
   old_string: <div style="text-align: center"><h1 style="display: inline-block">RUBRIK</h1></div>
   new_string: # RUBRIK
   ```
   (där RUBRIK är faktiska rubriktexten)
4. Om sliden har andra wrappers runt subtitle-text (`<div class="text-2xl mt-6 opacity-80">…</div>`), konvertera till plain paragraph.

- [ ] **Step 3: Verifiera att inline-style är borta**

```bash
cd /Users/daniel/projects/arduino-kurs
grep -c 'display: inline-block' presentation/slides.md
```

Expected: `0`

- [ ] **Step 4: Export PDF + spara kluster-baseline**

```bash
cd /Users/daniel/projects/arduino-kurs/presentation && npm run export
cd /Users/daniel/projects/arduino-kurs
mv presentation/slides-export.pdf kompendium/deliveries/slides-arduino-kurs.pdf
cp kompendium/deliveries/slides-arduino-kurs.pdf tasks/baseline-after-fas2a.pdf
```

- [ ] **Step 5: Visuell diff på 5 section-slides**

Dispatch sonnet-agent som öppnar `tasks/baseline-after-fas1.pdf` och `tasks/baseline-after-fas2a.pdf`, plockar ut sidorna för slides 5, 22, 29, 40, 50 och jämför. Krav: h1 ska fortfarande vara centrerad, subtitle-spacing ska se OK ut.

STOPP-regel: om ≥2 slides har oacceptabel drift → rapportera, justera CSS, försök igen.

- [ ] **Step 6: Commit**

```bash
cd /Users/daniel/projects/arduino-kurs
git add presentation/slides.md kompendium/deliveries/slides-arduino-kurs.pdf
git commit -m "style(slides): idiomatic section-divider layout (5 slides)"
```

---

## Task 4: Fas 2b — code-demo cleanup (7 slides)

**Files:**
- Modify: `presentation/slides.md` — slides 18, 25, 30, 38, 42, 48 (ny numrering; 2b är 7 slides enligt kluster-summering — verifiera exakt lista i taxonomi)

**Patterns som ska bort:**
- `[&_pre]:!text-3xl`, `[&_pre]:!text-2xl`, `[&_pre]:!p-6`, `[&_pre]:!p-8` (arbitrary-selector utility)
- `<div class="mt-N ..."><pre>...</pre></div>`-wrappning

**Ersätts med:** Om storleken är viktig för pedagogiskt syfte → `.big-code`-wrap (nu fixad i Fas 1). Annars plain markdown-fence utan wrapper.

- [ ] **Step 1: Lista exakta code-demo slide-rader från taxonomi**

```bash
cd /Users/daniel/projects/arduino-kurs
grep -E '^\| [0-9]+ .* code-demo' tasks/slide-taxonomi-20260414.md
```

Notera varje slides rad-range.

- [ ] **Step 2: Identifiera de 3 slides med [&_pre]-overrides**

Nuvarande radnummer (före Fas 0-radering, kommer flytta): 1298, 1969, 2472. Efter Fas 0 (37 rader borta från rad 133-169): 1261, 1932, 2435.

```bash
cd /Users/daniel/projects/arduino-kurs
grep -n '\[&_pre\]' presentation/slides.md
```

- [ ] **Step 3: För varje av de 3 överrid-slides — besluta**

Läs sliden och bedöm: är det stora kodblocket verkligen en pedagogisk poäng (fontstorleken MÅSTE vara stor) eller är det en estetisk wrap?

Om **MÅSTE**: byt `<div class="mt-6 [&_pre]:!text-3xl [&_pre]:!p-8">` mot `<div class="big-code mt-6">` och låt `.big-code pre { font-size: 1.25em }` från Fas 1 bära.

Om **bara estetisk**: stryp wrappern helt, låt kod-blocket stå som plain fence.

- [ ] **Step 4: För resterande 4 code-demo slides**

Läs varje och stryp överflödiga wrappers (typiskt `<div class="mt-N max-w-Nxl mx-auto">`) runt `\`\`\`cpp`-fences. Plain fence ska räcka.

- [ ] **Step 5: Verifiera**

```bash
cd /Users/daniel/projects/arduino-kurs
grep -c '\[&_pre\]' presentation/slides.md
```

Expected: `0`

- [ ] **Step 6: Export + baseline-save**

```bash
cd /Users/daniel/projects/arduino-kurs/presentation && npm run export
cd /Users/daniel/projects/arduino-kurs
mv presentation/slides-export.pdf kompendium/deliveries/slides-arduino-kurs.pdf
cp kompendium/deliveries/slides-arduino-kurs.pdf tasks/baseline-after-fas2b.pdf
```

- [ ] **Step 7: Visuell diff på 7 code-demo slides**

Sonnet-agent jämför before (`baseline-after-fas2a.pdf`) mot after (`baseline-after-fas2b.pdf`) på de specifika sidorna. Krav: kod-block ska vara läsbara, storlek rimlig, ingen radbrytning som förstör betydelse.

STOPP-regel: ≥2 oacceptabla → rapport + justering.

- [ ] **Step 8: Commit**

```bash
cd /Users/daniel/projects/arduino-kurs
git add presentation/slides.md kompendium/deliveries/slides-arduino-kurs.pdf
git commit -m "style(slides): idiomatic code-demo blocks (7 slides)"
```

---

## Task 5: Fas 2c — content-bullets conversion (11 slides)

**Files:**
- Modify: `presentation/slides.md` — slides 6, 9, 13, 15, 19, 26, 27, 41, 47, 51, 52 (se taxonomi)

**Pattern som ska bort:**
```html
<ul class="mt-N text-Nxl space-y-N max-w-Nxl">
  <li>Text</li>
  <li>Text</li>
</ul>
```
Samt omgivande `<div class="mt-N max-w-Nxl mx-auto">`-wrappers.

**Ersätts med:**
```md
- Text
- Text
```

- [ ] **Step 1: Lista slide-rader från taxonomi**

```bash
cd /Users/daniel/projects/arduino-kurs
grep -E '^\| (6|9|13|15|19|26|27|41|47|51|52) ' tasks/slide-taxonomi-20260414.md
```

- [ ] **Step 2: Per slide — iterera (11 slides)**

För varje av de 11 slides:

1. Read slide-blocket.
2. Identifiera HTML-wrappad lista (`<ul class="...">` + `<li>`-element).
3. Edit: byt hela `<ul class="...">...</ul>`-blocket mot markdown-listan `- item 1\n- item 2\n...`.
4. Stryp yttre wrapper-divs som nu bara wrappar en markdown-lista.
5. Bevara `<!-- talarnotiser -->` i slutet av sliden orörda.

**Varning:** Om en slide har MIX av markdown och HTML-listor → konvertera bara HTML-listorna, bevara markdown-innehållet.

- [ ] **Step 3: Verifiera**

```bash
cd /Users/daniel/projects/arduino-kurs
grep -c '<ul class=' presentation/slides.md
```

Expected: ska ha minskat kraftigt (idag ~15, efter denna task borde det vara <5 — kvar är bara "äkta" HTML-listor i domain-custom slides).

- [ ] **Step 4: Export + baseline**

```bash
cd /Users/daniel/projects/arduino-kurs/presentation && npm run export
cd /Users/daniel/projects/arduino-kurs
mv presentation/slides-export.pdf kompendium/deliveries/slides-arduino-kurs.pdf
cp kompendium/deliveries/slides-arduino-kurs.pdf tasks/baseline-after-fas2c.pdf
```

- [ ] **Step 5: Visuell diff på 11 content-bullets slides**

Sonnet-agent jämför sida-för-sida. Krav: listor ska vara läsbara, storlek rimlig, spacing OK. Drift är förväntad — detta är första kluster där utseendet *ska* förändras mätbart.

STOPP-regel: om listor ser ominska, packade för tätt, eller text är för liten → justera `.slidev-layout ul/li`-reglerna i main.css och försök igen.

- [ ] **Step 6: Commit**

```bash
cd /Users/daniel/projects/arduino-kurs
git add presentation/slides.md kompendium/deliveries/slides-arduino-kurs.pdf
git commit -m "style(slides): idiomatic content-bullets markdown lists (11 slides)"
```

---

## Task 6: Fas 2d — hero-message → center layout (10 slides)

**Files:**
- Modify: `presentation/slides.md` — slides 7, 14, 20, 21, 28, 31, 37, 39, 49, 53 (se taxonomi)

**Pattern som ska bort:**
```md
---
layout: default
class: px-14
---

<div class="h-full flex flex-col items-center justify-center text-center">

# Stor rubrik

<div class="mt-16 text-4xl max-w-4xl mx-auto">
Subtitle-text
</div>

</div>
```

**Ersätts med:**
```md
---
layout: center
---

# Stor rubrik

Subtitle-text
```

**Kritisk detalj:** CSS-regeln `.slidev-layout.center > p` (från Fas 1) ska bära subtitle-storlek/opacity. Första `<p>` efter `<h1>` stylas automatiskt.

- [ ] **Step 1: Lista slide-rader**

```bash
cd /Users/daniel/projects/arduino-kurs
grep -E '^\| (7|14|20|21|28|31|37|39|49|53) ' tasks/slide-taxonomi-20260414.md
```

- [ ] **Step 2: Per slide — iterera (10 slides)**

För varje:

1. Read slide-blocket.
2. Ändra frontmatter: `layout: default` / `class: px-14` → `layout: center` (stryp class).
3. Ta bort yttre `<div class="h-full flex ...">`- och `<div class="text-center">`-wrappers.
4. Behåll h1 som markdown-rubrik.
5. Konvertera subtitle-`<div class="mt-N text-Nxl ...">Text</div>` till plain paragraph (bara texten).
6. Om sliden har markerings-text/labels ovan h1 (typ `<div class="text-xs font-mono opacity-60">Modul 01</div>`) → behåll som HTML ELLER konvertera till blockquote / paragraph med manuell class. Låg prio, vi ser i visuell diff.
7. Bevara talarnotiser.

- [ ] **Step 3: Export + baseline**

```bash
cd /Users/daniel/projects/arduino-kurs/presentation && npm run export
cd /Users/daniel/projects/arduino-kurs
mv presentation/slides-export.pdf kompendium/deliveries/slides-arduino-kurs.pdf
cp kompendium/deliveries/slides-arduino-kurs.pdf tasks/baseline-after-fas2d.pdf
```

- [ ] **Step 4: Visuell diff på 10 hero-slides**

Sonnet-agent jämförelse. Detta är **den mest drift-tunga fasen** — layout-byte från default till center ändrar grundläggande positionering. Förväntat: h1 centrerad, subtitle under, vertikalt mittcentrerad. Små-label-text kan se annorlunda ut.

STOPP-regel: om vertikal positionering ser fel ut (för högt upp, för lågt ner) → justera `.slidev-layout.center` flex-regler i main.css.

- [ ] **Step 5: Commit**

```bash
cd /Users/daniel/projects/arduino-kurs
git add presentation/slides.md kompendium/deliveries/slides-arduino-kurs.pdf
git commit -m "style(slides): hero-message slides use center layout (10 slides)"
```

---

## Task 7: Fas 2e — two-column → two-cols layout (7 slides)

**Files:**
- Modify: `presentation/slides.md` — slides 11, 12, 17, 32, 34, 43, 46 (se taxonomi)

**Pattern som ska bort:**
```md
---
layout: default
---

<div class="grid grid-cols-2 gap-N">
<div>Vänster kolumn</div>
<div>Höger kolumn</div>
</div>
```

**Ersätts med:**
```md
---
layout: two-cols
---

Vänster kolumn

::right::

Höger kolumn
```

**Observera:** Slidev's `two-cols`-layout använder `::right::`-separator. Vänster är default, höger efter markören. Vid behov för rubrik över båda kolumnerna → `two-cols-header` med `::left::`/`::right::`.

- [ ] **Step 1: Lista slide-rader**

```bash
cd /Users/daniel/projects/arduino-kurs
grep -E '^\| (11|12|17|32|34|43|46) ' tasks/slide-taxonomi-20260414.md
```

- [ ] **Step 2: Per slide — iterera (7 slides)**

För varje:

1. Read slide-blocket.
2. Identifiera kolumn-struktur: är det `grid grid-cols-2`? Eller `flex`? Eller manuell positionering?
3. Om två-kolumn med gemensam rubrik OVAN → `two-cols-header` med `::left::` / `::right::` separatorer.
4. Om bara två kolumner utan topprubrik → `two-cols` med `::right::`.
5. Konvertera kolumn-innehåll till markdown där möjligt, bevara HTML där det behövs (ex. bild med absolut positionering eller kod-block med inline-wrappning).
6. Uppdatera frontmatter: `layout: two-cols` (eller `two-cols-header`).

- [ ] **Step 3: Export + baseline**

```bash
cd /Users/daniel/projects/arduino-kurs/presentation && npm run export
cd /Users/daniel/projects/arduino-kurs
mv presentation/slides-export.pdf kompendium/deliveries/slides-arduino-kurs.pdf
cp kompendium/deliveries/slides-arduino-kurs.pdf tasks/baseline-after-fas2e.pdf
```

- [ ] **Step 4: Visuell diff på 7 two-column slides**

Sonnet-agent. Krav: kolumner balanserade, gap rimlig, vertikal alignment OK. two-cols använder default 1fr/1fr — om bredd-fördelning behöver vara annorlunda (ex. 2fr/1fr) → lägg till per-slide class eller CSS-override.

STOPP-regel: om kolumnerna är uppenbart oba­lanserade → rapport.

- [ ] **Step 5: Commit**

```bash
cd /Users/daniel/projects/arduino-kurs
git add presentation/slides.md kompendium/deliveries/slides-arduino-kurs.pdf
git commit -m "style(slides): two-column slides use two-cols layout (7 slides)"
```

---

## Task 8: Fas 2f — domain-custom wrapper stripping (10 slides)

**Files:**
- Modify: `presentation/slides.md` — slides 1, 3, 8, 10, 16, 24, 33, 35, 36, 44, 45 (se taxonomi — 10+1 inkluderar config-block)

**Scope:** Dessa slides har domän-komponenter (sp-grid, WiringSlide, Ohms-triangel, RGB-cirklar, warn/tip-box) som MÅSTE bevaras strukturellt. Uppgiften här är att strippa *redundant omgivande wrapping* — typiskt `<div class="mt-N ... mx-auto">` runt själva komponenten.

**HIGH-RISK-SLIDES** (sparas till Fas 3 eller hanteras med extra försiktighet i denna fas):
- 9 — Ohms-triangel
- 11 — resistor-färgring (men är i two-column-klustret, hanterat i 2e)
- 26 — inline-färgrutor (i content-bullets, hanterat i 2c)
- 34 — buzzer warn-box (i two-column, hanterat i 2e)
- 40 — helt-inline-slide (i section-divider, hanterat i 2a)
- 42 — spänningsdelare (i code-demo, hanterat i 2b)

→ High-risk-slides har redan hanterats eller kommer hanteras i respektive kluster. Fas 2f rör bara "äkta domain-custom-slides" (sp-grid, RGB, WiringSlide).

- [ ] **Step 1: Lista slide-rader**

```bash
cd /Users/daniel/projects/arduino-kurs
grep -E '^\| (1|3|8|10|16|24|33|35|36|44|45) ' tasks/slide-taxonomi-20260414.md
```

- [ ] **Step 2: Per slide — iterera**

För varje:

1. Read slide-blocket.
2. Identifiera domän-komponenten (sp-grid, WiringSlide, rgb-circle, etc.).
3. Stryp OMGIVANDE wrappers (`<div class="mt-N ...">`, text-storleks-overrides runt text som hör till komponenten).
4. **Rör inte komponenten själv internt.**
5. Konvertera rubriker/paragraffer runt komponenten till plain markdown där möjligt.

- [ ] **Step 3: Export + baseline**

```bash
cd /Users/daniel/projects/arduino-kurs/presentation && npm run export
cd /Users/daniel/projects/arduino-kurs
mv presentation/slides-export.pdf kompendium/deliveries/slides-arduino-kurs.pdf
cp kompendium/deliveries/slides-arduino-kurs.pdf tasks/baseline-after-fas2f.pdf
```

- [ ] **Step 4: Visuell diff**

Sonnet-agent. Fokus: domänkomponenter ska se IDENTISKA ut före/efter (de är orörda). Endast omkringliggande text/rubrik-positionering får skilja sig.

STOPP-regel: om en komponent förändras → wrapper-stripning tog för mycket, backa.

- [ ] **Step 5: Commit**

```bash
cd /Users/daniel/projects/arduino-kurs
git add presentation/slides.md kompendium/deliveries/slides-arduino-kurs.pdf
git commit -m "style(slides): strip wrapper noise from domain-custom slides (10 slides)"
```

---

## Task 9: Fas 3 — Finputs och slutgranskning

**Files:**
- Modify: `presentation/slides.md`, `presentation/styles/main.css` (vid behov)

- [ ] **Step 1: Full genomgång av PDF**

Dispatch sonnet-agent som läser `kompendium/deliveries/slides-arduino-kurs.pdf` i sin helhet och rapporterar per slide: (a) layout-konsistens (liknar slides varandra i kluster), (b) typografi-rytm OK, (c) inga visuella buggar eller avvikare.

Output till fil: `tasks/fas3-full-review-20260414.md`

- [ ] **Step 2: High-risk-slides individuell review**

Slides 9, 11, 26, 34, 40, 42 (originalnummer — översätt till nya numret efter raderingen via taxonomi). För varje: jämför original-baseline (`tasks/baseline-before-fas0.pdf`) mot nuvarande PDF. Är förändringen acceptabel? Om inte → manuell fix.

- [ ] **Step 3: Fixa avvikare**

Baserat på Step 1 och Step 2: manuella Edit-justeringar per slide. Kan vara: CSS-tweak i main.css, per-slide class-tillägg, eller rullback till HTML-form för en specifik slide.

- [ ] **Step 4: Final export**

```bash
cd /Users/daniel/projects/arduino-kurs/presentation && npm run export
cd /Users/daniel/projects/arduino-kurs
mv presentation/slides-export.pdf kompendium/deliveries/slides-arduino-kurs.pdf
```

- [ ] **Step 5: Final visuell verifiering**

Dispatch sonnet-agent för slutlig konsistens-check. Samtliga 51 slides ska se "snarlika ut inom sitt kluster" per users explicita önskemål.

- [ ] **Step 6: Uppdatera taxonomifilen**

Markera i `tasks/slide-taxonomi-20260414.md` att omskrivning är klar och lägg till kort status-sektion med datum.

- [ ] **Step 7: Städa baseline-filer**

```bash
cd /Users/daniel/projects/arduino-kurs
rm tasks/baseline-*.pdf
```

(Eller arkivera till en subfolder om du vill behålla för framtida referens.)

- [ ] **Step 8: Final commit**

```bash
cd /Users/daniel/projects/arduino-kurs
git add presentation/slides.md presentation/styles/main.css kompendium/deliveries/slides-arduino-kurs.pdf tasks/slide-taxonomi-20260414.md
git commit -m "style(slides): final touch-ups after idiomatic rewrite"
```

- [ ] **Step 9: Skriv sammanfattning till tasks/todo.md**

Uppdatera `tasks/todo.md` med review-sektion:
- Vad gjordes (per fas)
- Slutlig slide-räkning
- Vilka high-risk-slides krävde manuell justering
- Eventuella kvarvarande per-slide overrides och varför
- Länkar till spec, taxonomi, och denna plan

---

## Rollback-strategi

Om något går sönder i en fas:

- **Fas 0 fel:** `git reset --hard HEAD~1` (eller motsvarande före pågående arbete)
- **Fas 1 fel:** `git revert <fas1-commit>` — CSS-only, isolerad
- **Fas 2 fel i specifikt kluster:** `git revert <kluster-commit>`, justera CSS/spec, försök igen
- **Flera faser fel:** worktree-baserad rollback: `git checkout baseline-branch && git cherry-pick <safe-commits>`

Alla destruktiva git-operationer kräver **explicit user-bekräftelse** innan körning.

## Öppna beslut som kan dyka upp under execution

- **`center`-layout spacing:** kan behöva iteration på `.slidev-layout.center h1 { margin }` och `.slidev-layout.center > p { font-size }` i Fas 2d.
- **`two-cols` balance:** per-slide bredd-override om 1fr/1fr inte räcker.
- **`.big-code` storlek:** 1.25em kan vara för litet/stort — justera i Fas 2b om det syns.
- **Label-text ovan h1 (modulnummer, kursnamn):** HTML vs markdown i hero-message — avgörs vid visuell review i Fas 2d.

Dessa ska rapporteras till user när de uppstår, inte tystnad-beslutas.
