# Patterns 1.10 virtual-device QA

Status: **VQA-03 remediated and emulator-verified — Play replacement pending**

Executed: September 22 and October 5, 2026
Current repository HEAD: `ed30b17`
Current Android application source: `ed30b17`
TestFlight candidate: `1.10.0 (60)` (`ced89606-46cf-4ab8-8e06-03c4d2b86a8c`)

The blocker fixes are committed in `66184f8`. The local Android release APK
was rebuilt with them, and TestFlight build 60 contains the same iOS source for
physical-device sign-off.

This is preflight evidence for the physical-device checklist. It does not
check any physical-device item or change `reviewed-locales.json`.

## October 5 Android candidate-32 retest

The release owner directed the remaining Android product and accessibility
checks to run on the emulator and accepted the existing physical purchase
history rather than requiring another real purchase. This section records
emulator-assisted evidence honestly; it does not relabel emulator observations
as physical-device QA.

Candidate:

- source commit: `ed30b17`;
- package: `com.maskedsyntax.patterns`;
- version: `1.10.0` (`versionCode 32`);
- build define: `PATTERNS_ENABLE_MULTILINGUAL=true`;
- release APK SHA-256:
  `a970b5752190ce034e068980f23f905c345e9566eb65e79737eab3e0bd53b36f`;
- device: `Medium_Phone`, Android 17/API 37, 1080×2400 at 420 dpi.

Passed observations:

- The current release APK built, installed, launched, and reported the expected
  package/version identity.
- `flutter analyze` completed with no issues. All 374 Flutter tests passed,
  including the 828-state six-language layout matrix. The mobile literal,
  translator-context, and ARB review-integrity gates passed for all 711
  messages in six languages.
- English, Brazilian Portuguese, German, Japanese, Spanish, and French each
  applied immediately, survived a process restart, and exposed localized
  Today, Journal, Tracker, Practice, Insights, and Settings semantics.
- Fresh onboarding, all primary tabs, Journal save, Tracker validation/save,
  the complete one-minute compulsion-delay flow, optional-reflection skip,
  Recovery immediate-support boundaries, and Y-BOCS non-diagnostic and
  non-emergency boundaries were exercised with synthetic data.
- Journal, tracked moment, and compulsion-delay completion data were saved
  before their factual completion presentation. Each presentation exposed a
  prominent **Done for now** action.
- At font scale 2.0, 560 dpi, and landscape, Japanese Today, Journal, and
  Insights remained scrollable. Body content ended where navigation began;
  the delay action and Journal content could be scrolled above navigation.
- With all three Android animation scales set to zero, navigation and the
  tested task flows remained usable. Dark mode and the Android monochromacy
  setting retained explicit labels, legends, icons, and chart text
  alternatives instead of depending on colour alone.
- TalkBack bound successfully with touch exploration enabled. Touch focus and
  external-keyboard traversal reached Today summaries and Insights. The rich
  Journal editor accepted external-keyboard input, exposed Bold, Italic, and
  Bulleted-list controls, saved successfully, and moved accessibility focus to
  the factual **Saved** confirmation.
- The Android notification permission dialog returned to the running delay
  timer. Export and import opened the Android document picker and returned to
  Settings after cancellation without a crash or lost records.
- Enabling the daily reminder scheduled the expected 8:00 PM alarm. Changing
  the app to Spanish kept the reminder enabled, rescheduled the alarm, and
  changed its visible time copy to locale-appropriate `20:00`. The reminder
  was disabled and emulator accessibility/display overrides were reset after
  testing.
- The Pro and tip sheets opened, reflowed, described restore behaviour and the
  no-feature-unlock tip boundary, and handled the expected sideloaded-build
  `purchases unavailable` state without crashing. A sideloaded APK cannot
  exercise a real Google Play purchase sheet.

### VQA-03 — analytics consent interrupts first quiet completion

Severity: **resolved after Android build 32; build 32 remains affected**
Platform: Android, with shared Flutter behaviour

Reproduction:

1. Start from an installation whose analytics-consent decision is undecided.
2. Create and save the first Journal entry.
3. Observe the route before the factual completion sheet can be used.

Observed: the **Help improve Patterns?** anonymous-usage dialog appears over
the Journal completion. Dismissing it reveals the correct **Saved** and
**Done for now** presentation.

Expected: a completion path presents only the saved factual confirmation and
**Done for now**. Analytics consent should be deferred to a later neutral
session, just like other non-essential prompts.

No data loss, analytics opt-in, or crash occurred. The dialog accurately says
collection remains off unless chosen, but its timing conflicts with the 1.10
quiet-completion contract.

Resolution:

- Analytics-consent eligibility is captured once when Home mounts. A meaningful
  action recorded later in that Home session cannot open the prompt over its
  completion presentation.
- An undecided installation with an already-recorded meaningful action remains
  eligible on a later neutral Home mount, so consent is deferred rather than
  removed.
- `test/analytics_consent_timing_test.dart` covers both guarantees. The focused
  quiet-completion suite, `flutter analyze`, and all 376 Flutter tests pass.
- A multilingual `1.10.0` release APK with version code 33 was built from the
  patched source. Its SHA-256 is
  `2a98940939a6ed1663832c6f5546bc1d5312306f904bd777fd4b5f808a442116`.
- Build 33 was installed on the Android 17/API 37 emulator. A first regular
  Journal save retained the uninterrupted **Saved** / **Done for now** result,
  no consent dialog appeared later in that session, and the dialog appeared
  after the next full app launch.
- The patch was made after Android build 32. Build 33 still needs to replace it
  on the Play track before release.

Still not established by this emulator pass:

- audible TalkBack wording, pronunciation, and live-region quality;
- haptics and real touch-target feel;
- biometric return focus because the emulator has no enrolled device
  credential;
- real Google Play purchase, cancellation, and restore surfaces. The release
  owner accepted previously completed physical purchase testing for this
  unchanged billing engine.

## Environments

| Platform | Virtual device | Runtime | Candidate |
| --- | --- | --- | --- |
| iOS | `iphone17`, 1206×2622 | iOS 26.5, Xcode 27.0 (`27A266a`) | multilingual debug simulator app, `1.10.0+32` |
| Android | `Medium_Phone`, 1080×2400 at 420 dpi | Android 17/API 37, emulator 37.1.11 | multilingual release APK, `1.10.0 (59)` |

Toolchain: Flutter 3.44.4 and Android platform tools 37.0.1.

The iOS simulator package retains the repository build number because Flutter
does not produce an iOS simulator release artifact. TestFlight build 60 is the
signed device candidate containing the remediations. The Android APK was built and inspected
as version name `1.10.0`, version code `59`, minimum SDK 24, and target SDK 36.

## Passed virtual checks

- The complete Flutter suite passed after remediation: 372 tests.
- The deterministic layout suite passed 828 rendered states: 46 representative
  surfaces/states × six languages × normal, 200%, and maximum stress scales.
- Fresh-install device-locale resolution passed on both platforms for `en-US`,
  `pt-BR`, `de-DE`, `ja-JP`, `es-ES`, and `fr-FR`.
- Fresh `pt-PT` and `ar-SA` installations correctly fell back to English on
  both platforms.
- The iOS onboarding path reached Today, and the live accessibility tree
  exposed the privacy/self-help boundaries and actionable controls.
- The iOS Journal and rich-editor trees exposed Back, date, Saved, Save,
  Journal editor, the writing field, Bold, Italic, and Bulleted list.
- The Android release APK installed and launched. Onboarding, all five tabs,
  Journal, Tracker, Practice, Insights, and Today were traversed in the normal
  configuration.
- Android Insights exposed textual alternatives for mood, urge intensity, ERP
  practice, and recent-activity visualizations.
- After the stress pass, both virtual devices were restored to portrait, light
  appearance, standard text/display scale, normal animations, and disabled
  screen-reader overrides. The app relaunched normally on both.

## Resolved release blockers

### VQA-01 — bottom navigation obscures content at maximum scale in landscape

Severity: **release blocker**
Platforms: iOS and Android

Reproduction:

1. Enable the largest available accessibility text/display configuration.
2. Open a content-heavy primary tab.
3. Rotate the virtual phone to landscape.
4. Scroll toward the primary action or lower content.

Observed:

- On Android at font scale 2.0 and 560 dpi, the bottom navigation occupies
  approximately y=709–968 while the scrolled **Start a delay** action occupies
  y=791–959. The navigation therefore covers the action and makes it
  unreliable to activate.
- On iOS at `accessibility-extra-extra-extra-large`, the enlarged bottom
  navigation covers most lower Journal content in landscape.

Expected: navigation and body content reflow or scroll independently so every
primary and escape action remains visible and reachable.

Resolution and retest:

- The shared tab bar now participates in `Scaffold` layout instead of being
  painted over page content. Body and navigation bounds meet without overlap.
- The redundant floating Journal/Tracker action is suppressed at 200% and
  larger text scales; the in-page action remains available.
- On the Android maximum-scale landscape retest, **Start a delay** occupied
  y=318–486 while navigation began at y=737.
- Scrolling exposed the Journal entry action and complete empty state above
  navigation on both iOS and Android.
- Status: **resolved in the working tree**.

### VQA-02 — iOS Journal clips large text and date controls

Severity: **release blocker**
Platform: iOS

At the largest accessibility text size, the Journal heading breaks inside the
word (`Journ` / `al`), date cards clip horizontally, and the floating/bottom
navigation overlaps empty-state content. The defects are visible in portrait
and become more severe in landscape.

Expected: the heading wraps only at valid boundaries, date controls remain
horizontally reachable, and navigation does not cover meaningful content.

Resolution and retest:

- Large-text Journal chrome is part of the page's vertical scroll region.
- The title stays on one fitted line instead of breaking within a word.
- Compact date-control typography is capped at 200% while retaining full
  accessibility labels; pills grow and remain horizontally scrollable.
- Portrait and landscape iOS retests at the largest content size showed the
  complete title and date labels. The entry action and every line of the empty
  state could be scrolled above navigation.
- Status: **resolved in the working tree**.

These defects explain the boundary of the widget render suite: it detects
Flutter layout exceptions and flex overflows, but a deliberately layered or
clipped layout can remain exception-free while still being unusable on a
platform viewport.

## Inconclusive virtual checks

- AXe could focus and activate the iOS rich editor and toolbar, but injected
  keyboard text did not persist in the Quill editor. Editing and formatting
  with a real keyboard and VoiceOver remains a physical-device check.
- Android TalkBack was enabled after clearing its notification-permission
  prompt. Touch exploration was active, its visual focus reached the grouped
  Today heading/Settings control and **Start a delay**, and the service remained
  bound without crashing. Injected gestures and keyboard events could not
  drive repeatable item-by-item traversal, and audio output was not observable,
  so no TalkBack common-task or spoken-copy pass is claimed.
- Virtual devices cannot validate the quality of spoken output, real touch
  target feel, haptics, biometric return focus, notification delivery in
  realistic device states, or store purchase sheets.

## Work reserved for physical devices

After a replacement candidate containing the fixes is installed, the release
owner still needs to run:

- VoiceOver and TalkBack speech, gesture, focus-order, and status-announcement
  checks through every common task;
- rich-text entry and toolbar use with the platform keyboard;
- largest-text, reduced-motion, grayscale/non-colour, Light/Dark, portrait,
  and landscape flows on actual screens;
- notification permission, channel, reminder, and timer delivery;
- biometric/system-dialog return focus;
- StoreKit and Google Play sandbox Pro purchase, all tip surfaces,
  cancellation, relaunch, and restore;
- a real iPhone 1.9→1.10 upgrade and final import/export spot check;
- perceived contrast, target size, pronunciation, and assistive-technology
  behaviour that cannot be established from an emulator accessibility tree.
