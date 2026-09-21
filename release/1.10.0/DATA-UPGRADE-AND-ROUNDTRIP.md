# Patterns 1.10.0 data upgrade and round-trip evidence

Verified: September 21, 2026

## Scope

This gate verifies that upgrading an established Patterns 1.9.0 installation
to 1.10.0 preserves local records, stable identifiers, purchases, reminders,
and established-user defaults. It also verifies that JSON restore replaces the
entire local dataset and preserves all supported table content exactly.

This evidence does not satisfy physical-device accessibility or sandbox
purchase testing; those remain separate release gates.

## Source baseline

- 1.9 candidate: commit `7c55d33`, `1.9.0+31`.
- 1.10 candidate: `1.10.0+32`, based on commit `e9e0454` plus the DATA-01
  changes recorded with this document.
- The committed 1.9 and pre-DATA-01 1.10 `db_helper.dart` files have the same
  SHA-256 digest:
  `b394499387ba5a4b69e040dcac864592ed048afbdd348b91a5d1e541c1f39c42`.
- Both releases use SQLite user version 10 and the same 18 data tables. No SQL
  schema migration is expected during this upgrade.

## Automated SQLite verification

`test/data_upgrade_roundtrip_test.dart` uses the native SQLite test backend and
an isolated on-disk database. Its representative 1.9 dataset includes one row
in every data table, with explicit primary keys and linked IDs. It covers:

- rich journal Delta JSON and unchanged ISO storage dates;
- OCD records, compulsion delays, ERP plans and sessions;
- exposure hierarchies, linked steps, prevention logs, and materials;
- stable program, enrollment, exercise, and task identifiers;
- behavioral experiments, reflections, action plans, implementation
  intentions, and uncertainty logs;
- Japanese user-authored text; and
- Y-BOCS scores, selected themes, and symptom identifiers.

The test opens the database at schema version 10, closes and reopens the same
file through the 1.10 helper, exports it, imports it into a fresh database, and
compares every field. It then imports the same backup a second time to prove a
restore replaces rather than merges data. A separate case proves that an older
backup with absent later-table keys clears those tables safely.

During this verification, JSON import was found to clear only the five oldest
tables before restoring. That could retain stale Pro/Y-BOCS rows or cause a
primary-key collision. `DbHelper.importAll` now clears all 18 data tables in
the same transaction before inserting validated backup rows.

Focused result:

```text
flutter test test/data_upgrade_roundtrip_test.dart \
  test/language_preferences_test.dart \
  test/preferences_migration_test.dart

20 tests passed
```

The complete Flutter suite also passes with 370 tests, `flutter analyze`
reports no issues, the mobile literal audit reports zero candidates, and the
translator-context and copy-freeze gates pass.

## Installed Android upgrade

Device used: Android 17 / API 37 arm64 emulator, `emulator-5554`.

1. Built commit `7c55d33` and installed `1.9.0+31` on a clean app sandbox.
2. Launched 1.9 so it created its production database and preferences.
3. Seeded representative existing-user data: rich journal, OCD record,
   `delay-4wk` enrollment, `w1a` task progress, Y-BOCS assessment, Pro
   entitlement, enabled 20:15 reminder, and established-install preferences.
4. Built `1.10.0+32` and installed it with `adb install -r`, without
   uninstalling or clearing app data.
5. Launched 1.10, stopped it cleanly, and inspected the application sandbox.

Post-upgrade results:

| Check | Result |
| --- | --- |
| Installed version code | 32 |
| SQLite user version | 10 |
| Database file changed during launch | No; byte-for-byte identical |
| Journal ID/content/date | Preserved (`101`, rich Delta JSON, `2026-09-14`) |
| OCD ID/type/distress/content | Preserved (`102`, obsession, 7) |
| Program enrollment | Preserved (`401`, `delay-4wk`) |
| Program task progress | Preserved (`402`, enrollment `401`, `w1a`) |
| Y-BOCS assessment | Preserved (`601`, total 21, checking theme) |
| Existing-user language | Migrated to English |
| Existing-user Calm Insights | Disabled |
| Analytics consent | Migrated to declined; analytics remains disabled |
| Pro entitlement | Preserved |
| Reminder | Preserved and enabled at 20:15 |
| Appearance | Preserved as system |

## Gate decision

DATA-01 is verified. Data-schema compatibility, installed-app upgrade,
preference migration, and JSON round-trip checks pass. Future changes to the
database schema or backup codec must rerun this test and update this evidence.
