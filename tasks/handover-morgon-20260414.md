# Handover — morgonfixar 2026-04-14

User har läst igenom deliveries/ och hittat en batch med fixar. Alla följer efter en `/clear`.

## 🚨 Blocker: ligature-problem i kompendiet (Menlo/JetBrains Mono i Typst)

**Symptom:** I PDF:erna renderas `==` som `⩵`, `!=` som `≠`, `<=` som `⩽`, `>=` som `⩾`. Det är EN bild från modul-2 (`for` loop med `i <= 255`) och EN från appendix-a-syntax (tabellen med `==`, `!=`, `<=`, `>=`) som user skickat. Se `tasks/user-screenshots-20260414/` om bilderna sparats.

**Orsaken:** Fontarna JetBrains Mono och Menlo har programmerings-ligatures på som default i Typst. Vi fixade redan ligatures i slides.md via CSS (`font-feature-settings: "liga" 0, "calt" 0`), men Typst mono-fonter har INTE fått samma behandling.

**Fix i `kompendium/theme.typ`:**
- Lägg till `features: ("calt": 0, "liga": 0, "clig": 0)` på mono-text-setter, ELLER
- Byt mono-font till en utan ligatures (t.ex. IBM Plex Mono, Fira Mono utan ligatures, Source Code Pro)
- ALTERNATIVT: använd `set text(font: mono-font, ligatures: false)` om Typst stödjer det
- Verifiera genom att kompilera och titta på `appendix-a-syntax.typ` som har `==`, `!=`, `<=`, `>=` på raderna ~100-110

Detta måste lösas över **ALLA dokument inklusive slides** (även om slides redan är fixat, verifiera en gång till).

## 🚨 Vertikal alignment i kod-kommentarer

User flaggade: "verticalt alignade saker så som kommentarer är ofta inte helt raka". Se `appendix-a-syntax.typ` eller slides där flera kommentarer efter `//` står på olika kolumnpositioner.

**Fix:** Gå igenom alla kod-block och säkerställ att inline-kommentarer är alignade i samma kolumn (pad med mellanslag tills `//` börjar på samma position). Exempel:
```cpp
analogWrite(ledR, 255 - i);   // röd sjunker
analogWrite(ledB, i);         // blå stiger
delay(20);                    // total tid: 255 × 20 ms ≈ 5 s
```

## 🚨 Modul 1 sida 7: kod-block överflöd

`modul-1-led-krets.pdf` sid 7 — kod-rutan överst sticker utanför pappret vid högerkanten. Kan inte skrivas ut. Trolig fil: `01-modul-1.typ`. Möjligen SOS-koden eller något annat long-line code-block.

**Fix:** Hitta block och antingen bryt rader, skala font, eller öka margin-respekterande width.

## 🎯 "Påminnelse-texter" — för uppläxande

Ta bort följande texter som är för moderande/uppläxande:

**modul 1:**
- Byt "Ta med allt nästa gång — laptop, Arduino, breadboard, hela kittet. Du har bara en breadboard, och vi bygger vidare direkt. Demontera gärna LED-kretsen hemma så är det lättare att starta om från scratch."
- Till: "Glöm inte dator eller Elegoo-kitet hemma!"
- **Gäller generellt:** alla modulers "Inför nästa träff"-avsnitt ska ha samma korta format.

**modul 2:** 
- Skippa text om penna och papper — används inte i träff 3.

**modul 3:**
- "Ingen läxa krävs — övningarna ovan räcker som repetition" → TA BORT (vi kräver aldrig läxor).

**modul 4:**
- "Kom utsövda, med laddad laptop och alla delar från kittet. Och kom hungriga — hackathon brukar bli längre än man tror."
- Skippa "utsövda" och "hungriga" (varför ska de vara hungriga?!). Behåll "hackathon" som roligt begrepp.

## 🎯 Emoji och unicode-ikoner — ta bort

Genomgående: bort med emoji och unicode-ikoner (⚠️, ✓, ✅, ❌, 🔧, ·, ◦ etc) **för läsbarhetens skull**. Använd text eller typografiska markörer istället.

Sökord att leta efter i alla filer:
- Emoji-range i markdown (`🚨 ⚠️ ✅ ❌ 💡 📝 🔍 🎯 🏆 📋 🚀`)
- Typst `set list(marker: ([•], [◦], [–]))` → byt till enklare text-markörer eller standard `-`
- `i-carbon-*` ikoner i slides — behåll endast där de tillför betydande pedagogiskt värde
- Andra speciella unicode som kan misstolkas

## 🎯 ELEGOO-manualen referenser — ta bort

User sa: "Jag tror vi kan ta bort referenser till ELEGOO-manualen överallt i alla dokument."

Sök och ta bort alla referenser som "ELEGOO Lesson X sid Y", "ELEGOO-manualen Lesson X", etc. — både i brödtext, bildtexter och speaker notes.

Grep-pattern: `ELEGOO|Elegoo.*sid|Elegoo.*Lesson|Lesson \d+`

## 🎯 Syntax highlighting på ALLA flerradiga kodstycken

User: "Generellt borde vi verkligen ha syntax highlight på alla flerradiga kodstycken."

**Status:**
- Bilagorna HAR syntax highlighting (user bekräftade)
- Modulkapitlen använder `raw.where(block: true)` i theme.typ utan syntax highlighting
- Slides har Shiki-highlighting via `\`\`\`cpp`-fencing

**Fix i `theme.typ`:**
- Säkerställ att ALLA `\`\`\`cpp`-fencade block i Typst-filerna får syntax highlighting
- Kolla om vanlig ` ``` ` (utan language) renderar utan highlight — om så: konvertera alla till ` ```cpp `
- Verifiera att Typst kan parsa Arduino C++ som "cpp" eller "c++"

**Grep:** hitta alla `\`\`\`` utan språkangivelse i `kompendium/*.typ` och lägg till `cpp`.

## 🎯 Kod-block radbrytning

"Vi borde också konsekvent undvika radbrytning mitt i kodexempel, gäller alla pdf:er."

**Fix:** Lägg till `overflow: "visible"` eller liknande, eller förkorta långa rader, eller minska monospace-storlek på bred kod.

## 🎯 Slides 16:9 check

User: "är slidsen 16:9 verkligen? isåfall är det flera slides vars innehåll inte fullt får plats. Samt att flera slides som ser bra ut i webbläsaren inte renderar särskilt fint i en PDF, särskilt där många bilder lagts ovanpå varandra."

**Fix:**
- Bekräfta Slidev-config att det är 16:9 (1920×1080)
- Kör en ny full visuell audit av slide-PDF:en (`deliveries/slides-arduino-kurs.pdf`) specifikt för overflow
- Speciellt slides med layered background images (cover, section dividers) — jämför webb-rendering mot PDF-export
- Möjlig fix: använd `--per-slide` flag på `slidev export` för bättre rendering, eller ändra image handling

## Sammanfattning — prioriterad ordning för nästa session

1. **Ligature-fix i Typst mono-font** (blocker för kompendium)
2. **Kod-kommentarer vertikal alignment** (blocker — ser oprofessionellt ut)
3. **Modul 1 sid 7 kod-överflöd**
4. **Emoji/unicode-ikoner bort** (genomgående)
5. **ELEGOO-referenser bort** (genomgående)
6. **"Uppläxande" Inför nästa träff-texter kortas**
7. **Syntax highlighting på flerradiga kodblock**
8. **Slide-PDF 16:9 audit + overflow-fix**
9. **Kod-radbrytning fixar**
10. **Rebygga alla deliveries**
11. **Final sonnet-audit över alla sidor för att bekräfta**

## Filer att redigera

- `kompendium/theme.typ` — ligatures + list markers + raw highlighting
- `kompendium/01-modul-1.typ` t.o.m. `05-modul-5.typ` — texter, emoji, ELEGOO-refs
- `kompendium/appendix-a-syntax.typ` t.o.m. `appendix-f-framspanningsfall.typ` — samma
- `presentation/slides.md` — emoji, ELEGOO-refs, kod-radbrytningar, 16:9 overflow
- `presentation/styles/main.css` — verifiera ligature-fix kvarstår

## Efter fixar

```bash
cd kompendium && bash build.sh
cp {kompendium,modul-*,bilagor-a-f}.pdf deliveries/
cd ../presentation && npm run build && npx slidev export --output ../kompendium/deliveries/slides-arduino-kurs.pdf
```

Sedan visuell audit med Sonnet-subagent per PDF för att verifiera alla fixar syns.

## Kontext du behöver

- Alla review-rapporter ligger i `tasks/review-*.md`
- Deliveries i `kompendium/deliveries/`
- Senaste PDF-render av kompendium-sidor i `kompendium/review-pages/m1/`, `m2/`, `m3/`, `m4/`, `m5/`, `bilagor/`
- Senaste slide-PNG:er i `tasks/overflow-audit/`

**Slut på handover.**
