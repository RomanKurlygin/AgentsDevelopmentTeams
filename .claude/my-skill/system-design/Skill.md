---
name: system-design
description: High-level system design, trade-offs, and architecture decisions for distributed systems. Use when sketching components, data flows, and non-functional requirements.
user-invocable: false
---

# System Design

Structure solutions around requirements and constraints.

---

## Clarify Requirements

* **Functional** — features, user stories.
* **Non-functional** — latency (p99), availability (nines), throughput, consistency, compliance, cost.

---

## Core Building Blocks

* **Load balancer** — HTTP/gRPC ingress.
* **App tier** — stateless services.
* **Data** — OLTP DB, cache, object storage, search index.
* **Async** — message queue / event bus.
* **CDN / edge** — static and cacheable API.

---

## Trade-Offs

* **Consistency vs availability** — CAP intuition; choose per operation (payments vs social likes).
* **Sync vs async** — simpler mental model vs resilience under load.
* **Monolith vs services** — velocity vs independent scaling (don’t split prematurely).

---

## API & Data

* Define **boundaries** (DDD bounded contexts).
* Choose **strong consistency** inside aggregate; **eventual** across services with events.

---

## Drawing

* **C4**: context → container → component for clarity.
* Annotate **traffic**, **data stores**, and **trust zones**.

---

## Anti-Patterns

* Designing for hypothetical scale on day one.
* Ignoring **failure modes** (dependency down, region loss).

---

## Summary

Start from **requirements**, map **components and data**, document **trade-offs**, and validate with **capacity estimates** and **failure scenarios**.
