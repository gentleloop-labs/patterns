# Patterns 1.10.0 implementation progress

Last updated: September 10, 2026

This is the working ledger for completing the unified 1.10 release plan. A
unit moves to **complete** only when its scoped implementation, focused tests,
static analysis, localization gates, and literal-audit update pass. Physical
device and store-review gates stay separate so code completion is never
mistaken for release approval.

Status values: `pending`, `in progress`, `code complete`, `verified`,
`blocked`.

## Product implementation

| ID | Unit | Status | Acceptance evidence |
| --- | --- | --- | --- |
| FOUNDATION-01 | Language persistence, production gate, notifications, PDFs, native locale declarations | code complete | Existing unit/widget coverage; production review manifest remains closed |
| CALM-01 | Calm Insights preference, migration, factual summaries, hidden calculated scores | code complete | `test/calm_insights_test.dart`, preference migration tests |
| COMPLETE-01 | Quiet completion contract for journal, tracking, delay, and ERP | code complete | `test/activity_completion_test.dart` plus flow-specific tests |
| JOURNAL-01 | Mobile journal list/editor localization and accessibility | code complete | Six-locale copy, localized dates, safe errors, editor semantics, large-text/reduced-motion tests |
| JOURNAL-02 | Shared desktop journal localization and accessibility | code complete | Six-locale copy, localized dates/times, safe errors, keyboard-accessible entries, selectable reader, 200% text test |
| TODAY-01 | Today first-run and established-state localization | code complete | Six-locale first-run, established, Calm Insights, recommendation, and desktop coverage; locale widget tests |
| TODAY-02 | Today semantics, large text, Reduced Motion, and non-colour cues | in progress | Mobile and desktop Today surfaces under active implementation |
| TRACK-01 | OCD tracker localization, validation, and accessibility | pending | — |
| INSIGHTS-01 | Insights localization and accessible chart alternatives | pending | — |
| RECOVERY-01 | Recovery Hub and ERP tools localization/accessibility | pending | — |
| CONTENT-01 | Stable-ID localized OCD tracks, programs, and Y-BOCS content | pending | — |
| SETTINGS-01 | Remaining shared settings, privacy, backup, reminders, dialogs, and errors | pending | — |
| SHELL-01 | Onboarding, What’s New, navigation, spotlight, and shared shell copy | pending | — |
| COMMERCE-01 | Mobile Pro, tips, macOS StoreKit, and verified Windows/Linux licensing | code complete | Commerce widget/service tests; live desktop release configuration remains pending |
| AUDIT-01 | Zero reviewed user-facing literal candidates | in progress | Baseline after COMMERCE-01: 652 candidates |

## Verification and release gates

| ID | Gate | Status | Exit condition |
| --- | --- | --- | --- |
| COPY-01 | English copy freeze | blocked | Product and accessibility implementation complete; literal audit cleared |
| REVIEW-01 | Six-language clinical, crisis, privacy, accessibility, and paywall review | blocked | Reviewer manifest signed or release policy explicitly amended |
| A11Y-DEVICE-01 | Physical-iPhone accessibility verification | pending | Common-task VoiceOver, largest text, Reduce Motion, grayscale, and Differentiate Without Color pass |
| DATA-01 | 1.9 upgrade and import/export compatibility | pending | Real-data upgrade and round-trip evidence recorded |
| PURCHASE-01 | Sandbox purchase, tip, and restore verification | pending | iPhone and macOS sandbox flows pass |
| DESKTOP-01 | Windows/Linux live commerce configuration | pending | HTTPS checkout and expected Lemon Squeezy product ID compile definitions verified |
| ASSET-01 | Localized screenshots | blocked | Copy/UI freeze, then 8 iPhone and 8 genuine macOS images per storefront |
| BUILD-01 | Release builds | pending | iOS, Android AAB, macOS, and Windows release builds pass |
| STORE-01 | App Store Connect 1.10 submission | blocked | Approved matrix, unchanged PPP schedule, builds/assets/IAPs validated and attached |

## Current metrics

- Version: `1.10.0+32` (final build number must still be reconciled remotely).
- Release announcement: `patterns_1_10`.
- Full Flutter suite after JOURNAL-02: 224 passing tests.
- Literal audit: 598 candidates after TODAY-01, down from 652.
- Store drafts: field, locale, and character-limit validation passing; not approved or uploaded.
