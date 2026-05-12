// Larm-toggle — Arduino-kursen, Träff 3
// Tryck = växla larmet av/på. Buzzern tjuter när larmet är på.
// Flank-detektion: vi reagerar bara på övergången HIGH → LOW,
// inte på att knappen "är" nere — annars skulle larmet flimra
// på och av många gånger per sekund så länge knappen hålls intryckt.
//
// Hårdvara: knapp → D9 + GND (INPUT_PULLUP).
//           active buzzer +ben → D12, −ben → GND.

const int knappPin  = 9;
const int buzzerPin = 12;

bool larmPaslaget = false;
int  lastState    = HIGH;

void setup() {
  pinMode(knappPin, INPUT_PULLUP);
  pinMode(buzzerPin, OUTPUT);
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  int state = digitalRead(knappPin);

  if (state == LOW && lastState == HIGH) {
    // fallande flank → toggla larmet
    larmPaslaget = !larmPaslaget;
  }

  // Spegla larmtillståndet på både buzzern och inbyggda LED:en
  digitalWrite(buzzerPin,   larmPaslaget ? HIGH : LOW);
  digitalWrite(LED_BUILTIN, larmPaslaget ? HIGH : LOW);

  lastState = state;
  delay(10);   // enkel debounce
}
