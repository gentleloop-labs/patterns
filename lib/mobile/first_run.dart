import '../app_preferences.dart';

/// The activity a new user chooses on the "What would help right now?" screen.
///
/// The [name] values (`urge`, `journal`, `erp`, `selfcheck`, `explore`) are the
/// stable strings persisted under [firstRunPathKey] and emitted to telemetry, so
/// keep them stable.
enum FirstRunPath { urge, journal, erp, selfcheck, explore }

FirstRunPath? firstRunPathFromString(String? value) {
  if (value == null) return null;
  for (final path in FirstRunPath.values) {
    if (path.name == value) return path;
  }
  return null;
}

/// The path the user picked during onboarding, if any (null = established user
/// or not yet chosen).
FirstRunPath? readFirstRunPath() =>
    firstRunPathFromString(appPreferences?.getString(firstRunPathKey));

/// Whether the user has completed their first meaningful activity. Gates the
/// transition from the simplified first-run Today to the full cockpit.
bool readFirstActivityDone() =>
    appPreferences?.getBool(firstActivityDoneKey) ?? false;

/// Popped by a first-run activity flow when the user *completes* it (vs backing
/// out, which pops null). Carries the small metrics the result screen needs to
/// speak honestly about what just happened.
class FirstRunActivityResult {
  /// Urge/anxiety before, if the activity measured it (delay & ERP paths).
  final int? intensityBefore;

  /// Urge/anxiety after, if measured.
  final int? intensityAfter;

  const FirstRunActivityResult({this.intensityBefore, this.intensityAfter});
}
