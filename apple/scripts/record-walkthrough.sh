#!/usr/bin/env bash
# Records a video of FeatureWalkthroughTests on a throwaway clone of a seeded
# simulator. The walkthrough writes and deletes data, so it never runs on the
# source simulator itself.
#
#   apple/scripts/record-walkthrough.sh [source-simulator-name] [output.mp4]
set -euo pipefail

source_name="${1:-Patterns A11y Audit}"
out="${2:-$PWD/patterns-walkthrough.mp4}"
apple="$(cd "$(dirname "$0")/.." && pwd)"
log="${out%.mp4}.log"

source_id=$(xcrun simctl list devices | grep -F "$source_name (" | head -1 | grep -oE '[0-9A-F-]{36}')
[ -n "$source_id" ] || { echo "No simulator named '$source_name'" >&2; exit 1; }
xcrun simctl shutdown "$source_id" 2>/dev/null || true
sim=$(xcrun simctl clone "$source_id" "Patterns Walkthrough $(date +%H%M%S)")
cleanup() { xcrun simctl shutdown "$sim" 2>/dev/null || true; xcrun simctl delete "$sim" 2>/dev/null || true; }
trap cleanup EXIT

echo "==> Building"
cd "$apple"
xcodebuild build-for-testing -project Patterns.xcodeproj -scheme Patterns \
  -destination "id=$sim" -quiet

xcrun simctl boot "$sim"
xcrun simctl bootstatus "$sim" -b >/dev/null
open -a Simulator --args -CurrentDeviceUDID "$sim" || true
xcrun simctl status_bar "$sim" override --time 9:41 --batteryState charged --batteryLevel 100 \
  --cellularBars 4 --wifiBars 3 || true
xcrun simctl privacy "$sim" grant notifications com.maskedsyntax.patterns 2>/dev/null || true

echo "==> Recording to $out"
xcrun simctl io "$sim" recordVideo --codec h264 --force "$out" &
recorder=$!
sleep 2

set +e
TEST_RUNNER_PATTERNS_WALKTHROUGH=1 xcodebuild test-without-building -project Patterns.xcodeproj \
  -scheme Patterns -destination "id=$sim" \
  -only-testing:PatternsUITests/FeatureWalkthroughTests/testWalkthrough > "$log" 2>&1
status=$?
set -e

sleep 2
kill -INT "$recorder"; wait "$recorder" 2>/dev/null || true

grep -E '^(STEP|MISS|WALK)\|' "$log" || true
echo "Video: $out"
echo "Log:   $log"
exit $status
