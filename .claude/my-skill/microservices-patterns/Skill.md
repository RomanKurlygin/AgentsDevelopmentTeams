---
name: microservices-patterns
description: Microservices communication, service boundaries, deployment, and operational patterns. Use when decomposing monoliths or designing multi-service platforms.
user-invocable: false
---

# Microservices Patterns

Prefer **clear boundaries** over many tiny services.

---

## When to Split

* **Independent scaling** or **release cadence** per domain.
* **Team ownership** aligned with business capabilities.
* **Not** for small teams without platform maturity — monolith/modular monolith first.

---

## Communication

* **Sync** — HTTP/gRPC for queries needing immediate answer; **timeouts + circuit breakers**.
* **Async** — events for decoupling; **schema registry** for evolution.

---

## Data

* **Database per service** — no shared DB tables across services; integrate via APIs or events.
* **Saga** for distributed transactions; accept **eventual consistency**.

---

## Deployment

* **Containers** + orchestrator (K8s, ECS); **CI/CD** per service.
* **Observability** — distributed tracing required (trace IDs across calls).

---

## Anti-Patterns

* Distributed monolith — every call chains through five services synchronously.
* Shared libraries that hide tight coupling without version discipline.

---

## Summary

Define **bounded contexts**, own **data per service**, prefer **events** for side effects, invest in **observability** and **release automation**.
