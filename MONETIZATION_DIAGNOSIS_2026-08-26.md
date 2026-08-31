# Patterns App Store Monetization Diagnosis

Date: 2026-08-26  
App: Patterns: OCD & ERP Journal  
Bundle ID: `com.maskedsyntax.patterns`  
App Store Connect ID: `6762611172`

This was a read-only investigation using App Store Connect, ASC web analytics, Apple storefront data, and the local StoreKit/paywall implementation. No source code, products, prices, metadata, or App Store Connect records were changed.

## Executive diagnosis

The app's purchase setup is not broken. The most likely revenue problems are:

1. Users are not reaching—or needing—the paywall often enough. Onboarding intentionally avoids monetization, while the free tier already includes journaling, OCD logging, Y-BOCS self-checks, Guided ERP, compulsion delay, emergency tools, coping tools, and basic insights.
2. The $39.99 paid proposition is difficult to justify at current engagement levels. All six observed purchases occurred while Pro was $14.99. There have been no purchases at $39.99 yet, although purchases had already stopped before the increase, so price is not the sole cause.
3. Activation and retention appear weaker than acquisition. Last-30-day sessions fell 57.9% while total downloads fell only 30.7%. Until activation, paywall exposure, and purchase attempts are measured, it is impossible to cleanly separate retention, paywall exposure, and paywall conversion.

The first action should be to make the privacy-safe funnel decision-grade. The first commercial experiment after that should be a lower, territory-adjusted Pro price—not ads or another ASO redesign.

## Actual App Store funnel

Requested ranges were May 29–August 26 and July 28–August 26, 2026. August 26 is incomplete; recent conclusions rely mainly on data through August 25.

| Apple metric | Last 90 days | Last 30 days | Previous 30 days |
|---|---:|---:|---:|
| Impressions | 8,704 | 3,938 | 2,743 |
| Product-page views | 872 | 261 | 417 |
| First-time downloads | 237 | 80 | 118 |
| Redownloads | 15 | 6 | 6 |
| Total downloads | 252 | 86 | 124 |
| Apple conversion rate | 3.95% | 2.86% | 6.34% |
| Sessions | 619 | 141 | 335 |
| In-app purchases | 6 | 2 | 4 |
| Proceeds | $77 | $24 | $52 |

Important trends:

- Impressions increased 43.6%, but product-page views fell 37.4%.
- First-time downloads fell 32.2%.
- Sessions fell 57.9%.
- Purchases fell 50% and proceeds fell 53.8%.
- Apple's latest peer benchmark showed conversion of 3.29%, versus peer median 1.50% and 75th percentile 3.47%. Product-page conversion is therefore not obviously the main structural problem.

Calculated ratios—not native Apple metrics:

| Calculated ratio | 90 days | 30 days |
|---|---:|---:|
| Impressions → page views | 10.02% | 6.63% |
| Page-view count → first downloads | 27.18% | 30.65% |
| Impressions → first downloads | 2.72% | 2.03% |
| First downloads → purchases | 2.53% | 2.50% |
| Total downloads → purchases | 2.38% | 2.33% |
| Proceeds per first download | $0.325 | $0.300 |
| Proceeds per product-page view | $0.088 | $0.092 |

The page-view/download calculations combine event counts with first-download counts and are not equivalent to Apple's unique-device conversion rate.

Apple's cohort reporting returned:

- 90-day download-to-paid: 2.42% D1, 2.61% D7, 2.86% D14, 2.72% D35.
- 90-day proceeds per download: $0.31 D1, $0.33 D7, $0.36 D14, $0.35 D35.
- The last-30-day D35 values are not mature and should not be used.
- Retention was too sparse for a firm conclusion: only seven threshold-eligible D0 devices were returned. Two returned on D1; none of three matured devices returned on D7.

Apple returned `Paying Users: 0` as an average-style metric despite six recorded IAPs. It cannot be used as a unique-payer count.

## Monetization configuration

The live catalog is technically healthy.

| Product | Type | State | US price |
|---|---|---|---:|
| Patterns Pro | Non-consumable | Approved | $39.99 |
| Small Tip | Consumable | Approved | $1.99 |
| Medium Tip | Consumable | Approved | $4.99 |
| Large Tip | Consumable | Approved | $9.99 |

Confirmed:

- All four parent products and their version records are `APPROVED`.
- ASC's IAP validator found zero errors and zero warnings.
- Every product is available in all 175 storefronts.
- The app itself is available in all 175 storefronts.
- Important storefronts—including US, India, UK, Canada, Australia, and Switzerland—are available.
- All products have completed App Review screenshots.
- Product IDs match the repository exactly.
- There are no subscriptions or subscription groups, consistent with the one-time-purchase design.
- There are no trials or introductory subscription offers because Pro is not a subscription.
- There are no promoted IAPs.
- No product is `READY_TO_SUBMIT`, rejected, unavailable, or missing metadata.
- The tip products generated no observed proceeds. All $76 of product-level proceeds came from Patterns Pro; Apple's overall card rounded/reported $77.

Current Pro pricing is:

- US: $39.99
- India: ₹3,999
- UK: £39.99
- Canada: C$49.99
- Australia: A$59.99
- Switzerland: CHF35

This is Apple-equivalentized pricing, not purchasing-power-adjusted pricing. ₹3,999 is particularly aggressive for the Indian market.

Only `en-US` localization exists for the app and all four products. That does not prevent purchasing, but non-English storefront customers receive no localized paid proposition.

One confirmed metadata inconsistency: the live Pro IAP description says "Guided ERP, exposure hierarchy & recovery metrics." Guided ERP is actually free in the code. This weakens trust and blurs what the purchase unlocks.

## Acquisition quality

ASC could retrieve source-level daily unique product-page observations, but not downloads or revenue grouped by source.

| Source | 90-day observations | Share | Last-30 observations | Share |
|---|---:|---:|---:|---:|
| App Store Search | 342 | 53.6% | 124 | 64.2% |
| Web Referrer | 106 | 16.6% | 22 | 11.4% |
| App Referrer | 102 | 16.0% | 26 | 13.5% |
| App Store Browse | 88 | 13.8% | 21 | 10.9% |
| Campaigns | 0 | — | 0 | — |

These are sums of daily unique-device observations, not distinct people over the entire range.

Search is dominant and usually represents stronger intent than Browse. Therefore, there is not good evidence that downloads are primarily low-intent curiosity traffic. The rising impressions combined with falling page views does suggest that recent impressions may be shallower or less relevant.

Revenue by storefront over 90 days:

- United States: $51
- Switzerland: $14
- India: $11

Last 30 days:

- United States: $13
- India: $11

Download-by-country was unavailable, so country-level download/revenue mismatches cannot be calculated.

## Where the funnel is broken

| Classification | Assessment | Evidence |
|---|---|---|
| A. Discovery | Not primary | 8,704 impressions; last-30 impressions increased 43.6%. |
| B. Product-page conversion | Mixed | Recent Apple conversion fell 6.34% → 2.86%, but latest peer benchmark remained near the 75th percentile. |
| C. Install-to-activation | Likely | Sessions fell much faster than downloads; no live activation funnel exists. |
| D. Retention | Likely risk, unproven | Sessions down 57.9%; D7 sample was only three matured devices. |
| E. Paywall exposure | Likely | No onboarding paywall; users must tap a locked tool or visit Settings. Exposure is not remotely measured in live 1.7. |
| F. Paywall conversion | Possible but inseparable | Rough download-to-purchase rate is approximately 2.5%, but paywall views and attempts are unknown. |
| G. Pricing/offer | Likely contributor | $39.99/₹3,999, no trial; all six purchases occurred at the old $14.99 price. |
| H. Implementation/configuration | Evidence against | Approved products, correct IDs, successful historical purchases, proper loading/retry/error UI. |
| I. Low-intent acquisition | Weak evidence | Search dominates; campaign traffic is zero. Recent impression/page-view divergence is the main caution. |
| J. Not enough data | Definitely applies | Only 237 first downloads and six purchases; only 32 first downloads during the first ten days at $39.99. |

## Free versus paid proposition

The free product is unusually capable:

- Daily journal
- OCD event logging
- Y-BOCS self-check
- Guided ERP
- Compulsion delay
- Emergency toolkit
- Coping library
- Basic insights and tracking

Pro unlocks eleven deeper tools, including exposure hierarchies and materials, structured programs, action planning, urge surfing, response prevention, uncertainty training, behavioral experiments, recovery metrics, and reflection tools.

The onboarding explicitly says there is no paywall and routes users directly into a free activity. The paid sheet only appears after Settings or a locked feature is selected.

That is considerate UX, but it means:

- Many users can solve their immediate need indefinitely without paying.
- Users may not understand why the deeper tools are worth $39.99.
- A user who only journals, logs compulsions, or uses Guided ERP may never see the paywall.
- "Move beyond tracking" is not fully aligned with a free tier that already contains multiple recovery exercises.

This is the strongest product-level explanation for downloads without revenue.

## StoreKit implementation review

Things that appear correct:

- Live product IDs match `ProService`, the tip service, and `ios/Patterns.storekit`.
- Purchase streams are subscribed at app startup.
- Pro uses `buyNonConsumable`.
- Purchase and restore success persist the entitlement.
- Pending transactions are completed.
- Products are fetched from StoreKit with three retries.
- Store-supplied localized pricing is displayed.
- Empty/error states have retry and restore affordances.
- Cancellations clear the in-flight state.
- RevenueCat is not used, so there is no RevenueCat catalog mismatch.

Suspicious but not shown to be suppressing revenue:

- The app grants entitlement from purchase-stream status without independently validating the receipt or checking later revocation/refund state.
- A restore timeout can report "no previous purchase" after 12 seconds even if a slow restore later completes.
- `notFoundIDs` is not inspected explicitly.
- The pending analytics implementation records purchase start/completion but not product-load failure, cancellation, purchase failure, or restore outcome.
- Tip loading accepts a partial product result without identifying which products are absent.

There is no confirmed purchase-flow failure. Six successful Pro purchases are strong evidence that the basic path works.

## Release and pricing timing

- App launched April 28.
- Pro shipped with 1.5; the version was submitted July 9. Purchases occurred July 12, 16, 18, 19, 29, and 30.
- The activation-first 1.6 update was submitted July 27. Two purchases occurred July 29–30.
- Pro was raised from $14.99 to $39.99 on August 16.
- Version 1.7 was submitted August 16 and released August 20.
- Version 1.8 was submitted August 25 and is currently waiting for review.

The ten days before the increase had 22 first downloads and zero IAPs. The ten days beginning August 16 had 32 first downloads and zero IAPs. Therefore:

- Every observed sale occurred at $14.99.
- There are no observed sales at $39.99.
- Revenue had already reached zero before the increase, so the data does not prove the price increase caused the stop.

The pending 1.8 listing changes the subtitle from "ERP tools for OCD recovery" to "Track urges, anxiety, triggers" and adds more privacy/tracking-oriented screenshots. That may attract more free-tracker intent while the paid tier is primarily deeper ERP. It is not live and cannot have caused current performance.

## Confirmed technical issues

- The Pro IAP localization incorrectly implies that Guided ERP is paid even though it is free.
- Live 1.7 has only on-device funnel telemetry; it cannot provide aggregate activation or paywall diagnostics.
- Pending 1.8's analytics vocabulary lacks purchase failure, cancellation, product-load result, and restore outcome.
- Entitlement handling is not receipt/revocation-aware.

None of these is a confirmed StoreKit purchase blocker.

## Possible product/monetization issues

These remain hypotheses:

- The free tier already satisfies most casual and moderate-intent users.
- Paywall exposure is too late or too rare.
- The value difference between free and Pro is not concrete enough for $39.99.
- Non-PPP prices—especially ₹3,999—suppress conversion.
- Users do not retain long enough to discover why exposure hierarchies, structured programs, and recovery metrics matter.
- The store listing attracts tracking/journaling intent while monetization depends on deeper ERP intent.

## Missing information

App Store Connect alone is not sufficient. It cannot tell us:

- Onboarding completion rate
- First meaningful action rate
- Paywall views per activated user
- Paywall source or triggering feature
- Product-load success/failure
- Purchase starts, cancellations, or errors
- Restore outcomes
- Whether non-payers ever tried a Pro tool
- Whether free users obtain enough value without Pro
- Reliable country/source/device/version download-to-purchase funnels

The App Manager API key was denied access to Apple's Analytics Reports API. The authenticated web dashboard supplied the metrics above, but detailed Sales & Trends exports also require the vendor number. A Sales/Admin-capable key plus vendor number would unlock authoritative dimensional reports.

Manual App Store Connect checks still needed:

- Paid Applications agreement, banking, and tax status
- App Privacy publish state
- A real production-device product-load, purchase, reinstall, and restore test
- Confirmation that the Xcode Cloud production analytics endpoint is configured for 1.8

Existing proceeds show that purchases are not globally blocked by account agreements.

## Smallest privacy-safe funnel

Pending 1.8 already implements much of this. Keep an app-scoped random installation ID—never IDFA, device ID, email, or a cross-app identifier—and collect only closed enums and aggregate counts.

| Event | Question answered |
|---|---|
| `app_open` | Are installs returning, and what are D1/D7 retention rates? |
| `onboarding_started` | Did the user reach onboarding? |
| `onboarding_completed` | Where does onboarding lose people? |
| `first_core_action` with closed action enum | Did the user experience actual value, and which free path activates best? |
| `pro_feature_tapped` with closed feature enum | Which paid capabilities have genuine demand? |
| `paywall_viewed` with closed source enum | What percentage of activated users ever see the offer, and from where? |
| `product_load_result` with success/coarse failure enum | Is StoreKit failing before a price can be shown? |
| `purchase_started` | Does the paywall persuade users to open Apple's purchase sheet? |
| `purchase_completed` | What is actual paywall conversion? |
| `purchase_failed` with coarse reason enum | Is conversion loss cancellation, unavailable product, verification, or store error? |
| `restore_started` | Are returning purchasers trying to recover access? |
| `restore_completed` with success/not-found/error enum | Does restore work reliably? |

Do not send journal text, OCD content, exposure titles, notes, distress details, names, emails, IP histories, or raw StoreKit error strings.

## Top five actions

### 1. Make the funnel decision-grade

Expected impact: High  
Effort: Medium

Add the missing failure/restore/product-load events and closed paywall source. Ship 1.8, verify its endpoint, and collect enough consented data before redesigning monetization.

Proof: reliable `activated → paywall_viewed → purchase_started → purchase_completed` rates, ideally at least 100 paywall views.

### 2. Run a lower-price and PPP experiment

Expected impact: High  
Effort: Low

Test a materially lower US price and territory-adjusted prices, especially India. The current price is 2.67× the only price that produced observed sales.

Proof: higher paywall-to-purchase rate and higher proceeds per download—not merely more transactions.

### 3. Expose Pro after demonstrated value

Expected impact: High  
Effort: Medium

After a user completes a free Guided ERP, compulsion-delay, or self-check flow, show a dismissible next-step card explaining the relevant Pro progression. Do not interrupt onboarding.

Proof: more paywall views per activated user without reducing first-core-action completion or D1 retention.

### 4. Clarify exactly what Pro buys

Expected impact: Medium  
Effort: Low

Fix the Guided ERP metadata inconsistency and lead with outcomes rather than a long tool list: build an exposure plan, practise it repeatedly, and see recovery progress.

Proof: higher `paywall_viewed → purchase_started` rate.

### 5. Improve activation and early return before buying traffic

Expected impact: High  
Effort: Medium

Sessions are deteriorating faster than downloads. Identify which onboarding path produces a first core action and a second-day return, then strengthen that path.

Proof: improved onboarding completion, first-core-action rate, D1/D7 retention, and sessions per new install.

## What not to focus on yet

- Do not buy ads. Campaign traffic is currently zero, and paid acquisition would amplify an unmeasured install-to-paywall funnel.
- Do not assume another screenshot or keyword overhaul will fix revenue. Current conversion benchmarks are respectable.
- Do not add a subscription merely because revenue is low; there is no evidence that billing frequency is the broken step.
- Do not rewrite StoreKit or migrate to RevenueCat solely for conversion. The existing catalog and basic purchase path work.
- Do not build more free tools before testing whether the current free tier already absorbs paid demand.
- Do not fund broad localization until download-by-country data shows where it will matter; prioritize pricing localization first.

## Evidence storage

Private raw ASC evidence and downloaded JSON were retained outside the repository at:

`/tmp/asc-patterns-diagnosis.4J52N8`
