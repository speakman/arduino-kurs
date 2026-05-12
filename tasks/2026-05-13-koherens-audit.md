# Koherens-audit: docs/ ↔ slides + kompendium
*Datum: 2026-05-13*
*Metod: 6 parallella sonnet-subagenter (5 per modul + 1 cross-cutting)*

## Sammanfattning

| Modul | Critical | Important | Minor | Status efter fix |
|-------|----------|-----------|-------|-----------------|
| Dag 1 — LED & krets | 1 | 2 | 1 | Critical+Important fixade |
| Dag 2 — PWM & RGB | 0 | 2 | 2 | Important fixade |
| Dag 3 — Digital input | 0 | 2 | 1 | Important fixade |
| Dag 4 — Analog input | 0 | 0 | 1 | Ren — inga fixar behövdes |
| Dag 5 — Hackathon | 0 | 1 | 2 | Important fixad |
| Cross-cutting | 0 | 1 | 1 | Båda fixade |

**Totalt:** 1 Critical, 8 Important, 8 Minor. Alla Critical + Important + 1 Minor (storlek) fixades. Återstående minors gäller terminologi-nyansering som inte motsäger primärkällorna.

---

## Critical-fynd (FIXAT)

### Dag 1: Ohms-räknings-divergens
- **Sajten före:** `R = 3 V / 0,02 A = 150 Ω`, mål 20 mA
- **Slides + Bilaga F:** `R = 3 V / 0,015 A = 200 Ω`, mål 15 mA
- **Risk:** Studenter får konflikt mellan kursmaterial och uppföljande resurser. Plus säkerhetsfråga — 20 mA är **maxvärdet**, inte designmålet.
- **Fix:** sajten visar nu 15 mA → 200 Ω + förklarar att 20 mA är max.

---

## Important-fynd (alla FIXADE)

| # | Fil | Före | Efter |
|---|-----|------|-------|
| 1 | dag/1.html | Bara 4-band-koden nämndes (röd·röd·brun + guld) | Lägg till 5-band-variant (röd·röd·svart·svart·brun) |
| 2 | dag/1.html | `blink-extern-led.ino` med `delay(500)` omotiverad | Motivera: "experimentera med tempo: 200, 50, 10" |
| 3 | dag/2.html | "~490 Hz" som generell siffra | "~490 Hz på de flesta pinnar, 980 Hz på 5 och 6" |
| 4 | dag/2.html | rgb-cycle.ino hade vit-block utan prosa-stöd | Vit-block också i visad kod + förklaring i tip |
| 5 | dag/3.html | Buzzer-lappens motivering: "skydda damm" (hittepå) | "fabriksdämpare för obekvämt högt ljud" (matchar slides) |
| 6 | dag/3.html | Operatorer `!= < > && \|\| !` saknades i "Vad du lärde dig" | Lägg in i `=` vs `==`-skillen |
| 7 | dag/5.html | "Mönstret" hade 3 block (saknade edge-detection-steget) | 4 block: Läs / Uppdatera / Beslut / Agera |
| 8 | resurser.html | "magiska remsor" (CLAUDE.md-policy: barnsligt) | "adresserbara LED-remsor" |

---

## Minor (delvis fixade)

| Fil | Fynd | Status |
|-----|------|--------|
| nedladdningar.html | Bilaga-D storlek "0,1 MB" (faktiskt 0,15) | Fixad → "0,15 MB" |
| dag/1.html | Intern inkonsekvens prosa vs figcaption på kopplings-ordning | Ej fixad — båda elektriskt korrekta |
| dag/2.html | rgb-cycle färgvärden matchar inte slides-övningens specifika tal | Ej fixad — pedagogiskt OK att avvika |
| dag/2.html | Fade-konceptet får mer plats än som ren hemövning | Ej fixad — site-prioritering OK |
| dag/3.html | larm-toggle.ino har LED_BUILTIN-init som inte finns i kompendium-skelettet | Ej fixad — sajten är pedagogiskt mer komplett |
| dag/4.html | "5 kΩ rumsljus" inte i primary sources | Ej fixad — tekniskt rimligt värde |
| dag/5.html | "sense + act" vs "INPUT/LOGIK/OUTPUT" vs "5-stegs sense-act-loop" — 3 varianter | Ej fixad — alla beskriver samma sak |
| dag/5.html | Material-card för modul-5 beskriver kompendiet "tunt" | Ej fixad — beskrivning kompletteras nedan vid behov |

---

## Tilt-sensor-logik — explicit 6-källsverifiering

Eftersom polaritet är extra risk-känslig efter en tidigare bugg (dag/4-prose-fix):

| Källa | Upprätt | Lutad |
|---|---|---|
| `tilt-photocell.ino` rad 16 | HIGH | LOW |
| Slides rad 2399 (presenter notes) | HIGH | LOW |
| Slides rad 2607 (presenter notes) | HIGH (1) | LOW (0) |
| Kompendium rad 131–132 + rad 238 | HIGH (öppen krets) | LOW |
| `docs/dag/4.html` prosa rad 210 | HIGH | LOW |
| `docs/dag/4.html` skill-card rad 94 | HIGH | LOW |

**Alla 6 instanser stämmer. Ingen regression.**

---

## Larm-komplett.ino vs Bilaga D — byte-jämförelse

Logiskt identiska. Skillnaderna är uteslutande:
- Inline-kommentar: appendix-D säger "RÖRT", larm-komplett.ino säger "LUTAD" (sistnämnda är korrekt fysiskt)
- Sektions-kommentarer (`// ─── SETUP ──`, `// ─── LOOP ──`): finns i appendix-D, ej i .ino
- Whitespace-variationer: irrelevant

Ingen funktionell divergens.

---

## CLAUDE.md-policy-check

| Policy | Status efter fix |
|--------|-----------------|
| Barnsligt språk (superkrafter/magi/röntgen/hjärnan/sinnen) | ✓ Ren (efter "magiska remsor"-fix på resurser.html) |
| Elev/lärar-direktiv ("ropa om du fastnar" etc.) | ✓ Ren |
| Röda/gröna post-it-lappar | ✓ Ren |
| ELEGOO Lesson/sid-referenser | ✓ Ren — varumärket ELEGOO används korrekt, inga sid-refs |

---

## Verifiering efter fix

- 7 filer ändrade, 24 insertions, 14 deletions
- 1 commit: `fix(content): koherens-audit — adressera 1 Critical + 8 Important`
- Pushat och deploy:at till live Pages
