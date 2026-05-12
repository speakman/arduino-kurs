import { defineConfig, devices } from "@playwright/test";

export default defineConfig({
  testDir: "./tests",
  fullyParallel: true,
  reporter: [["list"], ["json", { outputFile: "results.json" }]],
  use: {
    baseURL: "https://speakman.github.io/arduino-kurs/",
    trace: "retain-on-failure",
    screenshot: "only-on-failure",
  },
  projects: [
    { name: "desktop-chromium", use: { ...devices["Desktop Chrome"] } },
    {
      name: "mobile-chromium",
      use: {
        ...devices["Pixel 7"],   // Chromium-baserad → ingen WebKit-binary krävs
      },
    },
  ],
});
