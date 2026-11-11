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

## Accessibility audit

`PatternsUITests/AccessibilityAuditTests.swift` runs Xcode's accessibility
audit (contrast, hit areas, labels, Dynamic Type, clipped text) on Today,
Settings, the tip jar, Journal and its editor, Track and the event form, the
Practice hub with all 16 tools, Insights and the report sheet. It does this
in three passes: light, dark, and the Accessibility XL text size. The tests
only navigate; they never save or delete anything.

They read whatever data the simulator holds, so run them on a simulator with
seeded data (a clone of the upgrade-test simulator works). All three passes
should be clean before a release:

```sh
xcodebuild test -project Patterns.xcodeproj -scheme Patterns \
  -destination 'platform=iOS Simulator,name=Patterns A11y Audit' \
  -only-testing:PatternsUITests
```

Findings print as `A11Y|pass|screen|type|…` and fail the test. Known
system false positives print as `A11Y-NOTE|…` and don't fail it; the test
explains each kind.

House rules that keep it clean:
- Secondary text uses `AppColors.textSecondary`, never `.secondary` or
  `Color(.secondaryLabel)`. The system grey is only 3.3:1 on the cream
  background.
- Filled buttons use `.accentProminent`, and segmented pickers use
  `.adaptiveSegmented()`.
- A title with a trailing detail uses `TitleDetail`, so it stacks at large
  sizes instead of breaking mid-word.
