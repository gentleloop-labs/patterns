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
});
