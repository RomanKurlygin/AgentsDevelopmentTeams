---
name: repository-pattern
description: Database access abstraction, repository design, and separation from business logic. Use when hiding persistence details, swapping data stores, or keeping services free of query syntax.
user-invocable: false
---

# Repository Pattern

Apply when isolating data access from domain and application layers.

---

## Core Principles

1. **Repositories speak domain-ish language** — `findActiveUsersByTenant`, not `select *`.
2. **No business rules** — only persistence and mapping; “email must be unique” belongs in services.
3. **Hide the driver** — SQL, Prisma, Mongo APIs stay inside the repository module.
4. **Stable interfaces** — services depend on interfaces; tests use in-memory fakes.

---

## Interface Example

```ts
export interface UserRepository {
  findById(id: string): Promise<User | null>;
  findByEmail(email: string): Promise<User | null>;
  save(user: User): Promise<void>;
}
```

Implementation wraps your ORM or driver; **services depend on the interface**, not Prisma client types in public signatures.

---

## Mapping

* Map DB rows ↔ domain entities in one place (repository or dedicated mapper).
* Avoid leaking ORM models (`Prisma.User`) into service return types unless you explicitly choose “ORM at the boundary.”

---

## Queries

* Encapsulate complex queries as named methods rather than exposing generic `query(sql)`.
* Pagination, sorting, and filters: accept typed params, return `{ items, total }` or cursors.

---

## Transactions

* Repository methods can accept an optional **transaction / client** handle passed from the service orchestrating `db.$transaction`.

```ts
async function createWithAudit(data: User, tx?: Tx): Promise<void> {
  const client = tx ?? db;
  await client.user.create({ data });
}
```

---

## Anti-Patterns

* Repositories that throw HTTP errors or know about JWT.
* One mega-repository for the entire app.
* Duplicated query logic across services — lift into repository methods.

---

## When to Use

* Any non-trivial persistence.
* When you need to test services without a real database.

---

## Summary

Repositories **abstract data access**, expose **intent-revealing APIs**, and keep **business logic out**, so services stay portable and testable.
