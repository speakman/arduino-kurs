# Förslag: Elektronik-fördjupning + gate-fixar

**Författare:** Claude (huvudsession)
**Datum:** 2026-04-13
**Status:** Utkast — söker cross-check från parallella reviewers
**Bakgrund:** Gate-verdicten (`tasks/reviews/gate-verdict-20260413-224138.md`) identifierade 7 kritiska blockers, 15 viktiga förbättringar och 16 mindre punkter i slide-decket innan vi kan skriva kompendiet. Innan jag spikar fixplanen: användaren frågade om kursen behöver mer elektronik-fördjupning eller om programming/elektronik-balansen är rätt. Detta dokument är svaret + en föreslagen exekveringsplan.

---

## Del 1: Analys av nuvarande balans

Klassning av slides per innehållstyp (ungefärlig):

| Kategori | Exempel på slides | Antal |
|---|---|---|
| **Ren elektronik** | Mikrokontrollern, Spänning/ström/GND, Kretsen (vattenanalogi), LED & resistor, Power Rails, Alla färger av bara tre | ~6 |
| **Ren programmering** | Kodens anatomi (setup/loop), Tre kommandon, Hela Blink, Din egen rytm, Input≠Output, Serial Monitor, Pin-tilldelning, Startmall | ~8 |
| **Mixed / praktik** | Bygg kretsen, 6× WiringSlides, Ingenjörsuppgiften | ~8 |
| **Meta / pedagogik** | Cover, översikt, Post-it, agendor, delresultat, Tack, section dividers × 5 | ~11 |

**Observation:** Ren elektronik dominerar Modul 1 men tappar nästan helt från Modul 2 och framåt. Efter Modul 1 är det programmering + wiring-bilder. Detta är inte nödvändigtvis fel — värdet i en Arduino-kurs ligger i programmeringen. Men det finns fyra specifika elektronik-luckor som också råkar vara **pedagogiska hävstänger mot redan flaggade gate-issues**.

## Del 2: Fyra elektronik-slides som också fixar gate-flaggor

### E1. Breadboard-anatomi (Modul 1, precis före "Bygg kretsen")

**Innehåll:** Hur rader inuti är sammankopplade internt. 5 hål = en nod. Gapet i mitten. Kontrast mot power rails (som redan finns som egen slide senare).

**Varför:** Förhindrar den klassiska nybörjar-felsökningen "varför funkar det inte när jag flyttade LED:en två rader?". 5 min teori som sparar timmar klassrumssupport.

**Gate-kopplingar:** Ingen direkt — detta är ren addering.

---

### E2. Flytande pin & pullup (Modul 3, precis före "Input ≠ Output")

**Innehåll:** En "lös" digital pin plockar upp brus → random värden (visa med oscilloskop-liknande diagram eller bara text). Lösning: en pullup-resistor som drar pinnen till en definierad nivå när knappen är öppen. Arduinon har en inbyggd sådan som aktiveras med `INPUT_PULLUP`. Visa kretsens elektronik-grund, inte bara nyckelordet.

**Varför:** Förklarar INPUT_PULLUP från elektroniksidan, inte bara som magiskt nyckelord. FRO-publiken sannolikt har radioamatörer som vill förstå elektroniskt *varför*, inte bara *vad*.

**Gate-kopplingar:**
- **I1** (teknik): "pulldown" vs "pullup"-felet löses naturligt när elektronik-grunden är på plats
- **I5** (pedagogik): Förberedelse för if/else-slide som ska komma efter
- Delvis **C1** (pedagogik/codex): Sätter grund för att förstå state-toggle senare

---

### E3. Spänningsdelare med vattenanalogin (Modul 4, precis före fotocell-wiring)

**Innehåll:** Två resistorer i serie, mätpunkt emellan. Återanvänd Modul 1:s vattenanalogi — två strypventiler i serie, tryckmätare mellan dem. Härled med Ohms lag: ju lägre fotocellens R, desto högre spänning på A0. Förklarar varför 1 kΩ är där och vad 5V → LDR → A0 → 1 kΩ → GND betyder.

**Varför:** Knyter bakåt till Modul 1 — kursen får kumulativ känsla istället för fem frikopplade moduler. Starkaste "aha-momentet" i Modul 4.

**Gate-kopplingar:**
- **V3** (pedagogik): "Spänningsdelare dumpas som en rad speaker notes — förlorat gyllene tillfälle att återknyta till Ohms lag" — löst direkt
- Indirekt stöd för I6 (RGB pin-verifiering) genom mer fakta-grund

---

### E4. PWM / duty cycle (Modul 2, precis före RGB-wiring)

**Innehåll:** En digital pin kan bara vara HIGH eller LOW. Men 490 Hz av/på med variabel duty cycle känns analog för ögat. Visa waveform: 0%, 25%, 50%, 75%, 100% duty. analogWrite(pin, 0–255) mappar till duty cycle. Magic-move från förra veckans digitalWrite till analogWrite.

**Varför:** Både elektronik (signalteori) OCH programmeringslektion. Detta är kärnbegreppet i hela Modul 2 och finns idag bara i speaker notes.

**Gate-kopplingar:**
- **C4** (kritisk blocker): "PWM / analogWrite lärs aldrig ut på skärm" — löst direkt
- Delvis **C5** (asymmetrisk polish): Modul 2 får äntligen en kod-slide

---

### Bonus: E5. Säkerhet & goda vanor (Modul 1, kort slide)

**Innehåll:** Varm resistor = felkopplad, dra ur strömmen. Kortslut aldrig 5V → GND. Dra inte ut komponenter med strömmen på. LED-polaritet kan vändas (inte farligt, bara lyser inte).

**Varför:** Speaker notes har varningarna idag men de lever inte på skärm. Tar 60 sekunder att gå igenom men fixar en säkerhetsmental modell för resten av kursen.

**Gate-kopplingar:** Indirekt — ingen specifik flagga men rekommenderat av teknisk reviewer i "mindre justeringar".

---

## Del 3: Vad som INTE ska läggas till

- **Transistor-teori** — inte i hackathon-scope, kittets enda "switch" är tilt-sensorn
- **Kondensator-fundamentals** — OK att nämna i notes men inte egen slide
- **Oscilloskop, multimeter** — finns inte i kittet
- **Lödning** — finns inte i kittet
- **RF, antenn, impedans** — FRO-kursen är inte en radiokurs, även om publiken är radioamatörer
- **74HC595 skiftregister** — Elegoo Lesson 8 finns, men hackathonen använder den inte. Hoppa.
- **Djupare ADC-teori** (sample rate, aliasing, bit-djup) — utanför nybörjar-scope

## Del 4: Föreslagen exekveringsplan

### Fas 1 — mekaniska fixar (0.5–1 dag, kan göras i nästa session)

Alla flagged-as-trivial cosmetic och faktafel som inte kräver nya pedagogiska beslut.

1. **C6** Global eyebrow sök/ersätt — `text-xs opacity-50` → `text-sm opacity-70 tracking-widest`
2. **C7** WiringSlide caption uppdatering — `text-xs opacity-65` → `text-sm opacity-85`
3. **I1** "pulldown" → "pullup" i INPUT_PULLUP-förklaringen (slides.md:1329)
4. **I2** Slide 14 "Bygg kretsen" — ta bort höger kopplingsbox (duplicerar WiringSlide)
5. **I8** RGB-referens "Lesson 5 eller liknande" → "Lesson 4 sid 44–52" (slides.md:1227)
6. **I6** Verifiera RGB pin-mapping mot Elegoo PDF sid 50–51 — öppna pdf, bekräfta
7. **I15** SOS CW-timing: inline-kommentar i snippet
8. Minor punkter från codex: vattenanalogi D13/5V-not, common cathode-formulering, "knappens motsats" buzzer-text

### Fas 2 — elektronik-fördjupning + pedagogisk utökning (1–2 dagar)

Strukturella tillägg som lyfter Modul 2–4 till Modul 1:s nivå och löser de kritiska blockers.

**Nya slides i Modul 1:**
- E1 Breadboard-anatomi
- E5 Säkerhet & goda vanor (valfri)
- I4 "Variabler — const int och int" mini-slide

**Nya slides i Modul 2:**
- E4 PWM / duty cycle (löser C4)
- Komplett analogWrite-sketch (löser C4 och I7)
- Agenda-slide (löser C5)
- Fri övning "hitta lila/gammelrosa/skolgul" (löser C5)
- Delresultat-slide (löser C5)
- Nästa gång-teaser (löser C5)

**Nya slides i Modul 3:**
- E2 Flytande pin & pullup (löser I1 elegantare + I5 grund + del av C1)
- "Att fatta beslut med if/else" kod-slide (löser I5 + C2 programmering-sidan)
- Komplett knapp+buzzer-kod (löser C3 — codex+teknik flaggade båda)
- "Toggla ett tillstånd" slide (löser del av C1)
- Agenda + övning + delresultat + teaser (löser C5)

**Nya/ändrade slides i Modul 4:**
- E3 Spänningsdelare med vattenanalogi (löser V3)
- Flytta tilt-sensorn till Modul 3 **ELLER** rama om Modul 4-dividern till "Sensorer & felsökning" (löser C2)
- Agenda + övning + delresultat + teaser (löser C5)

**Ändringar i Modul 5:**
- Paus i agendan (löser V7/I12)
- Mer utbyggd startmall med 3–4 tomma rader istället för helt tom loop() (löser del av C1)
- "Minimum viable alarm"-fallback i speaker notes

### Fas 3 — live-verifiering

Kör presentationen på projektor i FRO-lokalen, läs från bakre raden. Den enda verifikationen som räknas. (Design-reviewern var tydlig på detta.)

### Fas 4 — skriv kompendiet

Som **referens** för det sliderna inte kan rymma: syntax-grammatik, felmeddelande-cheatsheet, komponent-katalog, hemläxor, hackathon-lösning i appendix, säkerhet, nästa steg. Med kors-referenser till slide-numrering.

---

## Del 5: Antaganden jag vill ha utmanade

1. **Är 4–5 nya elektronik-slides rätt mängd?** Eller för mycket/lite?
2. **Ska elektronik-slides blandas med gate-fixar (som jag föreslår) eller hållas separata i en egen fas?**
3. **Tilt-sensorn: flytta till Modul 3 eller behålla i Modul 4 med omraming?** Pedagogiskt finns det en fördel med att introducera den bredvid knappen (de är funktionellt identiska), men det stör också Modul 4:s "sensor-katalog"-känsla.
4. **E4 PWM på slide — är det kanske en för abstrakt koncept för en ren nybörjare i Modul 2?** Eller är det precis rätt (eftersom det direkt följs av praktisk analogWrite)?
5. **Modul 2 växer från 4 → 9–10 slides.** Är det pedagogiskt rimligt för 2 timmar, eller kväver det hands-on-tiden?
6. **Fas-tid:** 0.5–1 dag för Fas 1 + 1–2 dagar för Fas 2. Är det realistiskt eller underskattat?
7. **Nytt slide-innehåll skrivs av mig.** Pedagogik-reviewern satte Modul 1 som guldstandard — kan jag (LLM) skriva E2 och E3 till samma kvalitet, eller bör användaren skriva dem själv?
8. **Kompendie-försening:** Användaren ville ursprungligen skriva kompendiet snart. Fas 1+2 försenar det med ~2 dagar. Är det motiverat?

## Beslut som ska fattas efter review

- [ ] Ska vi köra E1–E5 alla fem, eller selektiv underset?
- [ ] Ska Fas 1 + Fas 2 bundlas i en session eller separeras?
- [ ] Hur hanterar vi tilt-sensorn (flytta vs rama om)?
- [ ] Ska Modul 2 verkligen växa så mycket, eller krymper vi omfånget annorlunda?
