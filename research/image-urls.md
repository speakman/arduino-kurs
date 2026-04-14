# Arduino Course Presentation — Image URL Research

All URLs below were verified via `curl -sI` / `curl -sI` and return `HTTP 200 image/*`.
Ranked best → worst per image. Resolution checked with `file` where downloaded.

## Image 1 — Active buzzer with "REMOVE SEAL AFTER WASHING" sticker

| Rank | Direct URL | Description | Resolution | Source page |
|------|------------|-------------|------------|-------------|
| 1 | https://www.goeszen.com/wp-content/uploads/2017/07/active_vs_passive_buzzer.jpg | Side-by-side photo of active (with white "REMOVE SEAL AFTER WASHING" sticker clearly legible) and passive buzzer on white background | 700 x 660 (95 KB) | https://design.goeszen.com/active-vs-passive-buzzer.html |
| 2 | https://startingelectronics.org/tutorials/arduino/modules/active-buzzer/geekcreit-active-buzzer.jpg | Geekcreit active buzzer shown with sticker on left, sticker removed on right (great didactic shot) | ~32 KB | https://startingelectronics.org/tutorials/arduino/modules/active-buzzer/ |
| 3 | https://www.surve.co.in/wp-content/uploads/active-buzzer-module.jpg | Active buzzer module photo, sticker visible on top of black cylinder | 394 x 336 (29 KB) | https://www.surve.co.in/difference-between-active-buzzer-and-passive-buzzer/ |

## Image 2 — SW-520D cylindrical tilt ball switch

All from the same OSOYOO product listing (same kit's exact part). Bare component, isolated on white. 1000x1000 each.

| Rank | Direct URL | Description | Size |
|------|------------|-------------|------|
| 1 | https://osoyoo.store/cdn/shop/files/LACC200608_3.jpg | Cylindrical metal SW-520D tilt switch, straight angle, two pins visible | 1000x1000 (~62 KB) |
| 2 | https://osoyoo.store/cdn/shop/files/LACC200608_4.jpg | Same part, alternate angle | 1000x1000 (~65 KB) |
| 3 | https://osoyoo.store/cdn/shop/files/LACC200608_5.jpg | Same part, close-up | 1000x1000 (~68 KB) |
| 4 | https://osoyoo.store/cdn/shop/files/LACC200608_6.jpg | Multiple pieces | 1000x1000 (~58 KB) |
| 5 | https://osoyoo.store/cdn/shop/files/LACC200608_7.jpg | Packaging shot | 1000x1000 (~47 KB) |

Source page: https://osoyoo.store/products/sw-520d-basic-tilt-switch

## Image 3 — Atmospheric Arduino hero background

Harrison Broadbent on Unsplash is the well-known dark/moody Arduino photographer. URLs below are the real image CDN URLs (extracted from `og:image` of the photo pages, then cleaned to use direct image CDN with `?w=2400&q=90&fm=jpg`). Swap `w=2400` for `w=3840` if you want 4K.

| Rank | Direct URL | Description | Res (w=2400) | Source |
|------|------------|-------------|--------------|--------|
| 1 | https://images.unsplash.com/photo-1562976540-78c559c80296?w=2400&q=90&fm=jpg | Harrison Broadbent — "Blue and black circuit board / Arduino Uno & electronic chip", dark background, cinematic | 2400 x ~1600 (408 KB) | https://unsplash.com/photos/blue-and-black-circuit-board-WL_st8FVyEc |
| 2 | https://images.unsplash.com/photo-1586920740099-f3ceb65bc51e?w=2400&q=90&fm=jpg | Harrison Broadbent — Arduino Uno close-up, motherboard, dark/moody | 2400 x 1351 (240 KB) | https://unsplash.com/photos/blue-and-black-circuit-board-f2S93diaVn0 |
| 3 | https://images.unsplash.com/photo-1586920740142-346aea2a2124?w=2400&q=90&fm=jpg | Harrison Broadbent — Green/black Arduino Uno, motherboard shot | 2400 x ~1600 (364 KB) | https://unsplash.com/photos/green-and-black-circuit-board-VOz0gV9HC0I |
| 4 | https://images.unsplash.com/photo-1621136429581-bf0890d5ac22?w=2400&q=90&fm=jpg | Nekhil R — Arduino Uno, blue/black | 2400 px (1.3 MB) | https://unsplash.com/photos/blue-and-black-circuit-board-hz7EFrw06Qk |
| 5 | https://images.unsplash.com/photo-1603732551658-5fabbafa84eb?w=2400&q=90&fm=jpg | Sahand Babali — Arduino Uno with electronic parts on a blue surface | 2400 px (416 KB) | https://unsplash.com/photos/blue-and-black-circuit-board-gavODTHG36Y |
| 6 | https://images.unsplash.com/photo-1562976540-1502c2145186?w=2400&q=90&fm=jpg | Harrison Broadbent — 2 RAM module circuit boards, dark | 2400 px (551 KB) | https://unsplash.com/photos/green-circuit-board-close-up-photography-ING1Uf1Fc30 |

Tip: Unsplash `images.unsplash.com` CDN accepts query params; try e.g. `?w=3840&q=85&fm=jpg&auto=format` for 4K, or add `&fit=crop&h=1080` for exact 16:9 crops.

## Verification notes

- Image 1 rank 1 downloaded (700x660 JPEG, confirmed shows the sticker).
- Image 2 rank 1 downloaded (1000x1000 JPEG).
- Image 3 rank 2 downloaded (2400x1351 JPEG). Other Unsplash entries verified via `curl -I` only (200 OK + content-length).
- Pexels/Unsplash HTML search pages block WebFetch (403) and bot-check curl; I extracted photo slugs via DuckDuckGo HTML mirror and pulled direct CDN URLs from each photo page's `og:image` meta tag.
