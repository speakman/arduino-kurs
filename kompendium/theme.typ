// theme.typ
// State-of-the-art typography för Arduino-kursens kompendium.
//
// Design-filosofi:
//   · Modulär skala 1.25× (Major Third) — 11 / 17 / 34pt
//   · Charter 11pt kropp — designad för laser 300 dpi, öppen apertur, god kontrast
//   · Leading 0.72em (~1.72×) — Charter behöver mer luft än kondenserade fonter
//   · Styckeavstånd 1.05em — bok-känsla, inte blogg-känsla
//   · Rubriker: Helvetica Neue, modulärt skalad, whitespace bär hierarkin
//   · Running head: visar aktuellt kapitel via query(), inte statisk text
//   · Färgpalett: editorial-cyan + bränt-sienna — trycker rent på laser
//   · Callout-boxar: vänsterkant-mönster (O'Reilly-konvention, inte full ram)
//   · Inline-kod: 9.6pt Menlo mot Charter 11pt — optisk x-höjd matchar

// ═══════════════════════════════════════════════════════════════════
// FÄRGER
// ═══════════════════════════════════════════════════════════════════

#let ink        = rgb("#1a1c20")  // varm nästan-svart
#let paper      = rgb("#ffffff")
#let rule       = rgb("#dde0e5")  // ljusa linjer, separatorer
#let cyan       = rgb("#087a92")  // dämpad editorial-cyan
#let cyan-soft  = rgb("#cde4ea")  // ljus cyan för subtila backgrounds
#let warm       = rgb("#b15b1e")  // bränt-orange för varningar
#let danger     = rgb("#a23b3b")  // djupröd — sparas för riktiga varningar
#let muted      = rgb("#6a7280")  // sekundär text, bildtexter, running head
#let soft-bg    = rgb("#f6f5f1")  // varm off-vit för code/callout/formel
#let tip-bg     = rgb("#eef4f5")  // mycket subtil cyan-wash
#let warn-bg    = rgb("#faf2e6")  // mycket subtil varm wash

// ═══════════════════════════════════════════════════════════════════
// TYPSNITT
// ═══════════════════════════════════════════════════════════════════

#let body-font = ("Charter", "Georgia")
#let sans-font = ("Inter", "Helvetica Neue", "Helvetica")
#let mono-font = ("JetBrains Mono", "Menlo", "Courier New")

// Stäng av programmerings-ligatures (==, !=, <=, >=, ->, =>) i mono-font.
// JetBrains Mono och Menlo har calt/liga/clig/dlig på som default och renderar
// annars `==` som `⩵`, `!=` som `≠` etc — oläsligt i pedagogisk kod.
#let mono-features = (liga: 0, clig: 0, calt: 0, dlig: 0)

// ═══════════════════════════════════════════════════════════════════
// HUVUDMALL
// ═══════════════════════════════════════════════════════════════════

#let kompendium(
  title: "Arduino-kurs · Kompendium",
  author: "FRO Ånge",
  date: "2026",
  body,
) = {
  set document(title: title, author: author)

  // ─── Sidlayout ────────────────────────────────────────────────
  set page(
    paper: "a4",
    // 2.8cm top (running head + andrum), 2.6cm övriga
    // 158mm textbredd → 70–72 tecken/rad med Charter 11pt (Butterick-optimalt)
    margin: (top: 2.8cm, bottom: 2.6cm, inside: 2.6cm, outside: 2.6cm),
    numbering: "1",
    number-align: center,

    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        // Hämta senaste H1 före nuvarande position → kapitelnamn i running head
        let chapters = query(heading.where(level: 1).before(here()))
        let chapter-title = if chapters.len() > 0 { chapters.last().body } else { [] }

        set text(size: 8pt, fill: muted, font: sans-font, tracking: 0.4pt)
        grid(
          columns: (1fr, 1fr),
          align: (left + horizon, right + horizon),
          upper(title),
          chapter-title,
        )
        v(-4pt)
        line(length: 100%, stroke: 0.3pt + rule)
      }
    },

    footer: context {
      set text(size: 8.5pt, fill: muted, font: sans-font)
      align(center)[#counter(page).display()]
    },
  )

  // ─── Brödtext ─────────────────────────────────────────────────
  set text(
    font: body-font,
    size: 11pt,
    lang: "sv",
    region: "se",
    fill: ink,
    hyphenate: true,
  )

  // leading 0.72em ≈ 19pt radavstånd — Charter behöver generös luft
  // spacing 1.05em — bok-känsla: stycken tätt, men synligt separerade
  // linebreaks: "optimized" — förhindrar flodfåror i justerad text
  set par(
    justify: true,
    leading: 0.72em,
    first-line-indent: 0pt,
    spacing: 1.05em,
    linebreaks: "optimized",
  )

  // Grundläggande show-regler
  show strong: set text(weight: "bold", fill: ink)
  show emph: set text(style: "italic")

  // ─── Rubriker ─────────────────────────────────────────────────
  set heading(numbering: none)

  // H1 — kapitelstart
  // Eyebrow (supplement) + stor rubrik + accentsträck.
  // Pattern: editorial chapter opener (O'Reilly, Manning, Pearson).
  // 2.8cm ovanför — "landning" på sidan, signalerar stor övergång.
  // pagebreak(weak: true) bryter bara om vi inte redan är på ny sida.
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2.8cm)
    block(below: 10pt)[
      #set text(
        font: sans-font,
        size: 9pt,
        fill: cyan,
        weight: "medium",
        tracking: 2.2pt,
      )
      #upper(it.supplement)
    ]
    block(below: 0pt)[
      #set text(
        font: sans-font,
        size: 34pt,
        weight: "bold",
        fill: ink,
        hyphenate: false,
      )
      #set par(leading: 0.88em)
      #it.body
    ]
    v(14pt)
    line(length: 3.5cm, stroke: 1.4pt + cyan)
    v(1.6cm)
  }

  // H2 — avsnitt
  // 17pt = 1.25² × 11pt (modulär skala).
  // semibold, inte bold — tydlig hierarki utan att skrika.
  // weak: true — förhindrar uppsamling vid angränsande rubriker.
  show heading.where(level: 2): it => {
    v(2em, weak: true)
    block(below: 0pt)[
      #set text(
        font: sans-font,
        size: 17pt,
        weight: "semibold",
        fill: ink,
      )
      #it.body
    ]
    v(0.9em, weak: true)
  }

  // H3 — underrubrik-etikett
  // Spärrad versal sans i accentfärg — etikett, inte avdelare.
  // Sitter tätt intill sitt stycke (0.35em nedan) — "hör ihop".
  // Cyan färg skapar hierarki via kulör, inte vikt — bevarar sidans ekonomi.
  show heading.where(level: 3): it => {
    v(1.4em, weak: true)
    block(below: 0pt)[
      #set text(
        font: sans-font,
        size: 10pt,
        weight: "semibold",
        fill: cyan,
        tracking: 1pt,
      )
      #upper(it.body)
    ]
    v(0.35em, weak: true)
  }

  // ─── Code blocks ──────────────────────────────────────────────
  // Vänsterkant-mönster: editorial, inte "box" — O'Reilly-standard.
  // 9.2pt Menlo: optisk x-höjd matchar Charter 11pt kropp.
  // soft-bg varm off-vit: värmen i Charter speglas i bakgrunden.
  // Tät leading i kod (0.62em): rader hör ihop, "enhet"-känsla.
  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: soft-bg,
      stroke: (left: 3pt + cyan),
      inset: (x: 14pt, y: 12pt),
      radius: (right: 4pt),
      above: 1.3em,
      below: 1.3em,
    )[
      #set text(font: mono-font, size: 9.2pt, features: mono-features)
      #set par(leading: 0.62em, spacing: 0.62em, justify: false)
      #it
    ]
  }

  // Inline-kod: 9.6pt (justerat mot Charter 11pt via x-höjd).
  show raw.where(block: false): it => {
    box(
      fill: soft-bg,
      inset: (x: 3pt, y: 0pt),
      outset: (y: 2pt),
      radius: 2pt,
    )[#set text(font: mono-font, size: 9.6pt, features: mono-features); #it]
  }

  // ─── Listor ───────────────────────────────────────────────────
  // 0.75em spacing: mer luft än löptext-leading — diskreta punkter.
  set list(
    indent: 0.2em,
    body-indent: 0.55em,
    marker: ([–], [·], [-]),
    spacing: 0.75em,
    tight: false,
  )
  set enum(
    indent: 0.2em,
    body-indent: 0.55em,
    spacing: 0.75em,
    tight: false,
  )

  // ─── Blockquote/citat ─────────────────────────────────────────
  show quote: it => block(
    fill: soft-bg,
    stroke: (left: 2pt + muted),
    inset: (x: 16pt, y: 10pt),
    above: 1.2em,
    below: 1.2em,
  )[
    #set text(style: "italic", fill: muted)
    #it.body
  ]

  // ─── Figur-kaption ────────────────────────────────────────────
  // 8.5pt kursiv sans i muted: sekundär, rekursiv, kontrast mot Charter.
  // justify: false — kort bildtext ser ful ut med kraft-justering.
  show figure.caption: it => {
    set text(
      font: sans-font,
      size: 8.5pt,
      fill: muted,
      style: "italic",
    )
    set par(leading: 0.6em, justify: false)
    it.body
  }

  show figure: it => block(
    above: 1.4em,
    below: 1.4em,
  )[#it]

  // ─── Länkar ───────────────────────────────────────────────────
  show link: it => underline(offset: 2pt, stroke: 0.5pt + cyan)[
    #text(fill: cyan)[#it]
  ]

  body
}

// ═══════════════════════════════════════════════════════════════════
// HJÄLPARE
// ═══════════════════════════════════════════════════════════════════

// ─── Intern callout-fabrik ─────────────────────────────────────────
// Vänsterkant-mönster (O'Reilly-konvention).
// Rubrik: spärrad versal sans 8.5pt i accentfärg — inte ikon, inga emojis.
// Bakgrund: mycket subtil färgtvätt — trycks rent på laser.
#let _callout(title-text, accent, bg, title-body) = block(
  width: 100%,
  fill: bg,
  stroke: (left: 4pt + accent),
  inset: (x: 14pt, y: 11pt),
  radius: (right: 4pt),
  above: 1.3em,
  below: 1.3em,
)[
  #block(below: 5pt)[
    #set text(
      font: sans-font,
      size: 8.5pt,
      weight: "bold",
      fill: accent,
      tracking: 1.2pt,
    )
    #upper(title-text)
  ]
  #set par(leading: 0.7em, spacing: 0.9em)
  #title-body
]

// ─── Callout-boxar ────────────────────────────────────────────────

/// Tips — cyan-accentuerad, kompletterande kunskap.
#let tip(title: "Tips", body) = _callout(title, cyan, tip-bg, body)

/// Varning — bränt-orange, gotchas och "gör inte detta".
#let warning(title: "Viktigt", body) = _callout(title, warm, warn-bg, body)

/// Faktaruta — dämpad, definitioner och faktapåståenden.
#let fact(title: "Notering", body) = _callout(title, muted, soft-bg, body)

// ─── Slide-referens ───────────────────────────────────────────────
/// Inline-referens till bildnummer i tillhörande presentation.
#let sref(n) = {
  text(font: sans-font, size: 8pt, fill: muted)[slide #n]
}

// ─── Snabbreferens-tabell ─────────────────────────────────────────
/// 2-kolumns referenstabell. Anropa med #quickref([Begrepp], [Förklaring], ...)
/// Rader: alternerade bordrar, ingen yttre ram.
#let quickref(..rows) = {
  set text(font: sans-font, size: 9.5pt)
  set par(leading: 0.65em, justify: false)
  block(above: 1.2em, below: 1.2em)[
    #table(
      columns: (auto, 1fr),
      stroke: (x, y) => (
        bottom: if y < rows.pos().len() - 1 { 0.4pt + rule } else { none },
      ),
      align: (left + top, left + top),
      inset: (x: 8pt, y: 8pt),
      ..rows.pos().flatten()
    )
  ]
}

// ─── Modul-rubrik med eyebrow och lead ────────────────────────────
/// Kapitelinledning med modulnummer (eyebrow), titel och ingress (lead).
/// Anropa i stället för en rak H1-rubrik.
/// Exempel: #module-heading("Modul 1", "LED & krets", "...")
#let module-heading(eyebrow, title, lead) = [
  #heading(level: 1, supplement: eyebrow)[#title]

  #block(above: -0.4em, below: 1.2em)[
    #set text(
      font: sans-font,
      size: 12.5pt,
      style: "italic",
      fill: muted,
    )
    #set par(leading: 0.75em)
    #lead
  ]
]

// ─── Formelbox ────────────────────────────────────────────────────
/// Centrerad formel- eller uttrycksbox.
/// Används för matematiska uttryck (Ohms lag etc) och viktiga formler.
#let formula(body) = {
  block(
    width: 100%,
    above: 1.4em,
    below: 1.4em,
  )[
    #align(center)[
      #block(
        fill: soft-bg,
        stroke: 0.5pt + rule,
        inset: (x: 18pt, y: 12pt),
        radius: 4pt,
      )[
        #set text(font: mono-font, size: 11.5pt, features: mono-features)
        #body
      ]
    ]
  ]
}

// ─── Avsnittsmärke ────────────────────────────────────────────────
/// Tunn horisontell linje som visuell avdelare inom ett avsnitt.
#let section-rule = {
  v(1em)
  line(length: 100%, stroke: 0.4pt + rule)
  v(1em)
}

// ─── Figurer ──────────────────────────────────────────────────────
/// Enkel figur med valfri caption. width är relativ till textbredd.
/// Figurnummer undertrycks — referensmaterial behöver inte numrering.
#let fig(path, caption: none, width: 70%) = {
  figure(
    image(path, width: width),
    caption: if caption != none { caption } else { [] },
    supplement: none,
    numbering: none,
    gap: 10pt,
  )
}

/// Två figurer sida vid sida med separata bildtexter.
/// Använd för komponentbilder, schema/breadboard-par etc.
#let fig-row(path1, path2, cap1: none, cap2: none) = {
  block(above: 1.4em, below: 1.4em)[
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 16pt,
      [#fig(path1, caption: cap1, width: 100%)],
      [#fig(path2, caption: cap2, width: 100%)],
    )
  ]
}
