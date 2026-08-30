import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a pristine install follows the system appearance', () async {
    SharedPreferences.setMockInitialValues({});
    await initAppPreferences();

    expect(
      appPreferences?.getString(appearancePreferenceKey),
      AppAppearance.system.name,
    );
  });

  test('an established install remains dark after upgrading', () async {
    SharedPreferences.setMockInitialValues({hasStartedKey: true});
    await initAppPreferences();

    expect(
      appPreferences?.getString(appearancePreferenceKey),
      AppAppearance.dark.name,
    );
    expect(appPreferences?.getInt(meaningfulActionCountKey), 0);
  });

  test('an established active user becomes eligible for calm Pro discovery', () async {
    SharedPreferences.setMockInitialValues({
      hasStartedKey: true,
      firstActivityDoneKey: true,
    });
    await initAppPreferences();

    expect(appPreferences?.getInt(meaningfulActionCountKey), 2);
  });

  test('an existing analytics opt-in migrates to explicit granted consent', () async {
    SharedPreferences.setMockInitialValues({usageAnalyticsEnabledKey: true});
    await initAppPreferences();

    expect(analyticsConsentDecision, AnalyticsConsentDecision.granted);
  });
}
