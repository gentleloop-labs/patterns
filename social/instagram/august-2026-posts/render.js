const fs = require("fs");
const path = require("path");
const puppeteer = require("../../../content/node_modules/puppeteer");

const baseDir = __dirname;
const outputDir = path.join(baseDir, "output");
const source = fs.readFileSync(path.join(baseDir, "posts.js"), "utf8");
const counts = [...source.matchAll(/id: "([^"]+)"[\s\S]*?slides: \[([\s\S]*?)\n    \]/g)]
  .map((match) => ({
    id: match[1],
    count: [...match[2].matchAll(/\{ label:/g)].length,
  }));

(async () => {
  fs.rmSync(outputDir, { recursive: true, force: true });
  fs.mkdirSync(outputDir, { recursive: true });

  const browser = await puppeteer.launch({
    headless: true,
    executablePath: "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
  });
  const page = await browser.newPage();
  await page.setViewport({ width: 1080, height: 1080, deviceScaleFactor: 1 });

  for (let index = 0; index < counts.length; index += 1) {
    const post = counts[index];
    const outDir = path.join(outputDir, `${String(index + 1).padStart(2, "0")}-${post.id}`);
    fs.mkdirSync(outDir, { recursive: true });

    for (let slide = 1; slide <= post.count; slide += 1) {
      const url = `file://${path.join(baseDir, "index.html")}?post=${index + 1}&slide=${slide}`;
      await page.goto(url, { waitUntil: "networkidle0" });
      await page.evaluate(() => document.fonts.ready);
      const out = path.join(outDir, `${String(slide).padStart(2, "0")}.png`);
      await page.screenshot({ path: out, type: "png" });
      console.log(path.relative(baseDir, out));
    }
  }

  await page.close().catch(() => {});
  const chrome = browser.process();
  if (chrome) chrome.kill("SIGTERM");
})();
