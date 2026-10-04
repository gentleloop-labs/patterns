# Patterns store screenshots

This campaign is ordered for storefront discovery rather than feature chronology:

1. **Calm Today** — factual recent activity without scores or streak pressure.
2. **Delay the urge. Watch it change** — immediate, practical compulsion-delay value.
3. **Build the ladder. Take the next step** — a clearly labeled Patterns Pro exposure tool.
4. **See patterns. Not judgments** — Calm Insights with factual activity counts.
5. **No AI to ask. No answer to chase** — the anti-reassurance position that separates Patterns from chatbot-led competitors.
6. **Your OCD data stays on your phone** — local-first records and optional anonymous analytics as verifiable proof.
7. **A journal for thoughts you don't say out loud** — private daily journaling.
8. **Patterns Pro. One-time unlock** — the price-free one-time Pro toolkit.

## Look

Saturated brand-yellow ground, oversized Fraunces headline, hard-cropped dark
product UI, and one floating fact pill per frame. This follows the category's
dominant App Store grammar: claim poster, single-mechanic crop, objection pill,
and a full-slot proof card. The Patterns lockup appears only in slot 1.

## Exports

- `exports/localized/apple/<language>/`: Apple `APP_IPHONE_67` portrait
  screenshots at 1290x2796.
- `exports/localized/play/<language>/`: Google Play 9:16 phone screenshots at
  1080x1920.
- `exports/localized/feature/<language>/`: Google Play 1024x500 feature
  graphics.
- `exports/localized/review/<language>/`: full-size and search-grid HTML/PNG
  review sheets.

The six generated language sets are English, Brazilian Portuguese, German,
Japanese, neutral Spanish, and French. Regional storefronts reuse the matching
language set through `release/1.10.0/screenshot-locale-manifest.json`.

All assets use the real Patterns logo and the app's current Manrope/Fraunces
typography and mobile color palette. In-frame UI follows the production Flutter
widget hierarchy and copy. Apple exports use an iPhone frame; Play exports use
an Android camera cutout. The Apple layout is authored and rendered directly at
1290x2796. The 1.10 pipeline intentionally does not generate a duplicate
6.5-inch set.

## Render

```sh
node render.js
```

## Suggested Google Play alt text

1. Today screen recommending a two-minute compulsion delay as one clear next step.
2. Compulsion-delay setup with an urge field, recorded intensity, and a wait duration.
3. Exposure hierarchy with three readable rungs, ratings for each practice step, and clear text states.
4. Calm Insights overview showing factual journal, tracked-moment, delay, and ERP counts without scores or streaks.
5. No-chatbot claim poster explaining that reassurance can become a compulsion and the question can stay open.
6. Privacy proof stating that journal and ERP records stay on-device unless manually exported, with optional anonymous usage sharing.
7. Full-screen private journal editor with a reflective entry and formatting controls.
8. Patterns Pro poster showing the one-time unlock, all six Pro tools, offline access, and no recurring charge without hardcoding a price.

Feature graphic: Patterns branding beside a card recommending a two-minute delay, with the line “A quieter way through OCD.”
