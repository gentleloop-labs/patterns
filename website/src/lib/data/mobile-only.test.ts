import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { describe, expect, it } from 'vitest';
import { faqs } from './faq';
import { features } from './features';
import { links } from './links';

const PUBLIC_COPY_FILES = [
  'src/routes/+page.svelte',
  'src/routes/roadmap/+page.svelte',
  'src/lib/sections/Download.svelte',
  'src/lib/sections/Preview.svelte'
];

const publicCopy = PUBLIC_COPY_FILES.map((path) => ({
  path,
  body: readFileSync(resolve(process.cwd(), path), 'utf8')
}));

const retiredPlatformLanguage = /\b(?:macOS|Windows|Linux)\b|desktop app|download for desktop|on desktop/i;

describe('mobile-only website positioning', () => {
  it('does not advertise retired app platforms in public page copy', () => {
    for (const file of publicCopy) {
      expect(file.body, file.path).not.toMatch(retiredPlatformLanguage);
    }

    for (const feature of features) {
      expect(`${feature.title} ${feature.description}`, feature.title).not.toMatch(
        retiredPlatformLanguage
      );
    }

    for (const faq of faqs) {
      expect(`${faq.question} ${faq.answer}`, faq.question).not.toMatch(retiredPlatformLanguage);
    }
  });

  it('exposes only the two mobile store destinations', () => {
    expect(links.ios).toContain('apps.apple.com');
    expect(links.playStore).toContain('play.google.com');
    expect(Object.keys(links)).not.toContain('macos');
  });

  it('states the supported mobile platforms in the download experience', () => {
    const download = publicCopy.find((file) => file.path.endsWith('Download.svelte'))?.body ?? '';
    expect(download).toContain('Available on iOS and Android');
    expect(download).toContain('App Store');
    expect(download).toContain('Google Play');
  });
});
