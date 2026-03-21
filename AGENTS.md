# AGENTS.md

> Universal agent instructions for all AI coding tools.  
> Supported by: Claude Code, GitHub Copilot, Cursor, Codex, Devin, Factory, Gemini CLI, Jules, VS Code, Zed.

Universal instructions for AI coding agents working in this repository.

This file defines coding rules, development workflow, and behavioral constraints for AI tools such as Claude Code, GitHub Copilot, Cursor, Codex, and other AI development assistants.

For feature requirements, see PRDs in `docs/prds/`.  
For technology stack and commands, see **PROJECT.md**.  
For Claude Code–specific setup (agents, commands, hooks), see **CLAUDE.md**.

## 1. Project Overview

This repository follows an agent-assisted development workflow where AI tools collaborate with humans to design, implement, and validate software features.

The development process is driven by Product Requirements Documents (PRDs).

PRDs define:

- product goals
- user scenarios
- acceptance conditions
- implementation scope

Every implementation task must map back to a PRD requirement.

Documentation structure:

```
docs/
  prds/            Product Requirements Documents
  architecture/    Technical design and system decisions
  plans/           Implementation plans and reports
  state/           Session state (STATE.md) for pause/resume workflows
  templates/       Document templates (PRD, context)
```

## 2. Development Principles

AI agents should follow these core engineering principles:

### Single Responsibility

- Functions and modules should perform one clear task.
- Avoid large functions or mixed responsibilities.

### Readability First

- Code should prioritize clarity over cleverness.
- Use descriptive names:

**Good:**

- `calculateInvoiceTotal()`
- `validateUserInput()`
- `generateReport()`

**Avoid** abbreviations or unclear names.

### Consistency

- Follow patterns already present in the codebase.
- If similar logic exists elsewhere, reuse that pattern.

### Predictable Behavior

- Do not introduce unexpected side effects.
- Prefer explicit logic and predictable data flow.

## 3. PRD-Driven Development

All feature development must follow the PRD workflow.

**Source of truth:** `docs/prds/`

Each PRD contains:

- feature overview
- user scenarios
- acceptance conditions
- technical constraints

Agents must:

- Read the relevant PRD before implementing anything
- Map each feature implementation to a scenario
- Implement behavior matching the acceptance conditions

**Example acceptance condition:**

```
GIVEN user submits valid email
WHEN registration endpoint is called
THEN a new user account is created
```

Every acceptance condition must be verifiable via tests.

Use **`docs/templates/PRD-TEMPLATE.md`** as the starting point for new PRDs.

## 4. Code Style Rules

General coding rules:

- keep functions short
- avoid deeply nested logic
- prefer small reusable utilities
- write clear variable names
- avoid unnecessary abstraction

Additional rules:

- avoid global mutable state
- prefer pure functions when possible
- validate inputs at system boundaries

Import rules and file naming conventions are defined in **PROJECT.md**.

## 5. Testing Requirements

Testing is mandatory for all new logic.

Agents must follow these rules:

### Acceptance Criteria Coverage

Each PRD acceptance condition must have at least one test.

### No Real External Services

Tests must not call real APIs. Use mocks or test doubles.

### Test Data

Use:

- factories
- fixtures
- generated test data

Avoid hardcoded datasets where possible.

### Test Organization

Tests should follow the structure defined in **PROJECT.md**.

**Example structure:**

```
tests/
  unit/
  integration/
  e2e/
```

## 6. Security Rules

Security rules are mandatory.

Agents must never:

- log tokens, passwords, or private keys
- commit .env files
- expose credentials in source code
- disable authentication checks

Sensitive data includes:

- API keys
- access tokens
- session identifiers
- personal user information

All inputs must be validated to prevent:

- injection attacks
- invalid data
- unauthorized access

## 7. Git Workflow

Agents should follow a structured Git workflow.

### Branch Naming

- `feat/feature-name`
- `fix/bug-description`
- `chore/maintenance-task`
- `docs/documentation-update`

### Commit Format

Use conventional commits:

- `feat: add report export feature`
- `fix: correct authentication validation`
- `docs: update API documentation`

### Pull Requests

Before merging:

- CI must pass
- tests must pass
- code review must be completed

All changes should be merged via pull request. Direct commits to main are not allowed.

## 8. Implementation Workflow

Feature development should follow this process.

### Step 1 — Requirements

Read the PRD: `docs/prds/[feature].md`

Understand:

- user scenarios
- acceptance conditions
- scope boundaries

### Step 2 — Implementation

Implement the required functionality:

- follow architecture patterns
- write maintainable code
- avoid scope creep

### Step 3 — Testing

Write tests covering:

- acceptance criteria
- edge cases
- failure scenarios

### Step 4 — Validation

Before committing:

- run tests
- run lint checks
- run type checks
- run build

Validation commands are defined in **PROJECT.md**.

## 9. Agent Permissions

AI agents have limited permissions.

### Allowed

Agents may:

- read any file
- modify source code
- add new tests
- create branches and commits
- update documentation

### Requires Human Approval

Agents must ask before:

- adding dependencies
- changing database schemas
- modifying public APIs
- changing CI/CD configuration
- deleting large parts of the codebase

### Forbidden

Agents must never:

- commit secrets
- remove security mechanisms
- skip tests
- bypass type checking
- modify historical migrations

## 10. Quality Standards

Before marking work as complete:

- all PRD acceptance conditions must be satisfied
- all tests must pass
- code coverage must meet project thresholds
- code must follow style guidelines
- documentation must be updated if needed

## 11. Documentation Rules

Documentation must stay synchronized with implementation.

Required updates when relevant:

- PRDs
- architecture docs
- API documentation
- changelog

When introducing new features, agents should ensure that documentation accurately reflects system behavior.

## 12. Validation Checklist

Before completing a task:

- [ ] Implementation matches PRD requirements
- [ ] Acceptance criteria validated by tests
- [ ] Code passes linting and formatting checks
- [ ] All tests pass
- [ ] No secrets or sensitive data in code
- [ ] Documentation updated if necessary

---

If multiple AI tools work in this repository, **AGENTS.md** acts as the shared behavioral contract for all automated coding agents.
