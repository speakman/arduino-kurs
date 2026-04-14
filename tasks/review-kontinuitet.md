# Kontinuitet slides ↔ kompendium — 2026-04-14

Sources reviewed:
- `presentation/slides.md` (~46 slides, 2754 rader)
- `kompendium/01-modul-1.typ` … `05-modul-5.typ`
- `kompendium/appendix-a-syntax.typ` … `appendix-f-framspanningsfall.typ`

## 🚨 Hard contradictions

### 1. Photocell typvärden — tredje raden glider
- **Slide 37** (`slides.md:2206-2210`, "Spänningsdelaren · Typiska värden · 1 kΩ"):
  - Hand över → `20–100`
  - Rumsljus → `150–400`
  - **Lampa nära → `600–900`**
- **Modul 4 kompendium** (`04-modul-4.typ:83-88`, "Typiska A0-värden med 1 kΩ"):
  - Hand över → `20–100` ✅
  - Rumsljus → `150–400` ✅
  - **Lampa nära, ljust arbetsbord → `500–700`** ❌
  - Ficklampa direkt → `700–900`
- **Slide-talarnoter dessutom** (`slides.md:2702`): *"mörker = A0 LÅG (~100-300). Dagsljus = A0 HÖG (~700-1000)"* — ett tredje, OINKONSISTENT spann i samma fil.
- Fix: välj ETT spann för "lampa nära" och uppdatera båda. Föreslår kompendiets fyrradiga indelning även på sliden, eller stryk talarnotens 100–300/700–1000 helt.

### 2. Modul 4 kompendium refererar vattenanalogi som inte finns i Modul 1 kompendium
- `04-modul-4.typ:50`: *"Kom ihåg vattenanalogin från Modul 1: 5 V är kranen, GND är utloppet, en resistor är en strypventil."*
- `01-modul-1.typ` har INGEN vattenanalogi — bara "krets är en ring" och "tryckskillnad" i förbigående (`01-modul-1.typ:17-18`).
- Vattenanalogin finns däremot på **slide 12** (`slides.md:481-531`, "Kretsen — som ett vattensystem", `pin 13 → kran/strypventil/utlopp`).
- Fix: lägg in ett kort vatten-stycke i `01-modul-1.typ`-sektionen "Kretsen", annars är Modul 4:s repetition tom luft för en deltagare som bara läser kompendiet utan att titta på slidesen.

## ⚠️ Missing or broken cross-refs

### 3. "Full debounce-diskussion i Appendix A / kapitel 3"
- `slides.md:1790`: *"Full debounce-diskussion i kompendiet Appendix A / kapitel 3."*
- `appendix-a-syntax.typ`: ingen träff på `debounce`/`studs` (verifierat med Grep).
- `03-modul-3.typ`: nämner `delay(10)` och en rad "I produktion används fler tekniker — se Bilaga A" (`03-modul-3.typ:128`) — som också pekar ut i tomma intet.
- Fix: antingen lägg till en debounce-sektion i Bilaga A, eller ta bort båda referenserna.

### 4. "Bonusutmaning · färgövergång" finns inte under det namnet
- `slides.md:1425, 1471-1472`: *"Lösning finns i kompendiets kapitel 2 som **Bonusutmaning · färgövergång**"* och *"sliden Bonusutmaning · färgövergång i kompendiets kapitel 2"*.
- `02-modul-2.typ:141-154`: övningen heter **"Övning 3 — Långsam övergång"** med `for`-loop. Innehållsmässigt rätt sak men namnet matchar inte alls.
- Fix: byt slide-text till "Övning 3 — Långsam övergång" eller döp om kompendiet.

### 5. "Full sketch i kompendiet, kapitel 2"
- `slides.md:1322`: *"Full sketch i kompendiet, kapitel 2."* (RGB-kod)
- `02-modul-2.typ:111-129`: levererar bara ett **"Skelett"** med `// ... fortsätt med grön och blå`. Ingen körbar full sketch finns i Modul 2.
- Fix: antingen utöka skelettet till full sketch eller ändra sliden till "skelett i kompendiet".

### 6. "Komplett körbar kod i kompendiets kapitel 3"
- `slides.md:1939`: *"Komplett körbar kod i kompendiets kapitel 3, inklusive kommentarer och vanliga fel."* (knapp+buzzer)
- `03-modul-3.typ:151-169`: levererar Bygg-från-minnet-skelettet — körbart men *utan* kommentarer eller "vanliga fel" inbakat. Vanliga fel finns i en separat `quickref` (`03-modul-3.typ:197-204`).
- Soft, men slide-promisen "inklusive kommentarer och vanliga fel" är överdriven. Lägg minst två rad-kommentarer i kompendium-skelettet eller skriv om sliden.

### 7. Slidnummer i kompendiets "I slidesen"-tipsboxar
- `01-modul-1.typ:148`: "Slide 2–4 (kursöversikten), slide 8 (Ohms lag-triangel)…"
- `02-modul-2.typ:178`: "Slide 19–24"
- `03-modul-3.typ:219`: "Slide 25–34"
- `04-modul-4.typ:210`: "Slide 35–44"
- `05-modul-5.typ:189`: "Slide 44–46"
- Slide-decken har ~46 slides (92 `---` separators). Modul 4 och Modul 5 överlappar på slide 44 — kan vara en glidning. Numreringen är gissad och inte verifierad mot färdig deck. Bör kontrollräknas eller bytas mot rubriker (vilket Modul 1 redan gör delvis).

## 💡 Soft drift

- **Spänningsdelar-analogin**: slide 37 säger "två strypventiler i rad" / "vattenrör som höjdskala" / "tryckmätare". Modul 4 (`04-modul-4.typ:50-55`) säger "två strypventiler i serie" / "tryckfall" / "voltmeter i mellanpunkten". Samma metafor, snäppet olika ordval. Inga motsägelser. Höjdskala-bilden saknas dock helt i kompendiet — om det är en ny pedagogisk pjäs vore det värt att få in.
- **Photocell-tröskel**: slide-talarnotens "Sätt tröskeln på t.ex. 400" (`slides.md:2703`) ↔ Bilaga D använder `morkTroskel = 300` (`appendix-d-hackathon-losning.typ:43`) ↔ Modul 5-exemplet använder `ljus < 400` (`05-modul-5.typ:134`). Tre olika gissningar, inga motsägelser eftersom varje text säger "kalibrera själv", men en gemensam default skulle minska förvirring.
- **Pin-tilldelning labels**: slide startmall (`slides.md:2622-2632`) använder `// Lesson 5/7/10/6/4` exakt som Bilaga D (`appendix-d-hackathon-losning.typ:33-39`) och Modul 5 quickref (`05-modul-5.typ:48-54`). Identiskt — bra.
- **Edge-detection-koden**: slide (`slides.md:1747-1759`) och Modul 3 (`03-modul-3.typ:111-123`) använder samma variabelnamn (`larmPaslaget`, `lastState`, `state`, `knappPin`), samma `delay(10)`, samma struktur. Bra.

## ✅ Well-aligned sections

- **Pin-mappning**: R=D6, G=D5, B=D3, knapp=D9, buzzer=D12, tilt=D2, LDR=A0 är identiskt i `slides.md:1265-1284, 2622-2632, 2682-2686`, `02-modul-2.typ:46-50, 174`, `03-modul-3.typ:71, 132, 153-154, 214`, `04-modul-4.typ:102, 149, 204-205`, `05-modul-5.typ:47-54, 181`, `appendix-d-hackathon-losning.typ:33-39`. Inga avvikelser.
- **Resistor-värden**: 220 Ω (LED-serie) och 1 kΩ (fotocell-delare) konsekventa överallt.
- **Hackathon-startmallen**: slide 45-mallen (`slides.md:2622-2662`) och Bilaga D:s pin-block (`appendix-d-hackathon-losning.typ:33-47`) använder samma variabelnamn i samma ordning. Plug-and-play för deltagaren.
- **Knapp+buzzer if/else**: slide (`slides.md:1946-1953`) och Modul 3 Bygg-från-minnet (`03-modul-3.typ:160-168`) är logiskt identiska.
- **Appendix F-referens** (framspänningsfall, slide `slides.md:445`) → existerar (`appendix-f-framspanningsfall.typ`) och innehåller exakt det som utlovas (LED I-V-kurva, härledning av 220 Ω, vidareförklaring av spänningsdelaren).
- **Appendix A-referenser** (datatyper/scope/operatorer, `for`-loop, kedjade if/else, `slides.md:1537, 1663` och `02-modul-2.typ:153`) → alla resolver (`appendix-a-syntax.typ` har sektioner för datatyper, `for`, `else if`).
- **`Vad du lärde dig idag`-listor** matchar slide-innehållet modul för modul (Modul 1: ring/Ohms lag/polaritet/220 Ω/`digitalWrite`; Modul 2: 0-255/PWM/`~`-pinnar/RGB; Modul 3: `digitalRead`/`INPUT_PULLUP`/edge-detection/active buzzer; Modul 4: 0-1023/Serial/spänningsdelare/fotocell/tilt; Modul 5: integration). Inga koncept introduceras i kompendiet före slidesen.
