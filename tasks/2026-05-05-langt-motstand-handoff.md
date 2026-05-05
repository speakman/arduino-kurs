# Handoff: Långt motstånd-pedagogik för Modul 4 (live idag)

## Status just nu

Föregående session avslutade en stor AI-bildregen-runda — alla deck-bilder bytta till Nano Banana 2-versioner, alla per-dag-PDF:er regenererade. Allt committat fram till `e8c965b`.

**Nästa task**: Användaren vill OMEDELBART diskutera + eventuellt implementera en ny pedagogisk byggsten — kanske för att fälla in i **dagens session (Modul 4 — analogRead/spänningsdelare)** som är live.

## Vad ska göras

Diskutera med användaren VAR och HUR vi infogar en pedagogisk brygga:
**"Lååångt motstånd"-metafor + vridpotentiometer-demo** som inkörsport till spänningsdelaren.

Fullständig idébeskrivning i `tasks/todo.md` under "Pending TODO" — börja där.

## Pedagogiken i fyra rader

1. Ett lååångt motstånd har spänning som sjunker linjärt (5 V → 0 V längs materialet)
2. Vid mitten = 2,5 V (halva motståndet har "ätit upp" halva spänningen)
3. Två lika motstånd i serie = samma sak, bara uppdelat i två (varje resistor äter halv spänning)
4. **Potentiometer = lååångt motstånd med glidande mätpunkt** — perfekt fysisk demo. Spänningsdelare med fotocell = samma princip men där fotocellen flyttar mätpunkten automatiskt med ljus.

## Constraint

Användaren övervägde att **fälla in detta i dagens Modul 4-session**. Det betyder:
- Begränsat tidsfönster
- Ändringen får inte rubba för mycket av befintlig flow
- Lightweight implementation — kanske 1-2 slides + 1 hands-on demo, inte en hel ny modul

## Kandidatplaceringar (ej beslutat)

1. **Slutet av Modul 1** (efter Ohms lag, slide 8) — som långsiktig brygga
2. **Före spänningsdelaren i Modul 4** (insättning mellan slide 40 och 41) — direkt anslutning
3. **Bilaga F** (Ohms lag + framspänning) — fördjupande, läses post-pass
4. **Inom slide 41 (Spänningsdelaren)** som intro-build — visuell sequence

För dagens-session-scenariot: alternativ 2 är troligast.

## Tillgängliga resurser

- **ELEGOO Basic Kit innehåller en 10 kΩ vridpotentiometer.** Medvetet utanför ordinarie kursinnehåll (per Bilaga C), men finns. Kan användas för EN demo idag.
- Bilaga C noterar potentiometern som "ej i kursen" — kan ändras om vi tar in den.

## Filer att läsa först

| Fil | Varför |
|-----|--------|
| `tasks/todo.md` (sista sektionen) | Fullständig idé + action items |
| `presentation/slides.md` rader ~390-430 (slide 8 Ohms lag) | Var Ohms lag introduceras |
| `presentation/slides.md` rader ~2020-2270 (Modul 4 + slide 41) | Spänningsdelar-sektionen |
| `kompendium/04-modul-4.typ` rader 50-100 (Spänningsdelaren) | Brödtext om spänningsdelaren |
| `kompendium/appendix-f-framspanningsfall.typ` rader 169-237 | Fördjupad spänningsdelar-matte |
| `kompendium/appendix-c-komponenter.typ` (sök "potentiometer") | Nuvarande potentiometer-status |
| `CLAUDE.md` | Projekt-konventioner (atomic commits, NB2 default, etc.) |

## Föreslagen approach för ny session

1. **Läs handoff + todo.md** (~5 min)
2. **Skum av kandidatslides** (Modul 1 + Modul 4 + Bilaga F) — ~10 min
3. **Diskutera med användaren**:
   - Bara metafor (no demo) eller demo med faktisk pot?
   - Slide-only? Slide + brödtext? Slide + brödtext + demo-protokoll?
   - En ny slide eller infällning i existerande?
4. **Skissa förslag** + få godkännande
5. **Implementera** (atomic commits per logisk enhet)
6. **Build + render slide(s) + ev. per-dag-PDF**

## Tidsbudget-estimering

- Diskussion + skiss: 10-15 min
- Implementation (1 ny slide + ev. brödtextstycke): 15-20 min
- Build + render: 5 min
- **Total: ~30-40 min** för ett lightweight tillägg

Om demo: lägg till 5 min för demo-protokoll i talarnotiser.

## Sista commit

```
e8c965b docs(todo): pending pedagogik — långt motstånd + potentiometer som brygga till spänningsdelaren
```

Inga uncommitted changes. Working tree clean.
