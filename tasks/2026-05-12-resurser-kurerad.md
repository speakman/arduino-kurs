# Kurerade resurser — "Nästa steg" för Arduino-kursdeltagare

**Datum:** 2026-05-12
**Mål:** Råmaterial för GitHub Pages "Resurser & nästa steg"-sektion. Verifierat aktivt och aktuellt per maj 2026.
**Målgrupp:** Vuxna nybörjare från FRO Ånge som precis lärt sig LED/PWM/digitalRead/analogRead på ELEGOO UNO Basic Starter Kit.

Verifieringsmetod: Varje länk WebFetch-testad eller WebSearch-bekräftad som aktiv 2026. Outdaterade tutorials (pre-2020, IDE 1.x-eran) har skalats bort. URL:er som returnerade 404, redirect-loop eller bot-block har antingen ersatts med fungerande motsvarighet eller markerats explicit.

---

## 1. Officiella Arduino-resurser

- **Arduino Documentation Hub** — https://docs.arduino.cc/
  Centrala dokumentationsportalen från Arduino själva. Hårdvara, mjukvara, programmering, learn-material samlat.
  *Varför:* Den enda officiella ingången som täcker både UNO R3, UNO R4, Cloud och IDE 2.x. Footer 2026-stämplad och aktivt uppdaterad.

- **Arduino Language Reference** — https://docs.arduino.cc/language-reference/
  Komplett referens över alla språk-funktioner (digitalWrite, analogRead, millis, Serial …) med exempel per funktion.
  *Varför:* Det enda dokumentet en nybörjare verkligen ska bookmarka. `arduino.cc/reference/en/` redirectar hit (verifierat 2026-05-12).

- **Arduino IDE 2.x dokumentation** — https://docs.arduino.cc/software/ide/
  Officiell guide till IDE 2.x (aktuell version 2.3.8, februari 2026): installation, autocomplete, Serial Monitor, Serial Plotter, debugger, library manager.
  *Varför:* Många "Arduino-tutorials" på nätet är fortfarande för IDE 1.x med gamla menyer — denna är aktuell.

- **Arduino IDE-nedladdning** — https://www.arduino.cc/en/software
  Officiell download-sida för Arduino IDE 2.3.8.
  *Varför:* Enda källan att rekommendera. Tredjepartsspeglar är riskabla.

- **Arduino Project Hub** — https://projecthub.arduino.cc/
  6 100+ communityprojekt sökbara med svårighetsgrad och komponenter.
  *Varför:* Officiellt sedan 2023 (tidigare Hackster white-label). Bra projekt-inspiration men kvalitet varierar — välj projekt med många vyer/kommentarer.

- **Arduino Cloud** — https://cloud.arduino.cc/
  IoT-plattform med dashboards, webbaserad editor och device-management. Gratis Maker-plan finns.
  *Varför:* Naturlig brygga när eleven vill koppla något till nätet. Hellre nämn än rekommendera — kräver UNO R4 / ESP32 för full nytta.

- **Arduino Forum** — https://forum.arduino.cc/
  Officiellt Discourse-forum, kategoriserat efter hårdvara, projekt, mjukvara.
  *Varför:* Modererat, historiskt djupt arkiv. För konkreta felsöknings-frågor ofta snabbare svar än Reddit.

- **Arduino Education** — https://www.arduino.cc/education/
  Pedagogiska kits och kurser. Inte primärt för självstudier men relevant för lärare/skolor.

---

## 2. YouTube-kanaler för nybörjare

### Engelska — kvalitet och frekvens verifierad

- **Paul McWhorter / Top Tech Boy** — https://www.youtube.com/@PaulMcWhorter (kanal) / https://toptechboy.com/arduino-lessons/ (lektionsindex)
  Pensionerad ingenjörslärare. 100+ Arduino-lektioner, plus uppföljande Python+Arduino-, Raspberry Pi- och AI-on-the-edge-serier. Långsamt och pedagogiskt tempo, talar tydligt.
  *Varför:* Den enda kanal som faktiskt undervisar — inte snabbprojekt-genomgång. Den nya tutorial-serien (2020-uppdaterad) är aktuell. Bästa förstaval för en vuxen som vill lära sig från grunden.

- **Programming Electronics Academy** — https://www.youtube.com/channel/UCDGAg1pqcy8IScMqHHTy9Gg (kanal) / https://www.programmingelectronics.com/ (sajt)
  Michael James. Fokus på "varför funkar koden så här". Gratis Arduino Crash Course finns på sajten.
  *Varför:* Förklarar kod-mönster (millis() utan delay, arrays, struktur) — pedagogiskt komplement till McWhorter.

- **DroneBot Workshop** — https://www.youtube.com/channel/UCzml9bXoEM0itbcE96CB03w (kanal) / https://dronebotworkshop.com/ (sajt)
  Bill från Kanada. Långa (30–60 min) djupgående genomgångar. Aktiv maj 2026 med Modulino- och UNO Q-tutorials.
  *Varför:* När eleven är klar med basics och vill gå vidare till sensorer, ESP32, motorer, IoT. Skriftliga tutorials på sajten kompletterar videorna.

- **Andreas Spiess (The Guy with the Swiss Accent)** — https://www.youtube.com/@AndreasSpiess
  Schweizisk ingenjör. ESP32, sensorer, IoT-djupdykningar. Mycket aktiv 2025–2026.
  *Varför:* När eleven växt ur Arduino UNO och börjar titta på ESP32/WiFi. Ärlig om vad som funkar och inte.

- **Officiella Arduino-kanalen** — https://www.youtube.com/@Arduino
  Produktnyheter, hands-on och tutorials.
  *Varför:* Ha med för fullständighet. Mer marknadsföring än undervisning — sekundärt val.

### Svenska

Ingen YouTube-kanal hittad 2026 med konsistent, aktuell, nybörjarinriktad Arduino-undervisning på svenska. Det fanns enstaka playlists 2018–2020 men inget aktivt 2024–2026. **Rekommendation:** länka inte slätstrukna gamla svenska videor — peka på McWhorter med svenska undertexter (YouTube auto-translate funkar acceptabelt på honom eftersom han talar långsamt och tydligt).

---

## 3. Online-communities

- **r/arduino (Reddit)** — https://www.reddit.com/r/arduino/
  Aktivt subreddit (kunde inte fetch:as direkt, men WebSearch bekräftar pågående aktivitet). Bra "stuck on a project"-första-anlöp.
  *Varför:* Snabbast svarstid för enkla nybörjarfrågor. Krav: alltid posta kod + foto av wiring.

- **Officiella Arduino Discord** — https://discord.com/invite/arduino
  ~40 000 medlemmar, modererat, hjälpkanaler per ämnesområde.
  *Varför:* Realtidshjälp. Bra när Reddit/forum är för långsamt. Ha tålamod — många chatkanaler är aktiva samtidigt.

- **Arduino Forum (officiellt)** — https://forum.arduino.cc/
  Se kategori 1. För längre/strukturerade frågor är detta bättre än Reddit eller Discord.

- **Arduino Stack Exchange** — https://arduino.stackexchange.com/
  Strikt Q&A-format (inga diskussioner). 387K månadsanvändare (rapporterat 2025), aktivt.
  *Varför:* När du letar svar på specifika tekniska frågor är detta ofta bättre än forum — sorterat på röster, inte trådning. Anti-svar: dåliga frågor stängs hårt, så läs FAQ först.

- **Electronics Stack Exchange** — https://electronics.stackexchange.com/
  Bredare elektronik-Q&A — kretsdesign, komponentval, mätning.
  *Varför:* När Arduino-frågan egentligen är elektronik-frågan ("varför bränner min motor LED:en").

- **Svenska ElektronikForumet** — https://elektronikforumet.com/forum/
  Bekräftat aktivt 2026-05-12 (senaste inlägg samma dag). 88 000+ inlägg i Inbäddade system/IoT-kategorin. Arduino-diskussioner pågående.
  *Varför:* Enda kvarvarande svenska forumet med kritisk massa för Arduino. Inte super-snabbt men respektfullt och lågtröskel.

- **Sweclockers — Enkortsdatorer** — https://www.sweclockers.com/forum/123-enkortsdatorer
  Sekundärt svenskt forum (mer hardcore-tech), Arduino-trådar förekommer.

---

## 4. Project-inspiration

- **Hackster.io** — https://www.hackster.io/
  Stor maker-community. Officiell Arduino Project Hub-värd före 2023.
  *Varför:* Bredare än bara Arduino — ESP32, Raspberry Pi, AI-on-the-edge. Bra för "vad göra härnäst".

- **Instructables — Circuits** — https://www.instructables.com/circuits/
  Step-by-step-projekt med tydliga foton. Pre-2020-innehåll är blandat men nyare är bra.
  *Varför:* Bra som komplement till Project Hub — fler "praktiska" projekt (rörelsesensor-lampa, vädersation, automatiserad bevattning).

- **Adafruit Learning System** — https://learn.adafruit.com/
  3 344+ tutorials totalt, dominerat av deras egna produkter men allmänt tillämpligt. Aktivt uppdaterad 2024–2026.
  *Varför:* Kvalitetsstandard för tutorials i branschen. Skarp pedagogik, korrekta kopplingsscheman, väl-testad kod. Om Adafruit har en guide på din sensor, börja där.

- **SparkFun Learn** — https://learn.sparkfun.com/
  Konkurrent till Adafruit. Bekräftat aktiv 2026 (senaste tutorial 2026-01-14).
  *Varför:* Hookup Guides per komponent. Ofta bättre än produkt-bladet från tillverkaren.

- **DroneBot Workshop tutorials** — https://dronebotworkshop.com/tutorials/
  Se YouTube-sektionen. Skriftliga versioner av videor med komplett kod och scheman.

- **Random Nerd Tutorials** — https://randomnerdtutorials.com/
  Sara Santos. Mycket aktivt 2026, ESP32-fokus men UNO-kompatibelt.
  *Varför:* När man söker "ESP32 + sensor X" är denna sajt nästan alltid bland topp-3 svar. Free eBooks finns; vissa kurser betalda.

- **ELEGOO Tutorials** — https://www.elegoo.com/blogs/arduino-projects
  ELEGOO:s egna tutorial-blog för UNO Basic, Super och The Most Complete Starter Kit.
  *Varför:* Eleven har redan ELEGOO-kittet. Officiell tutorial för exakt det kittet med nedladdningsbar kod.

---

## 5. Reference & docs

- **Arduino Language Reference** — https://docs.arduino.cc/language-reference/ (se kategori 1)

- **Arduino Libraries-katalog** — https://www.arduinolibraries.info/
  Tredjeparts men de-facto centralregister över alla Arduino-bibliotek (8 000+). Visar antal installationer och senaste uppdatering.
  *Varför:* När du letar bibliotek för en sensor — sök här först, kolla "Last updated".

- **Programming Electronics Academy artikelarkiv** — https://www.programmingelectronics.com/
  Lång-form artiklar som "millis() Arduino function: 5+ things to consider", "How to Use Arrays with Arduino".
  *Varför:* Förklarar koncept djupare än reference-sidan.

- **DigiKey Maker Tutorials** — https://www.digikey.com/en/maker
  DigiKey:s pedagogiska resurssida. "The Basics of C++ on an Arduino" 5-delsserie är specifikt bra.
  *Varför:* Industrikvalitet — komponentleverantör som tar utbildning på allvar.

### Böcker (kommersiella, men evergreen)

- **"Arduino: A Technical Reference"** av J. M. Hughes (O'Reilly, 2016)
  Inte ny, men referensbok för UNO-hårdvaran specifikt. Pinout-diagram, AVR-mikrocontroller-detaljer, shields, sensorer.
  *Varför:* Den enda boken som behandlar UNO som hårdvaru-objekt, inte projekt-kokbok. Begränsning: skriven för UNO R3, inte R4.

- **"Make: AVR Programming"** av Elliot Williams (Maker Media, 2014)
  Lär dig programmera AVR-chippet (ATmega328P) direkt, utan Arduino-abstraktionerna.
  *Varför:* När eleven är redo att se "vad ligger under huven". Verkligt avancerat — passar bara student med starkt intresse av embedded.

---

## 6. C++ för Arduino-utvecklare (gradient från Arduino-C till modern C++)

- **learncpp.com** — https://www.learncpp.com/
  Gratis komplett C++-tutorial. Modern C++ (C++11/14/17/20/23). Senast bekräftat uppdaterad mars 2024.
  *Varför:* De-facto gratis-standard för att lära sig C++. Inte embedded-specifik men exakt rätt grund. Bästa stegvis-resurs efter Arduino-basics.

- **DigiKey: "The Basics of C++ on an Arduino" (5-delar)** — https://www.digikey.com/en/maker/tutorials/2020/the-basics-of-c-on-an-arduino-part-1-variables
  Specifikt brygga från Arduino-makro-C till C++-koncept (variabler, funktioner, klasser, references, pointers).
  *Varför:* Mest direkt brygga från "Arduino C-stil" till "Detta är faktiskt C++". 2020-publicerad men språket har inte förändrats sedan.

- **"C++ in Embedded Systems" av Amar Mahmutbegović (Packt, 2025)** — https://www.packtpub.com/en-us/product/c-in-embedded-systems-9781835881156
  Praktisk C-till-modern-C++-transition för embedded. Inkluderar Embedded Template Library (ETL) som alternativ till STL.
  *Varför:* Den enda nya (2025) boken som direkt adresserar målgruppen "embedded-utvecklare med C-bakgrund som vill modernisera". Kommersiell (~$30).

- **Hackaday: "Using Modern C++ Techniques With Arduino"** — https://hackaday.com/2017/05/05/using-modern-c-techniques-with-arduino/
  Kort artikel om constexpr, templates, type-safety för Arduino.
  *Varför:* Inspirations-läsning för "vad är det att skriva Arduino mer C++:igt". Inte tutorial — peka, läs, fundera.

---

## 7. Nästa kit / hårdvara att utforska efter ELEGOO UNO Basic

### Närmaste uppgradering

- **Raspberry Pi Pico 2 W** — köp via [Electrokit](https://www.electrokit.com/), [Kjell & Company](https://www.kjell.com/), eller [Pimoroni](https://shop.pimoroni.com/)
  RP2350-chippet (dual-core ARM M0+ 133 MHz), WiFi/BT, ~50 kr.
  *Varför:* Mer kraft än UNO, programmeras i Arduino IDE 2.x (via earlephilhower/arduino-pico-core). Bästa nästa-steg för någon som vill behålla "Arduino-känslan" men få mer prestanda.

- **ESP32 (DOIT DEVKIT V1 eller ESP32-S3 Feather)** — Electrokit, Kjell, Adafruit-distributörer
  240 MHz dual-core, WiFi + BT inbyggt. ~100–200 kr.
  *Varför:* När eleven vill koppla något till nätet eller använda Bluetooth. Stort ekosystem. Setup-guide: https://developer.espressif.com/blog/2025/10/arduino-get-started/.

- **Arduino UNO R4 WiFi** — Electrokit (299 kr verifierat 2026-05-12), arduino.cc
  Officiell uppgradering: 48 MHz Renesas RA4M1, WiFi via ESP32-S3, LED-matris på board.
  *Varför:* "Officiell" sequence-uppgradering om eleven vill stanna i Arduino-ekosystemet utan att lära om.

### Robotkitt och utbyggnader

- **ELEGOO Smart Robot Car V4.0** — elegoo.com
  Naturlig utbyggnad om eleven har ELEGOO-kit redan. Ultraljud, IR, Bluetooth, motorer.

- **Arduino Plug and Make Kit (med Modulino-moduler)** — store.arduino.cc
  Officiellt nytt UNO R4-baserat kit (2025). Modulino-modulerna kopplas via Qwiic-kontakter — inget breadboarding.
  *Varför:* Helt annan inlärningskurva: ren mjukvara, inga elektronik-misstag. Bra för någon som inte vill hantera breadboards.

### Sensorer värda att testa (alla kompatibla med UNO)

- **DHT22 / DHT11** — temperatur + luftfuktighet
- **DS18B20** — vattentät temperatursensor (1-Wire)
- **MPU6050** — 6-axlig accelerometer + gyro (I2C)
- **HC-SR04** — ultraljud-avståndssensor
- **PIR HC-SR501** — rörelsesensor
- **MQ-2 / MQ-135** — gas/luftkvalitet
- **NeoPixel-ring (WS2812B)** — färgad LED-display

Köp via: Electrokit (sverigeleverans), Adafruit (US, högkvalitet), AliExpress (billigt, varierande kvalitet).

### Svenska komponenthandlare (verifierat 2026)

- **Electrokit** — https://www.electrokit.com/ — 14 000+ produkter, Malmö, snabb leverans. **Förstaval för svenska kunder.**
- **Kjell & Company** — https://www.kjell.com/se/produkter/el-verktyg/elektronik — bra för fysiska butiker (270 elektronik-artiklar). Dyrare per komponent men hämta-idag-möjlighet.
- **arduino.se** — https://www.arduino.se/ — svensk Arduino-portal med tutorials och produktlänkar.

**Lawicel AB:** Tidigare välkänd svensk Arduino-leverantör. **Stängde januari 2025** — använd inte i resurssamlingen.

---

## 8. Verktyg utöver Arduino IDE

- **PlatformIO (VSCode-extension)** — https://platformio.org/
  Professionellt embedded-development-IDE som VS Code-extension. Library manager, debug-stöd, multi-platform, unit testing.
  *Varför:* Naturlig steg-upp från Arduino IDE när eleven börjar känna sig begränsad. Stöder Arduino, ESP32, STM32, Pico — allt från samma editor. Tröskel högre än Arduino IDE 2.x.

- **Wokwi** — https://wokwi.com/
  Browser-baserad simulator för Arduino UNO, ESP32, STM32, Raspberry Pi Pico. Gratis för personligt bruk. Stöder pinout, sensorer, displays, multimeter.
  *Varför:* Eleven kan testa kod utan hårdvara — perfekt om kittet ligger hemma och tankarna kommer på jobbet. **Begränsning:** Pins 3.3V/IOREF/AREF/RESET inte tillgängliga i UNO-simuleringen; egna bibliotek kräver Pro-plan.

- **TinkerCAD Circuits** — https://www.tinkercad.com/circuits
  Autodesks gratis simulator. Mer pedagogisk än Wokwi, lägre tröskel men mindre kraftfull.
  *Varför:* Bra för helt nya nybörjare — drag-and-drop UNO + komponenter, skriv kod, simulera. Kontofritt prov funkar; sparade projekt kräver Autodesk-konto.

- **Fritzing** — https://fritzing.org/
  Skapa kopplingsscheman och PCB-layouter visuellt. Open source, **betalmodell:** ~10 euro engångsbelopp för officiella binärer (eller bygg själv från källkod gratis).
  *Varför:* När eleven vill dokumentera ett bygge eller designa en egen PCB. Inte simulator — bara visualisering. URL returnerade 403 vid test 2026-05-12 men WebSearch bekräftar aktiv distribution.

---

## 9. Bibliotek att utforska

Alla nedan installeras via Arduino IDE → Sketch → Include Library → Manage Libraries.

- **Servo** — https://docs.arduino.cc/libraries/servo/ — kontrollera RC-servomotorer (officiellt Arduino-bibliotek, ingår).
- **Wire** — https://docs.arduino.cc/learn/communication/wire/ — I2C-kommunikation med sensorer/displays (ingår).
- **SPI** — https://docs.arduino.cc/learn/communication/spi/ — SPI-kommunikation (ingår; för snabbare sensorer/SD-kort).
- **OneWire** (Paul Stoffregen) — https://github.com/PaulStoffregen/OneWire — DS18B20 temperatursensorer, iButtons.
- **DallasTemperature** — bygg på OneWire för temperaturläsning (high-level API).
- **Adafruit NeoPixel** — https://github.com/adafruit/Adafruit_NeoPixel — WS2812B addressable LEDs. **Aktivt uppdaterad** (v1.15.5, maj 2026). Det enklaste valet för enstaka NeoPixel-strip.
- **FastLED** — https://fastled.io/ + https://github.com/FastLED/FastLED — kraftfullare än NeoPixel-libbet, 30 000+ LEDs, animations-cookbook, **#2 mest populära Arduino-bibliotek** (v3.10.4, 7.4k GitHub stars, aktivt 2026). Använd för komplexa LED-projekt.
- **IRremote (Arduino-IRremote)** — https://github.com/Arduino-IRremote/Arduino-IRremote — sänd/ta emot IR-fjärrkontroll-koder. Stöder NEC, Sony SIRC, Philips RC5/RC6 m.fl.
- **LiquidCrystal_I2C** — driva 16x2/20x4 LCD-skärmar via I2C-backpack med bara 2 pins.
- **DHT sensor library** (Adafruit) — DHT11/DHT22 temperatur+luftfuktighet.
- **Arduino_DebugUtils** — strukturerad debug-utskrift med nivåer (DEBUG/INFO/WARNING/ERROR).
- **ArduinoJson** — parsa/generera JSON. Ovärderligt så fort eleven börjar prata HTTP/IoT.

---

## 10. Svenskspecifikt

Sammanställt och verifierat 2026-05-12. **Sverige har tunnare community-närvaro än engelsk-språkig värld** — kasta inte 10 medelmåttiga svenska länkar, ta de få som är bra.

- **arduino.se** — https://www.arduino.se/
  Svensk Arduino-introduktionsportal. Grundläggande tutorials (LED, temperatursensor, ljus-styrd motor, servo, vädersation). Aktiv 2026.
  *Varför:* Enda relevanta svenska tutorial-portalen för rena nybörjare. Modest scope men korrekt.

- **Svenska ElektronikForumet** — https://elektronikforumet.com/forum/
  Sveriges största elektronik-forum. 15 000+ medlemmar, aktivt 2026. Arduino-trådar i "Inbäddade system / IoT".
  *Varför:* Enda svenska forumet med kritisk massa för Arduino. Svar kommer på svenska.

- **Makers of Sweden** — https://www.makersofsweden.se/
  Centralorganisation för svenska makerspaces. 16 medlemsorganisationer, riksmöte maj 2026.
  *Varför:* Hitta närmaste makerspace via deras karta. **OBS** — kolla aktivitet lokalt; alla makerspaces har inte Arduino-utrustning.

- **Stockholm Makerspace** — https://www.makerspace.se/
  Sveriges största medlemsdrivna makerspace, KTH-campus. Verkstad: 350 m², 3D-skrivare, lasercutter, elektronik.
  *Varför:* För Stockholm-baserade elever som vill ha fysisk verkstad. Medlemskap krävs; öppet hus förekommer.

- **Electrokit** — https://www.electrokit.com/ (se kategori 7)

- **Kjell & Company** — https://www.kjell.com/se/produkter/el-verktyg/elektronik (se kategori 7)

- **Wikiskola: Resurser om Arduinoprojekt** — https://wikiskola.se/index.php/Resurser,_tips_och_länkar_om_Arduinoprojekt
  Svensk pedagogisk wiki, samlar tutorials och projekt riktade till lärare/elever.
  *Varför:* Specifikt för utbildningskontext — fungerar för FRO-kursdeltagare som vill sprida vidare.

### Vad som **inte** finns på svenska 2026

- Aktiv svensk YouTube-kanal med Arduino-tutorials på regelbunden basis (alla större försök 2018–2020 har slutat publicera)
- Svensk-språkig modern bok om Arduino (senaste relevant svensk Arduino-bok från 2016)
- Lawicel.se-tutorials — **företaget stängde januari 2025**, sajten kan ev. fortfarande finnas på archive.org men ska inte länkas som levande resurs

---

## TOPP 3 — om allt annat stryks från sajten

Om GitHub Pages-sajten bara har plats för tre länkar utöver kursmaterialet självt:

1. **Paul McWhorter Arduino-lektionerna** — https://toptechboy.com/arduino-lessons/
   Pedagogiskt komplett från nybörjare till medelnivå. Det vi inte hann undervisa i 5 träffar finns här i ~100 lektioner.

2. **Arduino Language Reference** — https://docs.arduino.cc/language-reference/
   Den enda dokumentationen eleven kommer behöva slå upp dagligen. Officiell, korrekt, sökbar.

3. **Electrokit** — https://www.electrokit.com/
   Praktisk verklighet — utan att kunna köpa komponenter i Sverige stannar lärandet. Snabb leverans, ärliga priser, brett sortiment.

### Hederlig fjärdeplats

**Wokwi** — https://wokwi.com/ — vid tröskelfallet "kan inte prova utan hårdvara". Den enda online-simulator som inte kräver konto för enkla UNO-projekt.

---

## Sammanfattning för sajt-strukturen

Föreslagen ordning på "Resurser & nästa steg"-sidan:

1. **Kom igång efter kursen** — Paul McWhorter (för struktur), Programming Electronics Academy (för koncept)
2. **Slå upp medan du kodar** — Arduino Language Reference, Arduino Forum, r/arduino
3. **Hitta nästa projekt** — Project Hub, Adafruit Learn, ELEGOO tutorials
4. **När du växt ur UNO** — ESP32, Raspberry Pi Pico 2 W, PlatformIO, learncpp.com
5. **Köp komponenter** — Electrokit (förstaval), Kjell & Company (fysisk butik)
6. **Träffa andra** — Stockholm Makerspace, Makers of Sweden, Svenska ElektronikForumet

Allt annat är "fördjupning" — sätt det under en kollapsbar sektion eller egen sida.
