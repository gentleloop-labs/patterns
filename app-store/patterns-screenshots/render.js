const fs = require("fs");
const path = require("path");
const puppeteer = require("../../content/node_modules/puppeteer");

const root = __dirname;
const chrome = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";

const shots = [
  { selector: "#shot-1", name: "01-calm-today" },
  { selector: "#shot-2", name: "02-delay-the-urge" },
  { selector: "#shot-4", name: "03-build-your-exposure-ladder" },
  { selector: "#shot-6", name: "04-see-patterns-not-judgments" },
  { selector: "#shot-3", name: "05-no-ai-to-ask" },
  { selector: "#shot-5", name: "06-nothing-leaves-your-phone" },
  { selector: "#shot-7", name: "07-private-journaling" },
  { selector: "#shot-8", name: "08-patterns-pro" },
];

// The Apple layout is authored and exported at APP_IPHONE_69 (1290x2796).
// Do not create redundant 6.5-inch variants for the 1.10 campaign.
const appleDesign = { width: 1290, height: 2796 };

const targets = [
  {
    mode: "apple",
    width: 1290,
    height: 2796,
    directory: path.join(root, "exports", "app-store-1290x2796"),
  },
  {
    mode: "play",
    width: 1080,
    height: 1920,
    directory: path.join(root, "exports", "play-store-1080x1920"),
  },
];

async function renderScreenshots(browser, target) {
  fs.mkdirSync(target.directory, { recursive: true });
  const page = await browser.newPage();
  await page.setViewport({
    width: target.width,
    height: target.height,
    deviceScaleFactor: 1,
  });
  await page.goto(`file://${path.join(root, "index.html")}?mode=${target.mode}`, {
    waitUntil: "networkidle0",
  });
  if (target.mode === "apple") {
    const zoom = target.width / appleDesign.width;
    await page.evaluate((values) => {
      document.documentElement.style.setProperty("--shot-zoom", values.zoom);
      document.documentElement.style.setProperty("--shot-h-design", `${values.shotHeight}px`);
    }, { zoom, shotHeight: Math.round(target.height / zoom) });
  }
  await page.evaluate(async () => document.fonts.ready);

  for (const shot of shots) {
    const element = await page.$(shot.selector);
    if (!element) throw new Error(`Missing ${shot.selector}`);
    const box = await element.boundingBox();
    // Clip to the exact store size: zoom rounding can leave a stray pixel.
    await page.screenshot({
      path: path.join(target.directory, `${shot.name}.png`),
      clip: {
        x: Math.round(box.x),
        y: Math.round(box.y),
        width: target.width,
        height: target.height,
      },
      captureBeyondViewport: true,
      omitBackground: false,
    });
  }
  await page.close();
}

async function renderFeatureGraphic(browser) {
  const directory = path.join(root, "exports", "play-store-feature");
  fs.mkdirSync(directory, { recursive: true });
  const page = await browser.newPage();
  await page.setViewport({ width: 1024, height: 500, deviceScaleFactor: 1 });
  await page.goto(`file://${path.join(root, "index.html")}?mode=feature`, {
    waitUntil: "networkidle0",
  });
  await page.evaluate(async () => document.fonts.ready);
  const feature = await page.$("#feature-graphic");
  if (!feature) throw new Error("Missing #feature-graphic");
  await feature.screenshot({
    path: path.join(directory, "patterns-feature-graphic-1024x500.png"),
    omitBackground: false,
  });
  await page.close();
}

async function renderContactSheet(browser) {
  const page = await browser.newPage();
  await page.setViewport({ width: 2100, height: 1200, deviceScaleFactor: 1 });
  await page.goto(`file://${path.join(root, "contact-sheet.html")}`, {
    waitUntil: "networkidle0",
  });
  await page.screenshot({
    path: path.join(root, "exports", "contact-sheet.png"),
    fullPage: true,
    omitBackground: false,
  });
  await page.close();
}

(async () => {
  const browser = await puppeteer.launch({
    headless: "new",
    executablePath: chrome,
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });
  for (const target of targets) {
    await renderScreenshots(browser, target);
  }
  await renderFeatureGraphic(browser);
  await renderContactSheet(browser);
  await browser.close();
  console.log(`Exported ${shots.length} Apple screenshots, ${shots.length} Play screenshots, and one Play feature graphic.`);
})();
