# Patterns 1.10 rendered mobile-layout review

Status: **complete**
Reviewed: September 17, 2026
Method: AI-assisted Flutter widget rendering plus deterministic overflow and
scroll-reachability checks

This pass covers the six in-app languages at a 390×844 phone viewport with
Reduced Motion enabled and three text configurations: normal, 200%, and a
3.2× maximum-accessibility stress scale.

## Evidence matrix

`test/rendered_mobile_layout_review_test.dart` renders and scrolls 46
representative states for every language and text configuration. They cover:

1. Onboarding promise and choices
2. Today
3. Journal list and editor
4. OCD Tracker and event editor
5. Compulsion delay, stop dialog, and reflection
6. Insights and Recovery Metrics
7. Recovery Hub, immediate support, and all recovery tools/editors
8. ERP plans, practice stop dialog, and reflection
9. Structured programs and Y-BOCS introduction, checklist, questions, and results
10. First-run result and Settings
11. Patterns Pro and optional tips

That is 828 rendered states. Each state is checked before scrolling and after
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

This is renderer-level layout evidence. It does not replace virtual- or
physical-device VoiceOver, TalkBack, platform font/display scaling, focus
traversal, purchase, or orientation verification. The September 22 virtual
pass proved that an exception-free layered layout can still obscure content at
maximum scale in landscape; those findings are recorded in
`VIRTUAL-DEVICE-QA.md`.
