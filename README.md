# cursor-prd-project

Agentic **PRD-driven development** workspace: universal agent rules (**AGENTS.md**), Claude-specific setup (**CLAUDE.md**), project commands (**PROJECT.md**), PRD templates, sub-agents, slash commands, domain skills, and optional **lifecycle hooks** for PRD quality metrics.

## Quick links

| Document | Purpose |
|----------|---------|
| [AGENTS.md](./AGENTS.md) | Rules for all AI coding tools (Cursor, Claude Code, Copilot, …) |
| [CLAUDE.md](./CLAUDE.md) | Claude Code: agents, commands, hooks, folder layout |
| [PROJECT.md](./PROJECT.md) | Product context, tech stack, validation commands (fill in when you add an app) |
| [Hooks.md](./Hooks.md) | Map of Pre/Post ToolUse and Stop hooks |
| [Create-PRD.md](./Create-PRD.md) | Alternate PRD authoring guide |

## Repository layout

- **`docs/prds/`** — Product Requirements Documents  
- **`docs/architecture/`** — Technical designs and `CONTEXT-*.md` decision locks  
- **`docs/plans/`** — Implementation plans  
- **`docs/templates/`** — `PRD-TEMPLATE.md`, `CONTEXT-TEMPLATE.md`  
- **`docs/state/`** — `STATE.md` for session handoff  
- **`.claude/agents/`** — Specialized sub-agents (product-manager, architect, implementer, …)  
- **`.claude/commands/`** — Slash-command prompts (`plan`, `execute`, `new-feature`, …)  
- **`.claude/my-skill/`** — Domain skills (`prd-creator`, `backend-architecture`, …)  
- **`.claude/hooks/`** — Shell hooks and `lib/` helpers  

## Getting started

1. Read **AGENTS.md** and **CLAUDE.md**.  
2. Copy **`docs/templates/PRD-TEMPLATE.md`** when creating a new PRD under **`docs/prds/`**.  
3. When you add a real application, update **PROJECT.md** with install/build/test/lint commands and validation script.  
4. Optional: tune **`.claude/settings.json`** (permissions, hooks, env).

## License

Add a license if you publish this repository publicly.
