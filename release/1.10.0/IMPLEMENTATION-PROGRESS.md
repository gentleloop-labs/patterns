# Patterns 1.10.0 implementation progress

Last updated: September 12, 2026

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
| FOUNDATION-01 | Language persistence, production gate, notifications, PDFs, native locale declarations | code complete | Existing unit/widget coverage; honest AI-assisted iOS/Android review manifest remains closed |
| CALM-01 | Calm Insights preference, migration, factual summaries, hidden calculated scores | code complete | `test/calm_insights_test.dart`, preference migration tests |
| COMPLETE-01 | Quiet completion contract for journal, tracking, delay, and ERP | code complete | `test/activity_completion_test.dart` plus flow-specific tests |
| JOURNAL-01 | Mobile journal list/editor localization and accessibility | code complete | Six-locale copy, localized dates, safe errors, editor semantics, large-text/reduced-motion tests |
| JOURNAL-02 | Shared desktop journal localization and accessibility | code complete | Six-locale copy, localized dates/times, safe errors, keyboard-accessible entries, selectable reader, 200% text test |
| TODAY-01 | Today first-run and established-state localization | code complete | Six-locale first-run, established, Calm Insights, recommendation, and desktop coverage; locale widget tests |
| TODAY-02 | Today semantics, large text, Reduced Motion, and non-colour cues | code complete | Localized control/chart semantics, 44-point actions, 200% mobile/desktop reflow, Reduced Motion and explicit day-state tests |
| TRACK-01 | OCD tracker localization, validation, and accessibility | code complete | Six-locale copy, locale-aware dates, safe CRUD failures, explicit adjustable distress semantics, 44-point controls, large-text and Reduced Motion coverage; 6 focused tests |
| INSIGHTS-01 | Insights localization and accessible chart alternatives | code complete | Six-locale copy, factual Calm Insights, pressure-metric suppression, localized number/date formatting, chart and heatmap text alternatives, non-colour trend cues, safe errors, 200% reflow, Reduced Motion, and 36 focused/regression tests |
| RECOVERY-01 | Recovery Hub and ERP tools localization/accessibility | code complete | Every mobile recovery surface is complete. Uncertainty Training resolves its three exercises from unchanged stable IDs, hides calculated practice counts in Calm Insights while retaining the deliberately recorded willingness value, and keeps failed saves retryable. Action Planner preserves user-authored situations, actions and notes, stores dates with the unchanged ASCII ISO codec, formats visible dates for the active locale, exposes explicit completion state, and keeps save, toggle and delete failures retryable. Both final units include six-language copy, accessible summaries and 44-point controls, 200% reflow, Reduced Motion coverage, and 10 focused tests. |
| CONTENT-01 | Stable-ID localized OCD tracks, programs, and Y-BOCS content | code complete | Structured programs, all five OCD tracks, and every Y-BOCS prompt, response anchor, symptom category/item, and severity explanation resolve from unchanged stable IDs in all six languages. Scoring, stored IDs, and English desktop compatibility remain unchanged; PDF theme labels now follow the selected locale. |
| SETTINGS-01 | Remaining shared settings, privacy, backup, reminders, dialogs, and errors | pending | — |
| SHELL-01 | Onboarding, What’s New, navigation, spotlight, and shared shell copy | pending | — |
| COMMERCE-01 | Mobile Pro, tips, macOS StoreKit, and verified Windows/Linux licensing | code complete | Commerce widget/service tests; live desktop release configuration remains pending |
| AUDIT-01 | Zero reviewed mobile/shared user-facing literal candidates | in progress | Mobile-only scope correctly excludes preserved desktop and legacy desktop-shell paths; 56 true mobile/shared candidates after completing every recovery unit |

## Verification and release gates

| ID | Gate | Status | Exit condition |
| --- | --- | --- | --- |
| COPY-01 | English copy freeze | blocked | Product and accessibility implementation complete; literal audit cleared |
| REVIEW-01 | Six-language guarded AI clinical, crisis, privacy, accessibility, and paywall review | blocked | Every recorded AI-assisted pass complete, risks resolved, physical QA recorded, and release owner approval given |
| A11Y-DEVICE-01 | Physical-iPhone accessibility verification | pending | Common-task VoiceOver, largest text, Reduce Motion, grayscale, and Differentiate Without Color pass |
| A11Y-DEVICE-02 | Physical-Android accessibility verification | pending | Common-task TalkBack, largest font/display scale, Reduced Motion, non-colour, and appearance pass |
| DATA-01 | 1.9 upgrade and import/export compatibility | pending | Real-data upgrade and round-trip evidence recorded |
| PURCHASE-01 | Sandbox purchase, tip, and restore verification | pending | Physical iPhone and Android sandbox/test-product flows pass |
| ASSET-01 | Localized mobile screenshots | blocked | Copy/UI freeze, then 8 iPhone and 8 Android images per storefront locale |
| BUILD-01 | Mobile release builds | pending | Signed iOS IPA and Android AAB pass with the multilingual gate enabled |
| STORE-01 | Coordinated App Store and Google Play 1.10 submission | blocked | Approved matrix, unchanged PPP schedules, builds/assets/IAPs/products validated and attached |

## Current metrics

- Version: `1.10.0+32` (final build number must still be reconciled remotely).
- Release announcement: `patterns_1_10`.
- Full Flutter suite after completing all recovery units: 307 passing tests.
- Mobile/shared literal audit: 56 candidates; stable localization selector keys are covered by narrow documented allowlist rules.
- Store drafts: field, locale, and character-limit validation passing; not approved or uploaded.
