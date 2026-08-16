#!/bin/sh

# Xcode Cloud runners ship Xcode and CocoaPods but no Flutter SDK, and
# ios/Flutter/Generated.xcconfig is gitignored. Without this script the
# Runner build phases have no FLUTTER_ROOT and the archive fails immediately.

set -e

FLUTTER_VERSION=3.44.4
FLUTTER_HOME="$HOME/flutter"

# Shallow clone of the exact SDK version the app is developed against.
git clone https://github.com/flutter/flutter.git \
  --depth 1 --branch "$FLUTTER_VERSION" "$FLUTTER_HOME"

export PATH="$FLUTTER_HOME/bin:$PATH"

flutter --version

# This project resolves its iOS plugin dependencies through CocoaPods, not
# Swift Package Manager, because Xcode Cloud refuses to create a workflow until
# every remote SwiftPM dependency is connected and file_picker pulls in six
# owned by third parties. The equivalent local setting lives in the developer's
# ~/.config/flutter/settings, which a fresh CI SDK clone does not have, so it
# must be set explicitly here. Without it the SDK regenerates the plugin package
# with SwiftPM dependencies and the build fails looking for a Package.resolved
# that this repository deliberately does not carry.
flutter config --no-enable-swift-package-manager

flutter precache --ios
flutter pub get

# Info.plist reads CFBundleVersion from $(FLUTTER_BUILD_NUMBER), which comes
# from pubspec.yaml, so Xcode Cloud's own build number is ignored unless it is
# passed through here. Without this every upload carries pubspec's number and
# App Store Connect rejects the second one as a duplicate. Falls back to the
# pubspec value when run outside Xcode Cloud.
BUILD_NUMBER_ARG=""
if [ -n "$CI_BUILD_NUMBER" ]; then
  BUILD_NUMBER_ARG="--build-number=$CI_BUILD_NUMBER"
  echo "Overriding pubspec build number with CI_BUILD_NUMBER=$CI_BUILD_NUMBER"
fi

# Writes ios/Flutter/Generated.xcconfig with FLUTTER_ROOT baked in as an
# absolute path, plus FLUTTER_BUILD_NAME/FLUTTER_BUILD_NUMBER. $HOME persists
# into the xcodebuild step, so the build phases resolve correctly from here.
# This also regenerates FlutterGeneratedPluginSwiftPackage with no dependencies
# and runs pod install, which is what actually fetches the native libraries.
flutter build ios --release --no-codesign --config-only $BUILD_NUMBER_ARG

cd "$CI_PRIMARY_REPOSITORY_PATH/ios"
pod install
