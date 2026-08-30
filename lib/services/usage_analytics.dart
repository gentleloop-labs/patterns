import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_preferences.dart';

/// The complete remote event vocabulary. There is intentionally no raw-string
/// tracking method and no metadata/properties argument.
enum UsageAnalyticsEvent {
  appOpened,
  onboardingStarted,
  onboardingCompleted,
  journalOpened,
  journalEntryCreated,
  erpOpened,
  erpSessionStarted,
  erpSessionCompleted,
  compulsionDelayStarted,
  compulsionDelayCompleted,
  insightsOpened,
  paywallViewed,
  purchaseStarted,
  purchaseCompleted,
  analyticsConsentGranted,
  activationCompleted,
  proFeatureTapped,
  productLoadResult,
  purchaseCanceled,
  purchaseFailed,
  restoreStarted,
  restoreCompleted,
  restoreNotFound,
  restoreFailed,
}

extension UsageAnalyticsEventWireName on UsageAnalyticsEvent {
  String get wireName => switch (this) {
    UsageAnalyticsEvent.appOpened => 'app_opened',
    UsageAnalyticsEvent.onboardingStarted => 'onboarding_started',
    UsageAnalyticsEvent.onboardingCompleted => 'onboarding_completed',
    UsageAnalyticsEvent.journalOpened => 'journal_opened',
    UsageAnalyticsEvent.journalEntryCreated => 'journal_entry_created',
    UsageAnalyticsEvent.erpOpened => 'erp_opened',
    UsageAnalyticsEvent.erpSessionStarted => 'erp_session_started',
    UsageAnalyticsEvent.erpSessionCompleted => 'erp_session_completed',
    UsageAnalyticsEvent.compulsionDelayStarted => 'compulsion_delay_started',
    UsageAnalyticsEvent.compulsionDelayCompleted =>
      'compulsion_delay_completed',
    UsageAnalyticsEvent.insightsOpened => 'insights_opened',
    UsageAnalyticsEvent.paywallViewed => 'paywall_viewed',
    UsageAnalyticsEvent.purchaseStarted => 'purchase_started',
    UsageAnalyticsEvent.purchaseCompleted => 'purchase_completed',
    UsageAnalyticsEvent.analyticsConsentGranted => 'analytics_consent_granted',
    UsageAnalyticsEvent.activationCompleted => 'activation_completed',
    UsageAnalyticsEvent.proFeatureTapped => 'pro_feature_tapped',
    UsageAnalyticsEvent.productLoadResult => 'product_load_result',
    UsageAnalyticsEvent.purchaseCanceled => 'purchase_canceled',
    UsageAnalyticsEvent.purchaseFailed => 'purchase_failed',
    UsageAnalyticsEvent.restoreStarted => 'restore_started',
    UsageAnalyticsEvent.restoreCompleted => 'restore_completed',
    UsageAnalyticsEvent.restoreNotFound => 'restore_not_found',
    UsageAnalyticsEvent.restoreFailed => 'restore_failed',
  };
}

enum UsageAnalyticsContext {
  journal,
  compulsionDelay,
  guidedErp,
  selfCheck,
  success,
  unavailable,
  error,
  settings,
  todayNextStep,
  recoveryMetrics,
  exposureHierarchy,
  exposureMaterials,
  structuredPrograms,
  actionPlanner,
  implementationIntentions,
  urgeSurfing,
  responsePrevention,
  uncertaintyTraining,
  behavioralExperiments,
  reflectionJournal,
}

extension UsageAnalyticsContextWireName on UsageAnalyticsContext {
  String get wireName => switch (this) {
    UsageAnalyticsContext.journal => 'journal',
    UsageAnalyticsContext.compulsionDelay => 'compulsion_delay',
    UsageAnalyticsContext.guidedErp => 'guided_erp',
    UsageAnalyticsContext.selfCheck => 'self_check',
    UsageAnalyticsContext.success => 'success',
    UsageAnalyticsContext.unavailable => 'unavailable',
    UsageAnalyticsContext.error => 'error',
    UsageAnalyticsContext.settings => 'settings',
    UsageAnalyticsContext.todayNextStep => 'today_next_step',
    UsageAnalyticsContext.recoveryMetrics => 'recovery_metrics',
    UsageAnalyticsContext.exposureHierarchy => 'exposure_hierarchy',
    UsageAnalyticsContext.exposureMaterials => 'exposure_materials',
    UsageAnalyticsContext.structuredPrograms => 'structured_programs',
    UsageAnalyticsContext.actionPlanner => 'action_planner',
    UsageAnalyticsContext.implementationIntentions =>
      'implementation_intentions',
    UsageAnalyticsContext.urgeSurfing => 'urge_surfing',
    UsageAnalyticsContext.responsePrevention => 'response_prevention',
    UsageAnalyticsContext.uncertaintyTraining => 'uncertainty_training',
    UsageAnalyticsContext.behavioralExperiments => 'behavioral_experiments',
    UsageAnalyticsContext.reflectionJournal => 'reflection_journal',
  };
}

abstract interface class UsageAnalyticsService {
  Future<void> track(
    UsageAnalyticsEvent event, {
    UsageAnalyticsContext? context,
  });
  Future<void> flush();
  Future<void> setCollectionEnabled(bool enabled);
}

class NoopAnalyticsService implements UsageAnalyticsService {
  const NoopAnalyticsService();

  @override
  Future<void> flush() async {}

  @override
  Future<void> setCollectionEnabled(bool enabled) async {}

  @override
  Future<void> track(
    UsageAnalyticsEvent event, {
    UsageAnalyticsContext? context,
  }) async {}
}

class QueuedAnalyticsEvent {
  final UsageAnalyticsEvent event;
  final int version;
  final int timestamp;
  final UsageAnalyticsContext? context;

  const QueuedAnalyticsEvent({
    required this.event,
    required this.version,
    required this.timestamp,
    this.context,
  });

  Map<String, Object> toJson() => {
    'name': event.wireName,
    'version': version,
    'timestamp': timestamp,
    if (context != null) 'context': context!.wireName,
  };

  String encode() => jsonEncode(toJson());

  static QueuedAnalyticsEvent? decode(String value) {
    try {
      final json = jsonDecode(value);
      if (json is! Map<String, dynamic> ||
          json.keys.any(
            (key) => !const {
              'name',
              'version',
              'timestamp',
              'context',
            }.contains(key),
          ) ||
          (json['version'] != 1 && json['version'] != 2) ||
          json['timestamp'] is! int ||
          json['name'] is! String ||
          (json['context'] != null && json['context'] is! String)) {
        return null;
      }
      final event = UsageAnalyticsEvent.values.firstWhere(
        (candidate) => candidate.wireName == json['name'],
      );
      final context = json['context'] == null
          ? null
          : UsageAnalyticsContext.values.firstWhere(
              (candidate) => candidate.wireName == json['context'],
            );
      return QueuedAnalyticsEvent(
        event: event,
        version: json['version'] as int,
        timestamp: json['timestamp'] as int,
        context: context,
      );
    } catch (_) {
      return null;
    }
  }
}

class AnalyticsBatch {
  final String installId;
  final String platform;
  final String appVersion;
  final List<QueuedAnalyticsEvent> events;

  const AnalyticsBatch({
    required this.installId,
    required this.platform,
    required this.appVersion,
    required this.events,
  });

  Map<String, Object> toJson() => {
    'installId': installId,
    'platform': platform,
    'appVersion': appVersion,
    'events': events.map((event) => event.toJson()).toList(growable: false),
  };
}

abstract interface class AnalyticsBatchTransport {
  Future<bool> send(AnalyticsBatch batch);
}

class HttpAnalyticsBatchTransport implements AnalyticsBatchTransport {
  final Uri endpoint;
  final http.Client _client;

  HttpAnalyticsBatchTransport({required this.endpoint, http.Client? client})
    : _client = client ?? http.Client();

  @override
  Future<bool> send(AnalyticsBatch batch) async {
    final response = await _client
        .post(
          endpoint.resolve('/v1/events/batch'),
          headers: const {'content-type': 'application/json'},
          body: jsonEncode(batch.toJson()),
        )
        .timeout(const Duration(seconds: 8));
    return response.statusCode >= 200 && response.statusCode < 300;
  }
}

class CloudflareAnalyticsService
    with WidgetsBindingObserver
    implements UsageAnalyticsService {
  static const queueKey = 'usageAnalyticsQueueV1';
  static const installIdKey = 'usageAnalyticsInstallIdV1';
  static const maxQueueSize = 500;
  static const uploadBatchSize = 50;
  static const flushThreshold = 10;

  final SharedPreferences preferences;
  final AnalyticsBatchTransport transport;
  final String platform;
  final String appVersion;
  final bool Function() _hasConsent;
  final Random _secureRandom;
  final bool _observeLifecycle;

  Future<void> _serial = Future.value();
  bool _flushInProgress = false;
  Timer? _intervalTimer;

  CloudflareAnalyticsService({
    required this.preferences,
    required this.transport,
    required this.platform,
    required this.appVersion,
    required bool Function() hasConsent,
    Random? secureRandom,
    bool observeLifecycle = true,
    Duration flushInterval = const Duration(minutes: 5),
  }) : _hasConsent = hasConsent,
       _secureRandom = secureRandom ?? Random.secure(),
       _observeLifecycle = observeLifecycle {
    if (_observeLifecycle) WidgetsBinding.instance.addObserver(this);
    _intervalTimer = Timer.periodic(flushInterval, (_) => unawaited(flush()));
  }

  bool get isCollectionEnabled => _hasConsent();

  Future<int> get pendingEventCount =>
      _synchronized(() async => _load().length);

  @override
  Future<void> track(
    UsageAnalyticsEvent event, {
    UsageAnalyticsContext? context,
  }) async {
    if (!isCollectionEnabled) return;
    try {
      final count = await _synchronized(() async {
        if (!isCollectionEnabled) return 0;
        final queued = _load()
          ..add(
            QueuedAnalyticsEvent(
              event: event,
              version: context == null ? 1 : 2,
              timestamp: DateTime.now().millisecondsSinceEpoch,
              context: context,
            ),
          );
        if (queued.length > maxQueueSize) {
          queued.removeRange(0, queued.length - maxQueueSize);
        }
        await _save(queued);
        return queued.length;
      });
      // Crossing the threshold triggers one attempt. If it fails, later events
      // do not create a request-per-event retry loop; interval/background
      // flushes handle the retry.
      if (count == flushThreshold) unawaited(flush());
    } catch (_) {
      // Analytics must never affect a user-facing action.
    }
  }

  @override
  Future<void> flush() async {
    if (!isCollectionEnabled || _flushInProgress) return;
    _flushInProgress = true;
    try {
      final snapshot = await _synchronized(() async {
        if (!isCollectionEnabled) return <QueuedAnalyticsEvent>[];
        return _load().take(uploadBatchSize).toList(growable: false);
      });
      if (snapshot.isEmpty || !isCollectionEnabled) return;

      final installId = await _installationId();
      if (!isCollectionEnabled) return;
      final succeeded = await transport.send(
        AnalyticsBatch(
          installId: installId,
          platform: platform,
          appVersion: appVersion,
          events: snapshot,
        ),
      );
      if (!succeeded || !isCollectionEnabled) return;

      await _synchronized(() async {
        final current = _load();
        final uploaded = snapshot.map((event) => event.encode()).toList();
        final stillPrefix =
            current.length >= uploaded.length &&
            List.generate(
              uploaded.length,
              (index) => current[index].encode() == uploaded[index],
            ).every((matches) => matches);
        if (stillPrefix) {
          current.removeRange(0, uploaded.length);
          await _save(current);
        }
      });
    } catch (_) {
      // Keep the queue for a later interval/background flush.
    } finally {
      _flushInProgress = false;
    }
  }

  @override
  Future<void> setCollectionEnabled(bool enabled) async {
    if (enabled) return;
    await _synchronized(() async {
      await preferences.remove(queueKey);
      // Re-enabling starts a new anonymous analytics installation, preventing
      // events on either side of an opt-out from being linked.
      await preferences.remove(installIdKey);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.detached) {
      unawaited(flush());
    }
  }

  void dispose() {
    _intervalTimer?.cancel();
    if (_observeLifecycle) WidgetsBinding.instance.removeObserver(this);
  }

  List<QueuedAnalyticsEvent> _load() =>
      (preferences.getStringList(queueKey) ?? const <String>[])
          .map(QueuedAnalyticsEvent.decode)
          .whereType<QueuedAnalyticsEvent>()
          .toList();

  Future<void> _save(List<QueuedAnalyticsEvent> events) => preferences
      .setStringList(queueKey, events.map((event) => event.encode()).toList());

  Future<String> _installationId() => _synchronized(() async {
    final existing = preferences.getString(installIdKey);
    if (existing != null) return existing;
    final created = _uuidV4();
    await preferences.setString(installIdKey, created);
    return created;
  });

  String _uuidV4() {
    final bytes = List<int>.generate(16, (_) => _secureRandom.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-'
        '${hex.substring(20)}';
  }

  Future<T> _synchronized<T>(Future<T> Function() action) {
    final completer = Completer<T>();
    _serial = _serial.then((_) async {
      try {
        completer.complete(await action());
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }
}

enum AnalyticsEnvironment { disabled, development, production }

class UsageAnalyticsConfiguration {
  static const _defaultProductionEndpoint =
      'https://patterns-analytics.maskedsyntax.workers.dev';
  static const _environmentName = String.fromEnvironment(
    'PATTERNS_ANALYTICS_ENV',
    defaultValue: kReleaseMode ? 'production' : 'disabled',
  );
  static const _developmentEndpoint = String.fromEnvironment(
    'PATTERNS_ANALYTICS_DEV_ENDPOINT',
  );
  static const _productionEndpoint = String.fromEnvironment(
    'PATTERNS_ANALYTICS_PROD_ENDPOINT',
    defaultValue: _defaultProductionEndpoint,
  );

  static AnalyticsEnvironment get environment => switch (_environmentName) {
    'development' => AnalyticsEnvironment.development,
    'production' => AnalyticsEnvironment.production,
    _ => AnalyticsEnvironment.disabled,
  };

  static String get endpoint => switch (environment) {
    AnalyticsEnvironment.development => _developmentEndpoint,
    AnalyticsEnvironment.production => _productionEndpoint,
    AnalyticsEnvironment.disabled => '',
  };
}

UsageAnalyticsService usageAnalytics = const NoopAnalyticsService();

Future<void> initUsageAnalytics() async {
  final endpoint = UsageAnalyticsConfiguration.endpoint;
  final preferences = appPreferences;
  final environment = UsageAnalyticsConfiguration.environment;
  if (environment == AnalyticsEnvironment.disabled ||
      endpoint.isEmpty ||
      preferences == null) {
    usageAnalytics = const NoopAnalyticsService();
    return;
  }

  try {
    final endpointUri = Uri.parse(endpoint);
    final allowedScheme =
        endpointUri.scheme == 'https' ||
        (environment == AnalyticsEnvironment.development &&
            endpointUri.scheme == 'http');
    if (!allowedScheme || endpointUri.host.isEmpty) {
      usageAnalytics = const NoopAnalyticsService();
      return;
    }
    final packageInfo = await PackageInfo.fromPlatform();
    final buildSuffix = packageInfo.buildNumber.isEmpty
        ? ''
        : '+${packageInfo.buildNumber}';
    usageAnalytics = CloudflareAnalyticsService(
      preferences: preferences,
      transport: HttpAnalyticsBatchTransport(endpoint: endpointUri),
      platform: _platformName,
      appVersion: '${packageInfo.version}$buildSuffix',
      hasConsent: () =>
          preferences.getBool(usageAnalyticsEnabledKey) ??
          defaultUsageAnalyticsEnabled,
    );
  } catch (_) {
    // A bad analytics build setting or plugin failure must not block startup.
    usageAnalytics = const NoopAnalyticsService();
  }
}

String get _platformName {
  if (kIsWeb) return 'web';
  return switch (defaultTargetPlatform) {
    TargetPlatform.iOS => 'ios',
    TargetPlatform.android => 'android',
    TargetPlatform.macOS => 'macos',
    TargetPlatform.windows => 'windows',
    TargetPlatform.linux => 'linux',
    TargetPlatform.fuchsia => 'linux',
  };
}
