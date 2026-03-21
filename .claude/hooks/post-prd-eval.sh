#!/usr/bin/env bash
set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$HOOK_DIR/lib/utils.sh"
source "$HOOK_DIR/lib/eval-engine.sh"
source "$HOOK_DIR/lib/metrics.sh"

ensure_hook_dirs

payload="$(cat || true)"
skill="$(extract_skill_name "$payload")"
[ "$skill" != "prd-creator" ] && exit 0

text="$(python - "$payload" <<'PY'
import json,sys
try:
    o=json.loads(sys.argv[1])
    print(o.get('tool_response') or '')
except Exception:
    print('')
PY
)"

# Base score from eval engine
score="$(evaluate_output "$text")"

# Bonus when acceptance conditions include GIVEN / WHEN / THEN
if [[ "$text" == *"GIVEN"* && "$text" == *"WHEN"* && "$text" == *"THEN"* ]]; then
  score=$((score + 10))
fi

record_score "$skill" "$score" "prd-hook"

echo "[post-prd-eval] skill=$skill score=$score"
