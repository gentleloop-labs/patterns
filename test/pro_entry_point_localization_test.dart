import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/services/pro_entry_point.dart';

void main() {
  test('Pro entry-point wire names remain stable', () {
    expect(ProEntryPoint.values.map((entry) => entry.wireName), [
      'settings',
      'today_next_step',
      'recovery_metrics',
      'exposure_hierarchy',
      'exposure_materials',
      'structured_programs',
      'action_planner',
      'implementation_intentions',
      'urge_surfing',
      'response_prevention',
      'uncertainty_training',
      'behavioral_experiments',
      'reflection_journal',
    ]);
  });

  test('every locale resolves complete Pro entry-point copy', () {
    for (final locale in AppLocalizations.supportedLocales) {
      final strings = lookupAppLocalizations(locale);
      for (final entry in ProEntryPoint.values) {
        expect(
          entry.headline(strings).trim(),
          isNotEmpty,
          reason: '${locale.toLanguageTag()} ${entry.wireName} headline',
        );
        expect(
          entry.benefits(strings),
          hasLength(3),
          reason: '${locale.toLanguageTag()} ${entry.wireName} benefits',
        );
        expect(
          entry.benefits(strings).every((benefit) => benefit.trim().isNotEmpty),
          isTrue,
          reason: '${locale.toLanguageTag()} ${entry.wireName} empty benefit',
        );
      }
    }
  });

  test('metrics paywall copy stays factual and score-free', () {
    final strings = lookupAppLocalizations(const Locale('en'));
    final copy = [
      ProEntryPoint.recoveryMetrics.headline(strings),
      ...ProEntryPoint.recoveryMetrics.benefits(strings),
    ].join(' ').toLowerCase();

    expect(copy, isNot(contains('score')));
    expect(copy, isNot(contains('streak')));
    expect(copy, isNot(contains('consistency')));
    expect(copy, isNot(contains('progress')));
  });
}
