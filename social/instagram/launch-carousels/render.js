const fs = require("fs");
const path = require("path");
const puppeteer = require("../../../content/node_modules/puppeteer");

const baseDir = __dirname;
const counts = { 1: 5, 2: 6, 3: 5, 4: 6, 5: 6 };
const folders = {
  1: "post-01-meet-patterns",
  2: "post-02-daily-loop",
  3: "post-03-designed-for-privacy",
  4: "post-04-nf-ocd-story",
  5: "post-05-howie-mandel-ocd-story",
};

(async () => {
  const browser = await puppeteer.launch({
    headless: true,
    executablePath: "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
  });
  const page = await browser.newPage();
  await page.setViewport({ width: 1080, height: 1350, deviceScaleFactor: 1 });

  for (const [post, count] of Object.entries(counts)) {
    const outDir = path.join(baseDir, "output", folders[post]);
    fs.mkdirSync(outDir, { recursive: true });

    for (let slide = 1; slide <= count; slide += 1) {
      const url = `file://${path.join(baseDir, "index.html")}?post=${post}&slide=${slide}`;
      await page.goto(url, { waitUntil: "networkidle0" });
      await page.evaluate(() => document.fonts.ready);
      const out = path.join(outDir, `${String(slide).padStart(2, "0")}.png`);
      await page.screenshot({ path: out, type: "png" });
      console.log(path.relative(baseDir, out));
    }
  }

  await browser.close();
})();
