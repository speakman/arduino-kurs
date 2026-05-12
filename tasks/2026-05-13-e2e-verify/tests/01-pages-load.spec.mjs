// Verifiera att alla nyckelsidor laddar utan konsolfel + har rätt title
import { test, expect } from "@playwright/test";

const pages = [
  { path: "",                   title: /Arduino/,        h1: /Allt du behöver/ },
  { path: "dag/1.html",         title: /Träff 1/,        h1: /LED & krets/ },
  { path: "dag/2.html",         title: /Träff 2/,        h1: /PWM & RGB/ },
  { path: "dag/3.html",         title: /Träff 3/,        h1: /Digital input/ },
  { path: "dag/4.html",         title: /Träff 4/,        h1: /Analog input/ },
  { path: "dag/5.html",         title: /Träff 5/,        h1: /Hackathon/ },
  { path: "nedladdningar.html", title: /Nedladdningar/,  h1: /Nedladdningar/ },
  { path: "resurser.html",      title: /Resurser/,       h1: /Resurser/ },
];

for (const p of pages) {
  test(`page loads ${p.path}`, async ({ page }) => {
    const errors = [];
    page.on("pageerror", e => errors.push(`pageerror: ${e.message}`));
    page.on("console", msg => {
      if (msg.type() === "error") errors.push(`console.error: ${msg.text()}`);
    });

    const response = await page.goto(p.path);
    expect(response.status(), `${p.path} HTTP-status`).toBe(200);
    await expect(page).toHaveTitle(p.title);
    await expect(page.locator("h1")).toContainText(p.h1);
    expect(errors, `${p.path} konsol-fel`).toEqual([]);
  });
}

test("404 returns custom error page", async ({ page }) => {
  const response = await page.goto("does-not-exist", { waitUntil: "networkidle" });
  expect(response.status()).toBe(404);
  await expect(page.locator(".err-hero .code")).toContainText("404");
});
