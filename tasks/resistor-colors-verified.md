# Resistor Color Codes — Verified from Elegoo UNO Basic Starter Kit Manual

Source image: `elegoo-040-057.png` (upscaled 4× for readability)

---

## Color-to-Digit Legend (confirmed matches standard)

| Color  | Digit |
|--------|-------|
| Black  | 0     |
| Brown  | 1     |
| Red    | 2     |
| Orange | 3     |
| Yellow | 4     |
| Green  | 5     |
| Blue   | 6     |
| Violet | 7     |
| Gray   | 8     |
| White  | 9     |

**Multiplier column shown:**
- Black = ×1
- Brown = ×10
- Red = ×100
- Orange = ×1000
- Yellow = ×10000
- Green = ×100000
- Blue = ×1000000
- Gold = ×0.1
- Silver = ×0.01

**Tolerance:**
- Brown = 1% (5-band)
- Red = 2% (5-band)
- Gold = ±5% (4-band)
- Silver = ±10% (4-band)

---

## Chart Examples (as drawn in the Elegoo manual)

### 4-Band CODE example: **47 kΩ ±5%**
- Band 1: Yellow (4)
- Band 2: Violet (7)
- Band 3: Orange (×1000 multiplier)
- Band 4: Gold (±5% tolerance)

### 5-Band CODE example: **51 kΩ ±1%**
- Band 1: Green (5)
- Band 2: Brown (1)
- Band 3: Black (0)
- Band 4: Red (×100 multiplier)
- Band 5: Brown (±1% tolerance)

---

## Derived Values (not explicitly shown as examples in the chart — calculated from the legend)

### 220 Ω

**4-band:**
- Band 1: Red (2)
- Band 2: Red (2)
- Band 3: Brown (×10 multiplier) → 22 × 10 = 220
- Band 4: Gold (±5% tolerance)

**5-band:**
- Band 1: Red (2)
- Band 2: Red (2)
- Band 3: Black (0)
- Band 4: Black (×1 multiplier) → 220 × 1 = 220
- Band 5: Brown (±1% tolerance)

### 1 kΩ (1000 Ω)

**4-band:**
- Band 1: Brown (1)
- Band 2: Black (0)
- Band 3: Red (×100 multiplier) → 10 × 100 = 1000
- Band 4: Gold (±5% tolerance)

**5-band:**
- Band 1: Brown (1)
- Band 2: Black (0)
- Band 3: Black (0)
- Band 4: Brown (×10 multiplier) → 100 × 10 = 1000
- Band 5: Brown (±1% tolerance)

### 10 kΩ (10000 Ω)

**4-band:**
- Band 1: Brown (1)
- Band 2: Black (0)
- Band 3: Orange (×1000 multiplier) → 10 × 1000 = 10000
- Band 4: Gold (±5% tolerance)

**5-band:**
- Band 1: Brown (1)
- Band 2: Black (0)
- Band 3: Black (0)
- Band 4: Red (×100 multiplier) → 100 × 100 = 10000
- Band 5: Brown (±1% tolerance)

---

## Notes / Ambiguities

1. **The chart does NOT show 220Ω, 1kΩ, or 10kΩ as explicit drawn examples.** The only examples drawn are 47kΩ (4-band) and 51kΩ (5-band). The values above are derived from the legend.

2. **The 5-band multiplier column shown in the chart goes up to ×1000000 (Blue).** The chart confirms Gold (×0.1) and Silver (×0.01) at the bottom of the multiplier list.

3. **Multiplier values shown in the chart:** 1, 10, 100, 1000, 10000, 100000, 1000000, 0.1 (GOLD), 0.01 (SILVER) — this is 9 entries mapping to Black through White plus Gold and Silver.

4. **The color mapping is standard IEC/EIA** — Elegoo's chart matches universally accepted conventions exactly.

5. **Physical resistors in the Elegoo kit** are typically 4-band with gold tolerance. The 220Ω included in the kit will be: Red-Red-Brown-Gold.
