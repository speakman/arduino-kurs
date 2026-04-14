# Öppna frågor för användaren

Frågor som dyker upp under bygget. Användaren svarar när de kommer tillbaka.

---

## ⚡ MÅSTE-SVARAS (påverkar titelbild + översikt)

### 1. Kurstitel + undertitel på titelbilden?
Just nu står det:
> **Elektronik & Programmering med Arduino**
> *5 veckor. 5 superkrafter. Ett tjuvlarm.*

Byt ut om du har en annan officiell titel.

### 2. Instruktör-info?
Placeholder på titelbilden säger `[Instruktör] · [Startdatum] · [Plats]`.
- Ditt namn / "Av Daniel X"?
- Organisation?
- Startdatum för första träffen?
- Var hålls kursen?

Eller ska jag utelämna en eller flera av dessa?

### 3. Målgrupp — vilka är deltagarna?
- Vuxna nybörjare?
- Ungdomar / gymnasium?
- Företagsutbildning?
- Mixed ålder?

Talarnotiserna är just nu kalibrerade för **vuxna nybörjare** (samma ton
som din ursprungliga outline). Bekräfta eller rätta.

### 4. Längd per träff?
- 1.5h, 2h, 3h?

Påverkar hur detaljerade tempo-cues jag lägger i notiserna. Just nu
antar jag **~2h per träff**.

---

## 💡 TREVLIGT-ATT-SVARA (defaults redan valda)

### 5. QR-kod eller länk till extra material?
T.ex. GitHub-repo med kod, kursplan-PDF, eller bara lärarens kontaktinfo.

**Default:** ingen QR-kod. Säg till om du vill ha en — jag kan generera
den från en URL och lägga på avslutnings-sliden.

### 6. Logga eller branding?
- Personlig logga?
- Organisationslogga?

**Default:** ingen logga, ren typografi.

### 7. Kittets namn — engelska eller svenska?
Just nu skrivs **"ELEGOO UNO Basic Starter Kit"** (engelska) eftersom
det är vad deltagarna köper. Säg till om du vill översätta.

---

## ✅ BESLUT JAG TOG LÄNGS VÄGEN (kan överstyras)

- **Visuell metafor:** "5 superkrafter låses upp" — genomgående linje
- **Färger:** Deep charcoal + elektrisk cyan + signal-gul + larm-röd
- **Typsnitt:** Inter (sans) + JetBrains Mono (kod), via Google Fonts
- **Syntax-tema:** Slidev default (Shiki, one-dark-pro-stil) — ser bra ut på projektor
- **21 slides** totalt: titel + översikt + inledning + 5 dividers + 12 innehåll + avslut

---

## 🔍 UPPTÄCKTER FRÅN RESEARCH — redan inbyggda i slides

Research-agenten hittade flera saker som avvek från din outline.
Jag har **redan applicerat dessa korrigeringar** i `slides.md`:

### Sidnummer-korrigeringar mot Elegoo-manualen
| Outline sa | Verifierat som |
|---|---|
| Blink/LED sid 42 | ✅ Sid 42 (korrekt) |
| RGB pinout sid 45 | ✅ Sid 45 (korrekt) |
| **RGB analogWrite sid 50** | ❌ Sid 48 (PWM-teori) + sid 51 (kod) |
| Serial Monitor sid 74 | ✅ Sid 74 (korrekt) |
| **Buzzer sid 60** | ❌ Sid 58 (sticker-fotot) + 60 (kopplingsdiagram) |
| **LDR sid 82** | ❌ Sid 80 (spänningsdelaren) |

### RGB-LED:ens benkonfiguration (viktig skillnad från outlinen)
Outlinen skrev *"det längsta benet i mitten är GND"*. Det är fel — det finns
ingen geometrisk mitt eftersom LED:en har **4 ben**, inte 3. Den korrekta
beskrivningen är:
> Pin-ordning från platta sidan: **Röd · Katod · Grön · Blå**.
> Katoden är det **längsta** benet OCH **andra benet från platta sidan**.

Korrigerat i slide 5 (Illusionen) och notiserna för RGB-sliden.

### Active buzzer — använd digitalWrite, inte tone()
ELEGOO Basic Kit har en **active** buzzer (inbyggd oscillator). Det räcker
med `digitalWrite(buzzerPin, HIGH);` för att få den att pipa. `tone()`
fungerar men är onödigt komplicerat. Uppdaterat i notiserna för slide 8
och slide 12 (kods-skelettet).

### Tilt-sensor-debounce
Outlinen rekommenderade `delay(100);`. Research säger **50ms** är mer än nog.
Uppdaterat i notiserna för Hackathon-sliden.

### Fotocellens koppling
Elegoo-manualens Lesson 10 (sid 80) kopplar så här:
- `5V → fotocell → pin A0 → 1kΩ → GND`
- Mörker = A0 LÅG (fotocellens motstånd är högt, drar ner spänningen)
- Ljus = A0 HÖG

Inbyggt i notiserna på slide 9.

### Ingen driver-installation behövs
Elegoo UNO R3 använder **äkta ATmega16U2** för USB (inte CH340). Ingen
driver-krångel på Mac/Windows/Linux. Kortet dyker upp som "Arduino/Genuino UNO".
Sparat en hel slide med troubleshooting. Noterat i Hjärnan-slidens notes.

### Jumper-kablar — två olika typer
Kittet har **65× stiff M-M** (för breadboard) och **5× flexible F-M DuPont**
(för sensorer som pluggas direkt i Arduino-headers, t.ex. buzzer och tilt).
Noterat i notiserna för slide 8 (Larmet) och slide 9 (Röntgen-glasögon).

---

## 📸 BILDER — status

### Nedladdade och inlagda
- ✅ `arduino-uno-hero.jpg` (Wikimedia Commons, CC0) — Hjärnan-sliden (slide 6)
- ✅ `breadboard-rails.png` (Wikimedia Commons, CC0) — Power Rails-sliden (slide 11)
- ✅ `photoresistors-three.jpg` (Wikimedia Commons, CC0) — Analoga sinnen-sliden (slide 16)
- ✅ `photoresistor-macro.jpg` (Wikimedia Commons, CC BY-SA) — reserv

### Kvarvarande bilder som kan förbättras
Dessa använder just nu **Iconify-ikoner som placeholders** och ser bra ut,
men skulle ännu bättre ut med riktiga foton:

- 📷 **Active buzzer med klisterlappen** (slide 14) — finns i Elegoo-manualens
  sid 58 (PDF är sparad i `research/elegoo-basic-kit-tutorial-v1.0.19.7.24.pdf`).
  **Alternativ 1:** extrahera sid 58 som bild. **Alternativ 2:** fota din egen
  buzzer med mobiltelefon på mörk bakgrund — 30 sekunders jobb, perfekt match.

- 📷 **Tilt-sensor** (slide 16) — ingen fri Wikimedia-bild finns. Samma
  rekommendation: fota din egen på mörk bakgrund.

- 📷 **RGB-LED närbild med ben-etiketter** (kan läggas till slide 10 om önskas)
  — finns i Elegoo-manualen sid 45.

- 📷 **Färdigt tjuvlarm** (slide 5, "Slutmålet") — Iconify-ikon används just
  nu. En riktig bild av den färdiga enheten (när du byggt den själv) skulle
  vara betydligt mer imponerande.

- 📷 **Cover-slide** — just nu ingen bakgrundsbild, bara gradient. En
  atmosfärisk bild på Arduino på mörk bakgrund (t.ex. Harrison Broadbent
  på Unsplash) skulle höja presentationen. Rekommenderat men inte kritiskt.

### Hur du byter ut en bild
1. Lägg bilden i `presentation/public/images/<filnamn>.jpg`
2. I `slides.md`, ersätt Iconify-diven med:
   ```html
   <img src="/images/<filnamn>.jpg" class="max-h-80 rounded-lg" />
   ```
3. Kör `npm run build` → dist/ byggs om automatiskt.

---

## 📄 RESURSER TILLGÄNGLIGA I PROJEKTET

- `research/elegoo-basic-kit-tutorial-v1.0.19.7.24.pdf` — officiella Elegoo-manualen (83 sidor)
- `research/elegoo-kit.md` — fullständig research-rapport med alla fynd
- `tasks/design.md` — design-dokument
- `tasks/todo.md` — arbetsplan
