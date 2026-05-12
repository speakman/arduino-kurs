// Blink — Arduino-kursen, Träff 1
// Tänder och släcker inbyggda LED:en (pin 13) en gång per sekund.

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);   // körs en gång vid uppstart
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);  // tänd
  delay(1000);                      // vänta 1 sekund
  digitalWrite(LED_BUILTIN, LOW);   // släck
  delay(1000);                      // vänta 1 sekund
}
