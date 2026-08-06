/**
 * Generates the static QR code shown on the desktop /get page.
 *
 * Pre-generated at author time rather than rendered at runtime: it keeps the QR
 * library out of the shipped bundle and out of the landing page's critical path.
 * The trade-off is that the encoded URL carries a fixed campaign stamp rather
 * than the live one, so desktop -> phone hand-offs land in their own bucket.
 *
 * Run: npm run qr
 */
import { writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, resolve } from 'node:path';
import QRCode from 'qrcode';

const TARGET =
  'https://patternsocd.com/get?utm_source=qr_code&utm_medium=qr&utm_campaign=desktop_handoff';

const out = resolve(dirname(fileURLToPath(import.meta.url)), '../static/assets/qr-get.svg');

const svg = await QRCode.toString(TARGET, {
  type: 'svg',
  errorCorrectionLevel: 'M',
  margin: 1,
  color: { dark: '#0A0A0A', light: '#FFFFFF' }
});

writeFileSync(out, svg);
console.log(`Wrote ${out}\n  -> ${TARGET}`);
