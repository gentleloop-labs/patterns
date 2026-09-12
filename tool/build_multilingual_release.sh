#!/bin/sh
set -eu

dart run tool/check_copy_freeze.dart
dart run tool/check_multilingual_release.dart
./tool/localization_audit.sh --scope mobile
dart run tool/check_arb_translator_context.dart
./tool/check_ppp_unchanged.sh
flutter build ipa --release --dart-define=PATTERNS_ENABLE_MULTILINGUAL=true
flutter build appbundle --release --dart-define=PATTERNS_ENABLE_MULTILINGUAL=true
