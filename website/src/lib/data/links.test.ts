import { describe, expect, it } from 'vitest';
import { links } from './links';
import { ANDROID_PACKAGE, IOS_APP_ID } from '$lib/utils/platform';

/**
 * Guards the two URLs the whole paid-acquisition funnel depends on. A typo here
 * is invisible in CI and expensive in a live campaign, so the identifiers are
 * cross-checked against the ones the rest of the site uses.
 */
describe('store links', () => {
  it('points at the real App Store listing for this app id', () => {
    const url = new URL(links.ios);
    expect(url.protocol).toBe('https:');
    expect(url.hostname).toBe('apps.apple.com');
    expect(url.pathname).toContain(`/id${IOS_APP_ID}`);
  });

  it('points at the real Play Store listing for this package', () => {
    const url = new URL(links.playStore);
    expect(url.protocol).toBe('https:');
    expect(url.hostname).toBe('play.google.com');
    expect(url.pathname).toBe('/store/apps/details');
    expect(url.searchParams.get('id')).toBe(ANDROID_PACKAGE);
  });

  it('uses the canonical hosts directly, with no shortener or redirector', () => {
    for (const url of [links.ios, links.playStore]) {
      expect(url).not.toMatch(/bit\.ly|tinyurl|t\.co|linktr|\/r\/|redirect/i);
    }
  });

  it('carries no tracking query string that the stores would drop', () => {
    expect(new URL(links.ios).search).toBe('');
    expect(new URL(links.playStore).searchParams.get('utm_source')).toBeNull();
  });

  it('keeps the macOS link on the same app id', () => {
    expect(links.macos).toContain(`/id${IOS_APP_ID}`);
    expect(new URL(links.macos).searchParams.get('mt')).toBe('12');
  });
});
