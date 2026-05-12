// Hackathon-skelett — Arduino-kursen, Träff 5
//
// Strukturen för larm-projektet, utan logiken — fyll i själv.
// Pin-tilldelningarna kommer från de tidigare modulerna; allt är
// redan ihopkopplat. Det som saknas är besluten i loop().

const int knappPin  = 9;
const int tiltPin   = 2;
const int ldrPin    = A0;
const int buzzerPin = 12;
const int ledR      = 6;
const int ledG      = 5;
const int ledB      = 3;

const int morkTroskel = 300;

bool larmPaslaget   = false;
int  lastKnappState = HIGH;

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
}

void loop() {
  // 1. LÄS — knapp, tilt, fotocell
  // TODO: läs alla tre och spara i variabler

  // 2. BESLUT — knappen togglar larmet (flank-detektion)
  // TODO: om knappen JUST tryckts (LOW men förra var HIGH),
  //       invertera larmPaslaget

  // 3. AGERA — välj vad som ska hända
  //   - Om larm PÅ och tilt LUTAD: buzzer + rött blink
  //   - Om larm AV och MÖRKT:      stämningsljus
  //   - Annars:                    tyst, RGB släckt

  delay(10);
}
