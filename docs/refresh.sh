#!/usr/bin/env bash
# Refresh docs/-siten från källmaterial i presentation/ och kompendium/.
# Idempotent — kör hur ofta du vill.
# Se REFRESH.md för fullständig dokumentation.

set -euo pipefail
cd "$(dirname "$0")/.."

echo "▶ docs/-refresh started"
echo "  repo: $(pwd)"

# 1. Slidev-decket → docs/slides/
echo
echo "▶ 1/3  Slidev → docs/slides/"
(cd presentation && npm run build:pages)

# Rensa Netlify-cruft som Slidev emit:ar (Pages ignorerar dem)
rm -f docs/slides/_redirects

# 2. Kompendium-PDF:er → docs/assets/pdf/
echo
echo "▶ 2/3  Kompendium-PDF:er → docs/assets/pdf/"
if [ -d kompendium/deliveries ]; then
  cp -v kompendium/deliveries/*.pdf docs/assets/pdf/ 2>/dev/null || true
  cp -v kompendium/deliveries/slides-per-dag/*.pdf docs/assets/pdf/ 2>/dev/null || true
else
  echo "  (skipping — kompendium/deliveries saknas — kör 'bash kompendium/build.sh' först)"
fi

# 3. Bilder: konvertera PNG → WebP där presentation/public/images/ har en nyare källa
echo
echo "▶ 3/3  Bilder: konvertera ändrade PNG → WebP"
for src in presentation/public/images/*.png presentation/public/images/wiring/*.png; do
  [ -f "$src" ] || continue
  name=$(basename "$src" .png)
  dst="docs/assets/img/${name}.webp"
  if [ ! -f "$dst" ] || [ "$src" -nt "$dst" ]; then
    magick "$src" -quality 88 -define webp:method=6 "$dst"
    echo "  ✓ $name.webp regenerated"
  fi
done

echo
echo "▶ docs/-refresh complete"
echo
echo "Nästa: kontrollera lokalt med:"
echo "  cd docs && python3 -m http.server 8000"
echo
echo "Push när du är nöjd:"
echo "  git add docs/ && git commit -m 'chore(docs): refresh från senaste source' && git push"
