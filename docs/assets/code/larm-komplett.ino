// ═══════════════════════════════════════════════════════════════
//   Hackathon-lösning — komplett tjuvlarm
//   Arduino-kursen, Träff 5
//
//   Funktioner:
//   • Knapp togglar larmet av/på (flank-detektion).
//   • Tilt-sensor + larm PÅ  → buzzer tjuter och RGB blinkar rött.
//   • Larm AV + mörkt rum    → mjukt stämningsljus.
//
//   Hela förklaringen rad-för-rad finns i Bilaga D i kompendiet.
// ═══════════════════════════════════════════════════════════════

// ─── Pin-tilldelning ────────────────────────────────────
const int knappPin  = 9;   // Modul 3 — digital in
const int tiltPin   = 2;   // Modul 4 — digital in
const int ldrPin    = A0;  // Modul 4 — analog in
const int buzzerPin = 12;  // Modul 3 — digital out
const int ledR      = 6;   // Modul 2 — PWM out
const int ledG      = 5;   // Modul 2 — PWM out
const int ledB      = 3;   // Modul 2 — PWM out

// ─── Tröskel för fotocellen ─────────────────────────────
// Kalibrera själv i Serial Monitor. Låg siffra = mörkt.
const int morkTroskel = 300;

// ─── Tillståndsvariabler (globala, lever mellan loopar) ─
bool larmPaslaget   = false;
int  lastKnappState = HIGH;  // HIGH = släppt (INPUT_PULLUP)

// ─── Hjälpfunktion för att skriva RGB ───────────────────
void sattFarg(int r, int g, int b) {
  analogWrite(ledR, r);
  analogWrite(ledG, g);
  analogWrite(ledB, b);
}

void setup() {
  Serial.begin(9600);
  pinMode(knappPin,  INPUT_PULLUP);
  pinMode(tiltPin,   INPUT_PULLUP);
  pinMode(buzzerPin, OUTPUT);
  pinMode(ledR, OUTPUT);
  pinMode(ledG, OUTPUT);
  pinMode(ledB, OUTPUT);

  Serial.println("Larmet startat. Larm av som default.");
}

void loop() {
  // 1. LÄS INPUTS
  int  knappState = digitalRead(knappPin);
  bool tiltLutad  = (digitalRead(tiltPin) == LOW);
  delay(50);                  // debounce tilt — kulan bouncar i hylsan
  int  ljus       = analogRead(ldrPin);

  // 2. EDGE-DETECTION för knappen (toggla larmläget)
  if (knappState == LOW && lastKnappState == HIGH) {
    larmPaslaget = !larmPaslaget;
    Serial.print("Larm nu ");
    Serial.println(larmPaslaget ? "PÅ" : "AV");
  }
  lastKnappState = knappState;

  // 3. BESTÄM VAD SOM SKA HÄNDA
  if (larmPaslaget && tiltLutad) {
    // LARM AKTIVT + RÖRT → tjut + rött blink
    digitalWrite(buzzerPin, HIGH);
    sattFarg(255, 0, 0);
    delay(100);
    digitalWrite(buzzerPin, LOW);
    sattFarg(0, 0, 0);
    delay(100);
  } else if (!larmPaslaget && ljus < morkTroskel) {
    // LARM AV + MÖRKT → stämningsljus (mjukt varmt)
    digitalWrite(buzzerPin, LOW);
    sattFarg(120, 60, 20);
  } else {
    // TYST
    digitalWrite(buzzerPin, LOW);
    sattFarg(0, 0, 0);
  }

  // 4. Kort paus mot kortkrets-looping
  delay(10);
}
