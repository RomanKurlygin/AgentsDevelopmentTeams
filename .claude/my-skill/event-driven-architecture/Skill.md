---
name: event-driven-architecture
description: Event-based systems, pub/sub, message brokers, and event sourcing trade-offs. Use when decoupling producers and consumers or building audit-friendly workflows.
user-invocable: false
---

# Event-Driven Architecture

Decouple components with durable events.

---

## Patterns

* **Event notification** — “OrderCreated” triggers shipping; consumers react.
* **Event-carried state transfer** — payload enough for consumers to avoid callback.
* **CQRS** — separate read models updated from events (complexity trade-off).
* **Event sourcing** — store events as truth; replay for audit (heavy operational cost).

---

## Brokers

* **Kafka** — log, replay, high throughput; ops overhead.
* **RabbitMQ** — flexible routing; classic queues.
* **Cloud** — SNS/SQS, Pub/Sub — managed simplicity.

---

## Contracts

* **Schema** (Avro, JSON Schema) in registry; **version** additive changes.
* **Idempotent** consumers; at-least-once delivery assumed.

---

## Ordering & Consistency

* **Partition key** (e.g. `orderId`) for per-entity ordering.
* Cross-aggregate consistency via **sagas** or **outbox**.

---

## Anti-Patterns

* Chatty request-reply over broker for synchronous UX.
* No dead-letter or monitoring on consumer lag.

---

## Summary

Use **brokers** with **versioned schemas**, design **idempotent** consumers, choose **partitioning** for order, and add **DLQ + lag alerts**.
