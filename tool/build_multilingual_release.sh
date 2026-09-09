#!/bin/sh
set -eu

dart run tool/check_multilingual_release.dart
./tool/localization_audit.sh
dart run tool/check_arb_translator_context.dart
./tool/check_ppp_unchanged.sh
flutter build ipa --release --dart-define=PATTERNS_ENABLE_MULTILINGUAL=true
flutter build macos --release --dart-define=PATTERNS_ENABLE_MULTILINGUAL=true
