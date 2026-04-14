# Handover — slide-densitet 2026-04-14 (eftermiddag)

Föregående session städade kompendiet + slides (ligatures, emoji, ELEGOO-refs, syntax highlighting, "Inför nästa träff"-texter, Modul 1 sid 7 overflow, kontinuitets-bug i Modul 5). Allt verifierat och bygt till `kompendium/deliveries/`.

**Detta dokument** beskriver återstående arbete: 10 slides flaggade av sonnet-audit som "mikrotext / för dense innehåll". Inte rendering-fel — det är att källtexten har för mycket innehåll på en yta, så Slidev skalar ner allt.

## De 10 problematiska slides

Listan kommer från en sonnet-audit av `kompendium/deliveries/slides-arduino-kurs.pdf` (export 14 april 10:55, 16:9 = 2000×1125 px verifierat). Alla rapporterades som svårlästa på projektoravstånd.

| Slide | Sektion | Problem (sonnet-audit-citat) |
|---|---|---|
| 8  | Modul 1 — "Spänning, ström, GND" | "extremt liten text. Volt/Ampere/GND-sektionerna och Ohms-lag-blocket är svårlästa i projektorformat" |
| 11 | Modul 1 — "Fem hål = en nod" (breadboard) | "all text och breadboard-bild kraftigt nedskalad. Text otillgänglig på projektoravstånd" |
| 16 | Modul 1 — "Din egen rytm" | "kod och brödtext i extremt liten teckenstorlek" |
| 22 | Modul 2 — analogWrite | "brödtext och kodblock som är för litet. Grafen i nedre höger är pytteliten" |
| 31 | Modul 3 — "En varning först" (buzzer-intro) | "väldigt liten text och bild" |
| 33 | Modul 3 — "Läs knapp. Styr buzzer." | "all text och kodblock nedskalat, svårläst" |
| 36 | Modul 4 — "Knappen var digital. Världen är analog." | "text och kod extremt liten" |
| 41 | Modul 4 — "Hitta din tröskel." | "brödtext och kodblock svårläsliga i liten storlek" |
| 45 | Modul 5 — Pin-tilldelning / hackathon-starter | "dubbla kodblock i liten text, svårläst" |
| 46 | Tack-slide | "liten text + pixlad/lågupplöst bild (verkar vara en inbäddad JPG med låg upplösning som bakgrund)" |

**Källfil:** `presentation/slides.md`. Slide-numrering matchar Slidev-export-PDF (1-indexerad, 46 slides totalt). För att hitta motsvarande markdown: räkna `---`-separerade frontmatter-block.

## User's föreslagna arbetsflöde

1. **Analys-fas (parallell):** Dispatcha en sonnet-subagent per problemslide. Varje agent får:
   - Slide-bildens path (`/tmp/slides-png/slide-XX.png` — om de finns kvar; annars rendera om från deliveries-PDF)
   - Slidens markdown-källa (extrahera från `presentation/slides.md`)
   - Eventuell motsvarande kompendium-text (se sync-mappning nedan)
   - Uppdrag: föreslå konkret restrukturering — splitta över flera slides, flytta text till speaker notes, ta bort ord, eller flytta till kompendiet
   - **Kritisk regel** (per memory `feedback_code_slides_vs_compendium`): Komplett kod hör hemma i kompendiet. Slides ska visa essens. Föreslå INTE att klämma in mer på sliden.
2. **Konsolidering:** Samla alla 10 förslag, presentera för user för godkännande.
3. **Implementation (sekventiell, en i taget):** För varje godkänt förslag, gör Edit-anrop. Sekventiell pga slide-numrering ändras vid splits — efter en split måste resten av listan re-mappas.
4. **Verifiering:** Rebuild + ny sonnet-audit per ändrad slide.

## Slide → kompendium-mappning (för agenterna)

- Slide 8 (Spänning/Ström/GND) ↔ Modul 1, "Vad du lärde dig idag" + Bilaga F (Ohms lag)
- Slide 11 (breadboard) ↔ `01-modul-1.typ` `=== Breadboarden`
- Slide 16 (Din egen rytm) ↔ `01-modul-1.typ` `== Bygg från minnet`
- Slide 22 (analogWrite) ↔ `02-modul-2.typ` `=== PWM och duty cycle`
- Slide 31 (buzzer-intro) ↔ `03-modul-3.typ` `=== Active buzzer — inte passive`
- Slide 33 (Läs knapp. Styr buzzer.) ↔ `03-modul-3.typ` `== Bygg från minnet`
- Slide 36 (digital → analog) ↔ `04-modul-4.typ` `=== Analog vs digital`
- Slide 41 (Hitta din tröskel) ↔ `04-modul-4.typ` `=== Typiska A0-värden`
- Slide 45 (Pin-tilldelning hackathon) ↔ `05-modul-5.typ` `=== Pin-tilldelning` + Bilaga D
- Slide 46 (tack-slide) — ingen direkt motsvarighet (kursens avslutning)

## Hur man hittar en specifik slide i `slides.md`

Slidev separerar slides med `---` på egen rad. För att hitta slide N:
```
awk '/^---$/{n++; next} n==N-1' slides.md
```
(eller `grep -n "^---$" slides.md` ger radnummer för alla separators)

Slide 1 är allt FÖRE första `---` (frontmatter ligger mellan första och andra `---`, så slide 1 = block 2). Räkna noggrant.

## Verifiering efter implementation

```bash
cd presentation && npx slidev export --output ../kompendium/deliveries/slides-arduino-kurs.pdf
mkdir -p /tmp/slides-png && pdftoppm -r 100 /tmp/slides-export.pdf /tmp/slides-png/slide -png
```

Sedan dispatcha sonnet-agent (per minne `feedback_use_sonnet_for_image_review`) för att verifiera att de 10 problemen är borta utan nya regressioner.

## Vad som är klart (referens)

Allt i `tasks/plan-20260414-fixes.md` är applicerat och rebuiltat. Levereras finns i `kompendium/deliveries/`. Continuity audit hittade och fixade två Modul 5-bugs (300/400 mismatch + saknad `morkTroskel`-konstant).

**Inga andra kända problem.** Bara slide-densiteten kvar.
