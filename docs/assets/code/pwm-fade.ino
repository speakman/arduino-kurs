// PWM-fade — Arduino-kursen, Träff 2
// Mjuk in- och utfade av en LED med analogWrite.
// Hårdvara: LED på pin 6 (en av PWM-pinnarna: 3, 5, 6, 9, 10, 11) via 220 Ω → GND.

const int ledPin = 6;

void setup() {
  pinMode(ledPin, OUTPUT);
}

void loop() {
  // Fade upp: 0 → 255
  for (int v = 0; v <= 255; v++) {
    analogWrite(ledPin, v);
    delay(5);
  }
  // Fade ner: 255 → 0
  for (int v = 255; v >= 0; v--) {
    analogWrite(ledPin, v);
    delay(5);
  }
}
