// Blink med extern LED — Arduino-kursen, Träff 1
// Samma som Blink men med en LED kopplad via 220 Ω på pin 13.
// Hårdvara: anod (långt ben) → 220 Ω → pin 13 · katod (kort ben + platt kant) → GND.

const int ledPin = 13;

void setup() {
  pinMode(ledPin, OUTPUT);
}

void loop() {
  digitalWrite(ledPin, HIGH);
  delay(500);                       // halv sekund på
  digitalWrite(ledPin, LOW);
  delay(500);                       // halv sekund av
}
