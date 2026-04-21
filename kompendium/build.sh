#!/usr/bin/env bash
# Bygger alla PDF:er: full kompendium + per-modul + bilagor.
# Körs från kompendium/-katalogen.

set -e

cd "$(dirname "$0")"

echo "→ Kompendium (fullständigt)"
typst compile main.typ kompendium.pdf

echo "→ Modul 1 (LED & krets)"
typst compile main-modul-1.typ modul-1-led-krets.pdf

echo "→ Modul 2 (PWM & RGB)"
typst compile main-modul-2.typ modul-2-pwm-rgb.pdf

echo "→ Modul 3 (Digital input)"
typst compile main-modul-3.typ modul-3-digital-input.pdf

echo "→ Modul 4 (Analog input)"
typst compile main-modul-4.typ modul-4-analog-input.pdf

echo "→ Modul 5 (Hackathon)"
typst compile main-modul-5.typ modul-5-hackathon.pdf

echo "→ Bilagor (A–F, fullständig)"
typst compile main-bilagor.typ bilagor-a-f.pdf

echo "→ Bilagor tidiga (A, B, C, E, F — utan hackathon-lösning)"
typst compile main-bilagor-tidiga.typ bilagor-tidiga.pdf

echo "→ Bilaga D (hackathon-lösning — delas ut EFTER dag 5)"
typst compile main-bilaga-d.typ bilaga-d-hackathon-losning.pdf

echo ""
echo "✓ Klar. PDF:er:"
ls -lh *.pdf
