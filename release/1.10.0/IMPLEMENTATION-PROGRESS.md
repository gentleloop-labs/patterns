# Patterns 1.10.0 implementation progress

Last updated: September 21, 2026

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
| SETTINGS-01 | Remaining shared settings, privacy, backup, reminders, dialogs, and errors | code complete | Six-language settings, privacy, App Lock, reminder, analytics-consent, ZIP export and ZIP/JSON import copy; complete localized backup previews; retry-safe scheduling/authentication/destructive outcomes; accessible 44-point controls, blocked background semantics, Reduced Motion, and 200% reflow coverage; 12 focused Settings/App Lock tests |
| SHELL-01 | Onboarding, What’s New, navigation, spotlight, and shared shell copy | code complete | Six-language first-run results, section intros, tab-tour finale and controls, navigation/FAB labels, and add-sheet copy; factual non-celebratory first-run confirmations; focus-contained tour route, 44-point actions, scrollable large-text layouts, and Reduced Motion across onboarding/navigation; 4 focused shell tests |
| COMMERCE-01 | Mobile Pro, tips, macOS StoreKit, and verified Windows/Linux licensing | code complete | Commerce widget/service tests; live desktop release configuration remains pending |
| AUDIT-01 | Zero reviewed mobile/shared user-facing literal candidates | verified | Mobile audit reports zero unreviewed candidates. Completion announcements use ICU composition; analytics returns stable action/theme IDs for localization at presentation boundaries; debug seed and capture-only marketing text have explicit narrow scope exclusions. |

## Verification and release gates

| ID | Gate | Status | Exit condition |
| --- | --- | --- | --- |
| COPY-01 | English copy freeze | verified | `source-freeze.json` hash-locks the 711-message canonical ARB and English iOS permission copy at source commit `b5813ae`; `tool/check_copy_freeze.dart`, zero-candidate mobile audit, translator-context gate, analysis, and the current 370-test suite pass |
| REVIEW-01 | Six-language guarded AI clinical, crisis, privacy, accessibility, and paywall review | verified | All six languages have 6/6 AI-assisted review passes complete. The 828-state mobile render matrix passes at normal, 200%, and maximum stress text scales after adaptive-layout fixes. Physical-device QA and release-owner approval remain separate gates. |
| A11Y-DEVICE-01 | Physical-iPhone accessibility verification | in progress | Multilingual `1.10.0 (59)` is valid in TestFlight and available to `Patterns Internal`; physical iPhone execution still must cover VoiceOver, largest text, Reduce Motion, grayscale, and Differentiate Without Color. |
| A11Y-DEVICE-02 | Physical-Android accessibility verification | in progress | Auditable checklist and Android 17/API 37 emulator install preflight complete; no physical Android device is connected. Common-task TalkBack, largest font/display scale, Reduced Motion, non-colour, and appearance must still pass on hardware. |
| DATA-01 | 1.9 upgrade and import/export compatibility | verified | Real `1.9.0+31` → `1.10.0+32` installed Android upgrade preserves records, stable IDs, Pro, reminders, and established-user defaults; native SQLite tests cover all 18 tables, complete replacement restore, older backups, rich journal JSON, Japanese text, and ISO storage; see `DATA-UPGRADE-AND-ROUNDTRIP.md` |
| PURCHASE-01 | Sandbox purchase, tip, and restore verification | pending | Physical iPhone and Android sandbox/test-product flows pass |
| ASSET-01 | Localized mobile screenshots | in progress | Existing eight-frame English Apple/Play campaign and renderer audited. Next: parameterize and review 8 iPhone and 8 Android images for each of 6 interface languages (96 unique images); regional storefront variants reuse them where their language and claims match |
| BUILD-01 | Mobile release builds | in progress | Signed multilingual iOS QA IPA `1.10.0 (59)` is valid in TestFlight; rebuild after physical QA findings, then verify the final iOS IPA and signed Android AAB |
| STORE-01 | Coordinated App Store and Google Play 1.10 submission | blocked | Approved matrix, unchanged PPP schedules, builds/assets/IAPs/products validated and attached |

## Current metrics

- Repository version: `1.10.0+32`; TestFlight QA candidate: `1.10.0 (59)`.
- Release announcement: `patterns_1_10`.
- Rendered mobile-layout matrix: 828 states across 46 representative surfaces and states, six languages, and three text scales passing.
- Full Flutter suite after DATA-01: 370 tests passing.
- Mobile/shared literal audit: zero unreviewed candidates; stable localization selector keys and debug-only sources are covered by documented allowlist rules.
- Store drafts: field, locale, and character-limit validation passing; not approved or uploaded.
