#!/bin/sh
set -eu

mode=check
scope=mobile
while [ "$#" -gt 0 ]; do
  case "$1" in
    check|--report)
      mode=$1
      ;;
    --scope)
      shift
      if [ "$#" -eq 0 ]; then
        echo "localization audit: --scope requires mobile or all" >&2
        exit 2
      fi
      scope=$1
      ;;
    *)
      echo "usage: $0 [check|--report] [--scope mobile|all]" >&2
      exit 2
      ;;
  esac
  shift
done

if [ "$scope" != "mobile" ] && [ "$scope" != "all" ]; then
  echo "localization audit: scope must be mobile or all" >&2
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
pattern="(?:Text|SelectableText|Tooltip|Semantics)\\(\\s*(?:const\\s*)?['\"]|(?:labelText|hintText|helperText|tooltip|semanticLabel|title|subtitle|content|message|label):\\s*(?:const\\s*)?['\"]"

if [ "$scope" = "mobile" ]; then
  # `lib/screens/**` is the legacy desktop shell's shared screen set. The
  # dedicated mobile shell imports `lib/mobile/screens/**` instead.
  # Keep the positive Dart glob first: ripgrep applies later matching glob
  # overrides last, so exclusions must follow it to remain effective.
  rg -n \
    --glob '*.dart' \
    --glob '!lib/l10n/**' \
    --glob '!lib/desktop/**' \
    --glob '!lib/screens/**' \
    --glob '!lib/services/desktop_license_service.dart' \
    --glob '!lib/services/desktop_purchase_service.dart' \
    "$pattern" \
    lib >"$candidates" || true
else
  rg -n \
    --glob '*.dart' \
    --glob '!lib/l10n/**' \
    "$pattern" \
    lib >"$candidates" || true
fi

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
  echo "Localization audit ($scope scope): $count unreviewed user-facing literal candidate(s)." >&2
  if [ "$mode" = "check" ]; then exit 1; fi
else
  echo "Localization audit ($scope scope): zero unreviewed user-facing literals."
fi
