import { defineShikiSetup } from '@slidev/types'

// Shiki's cpp grammar inconsistently colors certain Arduino functions
// inside a function body (e.g. `pinMode(LED_BUILTIN, OUTPUT)` in setup()
// renders as plain text while `digitalWrite` renders as a function call).
// This transformer forces the function-call color for the Arduino API.
const ARDUINO_FUNCTIONS = new Set([
  'pinMode',
  'digitalWrite',
  'digitalRead',
  'analogRead',
  'analogWrite',
  'tone',
  'noTone',
  'delay',
  'delayMicroseconds',
  'millis',
  'micros',
])

export default defineShikiSetup(() => ({
  transformers: [
    {
      name: 'arduino-builtins',
      tokens(tokens) {
        for (const line of tokens) {
          for (const token of line) {
            if (!token.content) continue
            const trimmed = token.content.trim()
            if (!ARDUINO_FUNCTIONS.has(trimmed)) continue
            token.htmlStyle = {
              '--shiki-dark': '#80A665',
              '--shiki-light': '#59873A',
            }
          }
        }
      },
    },
  ],
}))
