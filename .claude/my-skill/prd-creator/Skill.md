---
name: prd-creator
description: Create structured Product Requirements Documents (PRDs) for this repository using the official PRD template. Use this skill when planning a new feature, defining user scenarios, writing acceptance conditions (GIVEN/WHEN/THEN), or preparing requirements before implementation. This skill ensures that every feature follows the PRD-driven development workflow defined in AGENTS.md and that requirements can be validated by automated tests.
---

# PRD Creator Skill

This skill helps create **Product Requirements Documents (PRDs)** that follow the repository standards.

PRDs are the **source of truth for feature development**.  
All implementation work must trace back to a PRD requirement.

## Repository Structure

```
docs/
  prds/
  architecture/
  plans/
  templates/
```

PRDs must be created inside:

```
docs/prds/
```

Use the repository template **`docs/templates/PRD-TEMPLATE.md`** as the structural starting point (see also **Create-PRD.md** in the repo root).

---

## Core Principle

The repository follows **PRD-Driven Development**.

This means:

1. A feature must be described in a PRD before implementation.
2. Every user scenario must include **acceptance conditions**.
3. Acceptance conditions must be **testable**.
4. Implementation must map directly to those conditions.

**Example:**

```
GIVEN a valid email address
WHEN the user submits the registration form
THEN a new user account is created
```

Each acceptance condition should correspond to at least one test.

---

## PRD Creation Workflow

Follow this workflow when creating a PRD.

### Step 1 — Understand the Feature

Clarify the feature before writing the PRD.

**Key questions:**

- What problem does this feature solve?
- Who are the users?
- What workflows should be supported?
- What success criteria define completion?

If information is missing, ask the user for clarification.

### Step 2 — Define the Problem

Document the problem clearly.

**Include:**

- current situation
- user pain points
- supporting evidence (if available)
- consequences of not solving the problem

Focus on **real user needs**, not technical solutions.

### Step 3 — Identify Target Users

Describe the primary users.

**Example attributes:**

- technical level
- environment (web/mobile/API)
- goals and motivations

Avoid vague definitions like "everyone".

### Step 4 — Write User Scenarios

User scenarios describe how the feature will be used.

Each scenario must include:

- user role
- goal
- acceptance conditions

**Example scenario structure:**

```
Scenario — Create Report

User role: Analyst

Goal:
User wants to generate a report from analytics data.

Acceptance Conditions:

GIVEN valid report parameters
WHEN the report generation endpoint is called
THEN a report is created successfully
```

Include **example inputs and outputs** when possible.

### Step 5 — Define Scope

Clearly define what is included.

**Included** — Features that must be implemented.

**Excluded** — Features intentionally left out.

This prevents **scope creep**.

### Step 6 — Technical Context

Provide relevant technical context.

**Examples:**

- affected modules
- API endpoints
- database changes
- architectural constraints

Do not over-specify implementation unless necessary.  
The architect or implementer agents will handle detailed design.

### Step 7 — Define Quality Requirements

Each feature must specify quality constraints.

**Typical examples:**

- performance targets
- reliability expectations
- test coverage thresholds
- accessibility requirements

### Step 8 — Define Development Plan

Break the implementation into stages.

**Typical phases:**

1. Data layer
2. Business logic
3. API/interface
4. Integration and testing

Follow the architecture guidelines from `PROJECT.md`.

---

## Writing Guidelines

When writing PRDs:

**Use clear language.**

**Prefer:**

- concise sentences
- structured sections
- concrete examples

**Avoid:**

- vague descriptions
- unnecessary technical detail
- speculative features

PRDs should describe **what must happen**, not **how to code it**.

---

## Acceptance Condition Rules

Acceptance conditions must follow the format:

```
GIVEN [initial state]
WHEN [action]
THEN [expected result]
```

**Optional:**

```
AND [additional validation]
```

**Guidelines:**

- each condition must be testable
- avoid ambiguous terms
- define clear outcomes

**Bad example:**

```
THEN the system works correctly
```

**Good example:**

```
THEN the API returns status 201 and the user record is created
```

---

## PRD Validation Checklist

Before finalizing the PRD ensure:

- the problem is clearly defined
- user scenarios exist
- acceptance conditions are testable
- scope boundaries are explicit
- technical context is provided
- development phases are defined

---

## Relationship to AGENTS.md

PRDs drive the development workflow described in **AGENTS.md**.

AI agents must:

- read the PRD before implementation
- map implementation to acceptance conditions
- write tests that validate those conditions

PRDs therefore act as the **contract between product requirements and engineering implementation**.

---

## Output Location

Generated PRDs must be saved to:

```
docs/prds/[feature-name].md
```

Use a clear feature name.

**Examples:**

```
docs/prds/user-authentication.md
docs/prds/report-export.md
docs/prds/payment-processing.md
```

---

## Best Practices

**Strong PRDs:**

- describe real user workflows
- define measurable outcomes
- separate requirements from implementation
- minimize ambiguity

**Weak PRDs:**

- describe vague ideas
- mix product requirements with code details
- omit acceptance conditions
