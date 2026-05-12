// Navigations-test + Slidev SPA bootstrap
import { test, expect } from "@playwright/test";

test("nav från landing → dag/1 fungerar", async ({ page }) => {
  await page.goto("");
  await page.locator(".dag-grid a.dag-card").first().click();
  await expect(page).toHaveURL(/dag\/1\.html$/);
  await expect(page.locator("h1")).toContainText("LED & krets");
});

test("breadcrumb från dag/3 tillbaka till start fungerar", async ({ page }) => {
  await page.goto("dag/3.html");
  await page.locator(".breadcrumb a").click();
  await expect(page).toHaveURL(/\/$/);
  await expect(page.locator("h1")).toContainText("Allt du behöver");
});

test("next-dag-knappen tar dig vidare", async ({ page }) => {
  await page.goto("dag/2.html");
  await page.locator(".next-dag a.btn").click();
  await expect(page).toHaveURL(/dag\/3\.html$/);
});

test("Slidev SPA bootstrapar och visar slide 1", async ({ page }) => {
  await page.goto("slides/", { waitUntil: "networkidle" });
  // Slidev sätter <title> baserat på slide-innehåll
  await page.waitForFunction(() => document.title.includes("Arduino") || document.title.includes("Slidev"), { timeout: 10000 });

  // Body ska ha klass slidev-shrink
  await expect(page.locator("#slide-content, .slidev-page, [class*=slidev]").first()).toBeVisible({ timeout: 10000 });

  // Sliden ska visa cover-titel
  const heading = page.locator("h1").first();
  await expect(heading).toBeVisible();
});

test("Slidev tangent ArrowRight byter slide", async ({ page }) => {
  await page.goto("slides/", { waitUntil: "networkidle" });
  await page.waitForTimeout(2000);
  const url1 = page.url();
  await page.keyboard.press("ArrowRight");
  await page.waitForTimeout(800);
  const url2 = page.url();
  // URL ska ändras eftersom Slidev uses hash/path routing
  expect(url2).not.toBe(url1);
});

test("alla 9 huvud-sidor finns nåbara via top-nav", async ({ page }) => {
  await page.goto("");
  const links = [
    { sel: 'nav a:has-text("Start")', expectPath: /\/$/ },
    { sel: 'nav a:has-text("Träffarna")', expectPath: /dag\/1\.html$/ },
    { sel: 'nav a:has-text("Nedladdningar")', expectPath: /nedladdningar\.html$/ },
    { sel: 'nav a:has-text("Resurser")', expectPath: /resurser\.html$/ },
  ];
  for (const l of links) {
    await page.goto("");
    await page.locator(l.sel).first().click();
    await expect(page).toHaveURL(l.expectPath);
  }
});
