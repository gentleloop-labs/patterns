#!/usr/bin/env bash
# Full Flutter <-> native data compatibility loop.
#
# 1. Flutter writes fixture databases, backups and parity cases using the real
#    Dart data layer (apple/Fixtures/flutter/).
# 2. Swift tests open and restore every fixture and must match Flutter
#    exactly. They also write native-created files (apple/Fixtures/swift-out/).
# 3. Flutter opens and restores the native-created files, proving a Flutter
#    build can be installed over native 2.0 and that native backups restore
#    on Android and macOS.
#
# Run from anywhere: apple/scripts/compat-check.sh
set -euo pipefail

repo="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$repo"

echo "==> 1/3 Flutter writes fixtures"
python3 apple/scripts/gen_strings.py
PATTERNS_WRITE_NATIVE_FIXTURES=1 flutter test test/native_fixtures_test.dart \
  --plain-name 'Flutter -> native fixtures'
PATTERNS_WRITE_NATIVE_FIXTURES=1 flutter test test/native_l10n_fixture_test.dart

echo "==> 2/3 Swift reads fixtures and writes its own output"
(cd apple/Packages/PatternsCore && PATTERNS_WRITE_SWIFT_OUT=1 swift test)

echo "==> 3/3 Flutter reads what native wrote"
flutter test test/native_fixtures_test.dart --plain-name 'native -> Flutter'

echo "==> Compatibility loop passed"
