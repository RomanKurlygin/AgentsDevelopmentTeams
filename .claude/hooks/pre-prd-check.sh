#!/usr/bin/env bash
set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$HOOK_DIR/lib/utils.sh"
source "$HOOK_DIR/lib/metrics.sh"

ensure_hook_dirs

payload="$(cat || true)"
skill="$(extract_skill_name "$payload")"
[ "$skill" != "prd-creator" ] && exit 0

latest="$(get_latest_score "$skill")"

echo "[pre-prd-check] skill=$skill latest_score=$latest"

# Signal when quality is low — enable stricter validation downstream
threshold="${SKILL_EVAL_THRESHOLD:-80}"

if [ -n "$latest" ] && [ "$latest" -lt "$threshold" ]; then
  echo "[pre-prd-check] ⚠️ low quality detected, enabling stricter validation"
fi
