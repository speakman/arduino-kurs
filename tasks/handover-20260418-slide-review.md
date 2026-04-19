# Handover — slide-för-slide-granskning vid 1920×1080

**Datum:** 2026-04-18
**Sessionen innan:** grundmaterial-fixpass (27 fixar över 10 filer, bygger rent)
**Nästa session:** gå igenom **VARJE** slide (51 st) exakt hur de renderar vid 1920×1080 och säkerställ att varje är perfekt.

---

## Snabbstart för nästa session

### 1. Bygg slides + exportera PDF

```bash
cd /Users/daniel/projects/arduino-kurs/presentation
npx slidev export slides.md --output /tmp/slides-review.pdf
```

Det här tar ~60 sekunder. PDF:en blir 51 sidor, 1440×810 pt (vilket är 1920×1080 px vid 96 DPI).

### 2. Rendera slides vid exakt 1920×1080

```bash
# En slide:
pdftoppm -r 96 -jpeg /tmp/slides-review.pdf /tmp/slide -f N -l N

# En batch (t.ex. slide 10–15):
pdftoppm -r 96 -jpeg /tmp/slides-review.pdf /tmp/slide -f 10 -l 15

# Alla 51 (tar 30–60 sek):
pdftoppm -r 96 -jpeg /tmp/slides-review.pdf /tmp/slide
```

Filerna hamnar som `/tmp/slide-01.jpg` … `/tmp/slide-51.jpg`.

**Viktigt:** `-r 96` är *exakt* 1920×1080. Andra DPI-värden ger fel storlek.
Verifiera en gång: `identify /tmp/slide-01.jpg` ska säga `1920x1080`.

### 3. Läs slide-bilder

```
Read tool: /tmp/slide-NN.jpg
```

Claude Code:s Read-verktyg visar JPG:er direkt. Varje bild är exakt vad publiken ser på projektorn.

### 4. Edit → rebuild → re-render-loopen

När du hittat något som ska ändras på slide N:

```bash
# 1. Edit presentation/slides.md (rätt rader via grep)
# 2. Snabb rebuild (går fort när bara en rad ändrats):
cd /Users/daniel/projects/arduino-kurs/presentation
npx slidev export slides.md --output /tmp/slides-review.pdf
# 3. Re-rendera bara den sliden:
pdftoppm -r 96 -jpeg /tmp/slides-review.pdf /tmp/slide -f N -l N
# 4. Läs /tmp/slide-NN.jpg igen och bekräfta
```

---

## Arbetsflöde-rekommendation

Kursens `MEMORY.md` har redan en policy-memory (`feedback_slide_restructure_workflow.md`):

> **Parallell analys, sekventiell implementation.** Dispatcha sonnet-agents per slide för att *analysera* visuellt, men gör `Edit`:s en i taget.

Plus (`feedback_use_sonnet_for_image_review.md`):

> **Använd `subagent_type: Explore, model: "sonnet"`** för bild-/visuell audit. Opus är kraftig men overkill för "ser den här sliden bra ut?"-granskning.

### Föreslaget flöde

**Fas 1 — Inventera (parallell, sonnet):**
Dela upp de 51 sliderna i 5–6 batcher (à 8–10 slides) och dispatcha en sonnet-Explore-agent per batch. Varje agent:
1. Får pdftoppm-genererade JPG:er för sina slides
2. Rapporterar per slide: typografi (storlek, balans), layout (centrering, trångt/luftigt), innehåll (syftbarhet, fel, brott mot tonen), färg/kontrast
3. Flaggar slides som behöver åtgärd

Samla rapporterna i en fil (t.ex. `tasks/slide-audit-20260418.md`).

**Fas 2 — Åtgärda (sekventiell, opus):**
För varje flaggad slide:
1. Läs JPG själv för att bekräfta observationen
2. Edit slides.md
3. Re-render och verifiera
4. Fortsätt nästa

**Fas 3 — Sista genomkörning:**
Rendera alla 51 igen och stickprovs-kolla att inget regrediterat.

---

## Kritiska policies (missa inte dessa)

### "Inget barnsligt språk"
**FÖRBJUDNA ord:** superkrafter, magi, hjärnan, sinnen, röntgen.

De smög in från tidigt design-spec (`tasks/design.md`) — men är *medvetet bortstädade* av användaren sedan tidigare (`tasks/handover.md` rad 493: "FÖRBJUDNA"). Jag (föregående session) missade regeln först men rensade till slut.

Efter varje pass:

```bash
grep -inE "superkraft|magi|hjärna|sinnen|röntgen" \
  presentation/slides.md \
  presentation/README.md \
  kompendium/*.typ
```

Historiska dokument i `tasks/` (design.md, gamla handovers, reviews/) lämnas ifred.

### "Inga referenser till Elegoo-manualen"
Kompendiet + slides *ersätter* manualen; refererar inte till den. Inga "sid 42"-, "Lesson 4"-, "manualen säger"-frasar.

Sanity-grep:

```bash
grep -inE "manualen|sid 4[0-9]|sid 5[0-9]|sid 6[0-9]|sid 7[0-9]|sid 8[0-9]|Lesson " \
  presentation/slides.md kompendium/*.typ
```

Brandnamnet "ELEGOO"/"ELEGOO UNO R3" är OK som hårdvaruhänvisning.

### "Komplett kod i kompendiet, inte på slide"
Policy från `feedback_code_slides_vs_compendium.md`. Slides visar *essensen* (if/else-kärnan, 3 rader). Full sketch med `setup()` + kommentarer ligger i kompendiet.

---

## Slide-inventory (51 st)

Genererat från `slides.md`-grep. Siffra till vänster är slide-nummer (1-indexerat), rad-nummer refererar till `presentation/slides.md`.

| # | Rad | Layout | Titel/rubrik |
|---:|---:|---|---|
| 1 | 1 | cover | Elektronik & Programmering med Arduino |
| 2 | 67 | default | Fem träffar. Fem moduler. (kursöversikt) |
| 3 | 134 | section | Träff 1 av 5 — LED & krets |
| 4 | 168 | default | Idag — två timmar. *(agenda m. paus)* |
| 5 | 228 | full | Det här ska vi bygga. *(slutmålet)* |
| 6 | 267 | image-left | Mikrokontrollern. |
| 7 | 342 | default | Spänning, ström, GND. |
| 8 | 390 | default | U = R · I (Ohms lag) |
| 9 | 445 | two-cols-header | Kretsen — som ett vattensystem |
| 10 | 507 | two-cols-header | LED & resistor |
| 11 | 603 | default | Fem hål = en nod. (breadboard) |
| 12 | 653 | center | Kontrollera raden först. |
| 13 | 678 | default | Bygg kretsen. *(stegvis)* |
| 14 | 749 | default !p-0 | WiringSlide: LED-koppling |
| 15 | 783 | two-cols-header | setup() och loop(). |
| 16 | 854 | default | Hela Blink — på tre rader. |
| 17 | 923 | default | Din egen rytm. *(röd/grön-lapp tip)* |
| 18 | 1005 | center | Ni har byggt en blinkare. *(delresultat)* |
| 19 | 1072 | statement | Nästa gång... |
| 20 | 1118 | section | Träff 2 av 5 — PWM & RGB |
| 21 | 1144 | center | Alla färger, av bara tre. |
| 22 | 1200 | default !p-0 | WiringSlide: RGB-koppling |
| 23 | 1240 | default | analogWrite. |
| 24 | 1296 | default | Duty cycle. |
| 25 | 1326 | default | Hitta färgen. |
| 26 | 1395 | center | Ni har en pixel. |
| 27 | 1440 | section | Träff 3 av 5 — Digital input |
| 28 | 1465 | default | const int och int. |
| 29 | 1529 | statement | Input ≠ Output. |
| 30 | 1586 | two-cols-header | if / else. |
| 31 | 1652 | default !p-0 | WiringSlide: knapp-koppling |
| 32 | 1682 | two-cols-header | Reagera på flanken. *(edge-detection)* |
| 33 | 1756 | default | En varning först. *(buzzer-klisterlappen)* |
| 34 | 1843 | default !p-0 | WiringSlide: buzzer-koppling |
| 35 | 1869 | center | Läs knapp. Styr buzzer. |
| 36 | 1917 | default | Kärnan i loop(). |
| 37 | 1954 | center | Arduinon lyssnar. |
| 38 | 1986 | section | Träff 4 av 5 — Analog input |
| 39 | 2012 | default | Knappen var digital. Världen är analog. |
| 40 | 2074 | two-cols-header | analogRead() — Arduinons linjal. |
| 41 | 2121 | two-cols-header | Spänningsdelaren. *(custom SVG)* |
| 42 | 2225 | default !p-0 | WiringSlide: fotocell-koppling |
| 43 | 2247 | default !p-0 | WiringSlide: tilt-sensor-koppling |
| 44 | 2273 | two-cols | Serial Monitor. |
| 45 | 2341 | default | Hitta din tröskel. |
| 46 | 2391 | default | Koden att köra. |
| 47 | 2430 | center | Arduinon känner världen. |
| 48 | 2459 | section | Träff 5 av 5 — Integration |
| 49 | 2492 | default | Ingenjörsuppgiften. |
| 50 | 2562 | default | Pin-tilldelning *(hackathon-startmall)* |
| 51 | 2656 | center (end) | Tack. *(slut)* |

**High-risk-slides att inspektera extra noga:**
- **4** Idag — två timmar (nyligen ändrad med paus-rad, verifierad men värd ett andra öga)
- **8** U = R · I (innehåller Ohms-triangel-div — layout-känslig)
- **10** LED & resistor (two-cols-header, tät)
- **13** Bygg kretsen (5 stegvisa steg, textmängd)
- **14, 22, 31, 34, 42, 43** Wiring-slides (custom Vue-komponent, externa bilder)
- **17** Din egen rytm (nyligen ändrad med röd/grön-lapp tip-box, verifierad)
- **33** "En varning först" — buzzer-klisterlapp, bild+warn-box, inline style
- **41** Spänningsdelaren (800 px SVG, two-cols-header med komplext innehåll)
- **50** Pin-tilldelning (stor tabell)
- **51** Tack (slut-sliden, slut-brand)

---

## Filer som spelar roll

| Fil | Syfte |
|---|---|
| `presentation/slides.md` | **Källfil** för alla 51 slides |
| `presentation/styles/main.css` | Global typografi + design-tokens + layout-klasser (.big-code, .warn-box, .tip-box, .sp-grid, etc.) |
| `presentation/uno.config.ts` | UnoCSS-config med rebased typografi-skala för 1920-canvas |
| `presentation/components/WiringSlide.vue` | Vue-komponent för kopplings-slides (slide 14, 22, 31, 34, 42, 43) |
| `presentation/public/images/voltage-divider.svg` | Custom SVG för slide 41 |
| `presentation/public/images/wiring/*` | Fritzing-bilder för WiringSlide |

**Memory policy:** `feedback_code_slides_vs_compendium.md` — slides visar essens, inte full sketch.

---

## Nuvarande tillstånd

### Git
- Branch: `main`
- **Inget commit:at sedan `b41068c`** (slide 41 SVG från förra sessionen)
- Ändringar sedan dess **är inte commit:ade**: hela fix-passet från 2026-04-18 (27 fixar över 10 filer)
- `git status` visar modifierade:
  - `presentation/slides.md`
  - `presentation/README.md`
  - `kompendium/01-modul-1.typ` till `05-modul-5.typ`
  - `kompendium/appendix-a-syntax.typ`, `-c-`, `-e-`, `-f-`
  - `kompendium/*.pdf` (genererade)
- Plus nya filer i `tasks/`: rapport + handover

**Rekommendation innan /clear:** commit ändringarna med ett beskrivande meddelande, så nästa session har en ren baseline. Ex:

```
git add presentation/slides.md presentation/README.md kompendium/*.typ tasks/*.md
git commit -m "docs(course): rensa barnsligt språk, manualrefs, och 27 innehållsfixar"
```

(Användaren beslutar själv om commit ska göras — Claude Code commit:ar inte utan uttrycklig begäran.)

### Bygg-status
- ✅ `kompendium/build.sh` kör rent (7 PDF:er, 16 MB totalt)
- ✅ `npm run build` i presentation kör rent
- ✅ `npx slidev export slides.md` ger 51-sidig PDF à 10 MB

### Öppna frågor från föregående pass
1. **Du/ni-harmonisering.** Välj en form (förord säger "du", brödtext säger "ni kopplade"). Låt sedan någon köra global genomgång.
2. **Testpilot.** Hitta en radioamatör utan Arduino-vana, be dem läsa Modul 1 + bygga Blink ensam från kompendiet, notera var de fastnar.

Ingen av dessa blockerar slide-granskningen.

---

## Vad slide-granskningen bör leta efter

(Förslag — nästa session anpassar efter vad den faktiskt ser.)

### Layout
- Text rinner utanför canvasen
- Konstigt tomrum ovanför/under innehåll
- Kodblock som är för små eller för stora
- Två-kolums-layouts där kolumnerna är obalanserade

### Typografi
- Rubriker i ovanlig storlek relativt resten
- Textrader som bryter med bara ett ord på sista raden (änkor)
- Font-storlekar som inkonsistent mellan liknande slides

### Innehåll
- Stavfel (det finns en känd "snabva" som jag redan fixade i slide 17; ev. fler)
- Orphaned begrepp (ord som introduceras utan förklaring)
- Referenser till saker som inte finns (röd/grön-lapp är nu fixat, men leta efter liknande)

### Konsekvens
- Ikon-stilar (Carbon iconify-bibliotek är standard)
- Cyan (#00ffd1) som accent-färg konsekvent
- Röd (#ff3366) bara för GND/varning
- Eyebrow-labels ovan rubriker (font-mono uppercase opacity-50) — konsekvent format

### Bad smells
- Inline `style="..."` när det borde vara CSS-klass
- Magic numbers (`px-14`, `pt-12`) där global regel finns
- Duplicerade block med mindre variationer

---

## Sammanfattning

Allt bygger rent idag. Nästa session har:

1. En färsk 51-sidig PDF att börja från (`/tmp/slides-review.pdf` efter ny export)
2. En exakt render-pipeline: `pdftoppm -r 96 -jpeg` ger 1920×1080
3. En komplett slide-inventory att pricka av
4. Tydliga policies om språk + manualrefs
5. Ett beprövat arbetsflöde (parallell sonnet-analys, sekventiell opus-edit)

God lycka till.
