# CLAUDE.md

> Claude Code–specific configuration. For universal coding rules see **AGENTS.md**.  
> For tech stack, commands, and directory layout see **PROJECT.md**.  
> For hook scripts overview see **Hooks.md**.

## Agent Team Structure

This project uses Claude Code sub-agents defined in **`.claude/agents/`**. Each agent has a role, tool access, and permission model. The main session can delegate to specialists:

| Agent | Role | Model | When to Use |
|-------|------|-------|-------------|
| `product-manager` | PRDs, user stories, acceptance criteria | opus | Planning new features |
| `architect` | System design, API contracts, data models | opus | Technical design decisions |
| `implementer` | Code writing, feature implementation | inherit | Building features |
| `code-reviewer` | Quality, security, performance review | inherit | After code changes |
| `tester` | Test writing, coverage, validation | sonnet | Verifying acceptance criteria |
| `debugger` | Root cause analysis, bug fixing | inherit | Investigating bugs |
| `docs-writer` | API docs, architecture docs, changelogs | sonnet | Documentation tasks |

## Slash Commands (`.claude/commands/`)

Workflow prompts live as Markdown files under **`.claude/commands/`** (use the slash command name that matches your Claude Code setup).

| Area | Commands (examples) |
|------|---------------------|
| Planning | `plan`, `prime`, `new-feature` |
| Execution | `execute`, `commit` |
| Quality | `review-code`, `fix-bug` |
| Validation | `validation/validate`, `validation/execution-report`, `validation/system-review` |
| Issues | `github-issue/rca` |

Adjust invocations to match how your environment maps files to slash commands.

## Domain Skills (`.claude/my-skill/`)

Background knowledge for backend and process is organized as **`<name>/Skill.md`** (e.g. `backend-architecture`, `prd-creator`, `error-handling`).  
The **`prd-creator`** skill drives PRD structure and references **AGENTS.md** and **`docs/templates/`**.

## Lifecycle Hooks (`.claude/hooks/`)

**`.claude/settings.json`** configures **PreToolUse**, **PostToolUse**, and **Stop** hooks (see **Hooks.md**).  
Hooks depend on **bash**, **python3**, and libraries under **`.claude/hooks/lib/`**.  
Ensure **`session-report.sh`** exists if the Stop hook is enabled, or remove that entry from settings.

Optional environment variable: **`SKILL_EVAL_THRESHOLD`** (default `80` in settings).

## Directory Structure

```
.claude/
  agents/           # Sub-agent definitions (*.md)
  commands/         # Slash-command prompts
  hooks/            # Shell hooks + lib/*.sh
  my-skill/         # Domain skills (Skill.md per folder)
  settings.json     # Permissions, env, hooks
  settings.local.json  # Optional; personal overrides (gitignored if added)
docs/
  prds/             # Product Requirements Documents
  architecture/     # Technical design, CONTEXT-*.md
  plans/            # Implementation plans
  state/            # STATE.md for pause/resume workflows
  templates/        # PRD-TEMPLATE.md, CONTEXT-TEMPLATE.md
AGENTS.md           # Universal instructions (all AI tools)
CLAUDE.md           # This file
PROJECT.md          # Stack and commands
Hooks.md            # Hook event map
```

## Development Workflow

### Feature development (idea → merge)

1. **product-manager** (or PRD skill) → draft PRD in `docs/prds/` using **`docs/templates/PRD-TEMPLATE.md`**
2. Human review / approve PRD
3. Optional: capture locked decisions in **`docs/architecture/CONTEXT-<feature>.md`** (see **CONTEXT-TEMPLATE**)
4. **architect** → design doc in `docs/architecture/`
5. Human review / approve design
6. **implementer** → code on a feature branch
7. **tester** → tests vs acceptance criteria
8. **code-reviewer** → review
9. Human merges via PR

### Bug fixing

1. **debugger** → investigate
2. Human approves fix
3. **implementer** → apply fix
4. **tester** → regression tests
5. **code-reviewer** → review

## Session continuity

- Use **`docs/state/STATE.md`** to record focus, decisions, and next steps when pausing long sessions (align with your `/pause` / `/resume` workflow if you add those commands).

## Standards

- **AGENTS.md** — code style, testing, security, git workflow  
- **PROJECT.md** — commands and conventions once an app exists

## Boundaries

### Usually allowed

- Read project files
- Run tests / linters / typecheck **once defined in PROJECT.md**
- Edit source, tests, and docs per PRD

### Ask first

- New dependencies
- Database schema changes
- Public API / contract changes
- CI/CD changes
- Large deletions

### Never

- Commit secrets or credentials
- Rewrite applied migrations
- Push directly to `main` (prefer PRs)
- Skip tests for new logic where tests exist
