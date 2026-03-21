#!/usr/bin/env bash
set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

ensure_hook_dirs() {
  mkdir -p "$HOOK_DIR/logs" "$HOOK_DIR/metrics"
}

get_timestamp() {
  date -u +%Y-%m-%dT%H:%M:%SZ
}

extract_skill_name() {
  local payload="$1"

  python - "$payload" <<'PY'
import json,sys

raw=sys.argv[1]
name=''

try:
    o=json.loads(raw)

    name = (
        o.get('tool_input', {}).get('skill') or
        o.get('skill') or
        o.get('name') or
        ''
    )

except Exception:
    name=''

print(name)
PY
}
