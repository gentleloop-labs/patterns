# Patterns 1.10 rendered mobile-layout review

Status: **complete**
Reviewed: September 17, 2026
Method: AI-assisted Flutter widget rendering plus deterministic overflow and
scroll-reachability checks

This pass covers the six in-app languages at a 390×844 phone viewport with
Reduced Motion enabled and three text configurations: normal, 200%, and a
3.2× maximum-accessibility stress scale.

## Evidence matrix

`test/rendered_mobile_layout_review_test.dart` renders and scrolls these 16
representative states for every language and text configuration:

1. Onboarding promise
2. Onboarding choices
3. Today
4. Journal list
5. Journal editor
6. OCD Tracker
7. OCD event editor
8. Compulsion delay
9. Insights with Calm Insights enabled
10. Recovery Hub
11. Immediate support
12. ERP plan editor
13. Y-BOCS introduction
14. Settings
15. Patterns Pro
16. Optional tips

That is 288 rendered states. Each state is checked before scrolling and after
up to ten vertical scroll steps so off-screen widgets enter layout. Any Flutter
rendering exception, clipped flex, or overflow fails the release test with the
language, scale, surface, and scroll position.

Focused tests continue to cover Y-BOCS checklist selection, recovery-tool
editors, quiet-completion flows, validation, semantics, 44-point targets,
localized errors, and representative 200% layouts beyond this matrix.

## Defects found and resolved

- Made both onboarding pages one continuous scroll region so calls to action,
  choices, and safety copy remain reachable at maximum text sizes.
- Reflowed the Tracker title/action header and made its translated filter
  choices horizontally reachable at accessibility sizes.
- Allowed Insights count/value groups to wrap instead of overflowing at the
  maximum stress scale.
- Made ERP template selectors scale vertically, stacked template details at
  large text sizes, and allowed the practice-guide heading to wrap.

## Result and boundary

All 18 language/scale combinations pass. No translation or frozen English
source changed during this pass.

This is renderer-level layout evidence. It does not replace physical-device
VoiceOver, TalkBack, platform font/display scaling, focus traversal, purchase,
or orientation verification. Those remain separate release gates.
