#!/bin/sh

# Xcode Cloud's Test action drives XCTest, so it cannot run this project's
# Dart suite. Running it here instead gates the archive on the same 156 tests
# that gate a local release: a non-zero exit fails the build.

set -e

export PATH="$HOME/flutter/bin:$PATH"

cd "$CI_PRIMARY_REPOSITORY_PATH"

flutter analyze
flutter test
