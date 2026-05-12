// Tilt + fotocell tillsammans — Arduino-kursen, Träff 4
// Skriver båda sensorerna till Serial Monitor på samma rad.
// Hårdvara: fotocell-spänningsdelare på A0 (se photocell-read.ino).
//           tilt-sensor: ena benet → D2, andra → GND (INPUT_PULLUP).

const int ldrPin  = A0;
const int tiltPin = 2;

void setup() {
  Serial.begin(9600);
  pinMode(tiltPin, INPUT_PULLUP);
}

void loop() {
  int ljus = analogRead(ldrPin);
  int tilt = digitalRead(tiltPin);   // HIGH = upprätt, LOW = lutad
  Serial.print("ljus=");
  Serial.print(ljus);
  Serial.print("  tilt=");
  Serial.println(tilt);
  delay(100);
}
