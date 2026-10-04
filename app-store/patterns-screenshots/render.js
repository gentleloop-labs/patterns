const fs = require("fs");
const path = require("path");
const puppeteer = require("../../content/node_modules/puppeteer");

const root = __dirname;
const chrome = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
const manifest = JSON.parse(
  fs.readFileSync(
    path.join(root, "../../release/1.10.0/screenshot-locale-manifest.json"),
    "utf8",
  ),
);
const uiCopy = JSON.parse(
  fs.readFileSync(
    path.join(root, "../../release/1.10.0/screenshot-ui-copy.json"),
    "utf8",
  ),
);
const shots = manifest.frames.map((frame) => ({
  selector: `#${frame.id}`,
  name: frame.file,
}));
const arbFiles = {
  en: "app_en.arb",
  "pt-BR": "app_pt_BR.arb",
  de: "app_de.arb",
  ja: "app_ja.arb",
  es: "app_es.arb",
  fr: "app_fr.arb",
};

function icuLeaves(message, prefix = "") {
  const value = message.trim();
  if (!value.startsWith("{") || !value.endsWith("}")) return {};
  const inner = value.slice(1, -1);
  const firstComma = inner.indexOf(",");
  const secondComma = inner.indexOf(",", firstComma + 1);
  if (firstComma < 0 || secondComma < 0) return {};
  const kind = inner.slice(firstComma + 1, secondComma).trim();
  if (kind !== "select" && kind !== "plural") return {};
  const leaves = {};
  let cursor = secondComma + 1;
  while (cursor < inner.length) {
    while (/\s/.test(inner[cursor] || "")) cursor += 1;
    const keyStart = cursor;
    while (cursor < inner.length && inner[cursor] !== "{") cursor += 1;
    if (cursor >= inner.length) break;
    const caseName = inner.slice(keyStart, cursor).trim();
    let depth = 1;
    const bodyStart = ++cursor;
    while (cursor < inner.length && depth > 0) {
      if (inner[cursor] === "{") depth += 1;
      if (inner[cursor] === "}") depth -= 1;
      cursor += 1;
    }
    const body = inner.slice(bodyStart, cursor - 1).trim();
    const pathKey = prefix ? `${prefix}.${caseName}` : caseName;
    const nested = icuLeaves(body, pathKey);
    if (Object.keys(nested).length) Object.assign(leaves, nested);
    else leaves[pathKey] = body;
  }
  return leaves;
}

function arbReplacements(language) {
  if (language === "en") return {};
  const readArb = (name) =>
    JSON.parse(fs.readFileSync(path.join(root, "../../lib/l10n", name), "utf8"));
  const english = readArb(arbFiles.en);
  const localized = readArb(arbFiles[language]);
  const replacements = {};
  for (const [key, source] of Object.entries(english)) {
    if (key.startsWith("@") || typeof source !== "string") continue;
    const target = localized[key];
    if (
      typeof target === "string" &&
      source !== target &&
      !source.includes("{") &&
      !target.includes("{")
    ) {
      replacements[source.trim()] = target.trim();
      continue;
    }
    if (typeof target === "string") {
      const sourceLeaves = icuLeaves(source);
      const targetLeaves = icuLeaves(target);
      for (const [casePath, sourceLeaf] of Object.entries(sourceLeaves)) {
        const targetLeaf = targetLeaves[casePath];
        if (
          targetLeaf &&
          sourceLeaf !== targetLeaf &&
          !sourceLeaf.includes("{") &&
          !targetLeaf.includes("{")
        ) {
          replacements[sourceLeaf.trim()] = targetLeaf.trim();
        }
      }
    }
  }
  for (const [source, translations] of Object.entries(uiCopy)) {
    if (translations[language]) replacements[source] = translations[language];
  }
  return replacements;
}

// Apple accepts 1290x2796 as APP_IPHONE_67, its current 6.9-inch class.
const appleDesign = { width: 1290, height: 2796 };
const targets = [
  { mode: "apple", width: 1290, height: 2796, directory: "apple" },
  { mode: "play", width: 1080, height: 1920, directory: "play" },
];

async function applyLocalization(page, language) {
  const frameCopy = manifest.copy[language];
  const featureCopy = manifest.feature[language];
  if (!frameCopy || frameCopy.length !== shots.length || !featureCopy) {
    throw new Error(`Incomplete screenshot copy for ${language}`);
  }
  const localizedFrames = frameCopy.map((copy, index) => ({
    ...copy,
    id: manifest.frames[index].id,
  }));
  const replacements = arbReplacements(language);
  await page.evaluate(
    ({ language, frames, feature, replacements }) => {
      document.documentElement.lang = language;
      document.body.dataset.language = language;
      const walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT);
      while (walker.nextNode()) {
        const node = walker.currentNode;
        const source = node.nodeValue.trim();
        if (replacements[source]) {
          node.nodeValue = node.nodeValue.replace(source, replacements[source]);
        }
      }
      frames.forEach((copy) => {
        const shot = document.getElementById(copy.id);
        if (!shot) return;
        const badge = shot.querySelector(".fact-pill");
        const eyebrow = shot.querySelector(".eyebrow");
        const headline = shot.querySelector(".hero-copy h1");
        const subhead = shot.querySelector(".hero-copy > p");
        const body = shot.querySelector(".wedge-card > p");
        if (badge && copy.badge) badge.textContent = copy.badge;
        if (eyebrow && copy.eyebrow) eyebrow.textContent = copy.eyebrow;
        if (headline && copy.headline) headline.innerHTML = copy.headline;
        if (subhead && copy.subhead) subhead.textContent = copy.subhead;
        if (body && copy.body) body.textContent = copy.body;
      });
      const featureRoot = document.querySelector("#feature-graphic");
      featureRoot.querySelector(".feature-copy > span").textContent = feature.eyebrow;
      featureRoot.querySelector(".feature-copy h2").textContent = feature.headline;
      featureRoot.querySelector(".feature-copy p").textContent = feature.subhead;
      featureRoot.querySelector(".feature-card span").textContent = feature.cardLabel;
      featureRoot.querySelector(".feature-card b").textContent = feature.cardTitle;
      featureRoot.querySelector(".feature-card i").textContent = feature.cardAction;
    },
    { language, frames: localizedFrames, feature: featureCopy, replacements },
  );
}

async function openLocalizedPage(browser, mode, language, width, height) {
  const page = await browser.newPage();
  await page.setViewport({ width, height, deviceScaleFactor: 1 });
  await page.goto(`file://${path.join(root, "index.html")}?mode=${mode}`, {
    waitUntil: "networkidle0",
  });
  await applyLocalization(page, language);
  await page.evaluate(async () => document.fonts.ready);
  return page;
}

async function renderScreenshots(browser, target, language) {
  const directory = path.join(root, "exports", "localized", target.directory, language);
  fs.mkdirSync(directory, { recursive: true });
  const page = await openLocalizedPage(
    browser,
    target.mode,
    language,
    target.width,
    target.height,
  );
  if (target.mode === "apple") {
    const zoom = target.width / appleDesign.width;
    await page.evaluate(
      ({ zoom, shotHeight }) => {
        document.documentElement.style.setProperty("--shot-zoom", zoom);
        document.documentElement.style.setProperty("--shot-h-design", `${shotHeight}px`);
      },
      { zoom, shotHeight: Math.round(target.height / zoom) },
    );
  }
  for (const shot of shots) {
    const element = await page.$(shot.selector);
    if (!element) throw new Error(`Missing ${shot.selector}`);
    const box = await element.boundingBox();
    await page.screenshot({
      path: path.join(directory, `${shot.name}.png`),
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

async function renderFeatureGraphic(browser, language) {
  const directory = path.join(root, "exports", "localized", "feature", language);
  fs.mkdirSync(directory, { recursive: true });
  const page = await openLocalizedPage(browser, "feature", language, 1024, 500);
  const feature = await page.$("#feature-graphic");
  if (!feature) throw new Error("Missing #feature-graphic");
  await page.evaluate(() => {
    window.scrollTo(0, 0);
    const brand = document.querySelector(".feature-brand");
    if (!brand || brand.getBoundingClientRect().height < 40) {
      throw new Error("Feature graphic brand is not laid out");
    }
  });
  await new Promise((resolve) => setTimeout(resolve, 200));
  await page.screenshot({
    path: path.join(directory, "patterns-feature-graphic-1024x500.png"),
    clip: { x: 0, y: 0, width: 1024, height: 500 },
    omitBackground: false,
  });
  await page.close();
}

function reviewHtml(language, compact) {
  const width = compact ? 170 : 340;
  const screenshotCards = shots
    .map((shot, index) => {
      const alt = manifest.copy[language][index].alt;
      const apple = `../../apple/${language}/${shot.name}.png`;
      const play = `../../play/${language}/${shot.name}.png`;
      return `<article><h2>${index + 1}. ${shot.name}</h2><div><figure><img src="${apple}" alt="${alt}"><figcaption>Apple 1290×2796</figcaption></figure><figure><img src="${play}" alt="${alt}"><figcaption>Play 1080×1920</figcaption></figure></div><p>${alt}</p></article>`;
    })
    .join("\n");
  const feature = manifest.feature[language];
  const featureCard = `<article class="feature-review"><h2>Google Play feature graphic</h2><figure><img src="../../feature/${language}/patterns-feature-graphic-1024x500.png" alt="${feature.headline}"><figcaption>Play 1024×500</figcaption></figure><p>${feature.headline} ${feature.subhead}</p></article>`;
  return `<!doctype html><meta charset="utf-8"><title>Patterns 1.10 ${language} screenshot review</title><style>body{margin:0;padding:32px;background:#0b0b0a;color:#f5f1e8;font:16px -apple-system,BlinkMacSystemFont,sans-serif}header{max-width:980px;margin:auto}main{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:28px;max-width:1500px;margin:32px auto}article{padding:20px;border:1px solid #3b3527;border-radius:18px;background:#171510}h1,h2,p{margin-top:0}h2{font-size:16px}article>div{display:flex;gap:16px;align-items:start}figure{margin:0}img{display:block;width:${width}px;height:auto;border-radius:12px}.feature-review{grid-column:1/-1}.feature-review img{width:${compact ? 420 : 820}px;max-width:100%}figcaption{margin-top:8px;color:#bdb5a3;font-size:12px}p{margin-top:14px;color:#d9d1c0;line-height:1.45}@media(max-width:900px){main{grid-template-columns:1fr}img{width:${compact ? 130 : 250}px}.feature-review{grid-column:auto}}</style><header><h1>Patterns 1.10 screenshot review: ${language}</h1><p>${compact ? "Search-grid scale" : "Full review scale"}. Draft assets only. No remote upload is authorized.</p></header><main>${screenshotCards}${featureCard}</main>`;
}

async function renderReviewArtifacts(browser, language) {
  const directory = path.join(root, "exports", "localized", "review", language);
  fs.mkdirSync(directory, { recursive: true });
  for (const compact of [false, true]) {
    const name = compact ? "search-grid" : "full-size";
    const html = reviewHtml(language, compact);
    const htmlPath = path.join(directory, `${name}.html`);
    fs.writeFileSync(htmlPath, html);
    const page = await browser.newPage();
    await page.setViewport({ width: compact ? 1200 : 1800, height: 1200, deviceScaleFactor: 1 });
    await page.goto(`file://${htmlPath}`, { waitUntil: "networkidle0" });
    await page.screenshot({
      path: path.join(directory, `${name}.png`),
      fullPage: true,
      omitBackground: false,
    });
    await page.close();
  }
}

(async () => {
  const browser = await puppeteer.launch({
    headless: "new",
    executablePath: chrome,
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });
  for (const language of manifest.languageSets) {
    for (const target of targets) {
      await renderScreenshots(browser, target, language);
    }
    await renderFeatureGraphic(browser, language);
    await renderReviewArtifacts(browser, language);
  }
  await browser.close();
  console.log(
    `Exported ${manifest.languageSets.length * shots.length} Apple screenshots, ` +
      `${manifest.languageSets.length * shots.length} Play screenshots, ` +
      `${manifest.languageSets.length} feature graphics, and review artifacts.`,
  );
})();
