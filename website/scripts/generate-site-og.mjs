import { chromium } from '@playwright/test';
import { readFile } from 'node:fs/promises';
import { join } from 'node:path';

const root = process.cwd();
const output = join(root, 'static/og/patterns-share-v2.png');
const logo = await readFile(join(root, 'static/assets/logo.png'));
const product = await readFile(join(root, 'static/assets/website-cta-1200.jpg'));
const logoUrl = `data:image/png;base64,${logo.toString('base64')}`;
const productUrl = `data:image/jpeg;base64,${product.toString('base64')}`;

const browser = await chromium.launch({ headless: true });
try {
  const page = await browser.newPage({ viewport: { width: 1200, height: 630 }, deviceScaleFactor: 1 });
  await page.setContent(`<!doctype html>
    <html lang="en"><head><meta charset="utf-8"><style>
      * { box-sizing: border-box; }
      html, body { width: 1200px; height: 630px; margin: 0; overflow: hidden; }
      body {
        background: #0a0b0a;
        color: #fffdf7;
        font-family: Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        -webkit-font-smoothing: antialiased;
      }
      main { position: relative; width: 100%; height: 100%; overflow: hidden; }
      .product {
        position: absolute; right: 0; top: 0; width: 620px; height: 630px;
        object-fit: cover; object-position: right center;
        -webkit-mask-image: linear-gradient(90deg, transparent 0, transparent 160px, #000 260px);
        mask-image: linear-gradient(90deg, transparent 0, transparent 160px, #000 260px);
        filter: saturate(.9) brightness(.94);
      }
      .fade {
        position: absolute; inset: 0;
        background:
          linear-gradient(90deg, #0a0b0a 0%, #0a0b0a 48%, #0a0b0af0 58%, #0a0b0a80 65%, transparent 79%),
          linear-gradient(0deg, #0a0b0a85, transparent 20%);
      }
      .glow {
        position: absolute; width: 480px; height: 480px; left: 120px; top: 220px;
        border-radius: 50%; background: #e8bc4c16; filter: blur(92px);
      }
      .content { position: absolute; inset: 0; padding: 53px 62px 43px; }
      .brand { display: flex; align-items: center; gap: 14px; }
      .brand img { width: 58px; height: 58px; border-radius: 14px; }
      .brand span { font-size: 29px; font-weight: 760; letter-spacing: -.9px; }
      .badge {
        display: inline-block; margin-top: 39px; padding: 9px 13px;
        border: 1px solid #f3c64973; border-radius: 999px;
        color: #f3c649; font-size: 14px; font-weight: 750;
        letter-spacing: 1.25px; text-transform: uppercase;
      }
      h1 {
        max-width: 675px; margin: 23px 0 0;
        font-family: Georgia, "Times New Roman", serif;
        font-size: 59px; line-height: 1.06; letter-spacing: -2.2px;
        text-wrap: balance;
      }
      h1 em { color: #f4cb5b; font-style: normal; }
      .sub {
        max-width: 560px; margin: 23px 0 0;
        color: #d0cdc4; font-size: 21px; line-height: 1.35;
      }
      .footer {
        position: absolute; left: 62px; bottom: 43px;
        display: flex; align-items: center; gap: 13px;
        color: #bcb8af; font-size: 16px; font-weight: 550;
      }
      .footer b { color: #f4cb5b; font-size: 17px; }
      .edge { position: absolute; inset: 0; border: 1px solid #ffffff15; }
    </style></head><body>
      <main>
        <img class="product" src="${productUrl}" alt="" />
        <div class="fade"></div><div class="glow"></div>
        <div class="content">
          <div class="brand"><img src="${logoUrl}" alt="" /><span>patterns</span></div>
          <div class="badge">Private OCD journal &amp; ERP tools</div>
          <h1>See the pattern.<br><em>Choose your response.</em></h1>
          <p class="sub">Journal, track OCD, and practice ERP in one private place.</p>
          <div class="footer"><span>No account needed</span><b>·</b><span>iPhone &amp; Android</span></div>
        </div>
        <div class="edge"></div>
      </main>
    </body></html>`);
  await page.locator('.product').evaluate((image) => image.decode());
  await page.locator('.brand img').evaluate((image) => image.decode());
  await page.screenshot({ path: output });
  console.log(`Generated ${output}`);
} finally {
  await browser.close();
}
