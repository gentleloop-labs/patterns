import 'telemetry.dart';

/// The canonical acquisition and activation funnel, named to match the website.
///
/// Names are GA4-style lowercase `snake_case`, so `app_store_click` on the site
/// and `first_open` in the app read as one funnel, and so these names would map
/// 1:1 onto Firebase/GA4 if an opt-in remote sink is ever added.
///
/// ## Where these go
///
/// [Telemetry], which is on-device only: SharedPreferences counters plus a
/// capped local ring buffer that `Settings > Debug > Funnel` renders. Nothing
/// is uploaded. That is deliberate — the app's published privacy policy states
/// there is no remote telemetry, and these events do not change that.
///
/// ## Privacy contract
///
/// No method here accepts free text. Every parameter is either a bool or a
/// value drawn from a closed set, and [_slug] hard-limits anything string-like
/// to a short lowercase identifier. A future call site therefore cannot leak a
/// journal entry, trigger, compulsion description, exposure title, note,
/// distress description, therapist detail or medication detail into telemetry
/// even by mistake — there is no parameter that would carry it.
class AppEvents {
  AppEvents._();

  // --- Event names (single source of truth) -------------------------------

  static const firstOpen = 'first_open';
  static const onboardingStarted = 'onboarding_started';
  static const onboardingCompleted = 'onboarding_completed';
  static const firstMeaningfulAction = 'first_meaningful_action';
  static const firstJournalEntryCreated = 'first_journal_entry_created';
  static const firstCompulsionDelayStarted = 'first_compulsion_delay_started';
  static const firstCompulsionDelayCompleted =
      'first_compulsion_delay_completed';
  static const firstExposureCreated = 'first_exposure_created';
  static const firstExposureCompleted = 'first_exposure_completed';
  static const supporterScreenViewed = 'supporter_screen_viewed';
  static const supporterPurchaseStarted = 'supporter_purchase_started';
  static const supporterPurchaseCompleted = 'supporter_purchase_completed';
  static const reviewEligible = 'review_eligible';
  static const reviewRequestSkipped = 'review_request_skipped';
  static const reviewRequestAttempted = 'review_request_attempted';
  static const reviewRequestUnavailable = 'review_request_unavailable';
  static const reviewRequestFailed = 'review_request_failed';
  static const reviewManualStoreOpened = 'review_manual_store_opened';
  static const feedbackStarted = 'feedback_started';

  /// Every name above, for tests and the debug funnel readout.
  static const all = <String>[
    firstOpen,
    onboardingStarted,
    onboardingCompleted,
    firstMeaningfulAction,
    firstJournalEntryCreated,
    firstCompulsionDelayStarted,
    firstCompulsionDelayCompleted,
    firstExposureCreated,
    firstExposureCompleted,
    supporterScreenViewed,
    supporterPurchaseStarted,
    supporterPurchaseCompleted,
    reviewEligible,
    reviewRequestSkipped,
    reviewRequestAttempted,
    reviewRequestUnavailable,
    reviewRequestFailed,
    reviewManualStoreOpened,
    feedbackStarted,
  ];

  // --- Funnel ------------------------------------------------------------

  /// First launch of this installation. Once per install, by construction.
  static void logFirstOpen() => Telemetry.logOnce(firstOpen);

  /// The user reached the first onboarding screen.
  static void logOnboardingStarted() => Telemetry.logOnce(onboardingStarted);

  /// The user finished onboarding by choosing a starting path.
  ///
  /// [path] is a [FirstRunPath] enum name (`urge`, `journal`, `erp`,
  /// `selfcheck`, `explore`) — a fixed vocabulary, never user text.
  static void logOnboardingCompleted({required String path}) =>
      Telemetry.logOnce(onboardingCompleted, {'path': _slug(path)});

  /// The user saved their first journal entry. Content is never passed.
  static void logFirstJournalEntryCreated() {
    Telemetry.logOnce(firstJournalEntryCreated);
    _logFirstMeaningfulAction('journal');
  }

  /// The user started their first compulsion-delay timer. The compulsion they
  /// named is deliberately not a parameter.
  static void logFirstCompulsionDelayStarted() =>
      Telemetry.logOnce(firstCompulsionDelayStarted);

  /// The user saved their first completed compulsion-delay session.
  ///
  /// [ranToCompletion] distinguishes sitting the timer out from ending it
  /// early; urge ratings and notes are not included.
  static void logFirstCompulsionDelayCompleted({
    required bool ranToCompletion,
  }) {
    Telemetry.logOnce(firstCompulsionDelayCompleted, {
      'completed': ranToCompletion,
    });
    _logFirstMeaningfulAction('compulsion_delay');
  }

  /// The user built their first exposure hierarchy. Title, theme and step text
  /// are never passed; only the step count, which is a small integer.
  static void logFirstExposureCreated({required int stepCount}) =>
      Telemetry.logOnce(firstExposureCreated, {
        'steps': stepCount.clamp(0, 60),
      });

  /// The user finished their first ERP exposure session.
  static void logFirstExposureCompleted({required bool ranToCompletion}) {
    Telemetry.logOnce(firstExposureCompleted, {'completed': ranToCompletion});
    _logFirstMeaningfulAction('exposure');
  }

  /// The user completed their first Y-BOCS style self-check.
  static void logFirstSelfCheckCompleted() =>
      _logFirstMeaningfulAction('self_check');

  // --- Supporter ---------------------------------------------------------

  /// The supporter/Pro screen was shown. [source] is a call-site constant such
  /// as `settings` or `paywall_cta`, slugged defensively.
  static void logSupporterScreenViewed({required String source}) =>
      Telemetry.log(supporterScreenViewed, {'source': _slug(source)});

  /// The user tapped buy and the store flow was launched.
  static void logSupporterPurchaseStarted() =>
      Telemetry.log(supporterPurchaseStarted);

  /// A purchase or restore succeeded. No price, no receipt, no store account.
  static void logSupporterPurchaseCompleted({required bool restored}) =>
      Telemetry.log(supporterPurchaseCompleted, {'restored': restored});

  // --- Reviews and feedback ----------------------------------------------

  static void logReviewEligible({
    required String trigger,
    required String platform,
  }) => Telemetry.log(reviewEligible, {
    'trigger': _slug(trigger),
    'platform': _slug(platform),
  });

  static void logReviewRequestSkipped({
    required String trigger,
    required String reason,
    required String platform,
  }) => Telemetry.log(reviewRequestSkipped, {
    'trigger': _slug(trigger),
    'reason': _slug(reason),
    'platform': _slug(platform),
  });

  static void logReviewRequestAttempted({
    required String trigger,
    required String platform,
  }) => Telemetry.log(reviewRequestAttempted, {
    'trigger': _slug(trigger),
    'platform': _slug(platform),
  });

  static void logReviewRequestUnavailable({
    required String trigger,
    required String platform,
  }) => Telemetry.log(reviewRequestUnavailable, {
    'trigger': _slug(trigger),
    'platform': _slug(platform),
  });

  static void logReviewRequestFailed({
    required String trigger,
    required String platform,
  }) => Telemetry.log(reviewRequestFailed, {
    'trigger': _slug(trigger),
    'platform': _slug(platform),
  });

  static void logReviewManualStoreOpened({required String platform}) =>
      Telemetry.log(reviewManualStoreOpened, {'platform': _slug(platform)});

  static void logFeedbackStarted({required String platform}) =>
      Telemetry.log(feedbackStarted, {'platform': _slug(platform)});

  // --- Internals ---------------------------------------------------------

  /// Fires `first_meaningful_action` exactly once per installation, on whichever
  /// primary action the user completes first. [kind] records which one it was.
  static void _logFirstMeaningfulAction(String kind) =>
      Telemetry.logOnce(firstMeaningfulAction, {'kind': _slug(kind)});

  /// Reduces a value to a short lowercase identifier. This is the guard that
  /// makes it structurally impossible for prose to reach the sink: anything
  /// outside `[a-z0-9_]` is dropped and the result is capped well below the
  /// length of a sentence.
  static String _slug(String value) {
    final cleaned = value
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9_]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
    if (cleaned.isEmpty) return 'unknown';
    return cleaned.length <= 24 ? cleaned : cleaned.substring(0, 24);
  }
}
