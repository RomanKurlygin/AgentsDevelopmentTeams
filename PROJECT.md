# PROJECT.md

> **Project-specific configuration for the agentic development team.**  
> Update this file when you add a runtime app, change the tech stack, or define real lint/test commands.

This repository is primarily a **PRD-driven methodology workspace**: Markdown docs, Claude **hooks** (`.claude/hooks/`), **skills** (`.claude/my-skill/`), **slash commands** (`.claude/commands/`), and **sub-agents** (`.claude/agents/`).  
When you scaffold an application inside or alongside this repo, fill in the sections below so agents can run the correct tooling.

---

## Product Overview

| Field | Description |
|-------|-------------|
| Product name | Agentic PRD workspace (`cursor-prd-project`) |
| One-line description | Templates, hooks, and skills for PRD-driven development with AI agents |
| Target users | Teams using Claude Code / Cursor with multi-agent and PRD workflows |
| Core problem | Keep requirements, design, and implementation aligned via PRDs and automation |
| Key domain concepts | PRD, acceptance criteria (GIVEN/WHEN/THEN), architecture docs, agent skills |
| Deployment target | N/A (documentation repo); application deploy TBD when added |
| External integrations | Optional: Git remote; hooks may use Python for logging |

### Product Goals

1. Maintain a single source of truth for agent behavior (**AGENTS.md**, **CLAUDE.md**).
2. Store PRDs under `docs/prds/` and designs under `docs/architecture/`.
3. Optional: PRD lifecycle hooks in `.claude/hooks/` (see **Hooks.md**).

---

## Tech Stack

| Layer | Technology |
|-------|------------|
| Primary content | Markdown, JSON (`.claude/settings.json`), Bash hooks |
| Language (app) | *Not set — add when you introduce source code* |
| Runtime | *Not set* |
| Framework | *Not set* |
| Database | *Not set* |
| Test framework | *Not set* |
| E2E framework | *Not set* |
| Linter | *Not set* |
| Type checker | *Not set* |
| Package manager | *Not set* |

---

## Commands

Replace placeholders when a real application exists. Until then, there is **no** single `pnpm`/`npm` project at the repository root.

| Task | Command |
|------|---------|
| Install dependencies | *N/A until package manifest exists* |
| Dev server | *N/A* |
| Build | *N/A* |
| Run all tests | *N/A* |
| Run single test file | *N/A* |
| Test with coverage | *N/A* |
| Lint | *N/A* |
| Lint with auto-fix | *N/A* |
| Type check | *N/A* |
| E2E tests | *N/A* |
| DB migrate | *N/A* |

### Validation Command

The composite command agents run before every commit (must exit non-zero on failure):

```bash
# Replace with your real pipeline, e.g.:
# pnpm test && pnpm typecheck && pnpm lint

echo "No validation pipeline configured yet — add commands when the app exists."
```

---

## Directory Structure

Repository layout relevant to agents:

```
.cursor-prd-project/
├── AGENTS.md              # Universal agent rules
├── CLAUDE.md              # Claude Code: agents, commands, hooks
├── PROJECT.md             # This file
├── Hooks.md               # Hook scripts overview
├── Create-PRD.md          # Legacy/alternate PRD guide (optional)
├── docs/
│   ├── prds/              # PRD-*.md files
│   ├── architecture/      # Technical design docs, CONTEXT-*.md
│   ├── plans/             # Implementation plans
│   ├── state/             # STATE.md (pause/resume)
│   └── templates/         # PRD-TEMPLATE.md, CONTEXT-TEMPLATE.md
└── .claude/
    ├── settings.json
    ├── agents/            # Sub-agent definitions
    ├── commands/          # Slash-command prompts
    ├── hooks/             # Pre/Post ToolUse, Stop hooks
    └── my-skill/          # Domain skills (Skill.md per folder)
```

When you add an app, document its `src/`, tests, and tooling here.

---

## File Conventions

| Convention | Pattern |
|------------|---------|
| PRD files | `docs/prds/PRD-<feature>.md` or match **PRD-TEMPLATE** |
| Design docs | `docs/architecture/<feature>.md` |
| Locked decisions | `docs/architecture/CONTEXT-<feature>.md` from **CONTEXT-TEMPLATE** |
| Agent definitions | `.claude/agents/<role>.md` |
| Slash commands | `.claude/commands/<name>.md` |
| Skills | `.claude/my-skill/<skill-name>/Skill.md` |

---

## Code Standards

Until application code exists:

- Keep documentation and agent prompts consistent with **AGENTS.md**.
- Bash hooks require **bash**, **python3** (for JSON logging in hooks), and POSIX-friendly paths when run in WSL/Git Bash.

When you add code, list language-specific rules here (e.g. TypeScript strict mode).

---

## Architecture Pattern

- **Documentation & methodology**: PRD → optional context doc → architecture doc → implementation plans in `docs/plans/`.
- **Application** (when added): describe layering (e.g. controller → service → repository) in **PROJECT.md** and `docs/architecture/`.

---

## Security Considerations

- Do not commit secrets, `.env`, or API keys.
- Hook scripts must not log full payloads containing tokens (see hook implementations).

---

## Implementation Phases

Default phases for feature work (customize per PRD):

1. Requirements locked in `docs/prds/`
2. Design in `docs/architecture/`
3. Plan in `docs/plans/` (optional)
4. Implementation + tests per **PROJECT.md** commands when available

---

## Permissions Guidance

Add tool-specific Bash allowlists to `.claude/settings.json` as you introduce them, for example:

```json
"Bash(pnpm test*)",
"Bash(pnpm lint*)",
"Bash(pnpm typecheck*)"
```

Current **permissions** in `.claude/settings.json` are limited to Git read operations; extend when your validation command needs more.
