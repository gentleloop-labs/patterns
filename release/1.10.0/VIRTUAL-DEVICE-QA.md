# Patterns 1.10 virtual-device QA

Status: **passed after remediation — physical iPhone candidate available**

Executed: September 22, 2026
Repository HEAD: `66184f8`
Application source: `66184f8`
TestFlight candidate: `1.10.0 (60)` (`ced89606-46cf-4ab8-8e06-03c4d2b86a8c`)

The blocker fixes are committed in `66184f8`. The local Android release APK
was rebuilt with them, and TestFlight build 60 contains the same iOS source for
physical-device sign-off.

This is preflight evidence for the physical-device checklist. It does not
check any physical-device item or change `reviewed-locales.json`.

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
