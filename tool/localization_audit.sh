#!/bin/sh
set -eu

mode=${1:-check}
if [ "$mode" != "check" ] && [ "$mode" != "--report" ]; then
  echo "usage: $0 [check|--report]" >&2
  exit 2
fi

workspace=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
allowlist="$workspace/tool/localization_allowlist.txt"
candidates=$(mktemp)
unreviewed=$(mktemp)
trap 'rm -f "$candidates" "$unreviewed"' EXIT HUP INT TERM

cd "$workspace"

# This is intentionally a conservative heuristic. It covers common Flutter
# presentation sites and all built-in clinical/content definitions. False
# positives must be documented in the allowlist with a narrow path/text rule.
rg -n \
  --glob '!lib/l10n/**' \
  --glob '*.dart' \
  "(?:Text|SelectableText|Tooltip|Semantics)\\(\\s*(?:const\\s*)?['\"]|(?:labelText|hintText|helperText|tooltip|semanticLabel|title|subtitle|content|message|label):\\s*(?:const\\s*)?['\"]" \
  lib >"$candidates" || true

awk '
  FNR == NR {
    if ($0 !~ /^[[:space:]]*(#|$)/) allow[++count] = $0
    next
  }
  {
    accepted = 0
    for (i = 1; i <= count; i++) {
      if ($0 ~ allow[i]) {
        accepted = 1
        break
      }
    }
    if (!accepted) print
  }
' "$allowlist" "$candidates" >"$unreviewed"

count=$(wc -l <"$unreviewed" | tr -d ' ')
if [ "$count" -gt 0 ]; then
  cat "$unreviewed"
  echo "Localization audit: $count unreviewed user-facing literal candidate(s)." >&2
  if [ "$mode" = "check" ]; then exit 1; fi
else
  echo "Localization audit: zero unreviewed user-facing literals."
fi
