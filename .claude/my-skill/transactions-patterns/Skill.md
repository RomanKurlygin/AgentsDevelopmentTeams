---
name: transactions-patterns
description: Database transactions, consistency guarantees, isolation levels, and rollback strategies. Use when coordinating multi-step writes and avoiding partial failures.
user-invocable: false
---

# Transactions Patterns

Keep multi-step writes atomic and consistent.

---

## ACID Basics

* **Atomicity** — all steps commit or none.
* **Consistency** — constraints hold after commit.
* **Isolation** — concurrent transactions don’t read dirty data per level.
* **Durability** — committed data survives crash.

---

## Where to Start Transactions

* **Service layer** — one transaction per use case when multiple repositories participate.
* Avoid long transactions — **no network I/O** inside DB transaction when possible.

---

## Isolation

* Default **READ COMMITTED** often enough.
* Use **SERIALIZABLE** or explicit locking for race-sensitive invariants (inventory); handle retries on conflict.

---

## Patterns

* **Outbox** — write business row + outbox row in same transaction; process events async.
* **Saga** — multi-service workflows with compensating transactions (no single DB transaction across services).

---

## Idempotency

* For retries at HTTP level, use **idempotency keys** stored in DB with unique constraint.

---

## Anti-Patterns

* Nested transactions without clarity (savepoints only when needed).
* Holding locks while calling external APIs.

---

## Summary

Scope transactions at **use-case** boundaries, keep them **short**, pick **isolation** for real races, and use **outbox/saga** for distributed consistency.
