#!/usr/bin/env bash
set -euo pipefail

root="app-store/patterns-screenshots/exports/localized"
languages=(en pt-BR de ja es fr)

check_image() {
  local path="$1" expected_width="$2" expected_height="$3"
  local details width height alpha
  details="$(sips -g pixelWidth -g pixelHeight -g hasAlpha "$path" 2>/dev/null)"
  width="$(awk '/pixelWidth:/{print $2}' <<<"$details")"
  height="$(awk '/pixelHeight:/{print $2}' <<<"$details")"
  alpha="$(awk '/hasAlpha:/{print $2}' <<<"$details")"
  [[ "$width" == "$expected_width" && "$height" == "$expected_height" ]] || {
    echo "Invalid dimensions for $path: ${width}x${height}" >&2
    exit 1
  }
  [[ "$alpha" == "no" ]] || {
    echo "Alpha channel is not allowed for $path" >&2
    exit 1
  }
}

for language in "${languages[@]}"; do
  apple_count="$(find "$root/apple/$language" -maxdepth 1 -type f -name '*.png' | wc -l | tr -d ' ')"
  play_count="$(find "$root/play/$language" -maxdepth 1 -type f -name '*.png' | wc -l | tr -d ' ')"
  feature_count="$(find "$root/feature/$language" -maxdepth 1 -type f -name '*.png' | wc -l | tr -d ' ')"
  [[ "$apple_count" == 8 ]] || { echo "$language has $apple_count Apple screenshots" >&2; exit 1; }
  [[ "$play_count" == 8 ]] || { echo "$language has $play_count Play screenshots" >&2; exit 1; }
  [[ "$feature_count" == 1 ]] || { echo "$language has $feature_count Play feature graphics" >&2; exit 1; }
  while IFS= read -r path; do check_image "$path" 1290 2796; done < <(find "$root/apple/$language" -maxdepth 1 -type f -name '*.png' | sort)
  while IFS= read -r path; do check_image "$path" 1080 1920; done < <(find "$root/play/$language" -maxdepth 1 -type f -name '*.png' | sort)
  while IFS= read -r path; do check_image "$path" 1024 500; done < <(find "$root/feature/$language" -maxdepth 1 -type f -name '*.png' | sort)
done

echo "Validated 48 Apple screenshots, 48 Play screenshots, and 6 Play feature graphics."
