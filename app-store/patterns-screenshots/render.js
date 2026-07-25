const fs = require("fs");
const path = require("path");
const puppeteer = require("../../content/node_modules/puppeteer");

const root = __dirname;
const chrome = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";

const shots = [
  "01-when-ocd-feels-urgent",
  "02-delay-the-urge",
  "03-build-your-exposure-ladder",
  "04-see-patterns-not-judgments",
  "05-private-journaling",
  "06-private-by-design",
  "07-patterns-pro",
];

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
  await page.evaluate(async () => document.fonts.ready);

  for (let i = 0; i < shots.length; i += 1) {
    const element = await page.$(`#shot-${i + 1}`);
    if (!element) throw new Error(`Missing #shot-${i + 1}`);
    await element.screenshot({
      path: path.join(target.directory, `${shots[i]}.png`),
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
