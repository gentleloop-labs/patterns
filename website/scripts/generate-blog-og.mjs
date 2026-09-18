import { chromium } from '@playwright/test';
import { mkdir, readFile, readdir } from 'node:fs/promises';
import { join } from 'node:path';

const ROOT = process.cwd();
const CONTENT_DIR = join(ROOT, 'src/content/blog');
const OUTPUT_DIR = join(ROOT, 'static/og/blog');
const LOGO_PATH = join(ROOT, 'static/assets/logo.png');

const categories = {
  'recognizing-ocd': {
    label: 'Recognizing OCD',
    accent: '#FFD447',
    accentSoft: '#6B5621',
    backdrop: '#18150D'
  },
  'ocd-themes': {
    label: 'OCD Themes',
    accent: '#F0B86E',
    accentSoft: '#674729',
    backdrop: '#19130F'
  },
  'treatment-erp': {
    label: 'Treatment & ERP',
    accent: '#E9C867',
    accentSoft: '#5F542A',
    backdrop: '#16150E'
  },
  'living-with-ocd': {
    label: 'Living With OCD',
    accent: '#E7B8A5',
    accentSoft: '#61443A',
    backdrop: '#181210'
  },
  'personal-stories': {
    label: 'Personal Stories',
    accent: '#D8C5A1',
    accentSoft: '#594C36',
    backdrop: '#17140F'
  }
};

function parseScalar(raw) {
  const value = raw.trim();
  if (value.startsWith("'") && value.endsWith("'")) {
    return value.slice(1, -1).replaceAll("''", "'");
  }
  if (value.startsWith('"') && value.endsWith('"')) return JSON.parse(value);
  return value;
}

function readField(frontmatter, key) {
  const line = frontmatter.split('\n').find((entry) => entry.startsWith(`${key}:`));
  if (!line) throw new Error(`Missing ${key} in blog frontmatter`);
  return parseScalar(line.slice(line.indexOf(':') + 1));
}

function escapeHtml(value) {
  return value
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#039;');
}

function hash(value) {
  let result = 2166136261;
  for (const char of value) {
    result ^= char.charCodeAt(0);
    result = Math.imul(result, 16777619);
  }
  return result >>> 0;
}

function titleSize(title) {
  if (title.length <= 42) return 68;
  if (title.length <= 56) return 60;
  if (title.length <= 70) return 54;
  return 48;
}

function motif(slug, palette) {
  const seed = hash(slug);
  const rotation = -22 + (seed % 45);
  const offset = 12 + (seed % 52);
  const dotX = 67 + (seed % 175);
  const dotY = 76 + ((seed >>> 8) % 350);
  const cardShift = (seed >>> 16) % 42;

  return `
    <svg class="motif" viewBox="0 0 360 520" aria-hidden="true">
      <defs>
        <linearGradient id="fade" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stop-color="${palette.accent}" stop-opacity=".32" />
          <stop offset="1" stop-color="${palette.accent}" stop-opacity=".04" />
        </linearGradient>
        <filter id="glow"><feGaussianBlur stdDeviation="18" /></filter>
      </defs>
      <circle cx="244" cy="112" r="92" fill="${palette.accent}" opacity=".08" filter="url(#glow)" />
      <g transform="rotate(${rotation} 180 260)">
        <rect x="${58 + cardShift}" y="52" width="222" height="348" rx="34" fill="#11110f" stroke="${palette.accentSoft}" stroke-width="2" />
        <rect x="${76 + cardShift}" y="74" width="186" height="304" rx="25" fill="url(#fade)" stroke="${palette.accent}" stroke-opacity=".25" />
        <path d="M${111 + cardShift} 173 C${111 + cardShift} 101 ${223 + cardShift} 101 ${223 + cardShift} 173 C${223 + cardShift} 245 ${111 + cardShift} 245 ${111 + cardShift} 317 C${111 + cardShift} 373 ${199 + cardShift} 382 ${223 + cardShift} 329" fill="none" stroke="${palette.accent}" stroke-width="13" stroke-linecap="round" />
        <circle cx="${167 + cardShift}" cy="221" r="26" fill="none" stroke="${palette.accent}" stroke-width="10" />
      </g>
      <circle cx="${dotX}" cy="${dotY}" r="7" fill="${palette.accent}" />
      <circle cx="${offset + 264}" cy="446" r="4" fill="${palette.accent}" opacity=".7" />
    </svg>`;
}

function renderCard({ slug, title, category, logoDataUrl }) {
  const palette = categories[category] ?? categories['recognizing-ocd'];
  return `<!doctype html>
  <html lang="en">
    <head><meta charset="utf-8" /><style>
      * { box-sizing: border-box; }
      html, body { margin: 0; width: 1200px; height: 630px; overflow: hidden; }
      body {
        color: #f8f6ef;
        background:
          radial-gradient(circle at 81% 23%, ${palette.accent}17, transparent 31%),
          radial-gradient(circle at 18% 88%, ${palette.accent}0d, transparent 29%),
          linear-gradient(125deg, #090909 0%, ${palette.backdrop} 100%);
        font-family: Inter, ui-sans-serif, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        -webkit-font-smoothing: antialiased;
      }
      .frame { position: relative; width: 100%; height: 100%; padding: 58px 68px 50px; }
      .top { display: flex; align-items: center; gap: 18px; }
      .logo { width: 58px; height: 58px; border-radius: 14px; }
      .brand { font-size: 27px; font-weight: 710; letter-spacing: -.7px; }
      .category {
        margin-left: 18px; padding: 9px 15px; border: 1px solid ${palette.accent}73;
        border-radius: 999px; color: ${palette.accent}; font-size: 15px; font-weight: 750;
        letter-spacing: 1.45px; text-transform: uppercase;
      }
      .copy { position: relative; z-index: 2; width: 785px; margin-top: 72px; }
      h1 {
        margin: 0; color: #fffdf7; font-family: Georgia, "Times New Roman", serif;
        font-size: ${titleSize(title)}px; line-height: 1.03; letter-spacing: -2.2px;
        text-wrap: balance;
      }
      .rule { width: 84px; height: 6px; margin-top: 32px; border-radius: 6px; background: ${palette.accent}; }
      .sub { margin-top: 23px; color: #bbb8b0; font-size: 22px; letter-spacing: -.15px; }
      .domain { position: absolute; left: 68px; bottom: 45px; color: #85827b; font-size: 17px; letter-spacing: .3px; }
      .motif { position: absolute; z-index: 1; width: 368px; height: 530px; right: 30px; top: 52px; }
      .edge { position: absolute; inset: 0; border: 1px solid #ffffff0f; pointer-events: none; }
    </style></head>
    <body>
      <main class="frame">
        <div class="top">
          <img class="logo" src="${logoDataUrl}" alt="" />
          <span class="brand">patterns</span>
          <span class="category">${escapeHtml(palette.label)}</span>
        </div>
        <div class="copy">
          <h1>${escapeHtml(title).replaceAll('-', '&#8209;')}</h1>
          <div class="rule"></div>
          <div class="sub">Plain-language guidance for understanding the OCD loop.</div>
        </div>
        ${motif(slug, palette)}
        <div class="domain">patternsocd.com/blog</div>
        <div class="edge"></div>
      </main>
    </body>
  </html>`;
}

const files = (await readdir(CONTENT_DIR)).filter((file) => file.endsWith('.md')).sort();
const logo = await readFile(LOGO_PATH);
const logoDataUrl = `data:image/png;base64,${logo.toString('base64')}`;
await mkdir(OUTPUT_DIR, { recursive: true });

const browser = await chromium.launch({ headless: true });
try {
  const page = await browser.newPage({ viewport: { width: 1200, height: 630 }, deviceScaleFactor: 1 });
  for (const file of files) {
    const raw = await readFile(join(CONTENT_DIR, file), 'utf8');
    const frontmatter = raw.match(/^---\r?\n([\s\S]*?)\r?\n---/)?.[1];
    if (!frontmatter || /^draft:\s*true\s*$/m.test(frontmatter)) continue;

    const slug = file.replace(/\.md$/, '');
    const title = readField(frontmatter, 'title');
    const category = readField(frontmatter, 'category');
    await page.setContent(renderCard({ slug, title, category, logoDataUrl }), {
      waitUntil: 'load'
    });
    await page.screenshot({ path: join(OUTPUT_DIR, `${slug}.png`), type: 'png' });
  }
} finally {
  await browser.close();
}

console.log(`Generated ${files.length} blog OG images in ${OUTPUT_DIR}`);
