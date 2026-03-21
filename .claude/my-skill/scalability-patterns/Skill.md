---
name: scalability-patterns
description: Horizontal scaling, stateless services, load balancing, and capacity patterns. Use when growing traffic beyond a single node.
user-invocable: false
---

# Scalability Patterns

Scale out stateless tiers; isolate state.

---

## Stateless App Servers

* **No session in memory** — sessions in Redis or JWT with short TTL.
* **Idempotent** APIs where clients retry.
* Deploy **multiple replicas** behind a **load balancer** (round-robin, least conn).

---

## Data Layer

* **Scale reads** — replicas with replication lag awareness; read-your-writes when needed.
* **Scale writes** — sharding/partitioning, or split bounded contexts into services with own DB.

---

## Queues

* Absorb spikes — producers enqueue, workers scale independently (Kinesis, SQS, Rabbit).

---

## Autoscaling

* CPU/RPS-based rules; **cooldown** to avoid flapping; **min replicas** for baseline.

---

## Anti-Patterns

* Sticky sessions required because of in-memory cart without shared store.
* Chatty synchronous chains across regions.

---

## Summary

Keep **web tier stateless**, push **state** to DB/Redis/queue, **scale horizontally**, and use **async** boundaries for peak load.
