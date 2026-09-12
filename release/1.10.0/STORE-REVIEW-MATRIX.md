# Patterns 1.10 mobile store review matrix

Status: **working draft — not an upload approval request**

No 1.10 store version, build, product version, localization, screenshot, or
submission has been created remotely. Existing PPP prices must remain
unchanged. App Store Connect inventory and pricing checks have been read-only.

## In-app language readiness

| Language | Product copy | Guarded AI review | Rendered layouts | Physical iPhone | Physical Android | Production enablement |
| --- | --- | --- | --- | --- | --- | --- |
| English | frozen, 711 messages | pending | pending | pending | pending | blocked |
| Português (Brasil) | complete draft | pending | pending | pending | pending | blocked |
| Deutsch | complete draft | pending | pending | pending | pending | blocked |
| 日本語 | complete draft | pending | pending | pending | pending | blocked |
| Español | complete draft | pending | pending | pending | pending | blocked |
| Français | complete draft | pending | pending | pending | pending | blocked |

The frozen English source is recorded in `source-freeze.json`. The
mobile/shared literal audit reports zero unreviewed candidates, all 711 English
messages have translator context, and ARB key/metadata/select parity passes.
Reviews are recorded honestly as `ai_assisted`; they are not native-speaker or
clinician review.

## App Store readiness

| Locale | Metadata | IAP copy | iPhone screenshots | Review | Upload |
| --- | --- | ---: | ---: | --- | --- |
| en-US | draft, limits pass | 4/4 draft | source campaign 8/8 | pending | blocked |
| en-GB | draft, limits pass | 4/4 draft | 0/8 | pending | blocked |
| en-CA | draft, limits pass | 4/4 draft | 0/8 | pending | blocked |
| en-AU | draft, limits pass | 4/4 draft | 0/8 | pending | blocked |
| pt-BR | market draft, limits pass | 4/4 draft | 0/8 | pending | blocked |
| de-DE | market draft, limits pass | 4/4 draft | 0/8 | pending | blocked |
| ja | market draft, limits pass | 4/4 draft | 0/8 | pending | blocked |
| es-MX | market draft, limits pass | 4/4 draft | 0/8 | pending | blocked |
| es-ES | market draft, limits pass | 4/4 draft | 0/8 | pending | blocked |
| fr-FR | market draft, limits pass | 4/4 draft | 0/8 | pending | blocked |
| fr-CA | market draft, limits pass | 4/4 draft | 0/8 | pending | blocked |

## Google Play readiness

| Locale | Listing | Product copy | Phone screenshots | Review | Upload |
| --- | --- | ---: | ---: | --- | --- |
| en-US | draft | 4/4 draft source | 0/8 | pending | blocked |
| en-GB | draft | 4/4 draft source | 0/8 | pending | blocked |
| en-CA | draft | 4/4 draft source | 0/8 | pending | blocked |
| en-AU | draft | 4/4 draft source | 0/8 | pending | blocked |
| pt-BR | draft | 4/4 draft source | 0/8 | pending | blocked |
| de-DE | draft | 4/4 draft source | 0/8 | pending | blocked |
| ja-JP | draft | 4/4 draft source | 0/8 | pending | blocked |
| es-419 | draft | 4/4 draft source | 0/8 | pending | blocked |
| es-ES | draft | 4/4 draft source | 0/8 | pending | blocked |
| fr-FR | draft | 4/4 draft source | 0/8 | pending | blocked |
| fr-CA | draft | 4/4 draft source | 0/8 | pending | blocked |

The current store draft files use App Store locale identifiers. Google Play
copy must be materialized into its supported locale directories after review,
mapping `ja` to `ja-JP` and the Latin American Spanish source to `es-419`.

## App Store IAP resource plan

| Product | App Store ID | Version resource | Action after final matrix approval |
| --- | --- | --- | --- |
| Patterns Pro | 6785513588 | `a08dbd2f-033d-42e6-875a-c7844019a602`, `PREPARE_FOR_SUBMISSION` | reuse |
| Small tip | 6770887482 | no editable version | create exactly one mutable version |
| Medium tip | 6770892197 | no editable version | create exactly one mutable version |
| Large tip | 6770892883 | no editable version | create exactly one mutable version |

All four products have non-empty draft copy for all App Store locales. Every
tip description says that the tip is optional and unlocks no features. Google
Play product state and localization identifiers still require a fresh
read-only inventory before any write plan is prepared.

## Screenshot campaign

The eight-frame iPhone source campaign depicts Calm Insights without a score,
streak, delta, or consistency percentage. The final App Store campaign must
contain eight 1290×2796 images per locale. The final Google Play campaign must
contain eight 1080×1920 images per locale. Neither set may contain prices.
Localized capture is blocked until the guarded language review settles all
copy revisions.

Desktop screenshots and desktop storefront metadata are outside the 1.10
mobile release scope.

## Reviewer evidence

Every language and storefront review must retain:

- the stable ARB key or store/product field;
- route, dialog, notification, PDF, or storefront context;
- frozen English source and reviewed draft;
- general, accessibility, clinical, crisis/safety, privacy, or payment risk;
- preserved placeholders and ICU cases;
- identified revision and resolution notes;
- review method and pass status;
- rendered frame reference where applicable.

`reviewed-locales.json` is the machine-enforced summary. The production build
stays closed until all independent review passes, rendered-layout checks,
physical-device gates, per-store screenshot reviews, and release-owner
approval are complete.

## Release-owner approval boundary

Final approval happens only after both signed mobile builds pass, physical
iPhone and Android checklists pass, upgrade/data and sandbox purchase evidence
is recorded, all 176 localized screenshots are reviewed, the App Store and
Google Play matrices are complete, and a second PPP drift check passes.
Approval authorizes guarded metadata, product, screenshot, build attachment,
and submission operations. It never authorizes a price-schedule write.
