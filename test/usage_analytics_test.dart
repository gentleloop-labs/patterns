import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/services/usage_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeTransport implements AnalyticsBatchTransport {
  bool succeeds;
  final List<AnalyticsBatch> batches = [];

  _FakeTransport({this.succeeds = true});

  @override
  Future<bool> send(AnalyticsBatch batch) async {
    batches.add(batch);
    return succeeds;
  }
}

Future<(CloudflareAnalyticsService, _FakeTransport)> createService({
  required bool Function() hasConsent,
  bool succeeds = true,
}) async {
  final transport = _FakeTransport(succeeds: succeeds);
  final service = CloudflareAnalyticsService(
    preferences: await SharedPreferences.getInstance(),
    transport: transport,
    platform: 'ios',
    appVersion: '1.9.0+31',
    hasConsent: hasConsent,
    observeLifecycle: false,
    flushInterval: const Duration(days: 1),
  );
  return (service, transport);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('event serialization is a closed three-field schema', () {
    final event = QueuedAnalyticsEvent(
      event: UsageAnalyticsEvent.erpSessionCompleted,
      version: 1,
      timestamp: 1787571700000,
    );

    expect(event.toJson(), {
      'name': 'erp_session_completed',
      'version': 1,
      'timestamp': 1787571700000,
    });
    expect(UsageAnalyticsEvent.values.map((event) => event.wireName).toSet(), {
      'app_opened',
      'onboarding_started',
      'onboarding_completed',
      'journal_opened',
      'journal_entry_created',
      'erp_opened',
      'erp_session_started',
      'erp_session_completed',
      'compulsion_delay_started',
      'compulsion_delay_completed',
      'insights_opened',
      'paywall_viewed',
      'purchase_started',
      'purchase_completed',
      'analytics_consent_granted',
      'activation_completed',
      'pro_feature_tapped',
      'product_load_result',
      'purchase_canceled',
      'purchase_failed',
      'restore_started',
      'restore_completed',
      'restore_not_found',
      'restore_failed',
    });
  });

  test('v2 context serialization stays closed and contains no properties', () {
    final event = QueuedAnalyticsEvent(
      event: UsageAnalyticsEvent.paywallViewed,
      version: 2,
      timestamp: 1787571700000,
      context: UsageAnalyticsContext.exposureHierarchy,
    );

    expect(event.toJson(), {
      'name': 'paywall_viewed',
      'version': 2,
      'timestamp': 1787571700000,
      'context': 'exposure_hierarchy',
    });
    expect(QueuedAnalyticsEvent.decode(event.encode())?.context,
        UsageAnalyticsContext.exposureHierarchy);
  });

  test('queue persists between service instances', () async {
    final (first, _) = await createService(hasConsent: () => true);
    await first.track(UsageAnalyticsEvent.journalOpened);
    expect(await first.pendingEventCount, 1);
    first.dispose();

    final (second, _) = await createService(hasConsent: () => true);
    expect(await second.pendingEventCount, 1);
    second.dispose();
  });

  test(
    'analytics disabled does not queue or create an installation ID',
    () async {
      final (service, transport) = await createService(hasConsent: () => false);
      await service.track(UsageAnalyticsEvent.appOpened);
      await service.flush();

      expect(await service.pendingEventCount, 0);
      expect(transport.batches, isEmpty);
      final preferences = await SharedPreferences.getInstance();
      expect(
        preferences.containsKey(CloudflareAnalyticsService.installIdKey),
        isFalse,
      );
      service.dispose();
    },
  );

  test(
    'successful flush sends minimal batch and removes uploaded events',
    () async {
      final (service, transport) = await createService(hasConsent: () => true);
      await service.track(UsageAnalyticsEvent.appOpened);
      await service.track(UsageAnalyticsEvent.insightsOpened);
      await service.flush();

      expect(transport.batches, hasLength(1));
      expect(transport.batches.single.events, hasLength(2));
      expect(
        transport.batches.single.installId,
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
      );
      expect(transport.batches.single.platform, 'ios');
      expect(transport.batches.single.appVersion, '1.9.0+31');
      expect(await service.pendingEventCount, 0);
      service.dispose();
    },
  );

  test('failed flush retains queued events for later retry', () async {
    final (service, transport) = await createService(
      hasConsent: () => true,
      succeeds: false,
    );
    await service.track(UsageAnalyticsEvent.purchaseStarted);
    await service.flush();

    expect(transport.batches, hasLength(1));
    expect(await service.pendingEventCount, 1);
    service.dispose();
  });

  test('opt-out clears pending events and installation ID', () async {
    var enabled = true;
    final (service, _) = await createService(hasConsent: () => enabled);
    await service.track(UsageAnalyticsEvent.paywallViewed);
    await service.flush();
    await service.track(UsageAnalyticsEvent.purchaseStarted);
    enabled = false;
    await service.setCollectionEnabled(false);

    final preferences = await SharedPreferences.getInstance();
    expect(await service.pendingEventCount, 0);
    expect(
      preferences.containsKey(CloudflareAnalyticsService.installIdKey),
      isFalse,
    );
    service.dispose();
  });

  test('queue discards oldest events at the maximum size', () async {
    final (service, transport) = await createService(
      hasConsent: () => true,
      succeeds: false,
    );
    for (
      var index = 0;
      index < CloudflareAnalyticsService.maxQueueSize + 5;
      index++
    ) {
      await service.track(
        index < 5
            ? UsageAnalyticsEvent.appOpened
            : UsageAnalyticsEvent.journalOpened,
      );
    }

    expect(
      await service.pendingEventCount,
      CloudflareAnalyticsService.maxQueueSize,
    );
    expect(transport.batches.length, lessThanOrEqualTo(1));
    final preferences = await SharedPreferences.getInstance();
    final encoded = preferences.getStringList(
      CloudflareAnalyticsService.queueKey,
    )!;
    expect(encoded.first, contains('journal_opened'));
    service.dispose();
  });
}
