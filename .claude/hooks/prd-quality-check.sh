#!/usr/bin/env bash
set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$HOOK_DIR/lib/utils.sh"

ensure_hook_dirs

payload="$(cat || true)"
skill="$(extract_skill_name "$payload")"
[ "$skill" != "prd-creator" ] && exit 0

python - "$payload" <<'PY'
import json,sys

payload=sys.argv[1]

try:
    o=json.loads(payload)
    text=o.get('tool_response') or ''
except Exception:
    text=""

issues=[]

# Required PRD sections
required_sections=[
    "Problem",
    "User",
    "Scenario",
    "Scope",
    "Technical",
    "Quality"
]

for sec in required_sections:
    if sec.lower() not in text.lower():
        issues.append(f"missing_section:{sec}")

# Acceptance conditions (GIVEN / WHEN / THEN)
if "GIVEN" not in text or "WHEN" not in text or "THEN" not in text:
    issues.append("invalid_acceptance_conditions")

# Vague wording
bad_words=["some","maybe","etc","works correctly"]
for w in bad_words:
    if w in text.lower():
        issues.append(f"ambiguous:{w}")

print("[prd-quality-check]", "OK" if not issues else ",".join(issues))
PY
