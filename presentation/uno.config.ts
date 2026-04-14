import { defineConfig } from 'unocss'

// Canvas-calibrated typography for canvasWidth: 1920.
// Slidev's default Tailwind fontSize scale uses desktop-browser pixels
// (text-xs = 12 px .. text-7xl = 72 px) which is 2–3× too small on a 1920
// presentation canvas. We rebase the entire scale here so every text-*
// utility lands at a presentation-appropriate size. Slidev merges this with
// its internal uno.config.ts.
//
// Tuple format: [fontSize, lineHeight]. Body-ish sizes get 1.5 so wrapping
// prose reads cleanly; headings get progressively tighter line-heights
// because large type doesn't need much vertical breathing room and tight
// leading keeps hero slides visually anchored.
export default defineConfig({
  theme: {
    fontSize: {
      xs:   ['1.10rem', '1.5'],
      sm:   ['1.35rem', '1.5'],
      base: ['1.60rem', '1.5'],
      lg:   ['1.90rem', '1.5'],
      xl:   ['2.20rem', '1.5'],
      '2xl':['2.70rem', '1.45'],
      '3xl':['3.20rem', '1.4'],
      '4xl':['3.80rem', '1.3'],
      '5xl':['4.50rem', '1.2'],
      '6xl':['5.20rem', '1.1'],
      '7xl':['6.00rem', '1.05'],
      '8xl':['7.00rem', '1.0'],
    },
  },
})
