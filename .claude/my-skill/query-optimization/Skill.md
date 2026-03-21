---
name: query-optimization
description: Optimizing SQL queries, indexing strategies, and performance tuning for relational databases. Use when fixing slow endpoints and N+1 problems.
user-invocable: false
---

# Query Optimization

Measure first; then index, batch, or rewrite.

---

## Workflow

1. **Identify** slow queries (APM, `pg_stat_statements`, slow log).
2. **EXPLAIN (ANALYZE)** — understand seq scan vs index, row estimates.
3. **Fix** — index, rewrite, or cache.

---

## Common Issues

* **N+1** — use joins, `IN` queries, or DataLoader pattern in GraphQL.
* **Missing index** on filtered/sorted columns.
* **Select *** — fetch only needed columns.
* **Functions on indexed column** — `WHERE lower(email)` prevents index use unless expression index.

---

## Indexing

* **Composite** order matters — equality columns first, then range.
* **Partial indexes** for rare status values (`WHERE deleted_at IS NULL`).
* **Covering indexes** (INCLUDE) for read-heavy lists.

---

## Pagination

* **Keyset** (`WHERE id > ? ORDER BY id LIMIT`) over large **OFFSET** pages.

---

## Anti-Patterns

* Caching without fixing pathological queries.
* Adding indexes blindly without `EXPLAIN`.

---

## Summary

Use **EXPLAIN**, eliminate **N+1**, choose **indexes** deliberately, and prefer **keyset pagination** at scale.
