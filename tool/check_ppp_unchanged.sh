#!/bin/sh
set -eu

workspace=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
current=$(mktemp)
trap 'rm -f "$current"' EXIT HUP INT TERM

cd "$workspace"
asc iap pricing schedules manual-prices \
  --schedule-id 6785513588 \
  --resolved \
  --paginate \
  --output json >"$current"
dart run tool/check_ppp_snapshot.dart \
  app-store/patterns-pro-ppp-2026-09-08.json \
  "$current"
