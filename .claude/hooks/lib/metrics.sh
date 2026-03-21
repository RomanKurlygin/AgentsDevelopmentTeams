#!/usr/bin/env bash
set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
METRICS_DIR="$HOOK_DIR/metrics"

record_score() {
  local skill="$1"
  local score="$2"
  local source="${3:-hook}"

  mkdir -p "$METRICS_DIR"

  printf '{"timestamp":"%s","skill":"%s","score":%s,"source":"%s"}\n' \
    "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$skill" "$score" "$source" \
    >> "$METRICS_DIR/${skill}.jsonl"
}

get_latest_score() {
  local skill="$1"
  local file="$METRICS_DIR/${skill}.jsonl"

  [ ! -f "$file" ] && echo "N/A" && return

  python - "$file" <<'PY'
import json,sys

last='N/A'

for line in open(sys.argv[1],encoding='utf-8',errors='ignore'):
    try:
        last=str(json.loads(line).get('score','N/A'))
    except Exception:
        pass

print(last)
PY
}

get_avg_score() {
  local skill="$1"
  local file="$METRICS_DIR/${skill}.jsonl"

  [ ! -f "$file" ] && echo "N/A" && return

  python - "$file" <<'PY'
import json,sys

scores=[]

for line in open(sys.argv[1],encoding='utf-8',errors='ignore'):
    try:
        scores.append(float(json.loads(line).get('score',0)))
    except Exception:
        pass

if scores:
    print(round(sum(scores)/len(scores),2))
else:
    print("N/A")
PY
}
