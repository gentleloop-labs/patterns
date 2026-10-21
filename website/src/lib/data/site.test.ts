import { readFileSync } from 'node:fs';
import { join } from 'node:path';
import { describe, expect, it } from 'vitest';
import { links } from './links';
import { site } from './site';

describe('site metadata', () => {
  it('keeps absolute asset URLs on the apex host', () => {
    for (const url of [site.url, site.ogImage, site.logoUrl]) {
      expect(url.startsWith(links.site) || url === links.site).toBe(true);
      expect(url).not.toMatch(/https?:\/\/www\.patternsocd\.com/i);
    }
  });

  it('exposes logo dimensions for JSON-LD ImageObject', () => {
    expect(site.logoWidth).toBeGreaterThan(0);
    expect(site.logoHeight).toBeGreaterThan(0);
  });

  it('uses a versioned 1200 by 630 site-wide social image', () => {
    expect(site.ogImage).toBe(`${links.site}og/patterns-share-v2.png`);
    const image = readFileSync(join(process.cwd(), 'static/og/patterns-share-v2.png'));
    expect(image.toString('ascii', 1, 4)).toBe('PNG');
    expect(image.readUInt32BE(16)).toBe(site.ogImageWidth);
    expect(image.readUInt32BE(20)).toBe(site.ogImageHeight);
    expect(image.byteLength).toBeGreaterThan(100_000);
  });
});
