# Patterns 1.10 physical-device QA

Status: **in progress — hardware execution pending**

This is the auditable checklist for `A11Y-DEVICE-01` and
`A11Y-DEVICE-02`. Simulator and widget evidence may prepare this gate, but
only observations made on physical hardware may check an item below or change
`reviewed-locales.json`.

## Candidate identity

Record this before testing. Both platforms must use artifacts built from the
same commit and frozen 1.10 source.

| Field | iPhone | Android |
| --- | --- | --- |
| Commit | `c73edbd` |  |
| Version/build | `1.10.0 (59)` |  |
| Artifact/TestFlight or internal-track identifier | TestFlight build `a504b7e7-9812-4155-bb3a-735aa4a1e915`; `Patterns Internal` |  |
| Device model | iPhone 12 (`iPhone13,2`, tester inventory) |  |
| OS version | iOS 26.6 (tester inventory) |  |
| Screen size | 6.1-inch |  |
| Tester and date | Aftaab Siddiqui; execution pending |  |
| Clean install completed | [ ] | [ ] |
| 1.9 upgrade install completed | [ ] | [ ] |
| Sandbox/test purchase account ready | [ ] | [ ] |

Save screenshots, screen recordings, crash logs, and defect references under
the release evidence location selected by the release owner. Do not place
personal journal or OCD content in evidence; use synthetic test data.

## Test protocol

For every task below, verify all of these together:

- spoken label, role, value, state, and hint are concise and accurate;
- swipe/focus order follows the visual and task order without traps;
- headings, groups, dialogs, sheets, and status announcements are exposed;
- Back, Cancel, Dismiss, Delete, Reset, Save, and Done work without a gesture-
  only alternative;
- focus remains predictable after navigation, validation, save, deletion,
  timer completion, purchase, and restore;
- controls remain reachable, readable, and at least 44×44 points;
- user-authored text and deliberately recorded SUDS/Y-BOCS values remain
  unchanged.

Log every defect with platform, locale, settings, route, reproduction steps,
expected result, actual result, severity, and evidence reference. Any open
safety, data-loss, purchase, screen-reader blocker, unreachable action, or
severe clipping defect fails the gate.

## iPhone common-task pass

Run on a physical iPhone with VoiceOver. Use synthetic content that exercises
validation, success, error, and destructive outcomes.

- [ ] Onboarding: complete both pages; verify privacy and self-help boundaries,
      headings, choice states, Import, and first focus on each route.
- [ ] Navigation: traverse every tab, primary action, sheet, dialog, and Back
      action; verify selected-tab state and no decorative semantics.
- [ ] Journal: create, edit, search, format rich text, dismiss, save, hear the
      factual confirmation, and use **Done for now**.
- [ ] OCD Tracker: create obsession and compulsion records, adjust distress,
      trigger specific validation, edit/delete, and use **Done for now**.
- [ ] Compulsion delay: start, pause/resume where available, complete, skip the
      optional reflection, hear timer completion once, and use **Done for now**.
- [ ] ERP: choose a template, edit the plan, record SUDS, complete practice,
      skip the optional reflection, and use **Done for now**.
- [ ] Insights: read Calm Insights, detailed Insights, charts, heatmap, trends,
      empty states, and deliberately recorded measurements without relying on
      visual geometry or colour.
- [ ] Recovery and safety: traverse Recovery Hub, immediate support, one
      recovery editor, a structured program, and the complete Y-BOCS self-check
      including its non-diagnostic and non-emergency boundaries.
- [ ] Settings and privacy: change language without losing route/form state;
      toggle Calm Insights and appearance; inspect privacy/analytics copy;
      configure a reminder; test App Lock; export and import synthetic data;
      verify all outcomes are announced once.
- [ ] Commerce: open Pro and all three tip products, cancel safely, complete a
      sandbox Pro purchase and one tip, relaunch, and restore; verify factual
      announcements and that tips unlock no features.

## Android common-task pass

Run the same ten tasks above on a physical Android phone with TalkBack. Also
verify Android Back behaviour, notification permission/channel copy, TalkBack
adjustable-control actions, and that focus returns correctly after system
purchase, biometric, file-picker, and notification-permission surfaces.

- [ ] Onboarding and navigation
- [ ] Journal and rich-text toolbar
- [ ] OCD Tracker
- [ ] Compulsion delay
- [ ] ERP
- [ ] Insights and chart alternatives
- [ ] Recovery, immediate support, programs, and Y-BOCS
- [ ] Settings, privacy, reminder, App Lock, export, and import
- [ ] Pro purchase, optional tip, cancellation, relaunch, and restore
- [ ] Android Back, notification channel, system dialogs, and returned focus

## Display, motion, colour, and orientation matrix

Repeat the main flows—not just static screen inspection—with these settings.
Record the device and evidence reference for each row.

| Platform | Configuration | Required observation | Pass |
| --- | --- | --- | --- |
| iPhone | 200% text | Common tasks have no clipped or unreachable action | [ ] |
| iPhone | Largest accessibility text, small supported phone | Reflow, scrolling, editor, sheets, and dialogs remain usable | [ ] |
| iPhone | Reduce Motion | No decorative slide, scale, pulse, or animated counter remains | [ ] |
| iPhone | Grayscale + Differentiate Without Color | Type, selection, trend, warning, success, and destructive meaning remain explicit | [ ] |
| iPhone | Light and Dark | Text, icons, borders, disabled controls, focus, and charts retain contrast | [ ] |
| iPhone | Portrait and landscape | Every common task retains reachable primary and escape actions | [ ] |
| Android | Maximum font and display size | Common tasks reflow and all actions remain reachable | [ ] |
| Android | Remove/Reduce animations | Decorative motion stops and timers remain understandable | [ ] |
| Android | Colour correction/grayscale | Meaning does not depend on colour | [ ] |
| Android | Light and Dark | Text, icons, borders, disabled controls, focus, and charts retain contrast | [ ] |
| Android | Portrait and landscape | Every common task retains reachable primary and escape actions | [ ] |

## Six-language device smoke pass

The deep common-task pass may use English, but each shipped language needs a
physical-device smoke pass on both platforms. Select the language in Settings,
confirm it applies without restart, relaunch to verify persistence, and inspect
Onboarding, Today, Journal editor, Tracker editor, Insights, Recovery Hub,
Y-BOCS, Settings/privacy, Pro, tips, one validation error, one confirmation,
and one system notification. Use the matching screen-reader/TTS voice when it
is available and record any pronunciation limitation.

| Language | iPhone | Android | Evidence/notes |
| --- | --- | --- | --- |
| English | [ ] | [ ] |  |
| Português (Brasil) | [ ] | [ ] |  |
| Deutsch | [ ] | [ ] |  |
| 日本語 | [ ] | [ ] |  |
| Español | [ ] | [ ] |  |
| Français | [ ] | [ ] |  |

Also verify a fresh install follows each supported device language, an
established 1.9 install stays in English, non-Brazilian Portuguese falls back
to English, and an unsupported device language falls back to English.

## Gate closure

The release owner may mark a platform complete only when:

1. its common-task list, configuration matrix, purchase/restore flow, and all
   six locale smoke checks pass on physical hardware;
2. no release-blocking defect remains open;
3. device/build/evidence fields above are complete;
4. the results are rechecked on the final signed candidate if its code or
   native configuration changes afterward.

Only then update the corresponding top-level `physicalDeviceQa` fields and
per-locale platform booleans in `reviewed-locales.json`. Store accessibility
claims and release-owner approval remain unchanged until both platforms pass.

## Preflight record

September 17, 2026:

- Flutter, Xcode 27, CocoaPods, and the Android toolchain report healthy.
- The iOS 27 simulator build exposed deployment targets below Xcode 27's iOS
  15 minimum; the project and Pods were raised consistently to iOS 15.
- The multilingual debug candidate then built, installed, and launched on the
  iPhone 17 Pro simulator.
- The multilingual debug candidate built, installed, and launched as
  `1.10.0` (`versionCode 32`) on an Android 17/API 37 emulator.
- Paired physical iPhone `00008101-000A21562181001E` was offline, and ADB had
  no physical Android device. No physical checklist item was inferred from
  simulator evidence.
