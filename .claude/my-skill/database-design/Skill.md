---
name: database-design
description: Relational schema design, normalization trade-offs, and indexing fundamentals. Use when modeling domains for OLTP systems and avoiding data anomalies.
user-invocable: false
---

# Database Design

Model data for integrity and predictable performance.

---

## Normalization

* **1NF** — atomic columns; no repeating groups.
* **2NF/3NF** — reduce redundancy; use junction tables for M:N.
* **Denormalize** selectively for read hot paths — document why and refresh strategy.

---

## Keys & Constraints

* **Primary keys** — surrogate UUIDs/ULIDs vs natural keys; be consistent.
* **Foreign keys** with `ON DELETE` policy explicit (RESTRICT, CASCADE).
* **Unique** constraints for business identifiers (email per tenant).

---

## Indexing

* Index **filter/join** columns and **FK** columns.
* Composite indexes **(tenant_id, created_at)** for common lists.
* Avoid over-indexing — slows writes; measure with `EXPLAIN`.

---

## Types

* Prefer **timestamp with time zone**; store UTC.
* **Money** — decimal type, not float.
* **Enums** — DB enum vs lookup table vs app-enforced strings (trade-offs for migrations).

---

## Multi-Tenancy

* `tenant_id` on every row + composite keys/indexes, or schema-per-tenant for isolation — choose per compliance and scale.

---

## Anti-Patterns

* Unbounded JSON blobs as primary source of truth without schema.
* Missing FKs “for speed” — loses referential integrity.

---

## Summary

Start **normalized**, add **constraints and indexes** early, **denormalize** only with measurement, and design **multi-tenant** access patterns explicitly.
