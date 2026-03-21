#!/usr/bin/env bash
set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$HOOK_DIR/lib/utils.sh"

ensure_hook_dirs

log_file="$HOOK_DIR/logs/session-$(date -u +%F).jsonl"
ts="$(get_timestamp)"

printf '{"timestamp":"%s","event":"session_stop","message":"PRD hooks session ended"}\n' "$ts" >>"$log_file"

echo "[session-report] wrote $log_file"
