# Patterns 1.10.0 — Practice Without Pressure

Target publication date: **October 5, 2026**

This document is the release contract for the App Store featuring nomination.
Do not ship 1.10.0, or claim an accessibility feature in App Store Connect,
until the corresponding acceptance criteria below have been verified on a
physical iPhone.

The production multilingual build is fail-closed. Draft languages remain
available in debug/profile builds, but `tool/build_multilingual_release.sh`
will stop unless every field in `reviewed-locales.json` is signed off. Do not
set `PATTERNS_ENABLE_MULTILINGUAL=true` in another release workflow.

Release CI must also run `tool/localization_audit.sh` and
`dart run tool/check_arb_translator_context.dart`. Translator context is now
complete and that gate passes. The literal audit remains intentionally red
with 667 candidates as of September 10, 2026; its report is the working
full-product localization backlog and must reach zero before copy freeze.

## Product story

Patterns 1.10 asks a simple question: **How can an OCD app help without
becoming another thing to check?**

The release should make the app calmer for people who find scores, streaks,
motion, dense charts, or repeated prompts unhelpful. It should also make every
common iPhone task meaningfully more accessible.

## P0 — Calm Insights

Add a low-pressure way to use Patterns without calculated engagement-style
scores.

### Behaviour

- Add a **Calm Insights** preference in Settings with a plain-language
  explanation of what changes.
- Enable Calm Insights by default for new users.
- Preserve the current detailed-metrics experience for existing users during
  migration. They can enable Calm Insights themselves.
- When Calm Insights is enabled, hide:
  - the practice streak on Today;
  - the calculated recovery/practice-progress score and ring;
  - score deltas such as "points up/down";
  - consistency percentages and streak-focused summaries.
- Replace hidden numbers with factual, descriptive summaries, for example:
  - "You practised delaying a compulsion twice this week."
  - "You recorded three moments and completed one exposure."
  - "Your recent practice included journaling and response prevention."
- Keep measurements that the user deliberately records, including SUDS and
  Y-BOCS self-check results. Calm Insights is about hiding calculated product
  scores, not deleting useful personal records.
- Make the preference reversible without losing or rewriting any data.
- Do not send personal content or the generated summaries to analytics.

### Acceptance criteria

- Today has no score, ring, streak, or score delta in Calm Insights.
- Insights has no calculated recovery score, consistency percentage, or
  streak language in Calm Insights.
- Descriptive summaries remain accurate for empty, sparse, and established
  datasets.
- New installations start in Calm Insights; upgrades retain the existing
  detailed view.
- Widget tests cover the preference, migration, empty state, and both display
  modes.

## P0 — Accessibility across common tasks

The target is support that can honestly be declared in Apple's Accessibility
Nutrition Labels after device testing. The common tasks are onboarding,
journaling, tracking an OCD event, starting and completing a compulsion delay,
starting and completing guided ERP practice, reviewing Insights, changing
privacy/settings, exporting data, and purchasing/restoring Pro.

### VoiceOver and chart descriptions

- Give every custom interactive control a concise label, role, state, value,
  and hint where needed.
- Ensure logical focus order, useful grouping, and accessible headings.
- Exclude decorative icons and images from the semantics tree.
- Add text alternatives for progress rings, heatmaps, line charts, bar charts,
  timers, and other custom-painted information.
- Announce important saves, validation errors, timer completions, purchase
  results, and destructive-action results without interrupting the user
  unnecessarily.
- Ensure Back, Dismiss, Cancel, Delete, Reset, Save, and Done actions work with
  VoiceOver and do not depend on a swipe or long press alone.
- Verify the rich-text editor can be entered, edited, formatted, and exited
  with VoiceOver.

### Larger Text

- Support at least 200% text scaling throughout every common task.
- Test the largest iOS accessibility text sizes on a small supported iPhone.
- Remove severe truncation, overlap, clipped controls, and unreachable actions.
- Allow important labels and buttons to wrap or reflow rather than shrinking
  essential text until it becomes unreadable.
- Provide an accessible alternative when a compact chart or control cannot
  scale meaningfully.

### Reduced Motion

- Honour the system Reduce Motion/disable-animations preference across every
  decorative transition and animation.
- Keep timers functional without pulsing, scaling, sliding, or animated
  counters when motion is reduced.
- Audit direct uses of AnimatedContainer, AnimatedSwitcher, AnimatedScale,
  TweenAnimationBuilder, and AnimationController that bypass AppMotion.

### Do not rely on colour alone

- Pair colour-coded states with text, icons, shapes, or patterns.
- Ensure obsession and compulsion types, chart series, selected tabs, success,
  warnings, and destructive actions remain understandable without colour.
- Add legends or text summaries wherever chart meaning currently depends on
  colour.

### Contrast and touch targets

- Check text, icons, borders, focus indicators, disabled states, and chart
  series in both Light and Dark appearances.
- Keep common interactive targets at least 44 by 44 points unless an adjacent
  accessible control provides the same action.

### Verification gate

- Complete every common task using VoiceOver on a physical iPhone.
- Complete every common task at 200% text and at the largest accessibility
  size on a small iPhone.
- Repeat the main flows with Reduce Motion enabled.
- Repeat the main flows using grayscale and Differentiate Without Color.
- Only then update App Store Connect accessibility declarations.

## P0 — Quieter session endings

Give users a clear way to finish rather than immediately manufacturing another
task.

### Behaviour

- After saving a journal entry or OCD event, and after completing a compulsion
  delay or ERP exercise, show a calm, factual confirmation.
- Provide a prominent **Done for now** action that returns to a neutral screen.
- Do not put another suggested exercise, paywall, streak warning, score change,
  countdown, or celebratory animation in the completion path.
- Keep any reflection optional and skippable.
- Use wording such as "Saved" or "Practice recorded" rather than judging the
  session as successful or unsuccessful.

### Acceptance criteria

- All four primary completion paths expose Done for now.
- Back and dismiss behaviour does not lose saved work.
- Completion is understandable with VoiceOver and Reduced Motion.
- Tests cover save/completion, skip, dismiss, and navigation outcomes.

## P1 — Gentle copy and privacy clarity

- Audit required-field validation in Journal, Track, ERP, exposure tools, and
  recovery forms. Use specific, warm instructions rather than technical or
  scolding errors.
- Make Privacy settings clearly distinguish personal OCD content, local app
  preferences, purchase processing, manual exports, and optional anonymous
  feature-use analytics.
- Keep analytics off until a user explicitly enables it.
- Preserve the existing local-first model: no account, no cloud sync, no ads,
  and no personal OCD content in analytics.
- Keep the boundary visible: Patterns supports self-reflection and ERP
  practice; it is not diagnosis, therapy, or emergency care.

## Explicit non-goals for 1.10

- No AI chatbot, reassurance bot, interpretation of intrusive thoughts, or
  personalized treatment decisions.
- No accounts, cloud sync, social feed, advertising, or subscription.
- No new recovery score, engagement streak, badge, leaderboard, or daily-loss
  mechanic.
- No large new ERP module. The release should improve the experience and
  accessibility of the tools already present.
- Do not present the 1.9 light theme, purchase reliability, or analytics consent
  work as new 1.10 features.

## Primary implementation map

- `lib/app_preferences.dart`: preference key, default, and migration.
- `lib/mobile/screens/settings_screen.dart`: Calm Insights control and privacy
  explanation.
- `lib/mobile/screens/journal_screen.dart`: Today streak/score replacement and
  journal completion.
- `lib/mobile/screens/analytics_screen.dart`: descriptive Calm Insights view
  and accessible chart alternatives.
- `lib/mobile/screens/recovery_metrics_screen.dart`: remove streak pressure in
  Calm Insights.
- `lib/mobile/screens/ocd_tracker_screen.dart`: accessible form and quiet
  completion.
- `lib/mobile/screens/compulsion_delay_screen.dart`: timer semantics, Reduced
  Motion, and quiet completion.
- `lib/mobile/screens/erp_exercises_screen.dart`: practice semantics, Reduced
  Motion, and quiet completion.
- `lib/mobile/main_shell.dart`: tab semantics, motion audit, and release screen.
- `lib/widgets/animations.dart`: shared Reduced Motion behaviour.
- `lib/widgets/app_snack_bar.dart`: accessible status announcements.
- `lib/widgets/rich_journal.dart`: accessible editor/toolbar behaviour.
- `test/`: preferences, Calm Insights, semantics, large text, Reduced Motion,
  and completion-flow coverage.

## Release plumbing

- [ ] Implement every P0 item and verify its acceptance criteria.
- [ ] Decide whether all P1 items fit; remove any unshipped claim from metadata.
- [ ] Bump `pubspec.yaml` to `1.10.0` with the next approved build number.
- [ ] Change `currentReleaseId` and replace the 1.9 What's New screen.
- [ ] Add canonical App Store and Google Play 1.10 metadata.
- [ ] Update screenshots to show Calm Insights and accessibility improvements.
- [ ] Run `flutter analyze` with no issues.
- [ ] Run the complete Flutter test suite with no failures.
- [ ] Test upgrade/migration from 1.9 with real existing data.
- [ ] Test purchase and restore on sandbox accounts.
- [ ] Test export/import round trips, including formatted journals and all Pro
      records.
- [ ] Complete the physical-iPhone accessibility verification gate.
- [ ] Update App Store accessibility declarations only for verified support.
- [ ] Reconcile the featuring nomination if the shipped scope or date changes.
- [ ] Prepare and verify the TestFlight build before App Review submission.

## Submitted nomination promise

The current nomination promises Calm Insights, improved VoiceOver navigation,
Larger Text layouts, chart descriptions, Reduced Motion behaviour, non-colour
cues, quieter Done for now endings, local-first personal data, no account, and
default-off anonymous analytics. Any item removed from the release must also be
removed from the nomination before launch.
