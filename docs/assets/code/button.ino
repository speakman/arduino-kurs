// Tryckknapp läses som digital input — Arduino-kursen, Träff 3
// När knappen trycks tänds den inbyggda LED:en på pin 13.
// Hårdvara: knappens ena ben → D9, andra benet → GND. Ingen extern resistor.
//           pinMode(..., INPUT_PULLUP) använder Arduinons inbyggda pullup.

const int knappPin = 9;

void setup() {
  pinMode(knappPin, INPUT_PULLUP);
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  if (digitalRead(knappPin) == LOW) {
    // knappen tryckt (LOW eftersom INPUT_PULLUP — andra benet drar till GND)
    digitalWrite(LED_BUILTIN, HIGH);
  } else {
    digitalWrite(LED_BUILTIN, LOW);
  }
}
