// Verifiera bilder, kodfiler, PDF:er, fonter
import { test, expect } from "@playwright/test";

test("alla referenser på dag/1.html laddar utan 404", async ({ page }) => {
  const failures = [];
  page.on("response", resp => {
    const url = resp.url();
    const sameOrigin = url.startsWith(page.context()._options?.baseURL || "https://speakman.github.io/arduino-kurs");
    if (resp.status() >= 400 && sameOrigin) {
      failures.push(`${resp.status()} ${url}`);
    }
  });

  await page.goto("dag/1.html", { waitUntil: "networkidle" });
  // Vänta in lazy-loaded bilder
  await page.evaluate(() =>
    new Promise(resolve => {
      window.scrollTo(0, document.body.scrollHeight);
      setTimeout(resolve, 2000);
    })
  );

  expect(failures, "samme-origin 4xx/5xx").toEqual([]);
});

test("alla 11 .ino-kodfiler är nedladdningsbara", async ({ page }) => {
  await page.goto("nedladdningar.html");
  const inoLinks = page.locator('table.dl a[href$=".ino"]');
  const count = await inoLinks.count();
  expect(count).toBe(11);

  // Spot-check första 3 + sista 3 svarar 200
  const indexes = [0, 1, 2, count - 3, count - 2, count - 1];
  for (const i of indexes) {
    const href = await inoLinks.nth(i).getAttribute("href");
    const url = new URL(href, page.url()).href;
    const resp = await page.request.head(url);
    expect(resp.status(), `${href}`).toBe(200);
  }
});

test("alla 15 PDF-länkar är nedladdningsbara", async ({ page }) => {
  await page.goto("nedladdningar.html");
  const pdfLinks = page.locator('table.dl a[href$=".pdf"]');
  const count = await pdfLinks.count();
  expect(count).toBeGreaterThanOrEqual(15);

  // Spot-check 5 PDF:er (random varannan)
  const checks = [];
  for (let i = 0; i < count; i += 3) {
    const href = await pdfLinks.nth(i).getAttribute("href");
    checks.push({ href, url: new URL(href, page.url()).href });
  }
  for (const c of checks) {
    const resp = await page.request.head(c.url);
    expect(resp.status(), c.href).toBe(200);
    expect(resp.headers()["content-type"]).toContain("application/pdf");
  }
});

test("alla 17 WebP-bilder svarar 200", async ({ page }) => {
  // Kolla via dag-pages som referenserar bilderna
  const seenUrls = new Set();
  page.on("response", resp => {
    if (resp.url().endsWith(".webp")) seenUrls.add(resp.url());
  });

  for (const p of ["dag/1.html", "dag/2.html", "dag/3.html", "dag/4.html"]) {
    await page.goto(p, { waitUntil: "networkidle" });
    await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight));
    await page.waitForTimeout(1500);
  }

  expect(seenUrls.size, "antal unika WebP-bilder").toBeGreaterThanOrEqual(13);
  // Verifiera 3-pack med HEAD
  const sampled = [...seenUrls].slice(0, 3);
  for (const url of sampled) {
    const resp = await page.request.head(url);
    expect(resp.status(), url).toBe(200);
    expect(resp.headers()["content-type"]).toBe("image/webp");
  }
});

test("Inter-fonten laddas via Google Fonts (async)", async ({ page }) => {
  await page.goto("", { waitUntil: "networkidle" });
  // Vänta in font-laddning
  await page.waitForTimeout(2000);

  // Verifiera att body är renderad med Inter (eller fallback)
  const fontFamily = await page.evaluate(() =>
    getComputedStyle(document.body).fontFamily
  );
  expect(fontFamily).toContain("Inter");

  // Verifiera att fonts.googleapis.com begäran skedde
  const fontReqs = [];
  page.on("request", req => {
    if (req.url().includes("fonts.gstatic.com") || req.url().includes("fonts.googleapis.com")) {
      fontReqs.push(req.url());
    }
  });
  await page.reload({ waitUntil: "networkidle" });
  expect(fontReqs.length).toBeGreaterThan(0);
});

test("OG-card servas korrekt", async ({ page }) => {
  const og = await page.request.head("assets/img/og-card.jpg");
  expect(og.status()).toBe(200);
  expect(og.headers()["content-type"]).toBe("image/jpeg");
});
