# Arkitekt-utmaning av exekveringsplanen

**Verdict:** APPROVE_WITH_CHANGES
**Reviewer:** Arkitekt (Opus)
**Datum:** 2026-04-13

## Sammanfattning

Förslaget är pedagogiskt sunt och elektronik-tilläggen E1–E5 är välmotiverade. Men exekveringsordningen har **två allvarliga sekvensfel**:

1. **C2 (tilt-flytt) ligger i Fas 2**, men den ändrar slide-numreringen och modulgränser. Den måste göras **före** C6/C7 (globala sök/ersätt) — annars riskerar rad-referenserna i Fas 1 vara stale.
2. **Fas 3 (projektor-test) är schemalagd EFTER alla nya slides** — fel. Projektor-testet ska ske efter Fas 1 (när typografin är fixad) **och igen** efter Fas 2. Annars upptäcker du först i slutet att C6-fixen var otillräcklig och måste skriva om allt material en gång till.

Plus: tidsuppskattningarna är ~2x för optimistiska. ~16 nya slides à 30 min = 8h ren produktionstid, **utan** review-loopar och pedagogisk iteration. Realistiskt 2.5–3 dagar för Fas 2, inte 1–2.

Bundling av elektronik + gate-fixar är **rätt** — de delar samma pedagogiska kontext och bör inte separeras, men ordningen inom bundlen måste fixas.

## Beroendeanalys

Verkliga beroenden (→ = "blockerar"):

```
C2 (tilt-flytt/omraming) ──┐
                           ├─→ C6 global eyebrow-fix (rad-referenser stale annars)
                           ├─→ C7 WiringSlide caption (samma)
                           └─→ Alla nya Modul 3/4-slides (måste veta var tilten bor)

C6 + C7 (typografi) ───────→ Fas 3a projektor-test #1 ──→ alla nya slide-skrivningar
                                                          (annars skrivs ny content till
                                                          fel typografi-baseline)

E4 PWM (C4)         ───────→ Modul 2 agenda + övning + delresultat (C5 Modul 2)
E2 Pullup (I1+I5)   ───────→ "if/else"-slide (I5)        ──→ Komplett knapp+buzzer (C3)
                                                              ──→ "Toggla tillstånd" (C1a)
E3 Spänningsdelare  ───────→ Modul 4 övning + delresultat (C5 Modul 4)

I6 RGB pin-verifiering (PDF-läsning) ──→ Eventuellt ändra pin-konstanter ──→ Modul 5 mall
   (Måste göras EXTRA tidigt — om verifieringen visar fel pin-mappning ändras KOD i flera slides)

Kompendium (Fas 4) ←── BORDE läsa nya slides PARALLELLT, inte sekventiellt
```

**Parallelliserbart:**
- Fas 1 mekaniska fixar (C6, C7, I1, I8, I15, minor codex-punkter) — inga inbördes beroenden, kan klumpas i en session
- E1 Breadboard-anatomi och E5 Säkerhet — fristående tillägg, kan skrivas när som helst
- I4 Variabler-mini-slide — fristående

**Sekventiella tvång:**
- I6 PDF-verifiering MÅSTE göras före allt skrivande som rör RGB pins
- C2 tilt-beslutet MÅSTE fattas före Modul 3/4-arbetet (annars skrivs slides till fel modul)
- E2 → I5 → C3 → C1a är en pedagogisk kedja som ska skrivas i ordning

## Föreslagen reviderad sekvens

### Fas 0 — Beslut & verifiering (1–2h, MÅSTE göras före allt annat)
1. **I6** Öppna Elegoo-PDF sid 50–51, verifiera RGB pin-mappning. Om fel: bestäm om kursens pins ändras eller manual-not.
2. **C2-beslut** Tilt-sensor: flytta till Modul 3 ELLER rama om Modul 4 till "Sensorer & felsökning". Detta är ett **irreversibelt** strukturbeslut — gör det medvetet och först.
3. Bestäm: ska E5 (säkerhet) verkligen med? Ska E1 (breadboard-anatomi)? — kapa scope NU, inte i mitten av Fas 2.

### Fas 1 — Mekaniska fixar (3–5h)
Som förslaget, men ordnad efter risk:
1. C6 global eyebrow sök/ersätt
2. C7 WiringSlide caption
3. **Commit här.** Liten reversibel enhet.
4. I1 pullup-fix, I8 RGB-referens, I15 SOS-kommentar, I2 slide 14 högerkolumn
5. Minor codex-punkter (vattenanalogi, common cathode, buzzer-text, emoji→carbon)
6. **Commit.**

### Fas 1.5 — Projektor-test #1 (1h, OBLIGATORISK)
Kör presentationen på riktig projektor i FRO-lokalen, läs eyebrow-text och WiringSlide-captions från bakre raden. **Validera att C6/C7 räcker.** Om inte: justera typografi-baseline NU innan du skriver 16 nya slides till fel standard.

### Fas 2a — Pedagogiska skelett-tillägg (1 dag)
Skriv strukturen, inte detaljerna. Replikerar Modul 1:s mönster över Modul 2–4:
- Modul 2/3/4 agenda-slides (3 st)
- Modul 2/3/4 delresultat-slides (3 st)
- Modul 2/3/4 teaser-slides (3 st)
- Modul 5 paus i agendan + utbyggd startmall

Detta är **låg risk, hög ROI, repetitiva**. Gör batch-jobbet i en session.

### Fas 2b — Konceptuellt tunga slides (1–1.5 dagar)
Skrivs i pedagogisk kedja:
1. **E4 PWM/duty cycle** + komplett analogWrite-sketch + Modul 2 fri övning (löser C4)
2. **E2 Flytande pin & pullup** (löser I1-grund, I5-grund, del av C1)
3. **"if/else"-slide** (löser I5)
4. **Komplett knapp+buzzer-kod** (löser C3)
5. **"Toggla ett tillstånd"-slide** (löser C1a)
6. **E3 Spänningsdelare med vattenanalogi** (löser V3/I9)
7. (Valfritt) E1 Breadboard-anatomi, E5 Säkerhet, I4 Variabler

### Fas 2.5 — Projektor-test #2 (1h)
Verifiera nya slides på projektor. Fånga eventuell pedagogisk obalans.

### Fas 3 — Kompendium (parallellt med slutet av Fas 2b, sedan färdigställs)
**Börja kompendium-strukturen redan när Fas 2b är halvvägs.** Att skriva kompendiet exponerar var slides är otillräckliga — bättre att hitta det nu än efter att slides är "klara". Se rekommendation nedan.

## ROI-ranking av föreslagna fixar

**S-tier (gör absolut, billigt, fixar kritiska blockers):**
1. **C6 eyebrow sök/ersätt** — 15 min, fixar 27 ställen, enskilt största läsbarhets-vinsten
2. **C7 WiringSlide caption** — 5 min, gör 6 kopplings-slides dramatiskt mer användbara
3. **I1 pullup-fix** — 30 sek, eliminerar enda begreppsfelet
4. **I6 RGB-verifiering** — 10 min PDF-läsning, kan rädda hela Modul 2+5 från pin-fel
5. **C2 tilt-beslut** — 0 kod, bara ett beslut, eliminerar derail-risk i Modul 4

**A-tier (hög pedagogisk ROI, måttlig kostnad):**
6. **E4 PWM-slide** — fixar C4, kärnbegrepp i hela Modul 2 (1h att skriva väl)
7. **C3 buzzer-kod-slide** — kursens första input→output-program, måste på skärm (45 min)
8. **C1a state-toggle-slide** — utan denna fungerar inte hackathonen (1h)
9. **C5 Modul 2–4 delresultat-slides** — replikerbart mönster, 3 slides à 20 min (1h totalt)

**B-tier (värdefullt men inte blocker):**
10. E2 Flytande pin (1h — pedagogiskt fint, men I5 if/else löser samma upplevelse-problem)
11. E3 Spänningsdelare (1.5h — knyter ihop bakåt, men kan leva i kompendiet om det måste)
12. I5 if/else-slide (45 min)
13. I2 slide 14 städning (15 min)
14. C5 agenda + teaser-slides Modul 2–4 (6 slides à 15 min = 1.5h)

**C-tier (nice to have, skippa under tidspress):**
15. E1 Breadboard-anatomi
16. E5 Säkerhet
17. I4 Variabler mini-slide
18. Alla minor punkter (cosmetic)

## Tidsrealism

Förslagets gissningar: Fas 1: 0.5–1 dag. Fas 2: 1–2 dagar.

**Räkna baklänges från slide-volymen:**

Förslaget lägger till ungefär:
- Modul 1: 2–3 nya slides
- Modul 2: 5 nya slides
- Modul 3: 5 nya slides
- Modul 4: 4 nya slides
- Modul 5: 1–2 ändrade slides

Totalt: **17–19 nya slides + 5–8 ändrade.**

Vid 30 min/ny slide (content + speaker notes + verifiering): **~9 timmar ren produktion.** Plus:
- Pedagogisk iteration (E2, E3, E4 är konceptuellt täta — räkna 2x på dem): +2h
- Testkörning av kod-snippets för C3, C4, C1a: +1h
- Slidev-rendering-fix när nya layouts inte ser ut som väntat: +1h
- Magic-move-tweaks för PWM och if/else-evolution: +1h

**Realistisk Fas 2: 14h aktiv tid = 2–2.5 dagars fokuserat arbete**, inte 1–2.

Fas 1 är mer pålitligt uppskattad: ~4–5h aktiv tid är rimligt.

**Total: 3–3.5 dagar för Fas 1+2 + Fas 3 verifiering + 1–2 dagar för kompendium = ~5 dagar.**

Förslaget säger 2–3 dagar. **Underestimat med faktor 1.7–2x.** Klassiskt — pedagogiskt skrivande är inte mekaniskt.

## Risker med den föreslagna sekvensen

1. **Fas 1 dubbleras i tid** → Fas 2 trycks ihop → korta pedagogiska genvägar i E2/E3 → Modul 1:s "guldstandard" replikeras inte → C5 löses bara på pappret. **Mitigation:** Prioritera S+A-tier. Skippa C-tier under press.

2. **E3 Spänningsdelare är pedagogiskt svårast att skriva väl** — vattenanalogi-återkopplingen är hela poängen. Riskera 2h, inte 30 min. **Mitigation:** Boxa tiden, om den drar ut: parkera i kompendium istället.

3. **Projektor-testet kommer för sent.** Om C6-fixen visar sig otillräcklig för bakre raden, har du redan skrivit 16 nya slides till fel typografi-baseline. **Mitigation:** Fas 1.5 tvingande mellan Fas 1 och Fas 2.

4. **Tilt-beslutet (C2) gömt i mitten av Fas 2** — om det fattas sent har du redan skrivit Modul 3/4-skelett som måste skrivas om. **Mitigation:** Fas 0.

5. **I6 PDF-verifiering ligger i Fas 1 men efter typografi-fixarna** — om RGB-pins är fel ändras kod-snippets på flera slides, och redan-fixad eyebrow-typografi blir oviktig vs den ändringen. **Mitigation:** Fas 0.

6. **Reversibilitet:** C6/C7 är reversibla (sök/ersätt), nya slides är reversibla (radera), men **C2 tilt-flytt och PDF-baserad pin-omkonfiguration är strukturella** — gör först.

7. **Slide-bloat-risk i Modul 2:** 4→9–10 slides på 2h klassrumstid är gränsfall. Om varje slide tar 5 min talar tid blir det 50 min av 120 min — knappt utrymme för hands-on. **Mitigation:** Mät tempo i Fas 1.5 och justera scope.

8. **Förslaget antar att LLM kan skriva E2/E3 till Modul 1:s nivå.** Pedagogik-reviewern satte Modul 1 som guldstandard. Risk: nya slides blir tekniskt korrekta men pedagogiskt platta. **Mitigation:** Skriv ett utkast, låt användaren granska INNAN du skriver de andra. En review-checkpoint i mitten av Fas 2b.

## Vad förslaget missar att planera för

1. **I6 PDF-verifierings-konsekvenser.** Förslaget listar I6 som en 5-min checkpunkt men nämner inte att om Elegoo använder annan pin-mappning krävs **kod-uppdateringar i flera slides** + Modul 5 startmall + ev. nya bilder.

2. **Speaker notes-uppdatering för befintliga slides.** När du flyttar tilt-sensorn försvinner inte bara slide-positionen — speaker notes som refererar "som vi sa precis" måste uppdateras. Inte budgeterat.

3. **Cross-references mellan slides.** Förslaget bygger nya slides som "Toggla tillstånd"-slide, "if/else"-slide etc. Befintliga slides behöver eventuellt uppdateras till "som vi lärde oss på slide X".

4. **Build-verifiering.** Slidev-bygget kan failas av nya layouter eller saknade ikoner. Inte budgeterat.

5. **Bilder för nya slides.** E4 PWM-waveform: behöver SVG eller bild. E3 spänningsdelare: behöver schema. E1 breadboard-anatomi: behöver markup på en breadboard-bild. Inte budgeterat — det är 1–2h extra.

6. **Testkörning av nya kod-snippets.** C3 buzzer+knapp, C4 analogWrite-sketch, C1a state-toggle — dessa måste kompileras och köras på en Arduino innan de hamnar på en kursslide. Inte i förslaget.

7. **Differentiering (I13).** Förslaget nämner ej att speaker notes per modul ska få extra-utmaningar. Lågt arbete, men glömt.

8. **Repetitions-hooks (mindre punkt).** "Där vi var..."-slide innan varje modul. Lågt arbete, högt pedagogiskt värde, missat.

9. **WiringSlide.vue alt-attribut + v-html risk-not (codex-punkt).** Liten kod-fix, missad.

10. **Roll-back-plan om Fas 1.5 underkänner C6.** Vad gör du om typografin fortfarande är för liten på projektor? Förslaget har ingen plan B.

## Rekommendation om Fas 1 vs Fas 2 bundling

**Bundla — men med Fas 0 + Fas 1.5 emellan.** Argument:

**FÖR bundling:**
- Elektronik-slides och pedagogiska gate-fixar delar samma kontext: Modul 2–4. Att touch:a samma filer två gånger är ineffektivt.
- E2/E3/E4 löser samtidigt elektronik-djup OCH gate-blockers — separera dem är artificiellt.
- Kompendiet är slutmålet; ju snabbare slides är "färdiga nog", desto snabbare kan kompendiet börja.
- En enda bundle gör det lättare att verifiera helheten på projektor en gång.

**EMOT bundling (svag):**
- Risk att elektronik-ambitioner förlänger gate-fix-leveransen om något fastnar.
- Möjligt att leverera Fas 1 + projektor-test som "minimum viable fix" om tid är knapp.

**Slutsats:** Bundla. Men **isolera Fas 0 (irreversibla beslut) och Fas 1 (mekaniska fixar) som egna commits/sessioner** så att du har en valid fall-back. Om Fas 2 spårar ur har du fortfarande ett dramatiskt förbättrat deck efter Fas 1+1.5.

## Rekommendation om kompendium-parallellism

Förslaget sätter kompendiet sist (Fas 4). **Detta är delvis fel.** Bättre:

- Börja kompendium-**strukturen** (kapitelrubriker, appendix-skelett, cross-reference-mönster) **parallellt med Fas 2a**. Tar 1–2h, ingen content än.
- När Fas 2b skriver E3 Spänningsdelare: skriv samtidigt motsvarande kapitel i kompendiet. **Att förklara samma sak på två ytor (slide + papper) avslöjar pedagogiska luckor på båda sidor.** Detta är den mest värdefulla feedback-loopen.
- Slutfärdigställ kompendiet efter Fas 2.5 projektor-test.

Detta lägger inte till tid — det omfördelar och förbättrar kvaliteten på båda artefakterna.

## "Minsta rimliga leverans" — 80/20-plan (1 dag)

Om användaren bara har 1 dag innan kursen, ge denna order:

**Morgon (3–4h) — typografi och faktafel:**
1. C6 eyebrow sök/ersätt (15 min)
2. C7 WiringSlide caption (5 min)
3. I1 pullup-fix (30 sek)
4. I6 PDF-verifiering RGB-pins (10 min)
5. I8 RGB-referens (1 min)
6. I2 slide 14 högerkolumn (15 min)
7. I15 SOS-kommentar (1 min)
8. C2 beslut + tilt-flytt eller modul-omraming (30 min)
9. **Projektor-test på riktig projektor i FRO-lokalen.** (45 min — inkl. transport/uppsättning)

**Eftermiddag (4h) — de 3 hårda blockers:**
10. **C3 buzzer+knapp komplett kod-slide** (45 min) — utan denna fattas kursens första input→output-program
11. **C4 PWM/analogWrite-slide + komplett sketch** (1.5h) — utan denna är Modul 2 ett vakuum
12. **C1 hybrid-fix:** Bygg ut Modul 5-startmallen med kommenterad state-toggle-skelett (1h) istället för en helt ny slide. Pragmatisk genväg.
13. **C5 minimum:** Lägg till delresultat-slide för Modul 2, 3 och 4 — kopiera Modul 1:s mönster ordagrant (45 min för alla tre)

**Vad du SKIPPAR i 1-dags-planen:**
- E1, E2, E3, E5 elektronik-slides (parkera i kompendiet)
- I4 variabler-slide (hanteras inline i existerande slides)
- I5 if/else-slide (täcks pragmatiskt av C3 kod-slide)
- Modul 2–4 agenda + teaser-slides (lägg till om tid finns)
- Alla cosmetic minor-punkter
- Fas 4 kompendium (egen vecka)

**Resultat:** Alla 7 kritiska blockers är åtminstone delvis lösta, projektor-läsbarheten fixad, faktafel borta. Kursen är **leveransbar**. Den är inte **excellent** — den når inte E3:s spänningsdelar-djup eller C5:s fulla pedagogiska symmetri — men den är **inte trasig**.

Detta är 80% av värdet på ~25% av tiden i den fulla planen.
