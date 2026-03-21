---
name: api-testing
description: Testing HTTP APIs for contracts, status codes, validation errors, and edge cases. Use when automating API quality in CI and preventing regressions.
user-invocable: false
---

# API Testing

Verify behavior, not only status 200.

---

## Layers

1. **Contract** — OpenAPI/JSON Schema matches responses; breaking changes caught in CI.
2. **Behavior** — given auth/role, expected status and body shape.
3. **Edge cases** — empty body, huge payload, wrong `Content-Type`, missing auth.

---

## What to Assert

* Status code and **error envelope** (`code`, `message`).
* Pagination (`limit`, `cursor`, totals).
* **Headers:** `Location` on 201, rate-limit headers if applicable.
* Idempotency: duplicate requests with same key → same outcome.

---

## Tools

* **Supertest** (Node), **REST Assured** (JVM), **pytest + httpx** (Python).
* **Dredd** / **Schemathesis** for contract-based fuzzing from OpenAPI.

---

## Data Setup

* Factory functions for users/tenants; clean between tests.
* Prefer **API** to create fixtures over raw SQL when it reflects real flows.

---

## Anti-Patterns

* Asserting only `status === 200` without body checks.
* Shared mutable state between tests without isolation.

---

## Summary

Combine **contract checks**, **behavioral tests**, and **negative paths**; generate tests from **OpenAPI** when possible.
