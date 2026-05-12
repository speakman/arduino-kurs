// Verifiera de 3 Critical-fixarna från multi-auditor + 8 Important
import { test, expect } from "@playwright/test";

test("CRITICAL 1: nedladdningar.html har 4 korrekta <thead>-element (inte malformaterat)", async ({ page }) => {
  await page.goto("nedladdningar.html");
  const theadCount = await page.locator("table.dl > thead").count();
  expect(theadCount).toBe(4);

  // Var och en ska ha minst en <tr> direkt under
  for (let i = 0; i < 4; i++) {
    const trUnderThead = page.locator("table.dl > thead").nth(i).locator("> tr");
    await expect(trUnderThead).toHaveCount(1);
  }

  // Verifiera att HTML inte innehåller den korrupterade strängen
  const html = await page.content();
  expect(html).not.toContain('scope="col"ead');
});

test("CRITICAL 2: dag/1.html bilaga-F-länken pekar på existerande PDF", async ({ page }) => {
  await page.goto("dag/1.html");
  const link = page.locator('a[href*="bilag"]').filter({ hasText: "Bilaga F" });
  await expect(link).toHaveAttribute("href", /bilagor-a-f\.pdf$/);

  // Verifiera att länkmålet faktiskt finns (HEAD-request via fetch)
  const href = await link.getAttribute("href");
  const url = new URL(href, page.url()).href;
  const head = await page.request.head(url);
  expect(head.status()).toBe(200);
  expect(head.headers()["content-type"]).toContain("application/pdf");
});

test("CRITICAL 3: dag/4.html tilt-sensor prose stämmer med .ino-koden", async ({ page }) => {
  await page.goto("dag/4.html");

  // Långa prosaversionen
  const longProse = page.locator("p.intro").filter({ hasText: /Tilt-sensorn är digital/ });
  await expect(longProse).toContainText(/Står sensorn upprätt/);
  await expect(longProse).toContainText(/HIGH/);
  await expect(longProse).not.toContainText(/sluter kretsen.*LOW/);

  // Skill-card (kort sammanfattning)
  const skillCard = page.locator(".skill").filter({ hasText: "Tilt-sensorn" });
  await expect(skillCard).toContainText(/Upprätt.*HIGH/);
  await expect(skillCard).toContainText(/Lutad.*LOW/);
});

test("IMPORTANT: nedladdningar PDF-länkar har download-attribut", async ({ page }) => {
  await page.goto("nedladdningar.html");
  const pdfLinks = page.locator('a[href$=".pdf"]');
  const count = await pdfLinks.count();
  expect(count).toBeGreaterThan(10);

  // Alla PDF-länkar i .dl-tabellerna SKA ha download
  const dlLinks = page.locator('table.dl a[href$=".pdf"]');
  const dlCount = await dlLinks.count();
  for (let i = 0; i < dlCount; i++) {
    await expect(dlLinks.nth(i)).toHaveAttribute("download", "");
  }
});

test("IMPORTANT: nav-länken 'Träffarna' har inte class=active på dag-sidor (var missvisande)", async ({ page }) => {
  for (const p of ["dag/1.html", "dag/3.html", "dag/5.html"]) {
    await page.goto(p);
    const navLink = page.locator(".site-nav nav a").filter({ hasText: "Träffarna" });
    const classes = (await navLink.getAttribute("class")) ?? "";
    expect(classes, `${p}: Träffarna ska inte vara active`).not.toMatch(/\bactive\b/);
  }
});

test("IMPORTANT: hljs.highlightAll() guard funkar (script kastar inte)", async ({ page }) => {
  const errors = [];
  page.on("pageerror", e => errors.push(e.message));
  await page.goto("dag/1.html", { waitUntil: "networkidle" });
  // hljs är async-loadad via CDN — vänta tills den faktiskt processed koden
  // (v11 använder .hljs-type, .hljs-built_in, .hljs-title m.fl. — kolla generiskt)
  await page.waitForFunction(
    () => document.querySelectorAll('pre code.hljs [class^="hljs-"]').length > 0,
    { timeout: 15000 }
  );
  const anyHljsToken = page.locator('pre code.hljs [class^="hljs-"]');
  await expect(anyHljsToken.first()).toBeVisible();
  expect(errors).toEqual([]);
});

test("IMPORTANT: footer har <h3>, inte <h4> (heading-order)", async ({ page }) => {
  await page.goto("");
  const footerH3 = page.locator("footer.site-footer h3");
  await expect(footerH3).toHaveCount(3); // Om kursen, Material, Resurser
  const footerH4 = page.locator("footer.site-footer h4");
  await expect(footerH4).toHaveCount(0);
});

test("IMPORTANT: favicon.svg och favicon.ico svarar 200", async ({ page }) => {
  const svg = await page.request.head("favicon.svg");
  expect(svg.status()).toBe(200);
  expect(svg.headers()["content-type"]).toMatch(/svg/);

  const ico = await page.request.head("favicon.ico");
  expect(ico.status()).toBe(200);
  expect(ico.headers()["content-type"]).toMatch(/icon|x-icon|image/);
});

test("IMPORTANT: refresh-kontrakt-dokumentation finns publicerad", async ({ page }) => {
  const refresh = await page.request.head("REFRESH.md");
  expect(refresh.status()).toBe(200);
});
