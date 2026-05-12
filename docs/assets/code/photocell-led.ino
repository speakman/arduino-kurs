// Fotocell styr LED — Arduino-kursen, Träff 4
// När det blir mörkare än din tröskel tänds inbyggda LED:en.
// Hårdvara: +5V → fotocell → A0 → 1 kΩ → GND  (spänningsdelare).
//
// Tröskel-värdet 300 är ett riktvärde — kör photocell-read.ino först
// och hitta DITT värde för "lagom mörkt" i ert rum.

const int ldrPin     = A0;
const int morkTroskel = 300;

void setup() {
  Serial.begin(9600);
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  int ljus = analogRead(ldrPin);
  Serial.print("ljus=");
  Serial.println(ljus);

  if (ljus < morkTroskel) {
    digitalWrite(LED_BUILTIN, HIGH);   // mörkt → tänd
  } else {
    digitalWrite(LED_BUILTIN, LOW);
  }
  delay(100);
}
