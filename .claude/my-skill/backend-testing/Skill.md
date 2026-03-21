---
name: backend-testing
description: Unit, integration, and end-to-end testing strategies for backend systems. Use when designing test pyramids, boundaries, and CI feedback for services and APIs.
user-invocable: false
---

# Backend Testing

Balance fast feedback with realistic coverage.

---

## Test Pyramid

1. **Unit** — pure functions, domain rules, services with mocked ports (many, fast).
2. **Integration** — repositories with real DB (Testcontainers), HTTP against running app, message consumers.
3. **E2E** — few critical user journeys through API or UI (slow, flaky if overused).

---

## Unit Tests

* Mock **repositories and HTTP clients**; assert outputs and thrown errors.
* Keep tests **deterministic** — fixed clocks, seeded random when needed.

---

## Integration Tests

* One **real database** per CI job (container) or ephemeral schema.
* Run migrations before suite; truncate between tests or use transactions + rollback.
* Test **migrations** in a dedicated smoke step when possible.

---

## E2E

* Hit **public API** as clients do; use **seed data** via API or factories.
* Run in CI on merge; keep count small.

---

## Coverage

* Aim for high coverage on **domain and services**; integration proves wiring.
* Don’t chase 100% on glue code at the expense of meaningful asserts.

---

## Anti-Patterns

* E2E-only strategy — slow pipeline, brittle.
* Mocking everything including types — tests that don’t catch integration bugs.

---

## Summary

Prefer **many unit**, **focused integration**, **few E2E**; use **real DB** in integration for query and migration safety.
