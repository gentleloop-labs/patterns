import 'dart:io' show Platform;

import 'package:flutter/foundation.dart'
    show debugPrint, kDebugMode, kIsWeb, visibleForTesting;
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_preferences.dart';
import 'app_events.dart';

enum ReviewTrigger {
  journalSaved,
  urgeCompleted,
  erpCompleted,
  analyticsLinger,
}

enum RatingPromptIneligibility {
  preferencesUnavailable,
  optedOut,
  completed,
  missingFirstSeen,
  tooRecentlyInstalled,
  notEnoughMeaningfulActions,
  notEnoughDistinctDays,
  promptCooldown,
  annualAttemptLimit,
  failureBackoff,
  declineCooldown,
}

class RatingPromptDiagnostics {
  final DateTime? firstSeen;
  final int hoursInstalled;
  final int daysInstalled;
  final int journalCount;
  final int ocdCount;
  final int meaningfulActionCount;
  final int distinctDays;
  final DateTime? lastAttempt;
  final int attemptsInLast365Days;
  final DateTime? lastFailure;
  final DateTime? lastDecline;
  final bool optedOut;
  final bool completed;
  final bool eligible;
  final RatingPromptIneligibility? reason;

  const RatingPromptDiagnostics({
    required this.firstSeen,
    required this.hoursInstalled,
    required this.daysInstalled,
    required this.journalCount,
    required this.ocdCount,
    required this.meaningfulActionCount,
    required this.distinctDays,
    required this.lastAttempt,
    required this.attemptsInLast365Days,
    required this.lastFailure,
    required this.lastDecline,
    required this.optedOut,
    required this.completed,
    required this.eligible,
    required this.reason,
  });

  /// Compatibility alias for the old diagnostics field name.
  DateTime? get lastPrompt => lastAttempt;
}

/// Platform seam for the native in-app review and store-listing APIs.
abstract class ReviewGateway {
  Future<bool> isAvailable();

  Future<void> requestReview();

  Future<void> openStoreListing({required String appStoreId});
}

class InAppReviewGateway implements ReviewGateway {
  const InAppReviewGateway();

  InAppReview get _review => InAppReview.instance;

  @override
  Future<bool> isAvailable() => _review.isAvailable();

  @override
  Future<void> requestReview() => _review.requestReview();

  @override
  Future<void> openStoreListing({required String appStoreId}) =>
      _review.openStoreListing(appStoreId: appStoreId);
}

/// Privacy-preserving, eligibility-gated App Store / Play review requests.
///
/// Automatic prompts use only the native store UI. The API does not reveal
/// whether the sheet appeared or whether the user submitted a rating, so this
/// service records attempts rather than claiming completion.
class ReviewPromptService {
  static const _kFirstSeen = 'rating_first_seen_ts';
  static const _kJournalCount = 'rating_journal_count';
  static const _kOcdCount = 'rating_ocd_count';
  static const _kMeaningfulActionCount = 'rating_meaningful_action_count';
  static const _kDistinctDays = 'rating_distinct_days';
  static const _kLastDayKey = 'rating_last_day_key';
  static const _kAttemptHistory = 'rating_request_attempt_timestamps';
  static const _kLastFailureTs = 'rating_last_failure_ts';

  // Legacy keys are read during migration so existing choices and cooldowns
  // remain respected after upgrading.
  static const _kLastPromptTs = 'rating_last_prompt_ts';
  static const _kLastDeclineTs = 'rating_last_decline_ts';
  static const _kOptedOut = 'rating_opted_out';
  static const _kCompleted = 'rating_completed';

  static const _minHoursInstalled = 24;
  static const _minMeaningfulActions = 2;
  static const _minDistinctDays = 2;
  static const _automaticCooldownDays = 30;
  static const _failureBackoffDays = 7;
  static const _maxAutomaticAttempts = 3;
  static const _attemptWindowDays = 365;
  static const _legacyDeclineCooldownDays = 14;

  static const _iosAppStoreId = '6762611172';
  static const _androidPackage = 'com.maskedsyntax.patterns';
  static const _supportEmail = 'aftaab@aftaab.dev';

  static ReviewGateway _gateway = const InAppReviewGateway();
  static bool _inFlight = false;
  static bool? _mobileOverride;

  @visibleForTesting
  static const minHoursInstalled = _minHoursInstalled;

  @visibleForTesting
  static const minMeaningfulActions = _minMeaningfulActions;

  @visibleForTesting
  static const minDistinctDays = _minDistinctDays;

  @visibleForTesting
  static const automaticCooldownDays = _automaticCooldownDays;

  @visibleForTesting
  static const failureBackoffDays = _failureBackoffDays;

  @visibleForTesting
  static const maxAutomaticAttempts = _maxAutomaticAttempts;

  @visibleForTesting
  static const attemptWindowDays = _attemptWindowDays;

  static bool get _isMobile {
    final override = _mobileOverride;
    if (override != null) return override;
    if (kIsWeb) return false;
    return Platform.isIOS || Platform.isAndroid;
  }

  static String get _platformName {
    if (kIsWeb) return 'web';
    if (Platform.isIOS) return 'ios';
    if (Platform.isAndroid) return 'android';
    if (Platform.isMacOS) return 'macos';
    return 'other';
  }

  @visibleForTesting
  static void setGatewayForTesting(ReviewGateway? gateway) {
    _gateway = gateway ?? const InAppReviewGateway();
  }

  @visibleForTesting
  static void setMobileOverrideForTesting(bool? value) {
    _mobileOverride = value;
  }

  static Future<void> recordSessionStart() async {
    final prefs = mobilePreferences;
    if (prefs == null) return;
    final now = DateTime.now();
    await _migrateLegacyAttemptHistory(prefs, now);
    if (!prefs.containsKey(_kFirstSeen)) {
      await prefs.setInt(_kFirstSeen, now.millisecondsSinceEpoch);
    }
    final todayKey = _dayKey(now);
    if (prefs.getString(_kLastDayKey) != todayKey) {
      final count = (prefs.getInt(_kDistinctDays) ?? 0) + 1;
      await prefs.setInt(_kDistinctDays, count);
      await prefs.setString(_kLastDayKey, todayKey);
    }
  }

  static Future<void> recordJournalSaved() async {
    final prefs = mobilePreferences;
    if (prefs == null) return;
    await prefs.setInt(_kJournalCount, (prefs.getInt(_kJournalCount) ?? 0) + 1);
    await _recordMeaningfulAction();
  }

  static Future<void> recordOcdSaved(int distress) async {
    final prefs = mobilePreferences;
    if (prefs == null) return;
    await prefs.setInt(_kOcdCount, (prefs.getInt(_kOcdCount) ?? 0) + 1);
    await _recordMeaningfulAction();
  }

  static Future<void> recordUrgePracticeCompleted() =>
      _recordMeaningfulAction();

  static Future<void> recordErpPracticeCompleted() => _recordMeaningfulAction();

  static Future<void> _recordMeaningfulAction() async {
    final prefs = mobilePreferences;
    if (prefs == null) return;
    await prefs.setInt(
      _kMeaningfulActionCount,
      (prefs.getInt(_kMeaningfulActionCount) ?? 0) + 1,
    );
  }

  static RatingPromptDiagnostics diagnostics() {
    final prefs = mobilePreferences;
    final now = DateTime.now();
    if (prefs == null) {
      return const RatingPromptDiagnostics(
        firstSeen: null,
        hoursInstalled: 0,
        daysInstalled: 0,
        journalCount: 0,
        ocdCount: 0,
        meaningfulActionCount: 0,
        distinctDays: 0,
        lastAttempt: null,
        attemptsInLast365Days: 0,
        lastFailure: null,
        lastDecline: null,
        optedOut: false,
        completed: false,
        eligible: false,
        reason: RatingPromptIneligibility.preferencesUnavailable,
      );
    }
    return _diagnosticsForPrefs(prefs, now);
  }

  @visibleForTesting
  static bool isEligibleForTesting() => diagnostics().eligible;

  @visibleForTesting
  static Future<void> setTestingState({
    DateTime? firstSeen,
    int journalCount = 0,
    int ocdCount = 0,
    int? meaningfulActionCount,
    int distinctDays = 0,
    List<DateTime> attempts = const [],
    DateTime? lastFailure,
    DateTime? lastPrompt,
    DateTime? lastDecline,
    bool optedOut = false,
    bool completed = false,
  }) async {
    final prefs = mobilePreferences;
    if (prefs == null) return;
    for (final key in [
      _kFirstSeen,
      _kJournalCount,
      _kOcdCount,
      _kMeaningfulActionCount,
      _kDistinctDays,
      _kLastDayKey,
      _kAttemptHistory,
      _kLastFailureTs,
      _kLastPromptTs,
      _kLastDeclineTs,
      _kOptedOut,
      _kCompleted,
    ]) {
      await prefs.remove(key);
    }
    if (firstSeen != null) {
      await prefs.setInt(_kFirstSeen, firstSeen.millisecondsSinceEpoch);
    }
    await prefs.setInt(_kJournalCount, journalCount);
    await prefs.setInt(_kOcdCount, ocdCount);
    if (meaningfulActionCount != null) {
      await prefs.setInt(_kMeaningfulActionCount, meaningfulActionCount);
    }
    await prefs.setInt(_kDistinctDays, distinctDays);
    if (attempts.isNotEmpty) {
      await prefs.setStringList(
        _kAttemptHistory,
        attempts.map((date) => date.millisecondsSinceEpoch.toString()).toList(),
      );
    }
    if (lastFailure != null) {
      await prefs.setInt(_kLastFailureTs, lastFailure.millisecondsSinceEpoch);
    }
    if (lastPrompt != null) {
      await prefs.setInt(_kLastPromptTs, lastPrompt.millisecondsSinceEpoch);
    }
    if (lastDecline != null) {
      await prefs.setInt(_kLastDeclineTs, lastDecline.millisecondsSinceEpoch);
    }
    await prefs.setBool(_kOptedOut, optedOut);
    await prefs.setBool(_kCompleted, completed);
  }

  static RatingPromptDiagnostics _diagnosticsForPrefs(
    dynamic prefs,
    DateTime now,
  ) {
    final firstSeenMs = prefs.getInt(_kFirstSeen) as int?;
    final firstSeen = firstSeenMs == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(firstSeenMs);
    final installedDuration = firstSeen == null
        ? Duration.zero
        : now.difference(firstSeen);
    final journalCount = prefs.getInt(_kJournalCount) as int? ?? 0;
    final ocdCount = prefs.getInt(_kOcdCount) as int? ?? 0;
    final meaningfulActionCount =
        prefs.getInt(_kMeaningfulActionCount) as int? ??
        journalCount + ocdCount;
    final distinctDays = prefs.getInt(_kDistinctDays) as int? ?? 0;
    final attempts = _readAttemptHistory(prefs, now);
    final lastAttempt = attempts.isEmpty ? null : attempts.last;
    final lastFailureMs = prefs.getInt(_kLastFailureTs) as int?;
    final lastFailure = lastFailureMs == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(lastFailureMs);
    final lastDeclineMs = prefs.getInt(_kLastDeclineTs) as int?;
    final lastDecline = lastDeclineMs == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(lastDeclineMs);
    final optedOut = prefs.getBool(_kOptedOut) as bool? ?? false;
    final completed = prefs.getBool(_kCompleted) as bool? ?? false;

    RatingPromptIneligibility? reason;
    if (optedOut) {
      reason = RatingPromptIneligibility.optedOut;
    } else if (completed) {
      reason = RatingPromptIneligibility.completed;
    } else if (firstSeen == null) {
      reason = RatingPromptIneligibility.missingFirstSeen;
    } else if (installedDuration.inHours < _minHoursInstalled) {
      reason = RatingPromptIneligibility.tooRecentlyInstalled;
    } else if (meaningfulActionCount < _minMeaningfulActions) {
      reason = RatingPromptIneligibility.notEnoughMeaningfulActions;
    } else if (distinctDays < _minDistinctDays) {
      reason = RatingPromptIneligibility.notEnoughDistinctDays;
    } else if (lastFailure != null &&
        now.difference(lastFailure) <
            const Duration(days: _failureBackoffDays)) {
      reason = RatingPromptIneligibility.failureBackoff;
    } else if (lastAttempt != null &&
        now.difference(lastAttempt) <
            const Duration(days: _automaticCooldownDays)) {
      reason = RatingPromptIneligibility.promptCooldown;
    } else if (attempts.length >= _maxAutomaticAttempts) {
      reason = RatingPromptIneligibility.annualAttemptLimit;
    } else if (lastDecline != null &&
        now.difference(lastDecline) <
            const Duration(days: _legacyDeclineCooldownDays)) {
      reason = RatingPromptIneligibility.declineCooldown;
    }

    return RatingPromptDiagnostics(
      firstSeen: firstSeen,
      hoursInstalled: installedDuration.inHours,
      daysInstalled: installedDuration.inDays,
      journalCount: journalCount,
      ocdCount: ocdCount,
      meaningfulActionCount: meaningfulActionCount,
      distinctDays: distinctDays,
      lastAttempt: lastAttempt,
      attemptsInLast365Days: attempts.length,
      lastFailure: lastFailure,
      lastDecline: lastDecline,
      optedOut: optedOut,
      completed: completed,
      eligible: reason == null,
      reason: reason,
    );
  }

  static bool _isEligible(ReviewTrigger trigger) {
    final result = diagnostics();
    if (!result.eligible) {
      AppEvents.logReviewRequestSkipped(
        trigger: trigger.name,
        reason: result.reason?.name ?? 'unknown',
        platform: _platformName,
      );
      _debugLog(trigger, result);
      return false;
    }
    AppEvents.logReviewEligible(trigger: trigger.name, platform: _platformName);
    return true;
  }

  static void _debugLog(ReviewTrigger trigger, RatingPromptDiagnostics result) {
    if (!kDebugMode) return;
    debugPrint(
      'Review prompt skipped for ${trigger.name}: '
      '${result.reason?.name ?? 'eligible'} '
      '(hoursInstalled=${result.hoursInstalled}, '
      'meaningfulActions=${result.meaningfulActionCount}, '
      'distinctDays=${result.distinctDays}, '
      'lastAttempt=${result.lastAttempt}, '
      'attempts365=${result.attemptsInLast365Days}, '
      'lastFailure=${result.lastFailure}, '
      'optedOut=${result.optedOut}, completed=${result.completed})',
    );
  }

  /// Requests the native store review UI at an eligible happy moment.
  static Future<void> maybeRequestReview(
    BuildContext context, {
    required ReviewTrigger trigger,
  }) async {
    if (!_isMobile || _inFlight || !_isEligible(trigger)) return;
    _inFlight = true;
    try {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      if (!context.mounted) return;
      await _requestNativeReview(trigger);
    } finally {
      _inFlight = false;
    }
  }

  static Future<void> _requestNativeReview(ReviewTrigger trigger) async {
    try {
      if (!await _gateway.isAvailable()) {
        await _recordFailure();
        AppEvents.logReviewRequestUnavailable(
          trigger: trigger.name,
          platform: _platformName,
        );
        return;
      }
      await _gateway.requestReview();
      await _recordAttempt();
      AppEvents.logReviewRequestAttempted(
        trigger: trigger.name,
        platform: _platformName,
      );
    } catch (_) {
      await _recordFailure();
      AppEvents.logReviewRequestFailed(
        trigger: trigger.name,
        platform: _platformName,
      );
    }
  }

  /// Explicit Settings action: open the store listing instead of a quota-bound
  /// native sheet. This never changes automatic prompt eligibility.
  static Future<void> requestReviewManually(BuildContext context) async {
    if (!_isMobile || _inFlight) return;
    _inFlight = true;
    var opened = false;
    try {
      try {
        await _gateway.openStoreListing(appStoreId: _iosAppStoreId);
        opened = true;
      } catch (_) {
        opened = await _openStoreUrl();
      }
      if (opened) {
        AppEvents.logReviewManualStoreOpened(platform: _platformName);
      } else if (context.mounted) {
        _showLaunchError(context, 'Couldn’t open the store. Please try again.');
      }
    } finally {
      _inFlight = false;
    }
  }

  /// Separate support path; it is intentionally unrelated to review
  /// eligibility and never receives journal or health data.
  static Future<void> sendFeedback(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: _supportEmail,
      queryParameters: {
        'subject': 'Patterns feedback',
        'body': 'Hi,\n\nMy feedback about Patterns:\n\n',
      },
    );
    var opened = false;
    try {
      opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      opened = false;
    }
    if (opened) {
      AppEvents.logFeedbackStarted(platform: _platformName);
    } else if (context.mounted) {
      _showLaunchError(
        context,
        'Couldn’t open email. You can write to $_supportEmail.',
      );
    }
  }

  static Future<void> _recordAttempt() async {
    final prefs = mobilePreferences;
    if (prefs == null) return;
    final now = DateTime.now();
    final attempts = _readAttemptHistory(prefs, now)..add(now);
    await prefs.setStringList(
      _kAttemptHistory,
      attempts.map((date) => date.millisecondsSinceEpoch.toString()).toList(),
    );
    await prefs.setInt(_kLastPromptTs, now.millisecondsSinceEpoch);
    await prefs.remove(_kLastFailureTs);
  }

  static Future<void> _recordFailure() async {
    await mobilePreferences?.setInt(
      _kLastFailureTs,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  static List<DateTime> _readAttemptHistory(dynamic prefs, DateTime now) {
    final raw = prefs.getStringList(_kAttemptHistory) as List<String>?;
    final values = <DateTime>[];
    if (raw != null) {
      for (final value in raw) {
        final millis = int.tryParse(value);
        if (millis != null) {
          values.add(DateTime.fromMillisecondsSinceEpoch(millis));
        }
      }
    } else {
      final legacyMillis = prefs.getInt(_kLastPromptTs) as int?;
      if (legacyMillis != null) {
        values.add(DateTime.fromMillisecondsSinceEpoch(legacyMillis));
      }
    }
    values.removeWhere((date) {
      final age = now.difference(date);
      return age.isNegative || age >= const Duration(days: _attemptWindowDays);
    });
    values.sort();
    return values;
  }

  static Future<void> _migrateLegacyAttemptHistory(
    dynamic prefs,
    DateTime now,
  ) async {
    final attempts = _readAttemptHistory(prefs, now);
    await prefs.setStringList(
      _kAttemptHistory,
      attempts.map((date) => date.millisecondsSinceEpoch.toString()).toList(),
    );
  }

  static Future<bool> _openStoreUrl() async {
    final uri = Platform.isAndroid
        ? Uri.parse(
            'https://play.google.com/store/apps/details?id=$_androidPackage',
          )
        : Uri.parse(
            'https://apps.apple.com/app/id$_iosAppStoreId?action=write-review',
          );
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  static void _showLaunchError(BuildContext context, String message) {
    ScaffoldMessenger.maybeOf(
      context,
    )?.showSnackBar(SnackBar(content: Text(message)));
  }

  static String _dayKey(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
