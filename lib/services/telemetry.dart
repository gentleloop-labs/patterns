import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../app_preferences.dart';

/// On-device, privacy-preserving product telemetry.
///
/// This is NOT analytics in the tracking sense: nothing leaves the device.
/// Events increment [SharedPreferences] counters and append to a capped local
/// ring buffer that a hidden Settings > Debug > Funnel screen renders. It exists
/// to validate the first-session redesign (activation + retention) without
/// breaking the app's privacy promise.
///
/// Transport is deliberately funnelled through the single [_sink] seam so an
/// opt-in remote sink can be added later without touching any call site.
class Telemetry {
  Telemetry._();

  static const _countPrefix = 'tel_count_';
  static const _logKey = 'tel_log';
  static const _installDayKey = 'tel_install_day';
  static const _returnedDaysKey = 'tel_returned_days';
  static const _maxLogEntries = 250;

  /// Records an event. Fire-and-forget; safe to call before prefs are ready
  /// (it simply no-ops). Only short, categorical props become their own
  /// counters — numeric metrics live in the ring buffer only, so we never
  /// explode the keyspace.
  static void log(String event, [Map<String, Object?>? props]) {
    _sink(event, props);
  }

  /// Logs [event] at most once ever (across launches), keyed by a persisted
  /// marker. Useful for "first time X happened" milestones like the score
  /// first appearing.
  ///
  /// Returns true when the event was actually recorded (i.e. this was the first
  /// time), so callers can chain a further once-only effect off it.
  static bool logOnce(String event, [Map<String, Object?>? props]) {
    final prefs = appPreferences;
    if (prefs == null) return false;
    final key = 'tel_once_$event';
    if (prefs.getBool(key) ?? false) return false;
    prefs.setBool(key, true);
    log(event, props);
    return true;
  }

  static void _sink(String event, Map<String, Object?>? props) {
    final prefs = appPreferences;
    if (prefs == null) return;

    // Base counter.
    _increment(event);

    // Categorical sub-counters (e.g. onboarding.path_chosen.urge).
    if (props != null) {
      for (final entry in props.entries) {
        final value = entry.value;
        if (_isCategorical(value)) {
          _increment('$event.${entry.key}:$value');
        }
      }
    }

    // Ring buffer for the debug funnel screen.
    final line = jsonEncode({
      't': DateTime.now().toIso8601String(),
      'e': event,
      if (props != null && props.isNotEmpty) 'p': props,
    });
    final log = prefs.getStringList(_logKey) ?? <String>[];
    log.add(line);
    if (log.length > _maxLogEntries) {
      log.removeRange(0, log.length - _maxLogEntries);
    }
    prefs.setStringList(_logKey, log);

    if (kDebugMode) debugPrint('[telemetry] $line');
  }

  static bool _isCategorical(Object? value) {
    if (value is bool) return true;
    if (value is String) return value.length <= 24;
    // Small ints read as categorical (e.g. retention day index); large/float
    // metrics stay out of the counter keyspace.
    if (value is int) return value >= 0 && value <= 60;
    return false;
  }

  static void _increment(String name) {
    final prefs = appPreferences;
    if (prefs == null) return;
    final key = '$_countPrefix$name';
    prefs.setInt(key, (prefs.getInt(key) ?? 0) + 1);
  }

  /// Logs `session.start` and, once per elapsed day, `retention.dayN`.
  ///
  /// Reuses the local install-day anchor so we can measure D1/D7 return without
  /// any off-device call. Idempotent per calendar day of return.
  static Future<void> recordSessionStart() async {
    final prefs = appPreferences;
    if (prefs == null) return;

    final today = _dayNumber(DateTime.now());
    final installDay = prefs.getInt(_installDayKey);
    if (installDay == null) {
      await prefs.setInt(_installDayKey, today);
      log('session.start', {'day': 0});
      return;
    }

    final dayN = today - installDay;
    log('session.start', {'day': dayN.clamp(0, 60)});

    if (dayN > 0) {
      final returned = (prefs.getStringList(_returnedDaysKey) ?? <String>[])
          .toSet();
      final marker = dayN.toString();
      if (!returned.contains(marker)) {
        returned.add(marker);
        await prefs.setStringList(_returnedDaysKey, returned.toList());
        log('retention.day', {'n': dayN.clamp(1, 60)});
      }
    }
  }

  /// Days since the Unix epoch in local time — a stable calendar-day index.
  static int _dayNumber(DateTime d) =>
      DateTime(d.year, d.month, d.day).millisecondsSinceEpoch ~/
      Duration.millisecondsPerDay;

  // --- Debug funnel readout ---------------------------------------------

  /// All event counters, keyed by event name (prefix stripped), sorted.
  static Map<String, int> counters() {
    final prefs = appPreferences;
    if (prefs == null) return const {};
    final out = <String, int>{};
    for (final key in prefs.getKeys()) {
      if (key.startsWith(_countPrefix)) {
        out[key.substring(_countPrefix.length)] = prefs.getInt(key) ?? 0;
      }
    }
    return Map.fromEntries(
      out.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
  }

  /// Most-recent events first, decoded from the ring buffer.
  static List<Map<String, Object?>> recentEvents() {
    final prefs = appPreferences;
    if (prefs == null) return const [];
    final log = prefs.getStringList(_logKey) ?? const <String>[];
    return log.reversed
        .map((line) {
          try {
            return jsonDecode(line) as Map<String, Object?>;
          } catch (_) {
            return <String, Object?>{'e': line};
          }
        })
        .toList(growable: false);
  }

  /// Clears all telemetry (counters, log, retention anchors). Debug/testing.
  static Future<void> reset() async {
    final prefs = appPreferences;
    if (prefs == null) return;
    for (final key in prefs.getKeys().toList()) {
      if (key.startsWith(_countPrefix)) await prefs.remove(key);
    }
    await prefs.remove(_logKey);
    await prefs.remove(_installDayKey);
    await prefs.remove(_returnedDaysKey);
  }
}
