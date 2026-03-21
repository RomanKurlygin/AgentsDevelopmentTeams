#!/usr/bin/env bash
set -euo pipefail

LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

evaluate_output() {
  local text="$1"

  # PRD-shaped output → use prd-eval scoring
  if [[ "$text" == *"GIVEN"* && "$text" == *"Scenario"* ]]; then
    source "$LIB_DIR/prd-eval.sh"
    evaluate_prd "$text"
    return
  fi

  # Generic fallback
  local score=40

  [[ -n "$text" ]] && score=$((score+20))
  [[ "$text" == *"##"* ]] && score=$((score+10))
  [[ "$text" == *"```"* ]] && score=$((score+10))

  local length=${#text}
  [ $length -gt 300 ] && score=$((score+10))
  [ $length -gt 1000 ] && score=$((score+10))

  [ $score -gt 100 ] && score=100

  echo "$score"
}
