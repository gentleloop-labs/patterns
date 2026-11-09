# Patterns for Apple platforms (native)

The SwiftUI rewrite of the iOS app, developed on the `ios/swiftui` branch. It
installs as an update over the Flutter app (same bundle ID,
`com.maskedsyntax.patterns`) and reads the Flutter app's data in place. There
is no migration step, so nothing on a user's phone is converted or lost.

The full plan, including rollout and rollback, is in the session plan. The
rules that matter day to day:

- **Schema stays at v10 for 2.0.** Do not add tables or columns until native
  has shipped and proven stable. That keeps it possible to ship a Flutter
  build over native if 2.0 has a serious bug. Any later change lands in both
  `lib/database/db_helper.dart` and `PatternsSchema.swift` together.
- **Keep Flutter's names.** Database columns, `flutter.`-prefixed
  UserDefaults keys, notification ids and backup keys are part of the
  contract with Android, macOS and older iOS builds.
- **Run the compatibility loop** after any data-layer change, on either side:

  ```sh
  apple/scripts/compat-check.sh
  ```

## Layout

| Path | What |
|---|---|
| `Packages/PatternsCore` | UIKit-free data layer, to be shared with macOS later: GRDB database, records, Dart date and Quill Delta codecs, settings, materials, backups. |
| `Fixtures/flutter` | Files written by the real Flutter code (`test/native_fixtures_test.dart`). Committed. |
| `Fixtures/swift-out` | Files written by native code for Flutter to read back. Generated, not committed. |
| `scripts/compat-check.sh` | Flutter → native → Flutter round trip. |

## What PatternsCore guarantees (all covered by tests)

- `patterns.db` at schema v10 opens without a single byte changing. Older
  files (v1 to v9) upgrade exactly as Flutter's `onUpgrade` would, and files
  from a newer build are refused and left untouched.
- Every row reads back identically, and re-saving unedited records is
  lossless. Timestamps keep their stored text verbatim.
- Backups (`data.json` and zip bundles) are accepted or rejected exactly as
  Flutter does, with the same messages, across 1,400+ generated cases.
- Journal rich text gives the same plain text and styled runs as
  `rich_journal.dart`. Attributes the native editor does not use are kept.
- Settings are read and written under the same keys and types.
- On the first native launch, `LegacyDataSnapshot` copies the database and
  materials to `Application Support/pre-native-backup/` before anything opens
  them.
