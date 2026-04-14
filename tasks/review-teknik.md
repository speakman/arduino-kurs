# Teknisk granskning — 2026-04-14

Granskad: `kompendium/01..05-modul-N.typ`, `appendix-a..f`, `presentation/slides.md`.
Korsreferens mot `research/elegoo-kit.md` och ATmega328P/Arduino Uno R3-specs.

## Critical errors (wrong facts)

Inga faktafel som kan ge fel beteende eller skadad komponent hittades. Pin-mappning (R=D6, G=D5, B=D3, knapp=D9, buzzer=D12, tilt=D2, LDR=A0) är konsekvent över slides + alla 5 moduler + Bilaga C + Bilaga D. Inga USB-C-referenser någonstans. ELEGOO-lektionsnummer (4 RGB, 5 knapp, 6 active buzzer, 7 tilt, 10 fotocell) stämmer med PDF-TOC.

## Misleading or imprecise

- `kompendium/02-modul-2.typ:71` — "växlar … runt 490 gånger i sekunden (på de flesta PWM-pinnarna)". Korrekt undantag, men bra att vara ännu mer specifik: D5 och D6 går på ~980 Hz (Timer0), inte 490 Hz. Förslag: ersätt "(på de flesta PWM-pinnarna)" med "(D3, D9, D10, D11 ≈ 490 Hz; D5, D6 ≈ 980 Hz)". Bildtexten på rad 62 säger dessutom "500 gånger per sekund" eftersom ELEGOO-bilden använder 500 Hz som illustration — värt att lägga till "ELEGOO-bilden ritar med 500 Hz för enkelhet; verkligt värde är 490/980 Hz" så att 500 ≠ 490 inte förvirrar.
- `kompendium/appendix-c-komponenter.typ:188` — "5V-pin … Max ca 400 mA totalt." Den vanligaste siffran är ~500 mA (USB-polyfuse) minus ~50 mA till själva kortet ≈ 450 mA. 400 mA är konservativt och ofarligt, men byt till "≈ 450 mA, begränsas av USB-polyfusen 500 mA" om du vill vara teknisk korrekt.
- `kompendium/appendix-e-sakerhet.typ:31` — "Arduinons digitala pinnar kan maximalt leverera *20 mA per pinne*". 20 mA är *rekommenderat* (DC), absolut max är 40 mA per pinne enligt ATmega328P-datasheetet. Lägg ev. till "(absolut max 40 mA, rekommenderat tak 20 mA)". Bilaga C har samma siffra utan kommentar.
- `kompendium/04-modul-4.typ:43` använder $5"V" / 1024 ≈ 4,88$ mV; `appendix-f` använder "1023 steg" och "5/1023*1023" alternativt. Båda förekommer i materialet — 1024 nivåer / 1023 max-tal är två olika sanna saker, men det är värt en mening i Bilaga F som klargör skillnaden så att inte 1023 vs 1024 ser ut som en bugg.
- `kompendium/02-modul-2.typ:25` — "rött/katod/grönt/blå (inte intuitivt — katoden är *andra* benet, inte i mitten)". Stämmer (Elegoo p. 46), men bildtexten på rad 41 listar etiketterna i omvänd ordning ("BLUE, GREEN, CATHODE, RED") eftersom Elegoo-bilden är fotad från andra sidan. Lägg till en explicit not "(bilden är fotad från benens baksida — vänd LED:en så platta sidan är mot dig så stämmer ordningen R-K-G-B från vänster)".
- `kompendium/01-modul-1.typ:84` — "`digitalWrite(pin, HIGH)` sätter pinnen till ~5 V". Strikt sett är det Vcc minus Vol/Voh-droppen (~4.7–4.9 V vid kursens belastningar). "~5 V" är pedagogiskt OK men flagga för senare modul när precision spelar roll.
- `kompendium/04-modul-4.typ:104` — "Tilten studsar fysiskt — kulan bouncar inuti sin hylsa i en *tiondels sekund*". Tilt-bouncetider är typiskt 5–30 ms; "en tiondels sekund" är högt räknat. `delay(50)` som föreslås är fortfarande rimligt.

## Code issues (syntax, compile, runtime)

Genomgång av varje kodblock i kompendiet — alla kompilerar och beter sig som beskrivet:

- `01-modul-1.typ` (Blink-skelett, hjärtslag-tip, morse-funktioner) — inga problem.
- `02-modul-2.typ:113-128` RGB-skelett — kompilerar; tomma platshållarkommentaren `// ... fortsätt med grön och blå` är tydligt markerad som ofullständig.
- `02-modul-2.typ:147-152` `for`-loop — `delay(20)` ger `255 × 20 = 5100 ms ≈ 5,1 s`. Texten säger "≈ 5 s" ✓.
- `03-modul-3.typ:111-124` edge-detection — korrekt, `lastState` initialiseras till `HIGH` (matchar INPUT_PULLUP). ✓
- `03-modul-3.typ:153-168` knapp/buzzer-skelett — korrekt; använder enkelt `if/else` utan edge-detection vilket texten också säger.
- `04-modul-4.typ:118-128` Serial-skelett — `Serial.begin(9600)`, `Serial.println` ✓.
- `04-modul-4.typ:174` `analogWrite(ledR, map(ljus, 0, 1023, 255, 0));` — `map()` på Arduino är heltalsdivision, fungerar fint för detta intervall ✓. Men `ledR` = D6 är PWM ✓.
- `05-modul-5.typ:114-150` huvud-loop — kompilerar, alla pinnar konsekvent med deklarationerna i Bilaga D.
- `appendix-d-hackathon-losning.typ:31-105` full sketch — kompilerar, semantik korrekt. `lastKnappState` global, `larmPaslaget` global, `INPUT_PULLUP` på både knapp och tilt, edge-detection korrekt mönstrad. ✓
- `appendix-d` Variation 2 (hysteres) — `static bool` deklareras inuti `loop` vilket är giltig C++; texten förklarar att static behåller värdet mellan anrop ✓.
- `appendix-d` Variation 3 (fade-in) — `stamningsStyrka` ökar till 120, RGB-värden delas (`/2`, `/6`) — alla heltalsoperationer, inget överflöd.
- `appendix-a-syntax.typ:39` "`int` ... På Uno: −32768 till 32767" — korrekt för 16-bit AVR-int ✓ (skiljer sig från 32-bit på t.ex. ESP32, men kursen är Uno).
- `appendix-b-felmeddelanden.typ:53-57` förklaringen av `digitalWrit` vs `digitalwrite` — separerar de två misstagen rent (`e`-fel vs case-fel) precis som instruktören krävde ✓.
- `appendix-b:131` USB-Type B-formuleringen ✓.
- `appendix-f` Vf-räkningarna: $(5−2)/0,015 = 200 Ω → 220$ ✓; $(5−2)/220 = 13,6$ mA ✓; blå $(5−3,2)/0,015 = 120$ Ω ✓; spänningsdelare 50k+1k mörker → 0,098 V → ~20 ✓; 500+1k ljus → 3,33 V → ~682 ✓.

## Tekniskt korrekt / well-put

- Hela Bilaga F (Ohms lag, LED-IV-kurva, varför 220 Ω, spänningsdelare-härledning, hysteres-koncept). Räkne­exemplen är genomgående korrekta och pedagogiskt motiverade.
- Modul 3 förklaringen av `INPUT_PULLUP` → "färdig spänningsdelare" som brygga till Modul 4 är en bra mental modell utan att vara fel.
- ATmega328P-specifikationer (16 MHz, 32 KB flash, 2 KB SRAM, 1 KB EEPROM) i Bilaga C ✓.
- Active vs passive buzzer-distinktionen och varför `tone()` *inte* behövs för aktiv buzzer ✓.
- Tilt-sensorn beskriven som *digital* med `INPUT_PULLUP` och `digitalRead`, korrekt som "elektriskt identisk med en knapp" ✓.
- Common-cathode RGB med katoden som andra benet från platta sidan = längsta benet, R-K-G-B-ordning från platta sidan, korsverifierad mot ELEGOO p. 45–46 ✓.
- Fotocell ~50 kΩ mörker / ~500 Ω ljus ✓ (matchar Elegoo 5516-LDR).
- Färgkoder (220 Ω = röd-röd-brun, 1 kΩ = brun-svart-röd, 10 kΩ = brun-svart-orange) ✓.

## Summary

Inga kritiska fel. Sju "imprecise"-noteringar (PWM-frekvens 490 vs 980 Hz på D5/D6, 5V-pin 400 vs ~450 mA, per-pin 20 vs 40 mA absolute, 1023 vs 1024 ADC-nyans, RGB-bildtext-orientering, "~5 V" på HIGH, tilt-bouncetid). All kod kompilerar, all matematik stämmer, alla pin-mappningar är konsekventa över slides och kompendium, ELEGOO-lektionsnumren matchar PDF-TOC, USB-B inte USB-C överallt, instruktörens `digitalWrit`-flagga är korrekt hanterad i både Modul 1 och Bilaga B.
