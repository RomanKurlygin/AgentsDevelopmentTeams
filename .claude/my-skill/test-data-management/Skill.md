---
name: test-data-management
description: Fixtures, factories, and test data isolation for reliable automated tests. Use when scaling test suites and avoiding flaky shared databases.
user-invocable: false
---

# Test Data Management

Keep tests isolated and reproducible.

---

## Strategies

1. **Factories** — `createUser({ email })` with sensible defaults; override only what the test cares about.
2. **Builders** — fluent API for complex graphs (`order.withItems(3).build()`).
3. **Fixtures** — static JSON for contract tests; version with schema.

---

## Isolation

* **Per-test DB** (ephemeral) — strongest isolation; slower.
* **Transaction rollback** — wrap each test in `BEGIN` / `ROLLBACK`.
* **Truncate tables** — fast reset; respect FK order or use CASCADE carefully.

---

## Parallel Runs

* Avoid **global counters**; use UUIDs or sequences per worker.
* Separate **schemas** or DBs per Jest worker when parallel integration tests run.

---

## Sensitive Data

* Never copy production dumps to dev without **masking**.
* Synthetic emails/domains (`@test.example`) to avoid accidental mail.

---

## Anti-Patterns

* Tests depending on **order of execution**.
* Shared “admin” user mutated by all tests without reset.

---

## Summary

Use **factories**, **clear isolation** (transaction or reset), and **parallel-safe** identifiers so suites stay **fast and deterministic**.
