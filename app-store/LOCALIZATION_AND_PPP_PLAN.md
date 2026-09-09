# Patterns App Store Localization and PPP Plan

Prepared: 2026-09-08

Status: the nine-territory Patterns Pro PPP pilot was applied and verified in App Store Connect on 2026-09-08. All pilot prices are effective immediately; there are no pending price changes.

## Objective

Increase qualified App Store discovery and paid conversion for Patterns Pro. Downloads alone are not the target: each market should be evaluated on product-page conversion, first opens, Pro purchases, proceeds, and refunds.

## Current state

- App Store metadata is available only in `en-US`.
- The app UI is English-only. Non-English product pages should launch with matching in-app language support, or clearly disclose that the app is in English.
- Patterns Pro is an approved one-time purchase with a US base price of USD 19.99.
- Apple's current auto-equalized prices are too close to the US nominal price in several price-sensitive markets. Examples before the PPP pilot: India INR 1,499; Brazil BRL 129.90; Indonesia IDR 349,000; Viet Nam VND 599,000; and Türkiye TRY 999.99.
- App Store Connect country analytics could not be read with the current API-key role. This plan is therefore a market-entry hypothesis, not a claim about Patterns' historical country performance.

## Localization priority

### Wave 0: English storefront expansion

Do this first because it matches the current English app and has the lowest trust and support risk.

| Storefront focus | App Store locale | Why it belongs in the first wave |
|---|---|---|
| United Kingdom and Ireland | `en-GB` | Large, high-spend iOS market; local spelling and search terms can improve relevance. |
| Canada | `en-CA` | High-value English market with strong iOS adoption. |
| Australia and New Zealand | `en-AU` | High purchasing power and an English product fit. |
| United States | `en-US` | Keep as the primary conversion and price-control market. |

Use market-specific keywords rather than copying the US keyword field. Keep the product name stable. Localize screenshots only where spelling or claims differ.

### Wave 1: best balance of downloads and payment potential

Ship these product pages with matching in-app language support and native review of OCD/ERP terminology.

| Priority | Countries | App Store locale | Commercial role |
|---:|---|---|---|
| 1 | Brazil | `pt-BR` | Large and fast-growing iOS download market; strong upside from both localization and PPP pricing. |
| 2 | Germany and Austria | `de-DE` | High-value European customers and healthy App Store growth. |
| 3 | Japan | `ja` | Large iOS install base and strong willingness to pay; requires excellent native localization. |
| 4 | Mexico, Colombia, Chile, Peru, Argentina and other Spanish-speaking Latin American storefronts | `es-MX` | One localization reaches several high-volume markets; pair it with territory pricing. |
| 5 | France and French-speaking Belgium/Switzerland | `fr-FR` | Stable, high-LTV European market. |
| 6 | Spain | `es-ES` | Reuse the Spanish translation base, but adapt search terms and tone for Spain. |

### Wave 2: volume and growth, with stronger affordability adjustments

| Priority | Countries | App Store locale | Launch condition |
|---:|---|---|---|
| 7 | India | `hi` plus `en-GB` | Start with the English storefront and PPP price; add Hindi after the core app is localized. |
| 8 | Viet Nam | `vi` | Fast-growing iOS download market; needs a deeply discounted one-time price. |
| 9 | Indonesia | `id` | Very large mobile market; iOS is smaller, so validate paid conversion before extensive creative production. |
| 10 | South Korea | `ko` | High-spend market, but native product quality expectations are high. |
| 11 | Türkiye | `tr` | Large download market with severe price sensitivity and currency volatility. |
| 12 | Thailand | `th` | Useful regional scale once the app and support content are localized. |
| 13 | China mainland | `zh-Hans` | Enormous iOS reach, but enter only after language, policy, support, and mental-health positioning are reviewed. |

Do not prioritize dozens of small locales at once. Every added language creates ongoing work for release notes, screenshots, support, safety copy, and product QA.

## PPP pricing policy

Use the US USD 19.99 one-time price as the anchor. Apply three practical affordability bands rather than a false-precision currency conversion:

- 100% band: mature, high-spend markets. Retain Apple's equalized pricing.
- 55-70% band: upper-middle-income or price-sensitive markets where iOS users still have meaningful payment capacity.
- 30-50% band: lower-income markets where the current nominal equivalent is a major conversion barrier.

The first pilot uses rounded App Store price points and leaves rich markets unchanged. Prices should be reviewed quarterly, especially in high-inflation currencies. The values below were read back from App Store Connect after the change.

| Territory | Before | Pilot price | Change | Band rationale |
|---|---:|---:|---:|---|
| India | INR 1,499 | **INR 499** | -67% | Large iOS growth opportunity; current price is far above a practical PPP level. |
| Brazil | BRL 129.90 | **BRL 69.90** | -46% | Strong iOS download growth with better payment potential than a deepest-discount market. |
| Mexico | MXN 399 | **MXN 249** | -38% | Large mobile market; moderate discount protects proceeds while improving affordability. |
| Indonesia | IDR 349,000 | **IDR 149,000** | -57% | High-volume, highly price-sensitive market. |
| Viet Nam | VND 599,000 | **VND 199,000** | -67% | Fast iOS download growth and a large nominal affordability gap. |
| Türkiye | TRY 999.99 | **TRY 399.99** | -60% | High inflation and currency volatility make the auto-equalized price fragile. |
| Philippines | PHP 1,290 | **PHP 499** | -61% | Large English-capable mobile market with low purchasing power. |
| Thailand | THB 699 | **THB 399** | -43% | Moderate PPP adjustment for a meaningful iOS audience. |
| South Africa | ZAR 399.99 | **ZAR 249.99** | -38% | Fast overall app-market growth and broad English usability. |

The voluntary tip products remain unchanged in the first test. Patterns Pro is the core conversion event and should be isolated so the result is interpretable.

## Measurement and decision rule

Compare 30 complete days before and after launch by territory:

- App Store impressions and product-page views
- product-page conversion rate and first-time downloads
- Pro purchases per first-time download
- proceeds per product-page view
- refunds and support complaints

Keep a lower territory price when paid conversion rises enough that territory proceeds improve, or when the accessibility gain is strategically valuable without a material increase in refunds. Revisit or step the price up when purchases increase but proceeds per product-page view fall sharply.

Do not judge localization from raw downloads alone. A localized listing with an English-only app can increase installs while lowering trust, ratings, and paid conversion.

## Evidence used

- AppTweak's 2025 estimates place the US, China, Japan, Brazil, UK, India, Germany, Viet Nam, and France among the largest iOS download markets: <https://www.apptweak.com/en/reports/app-downloads-by-country>
- Sensor Tower reported continued non-game IAP growth and strong European and Latin American momentum in 2025: <https://sensortower.com/blog/q2-2025-digital-market-index>
- Apple documents the metadata locales and storefront fallback behavior: <https://developer.apple.com/help/app-store-connect/reference/app-information/app-store-localizations>
- World Bank ICP data is the macro PPP reference; its estimates are approximate and are not a digital-goods price list: <https://www.worldbank.org/en/programs/icp/data>
