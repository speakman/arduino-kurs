// A11y-spot-checks + visuell verifiering
import { test, expect } from "@playwright/test";

test("alla img-tags har alt-attribut", async ({ page }) => {
  for (const p of ["/", "dag/1.html", "dag/3.html", "dag/4.html", "resurser.html"]) {
    await page.goto(p);
    const imgs = page.locator("img");
    const count = await imgs.count();
    for (let i = 0; i < count; i++) {
      const alt = await imgs.nth(i).getAttribute("alt");
      expect(alt, `${p} img #${i} saknar alt`).not.toBeNull();
    }
  }
});

test("heading-order är monotont stigande på alla sidor", async ({ page }) => {
  for (const p of ["/", "dag/1.html", "dag/3.html", "nedladdningar.html", "resurser.html"]) {
    await page.goto(p);
    const levels = await page.evaluate(() => {
      const headings = Array.from(document.querySelectorAll("h1,h2,h3,h4,h5,h6"));
      return headings.map(h => parseInt(h.tagName.slice(1), 10));
    });

    let prev = 0;
    for (const lvl of levels) {
      // Tillåt att hoppa NER eller gå upp ett steg åt gången
      if (lvl > prev) {
        expect(lvl - prev, `${p} heading-hopp h${prev}→h${lvl}`).toBeLessThanOrEqual(1);
      }
      prev = lvl;
    }
  }
});

test("nedladdningar-tabeller har scope='col' på alla <th>", async ({ page }) => {
  await page.goto("nedladdningar.html");
  const ths = page.locator("table.dl thead th");
  const count = await ths.count();
  for (let i = 0; i < count; i++) {
    await expect(ths.nth(i)).toHaveAttribute("scope", "col");
  }
});

test("WCAG-färgkontrast — accent-färg på vit bg", async ({ page }) => {
  await page.goto("");
  // Verifiera att --ak-accent används för länkar
  const color = await page.evaluate(() => {
    const a = document.querySelector(".btn");
    return getComputedStyle(a).backgroundColor;
  });
  // #00747d = rgb(0, 116, 125)
  expect(color).toBe("rgb(0, 116, 125)");
});

test("kod-block får hljs-class efter att highlight.js körts", async ({ page }) => {
  await page.goto("dag/1.html", { waitUntil: "networkidle" });
  await page.waitForFunction(
    () => document.querySelectorAll('pre code.hljs [class^="hljs-"]').length > 0,
    { timeout: 15000 }
  );

  const codeWithHljsClass = page.locator('pre code.language-cpp').first();
  await expect(codeWithHljsClass).toHaveClass(/hljs/);

  // Verifiera att någon syntax-token har faktisk färgning
  const tokenColor = await page.evaluate(() => {
    const tk = document.querySelector('pre code.hljs [class^="hljs-"]');
    return tk ? getComputedStyle(tk).color : null;
  });
  expect(tokenColor).not.toBeNull();
  expect(tokenColor).not.toBe("rgb(0, 0, 0)");
});
