---
name: contract-testing
description: Consumer-driven contract testing between services and API providers. Use when multiple teams evolve HTTP or message contracts independently.
user-invocable: false
---

# Contract Testing

Catch integration breaks before deploy.

---

## Consumer-Driven Contracts (Pact)

1. **Consumer** defines expected interactions (request/response shapes).
2. **Pact file** is shared (broker).
3. **Provider** verifies against pact in CI — fails if response no longer matches.

Suited for **many consumers** of one API or **internal microservices**.

---

## Provider Contract Tests

* Provider CI runs tests generated from **Pacts** or **OpenAPI** (schemathesis).
* Complements but does not replace **unit tests** of provider logic.

---

## Versioning

* Tag pacts with **consumer version** and **API version**.
* Deploy only when **can-i-deploy** (Pact broker) allows.

---

## When Not to Use

* Monolith with single UI — E2E or integration may suffice.
* Early prototypes — overhead too high until APIs stabilize somewhat.

---

## Anti-Patterns

* Manual “golden” JSON files never updated when API changes.
* Skipping provider verification in CI.

---

## Summary

Use **Pact** or **OpenAPI-driven** contract tests so **consumers’ expectations** drive **provider compatibility** checks in CI.
