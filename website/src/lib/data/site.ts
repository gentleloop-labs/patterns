import { links } from './links';

/**
 * Single source of truth for site-wide metadata. Keeping the app version here
 * (rather than hand-copied into JSON-LD) prevents the structured data from
 * drifting out of sync with the shipped app.
 */
export const site = {
  name: 'Patterns',
  /**
   * The two apps ship on separate version lines: the iPhone app was rebuilt
   * natively in Swift and jumped to 2.0, while Android stays on the Flutter
   * 1.x line. Never quote one platform's version for the other.
   *
   * ios: keep in sync with MARKETING_VERSION in apple/ (2.0.0 = build 101).
   * android: keep in sync with the version in pubspec.yaml.
   */
  platforms: {
    ios: {
      name: 'iPhone',
      version: '2.0.0',
      shortVersion: '2.0',
      requires: 'iOS 17 or later',
      build: 'Native app, written in Swift'
    },
    android: {
      name: 'Android',
      version: '1.10.3',
      shortVersion: '1.10',
      requires: 'Android 7.0 or later',
      build: 'Built with Flutter'
    }
  },
  /** Announced in the homepage hero; links to the release on the roadmap. */
  latestRelease: {
    platform: 'iPhone',
    version: '2.0',
    summary: 'Patterns 2.0: a native iPhone app',
    href: '/roadmap#released'
  },
  /** Preferred host is the apex domain (no www). See website/README.md. */
  url: links.site,
  /** Purpose-built 1200×630 social share image. */
  ogImage: `${links.site}og/patterns-share-v2.png`,
  ogImageWidth: 1200,
  ogImageHeight: 630,
  logoUrl: `${links.site}assets/logo.png`,
  logoWidth: 512,
  logoHeight: 512,
  author: { name: 'Aftaab Siddiqui', url: links.author },
  publisher: { name: 'MaskedSyntax', url: links.maskedsyntax }
} as const;
