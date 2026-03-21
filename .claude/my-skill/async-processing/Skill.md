---
name: async-processing
description: Background jobs, queues, workers, and async workflows for long or unreliable operations. Use when decoupling HTTP from heavy work and improving resilience.
user-invocable: false
---

# Async Processing

Move work off the request path when it doesn’t need an immediate response.

---

## When to Use Async

* **Email, webhooks, reports** — minutes acceptable.
* **Retries** — external APIs unreliable.
* **Burst traffic** — smooth with queue + workers.

---

## Building Blocks

* **Queue** — SQS, RabbitMQ, Redis streams, Kafka (event log).
* **Workers** — horizontal scale; **idempotent** handlers with dedupe keys.
* **Dead-letter queue** — poison messages after max retries; alert on DLQ depth.

---

## Patterns

* **Outbox** — transactional with domain write; relay to broker.
* **Saga / process manager** — orchestrate multi-step async flows with state machine.

---

## Semantics

* **At-least-once** delivery common — handlers must be **idempotent**.
* **Exactly-once** expensive; usually simulate with idempotency store.

---

## Anti-Patterns

* Fire-and-forget `setTimeout` for critical billing without persistence.
* Unbounded in-memory queues on app servers.

---

## Summary

Persist intent (**outbox**), use **durable queues**, scale **workers**, design **idempotent** consumers, and **monitor DLQs**.
