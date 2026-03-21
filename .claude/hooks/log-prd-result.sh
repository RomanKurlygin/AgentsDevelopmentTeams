#!/usr/bin/env bash
set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$HOOK_DIR/lib/utils.sh"

ensure_hook_dirs

payload="$(cat || true)"
skill="$(extract_skill_name "$payload")"
[ "$skill" != "prd-creator" ] && exit 0

log_file="$HOOK_DIR/logs/prd-results-$(date -u +%F).jsonl"

python - "$payload" "$log_file" <<'PY'
import json,sys,datetime

payload,log_file=sys.argv[1],sys.argv[2]

entry={
  "timestamp":datetime.datetime.utcnow().isoformat()+"Z",
  "event":"prd_generated"
}

try:
    o=json.loads(payload)
    text=o.get('tool_response') or ''
    entry['length']=len(text)
    entry['has_given_when_then']="GIVEN" in text and "WHEN" in text and "THEN" in text
except Exception:
    entry['length']=0
    entry['has_given_when_then']=False

with open(log_file,'a',encoding='utf-8') as f:
    f.write(json.dumps(entry,ensure_ascii=False)+'\n')
PY
