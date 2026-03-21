# Hooks

The project includes a lifecycle hook system inspired by AgentsTeam, extended for PRD-driven development and self-improving skills.

## Events

| Hook | Matcher | Script |
|------|-----------|--------|
| PreToolUse | `prd-creator` | `.claude/hooks/pre-prd-check.sh` |
| PostToolUse | `prd-creator` | `.claude/hooks/log-prd-result.sh` |
| PostToolUse | `prd-creator` | `.claude/hooks/post-prd-eval.sh` |
| PostToolUse | `prd-creator` | `.claude/hooks/prd-quality-check.sh` |
| Stop | — | `.claude/hooks/session-report.sh` |

## Libraries

- `.claude/hooks/lib/utils.sh`
- `.claude/hooks/lib/metrics.sh`
- `.claude/hooks/lib/eval-engine.sh`
- `.claude/hooks/lib/prd-eval.sh`

## Data

- **Logs:** `.claude/hooks/logs/*.jsonl`
- **Metrics:** `.claude/hooks/metrics/*.jsonl`

## PRD-focused features

The hooks add PRD-specific behavior:

- PRD structure checks
- Validation of acceptance conditions (GIVEN / WHEN / THEN)
- Requirement quality assessment
- Detection of missing sections
- Self-improvement via scoring

## Self-improvement loop

Each `prd-creator` run follows this sequence:

1. Read and consider the previous score.
2. Generate the PRD.
3. Validate structure.
4. Assess quality.
5. Write results to metrics.

Over time, this helps the system improve PRD quality.
