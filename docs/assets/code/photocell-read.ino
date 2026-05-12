// Fotocell — analogRead + Serial.println — Arduino-kursen, Träff 4
// Skriver ljusvärdet 0..1023 till Serial Monitor 10 gånger per sekund.
// Hårdvara: +5V → fotocell → A0 → 1 kΩ → GND  (spänningsdelare).

const int ldrPin = A0;

void setup() {
  Serial.begin(9600);
  // analoga pins är INPUT som default
}

void loop() {
  int ljus = analogRead(ldrPin);
  Serial.println(ljus);
  delay(100);
}
