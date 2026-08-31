const fs = require("fs");
const path = require("path");
const puppeteer = require("../../../content/node_modules/puppeteer");

const baseDir = __dirname;
const outputDir = path.join(baseDir, "output");
const ids = [
  "01-reassurance-loop",
  "02-mental-compulsions",
  "03-erp-two-parts",
  "04-urgent-doubt",
  "05-recovery-progress",
];

(async () => {
  fs.mkdirSync(outputDir, { recursive: true });
  const browser = await puppeteer.launch({
    headless: true,
    executablePath: "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
  });

  for (let index = 0; index < ids.length; index += 1) {
    const page = await browser.newPage();
    await page.setViewport({ width: 1080, height: 1350, deviceScaleFactor: 1 });
    const url = `file://${path.join(baseDir, "index.html")}?post=${index + 1}`;
    await page.goto(url, { waitUntil: "networkidle0" });
    await page.evaluate(() => document.fonts.ready);
    await page.evaluate(() => window.scrollTo(0, 0));
    const outputPath = path.join(outputDir, `${ids[index]}.png`);
    await page.screenshot({
      path: outputPath,
      type: "png",
      clip: { x: 0, y: 0, width: 1080, height: 1350 },
    });
    console.log(path.relative(baseDir, outputPath));
    await page.close();
  }

  const chrome = browser.process();
  if (chrome) chrome.kill("SIGTERM");
})();
