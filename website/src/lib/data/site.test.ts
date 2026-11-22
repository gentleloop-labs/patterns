import { existsSync, readFileSync } from 'node:fs';
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

  // iPhone (native, 2.x) and Android (Flutter, 1.x) ship on separate version
  // lines. Each number on the site must come from its own app's source. App
  // releases are cut on the branch that holds the native app (apple/), so the
  // comparison runs there; the website-only master can lag a release bump.
  it('keeps each platform version in step with its own app', () => {
    const projectYml = join(process.cwd(), '../apple/project.yml');
    if (existsSync(projectYml)) {
      const native = readFileSync(projectYml, 'utf8').match(/MARKETING_VERSION:\s*"([\d.]+)"/)?.[1];
      expect(site.platforms.ios.version).toBe(native);

      const pubspec = readFileSync(join(process.cwd(), '../pubspec.yaml'), 'utf8');
      const flutterVersion = pubspec.match(/^version:\s*([\d.]+)/m)?.[1];
      expect(site.platforms.android.version).toBe(flutterVersion);
    }

    expect(site.platforms.ios.version.startsWith(site.platforms.ios.shortVersion)).toBe(true);
    expect(site.platforms.android.version.startsWith(site.platforms.android.shortVersion)).toBe(true);
  });
});
