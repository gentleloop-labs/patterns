# Patterns 1.10 store review matrix

Status: **working draft — not an upload approval request**

No App Store Connect version, build, tip-product version, localization,
screenshot, or submission was created by this work. The only remote operations
were read-only inventory and pricing checks.

## Locale readiness

| Locale | App metadata | IAP copy | iPhone 6.9-inch | macOS | Native clinical/privacy review | Upload |
| --- | --- | ---: | ---: | ---: | --- | --- |
| en-US | draft, limits pass | 4/4 draft | source set 8/8 | 0/8 | pending copy freeze and device QA | blocked |
| en-GB | draft, limits pass | 4/4 draft | 0/8 | 0/8 | pending | blocked |
| en-CA | draft, limits pass | 4/4 draft | 0/8 | 0/8 | pending | blocked |
| en-AU | draft, limits pass | 4/4 draft | 0/8 | 0/8 | pending | blocked |
| pt-BR | machine-assisted draft | 4/4 draft | 0/8 | 0/8 | native review required | blocked |
| de-DE | machine-assisted draft | 4/4 draft | 0/8 | 0/8 | native review required | blocked |
| ja | machine-assisted draft | 4/4 draft | 0/8 | 0/8 | native review required | blocked |
| es-MX | market-specific draft | 4/4 draft | 0/8 | 0/8 | Mexico review required | blocked |
| es-ES | market-specific draft | 4/4 draft | 0/8 | 0/8 | Spain review required | blocked |
| fr-FR | market-specific draft | 4/4 draft | 0/8 | 0/8 | France review required | blocked |
| fr-CA | market-specific draft | 4/4 draft | 0/8 | 0/8 | Canada review required | blocked |

The metadata and IAP drafts live beside this matrix, outside canonical
`metadata/`. `tool/validate_store_drafts.dart` checks required locales,
non-empty IAP fields, duplicate keywords, and Apple character limits.

Every current English ARB message has translator context, and ARB message,
metadata, placeholder, and selector parity passes across the six languages.
Full-product copy is not frozen: the main mobile Settings surface is now
localized and covered by a Japanese widget test, while the conservative
literal audit still reports 662 candidates that must be localized or narrowly
reviewed before production.

## IAP resource plan

| Product | App Store ID | Version resource | Action after approval |
| --- | --- | --- | --- |
| Patterns Pro | 6785513588 | a08dbd2f-033d-42e6-875a-c7844019a602, PREPARE_FOR_SUBMISSION | reuse |
| Small tip | 6770887482 | no editable version | create exactly one mutable version |
| Medium tip | 6770892197 | no editable version | create exactly one mutable version |
| Large tip | 6770892883 | no editable version | create exactly one mutable version |

All four products have non-empty copy drafted for all 11 storefront locales.
Tip descriptions explicitly say that tips are optional and unlock no features.

## Screenshot campaign

The existing eight-frame iPhone source campaign now depicts Calm Insights
without a score, streak, delta, or consistency percentage. It renders exactly
eight `APP_IPHONE_69` images at 1290×2796, contains no price amounts, and no
longer generates duplicate 6.5-inch assets. This source set is for visual and
copy review only; localized sets are blocked until in-app copy freezes.

A genuine desktop source campaign at 2880×1800 is still required. Mobile
frames must not be repurposed as macOS screenshots.

## Reviewer packet schema

Each reviewed string or store field must be recorded with:

| Field | Required value |
| --- | --- |
| key / store field | stable ARB key, IAP product+field, or metadata field |
| screen context | route, dialog, notification, PDF, or storefront placement |
| English source | frozen canonical source |
| draft | locale draft, with ICU placeholders unchanged |
| risk category | general, accessibility, clinical, crisis/safety, privacy, or paywall |
| screenshot reference | frame number or `n/a` |
| reviewer | qualified reviewer name |
| revisions | dated notes |
| sign-off status | pending, changes requested, or approved |

Sign-off is represented in `reviewed-locales.json`. The release script remains
fail-closed until every required review, physical-iPhone accessibility QA, and
release-owner approval is true.

## Release-owner approval boundary

Approval must happen only after this matrix shows complete in-app copy, 8/8
iPhone images and 8/8 genuine macOS images for every storefront locale, all
native reviews, passing build/test gates, and a second PPP drift check. Approval
authorizes guarded App Store Connect apply/upload steps; it never authorizes a
price-schedule write.
