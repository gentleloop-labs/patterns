import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { describe, expect, it } from 'vitest';
import QRCode from 'qrcode';

/**
 * The committed QR image is generated at author time, so nothing at runtime
 * proves it still encodes the right URL. This regenerates it from the same
 * source of truth and compares byte-for-byte: if the target URL or the render
 * options ever drift from the committed asset, this fails.
 */
const QR_TARGET =
  'https://patternsocd.com/get?utm_source=qr_code&utm_medium=qr&utm_campaign=desktop_handoff';

// Resolved from the vitest root (the website package), not from import.meta.
const committed = readFileSync(resolve('static/assets/qr-get.svg'), 'utf8');

describe('desktop hand-off QR code', () => {
  it('encodes exactly the intended /get URL', async () => {
    const regenerated = await QRCode.toString(QR_TARGET, {
      type: 'svg',
      errorCorrectionLevel: 'M',
      margin: 1,
      color: { dark: '#0A0A0A', light: '#FFFFFF' }
    });

    expect(committed).toBe(regenerated);
  });

  it('points at the real landing page over https', () => {
    const url = new URL(QR_TARGET);
    expect(url.protocol).toBe('https:');
    expect(url.hostname).toBe('patternsocd.com');
    expect(url.pathname).toBe('/get');
  });

  it('carries its own campaign so the desktop hand-off is distinguishable', () => {
    const params = new URL(QR_TARGET).searchParams;
    expect(params.get('utm_source')).toBe('qr_code');
    expect(params.get('utm_medium')).toBe('qr');
    expect(params.get('utm_campaign')).toBe('desktop_handoff');
  });

  it('is a self-contained svg with no external references', () => {
    expect(committed.startsWith('<svg')).toBe(true);
    expect(committed).not.toMatch(/<image|href=|url\(/i);
  });
});
