// RGB-cykel — Arduino-kursen, Träff 2
// Bygger upp färger genom att blanda röd, grön och blå med olika styrka.
// Hårdvara: gemensam katod RGB-LED. Tre 220 Ω-resistorer:
//   R → D6   G → D5   B → D3   gemensam katod → GND.

const int ledR = 6;
const int ledG = 5;
const int ledB = 3;

void setup() {
  pinMode(ledR, OUTPUT);
  pinMode(ledG, OUTPUT);
  pinMode(ledB, OUTPUT);
}

void loop() {
  // Lila: röd + blå
  analogWrite(ledR, 200);
  analogWrite(ledG,   0);
  analogWrite(ledB, 200);
  delay(1000);

  // Gult: röd + grön
  analogWrite(ledR, 255);
  analogWrite(ledG, 180);
  analogWrite(ledB,   0);
  delay(1000);

  // Cyan: grön + blå
  analogWrite(ledR,   0);
  analogWrite(ledG, 200);
  analogWrite(ledB, 200);
  delay(1000);

  // Vit: alla tre på samma nivå
  analogWrite(ledR, 150);
  analogWrite(ledG, 150);
  analogWrite(ledB, 150);
  delay(1000);
}
