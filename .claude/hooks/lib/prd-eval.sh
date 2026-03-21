#!/usr/bin/env bash
set -euo pipefail

evaluate_prd() {
  local text="$1"
  local score=0

  # Required sections
  [[ "$text" == *"Problem"* ]] && score=$((score+10))
  [[ "$text" == *"User"* ]] && score=$((score+10))
  [[ "$text" == *"Scenario"* ]] && score=$((score+15))
  [[ "$text" == *"Scope"* ]] && score=$((score+10))
  [[ "$text" == *"Technical"* ]] && score=$((score+10))
  [[ "$text" == *"Quality"* ]] && score=$((score+10))

  # Acceptance conditions (GIVEN / WHEN / THEN)
  if [[ "$text" == *"GIVEN"* && "$text" == *"WHEN"* && "$text" == *"THEN"* ]]; then
    score=$((score+25))
  fi

  # Length bonuses
  local length=${#text}
  [ $length -gt 500 ] && score=$((score+5))
  [ $length -gt 1500 ] && score=$((score+5))

  # Penalties for vague wording
  bad_words=("maybe" "some" "etc" "works correctly")

  for w in "${bad_words[@]}"; do
    if [[ "$text" == *"$w"* ]]; then
      score=$((score-5))
    fi
  done

  # Clamp to 0–100
  [ $score -gt 100 ] && score=100
  [ $score -lt 0 ] && score=0

  echo "$score"
}
