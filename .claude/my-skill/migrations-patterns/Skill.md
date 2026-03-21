---
name: migrations-patterns
description: Database migrations, versioning, and safe rollback strategies. Use when evolving schema in CI/CD without downtime surprises.
user-invocable: false
---

# Migrations Patterns

Ship schema changes safely and reversibly.

---

## Principles

1. **Forward-only in prod** when possible — avoid destructive `DOWN` in hot path; use compensating migrations.
2. **Expand and contract** — add new column (nullable) → backfill → switch reads/writes → remove old.
3. **Small steps** — one logical change per migration for easier rollback reasoning.

---

## Zero-Downtime Patterns

* Add column **nullable** first; deploy app that writes both; backfill; make NOT NULL with default.
* Rename: add new column → copy → switch → drop old.
* Index creation: `CREATE INDEX CONCURRENTLY` (Postgres) to avoid long locks.

---

## Versioning

* Sequential or timestamped migration files; single **source of truth** (Flyway, Prisma, Liquibase).
* Run migrations in **CI** and **before** app start in deploy (or init container).

---

## Rollback

* Prefer **new migration** that undoes data change rather than relying on `down` in emergency.
* Backup / PITR for catastrophic mistakes.

---

## Anti-Patterns

* Manual hotfix SQL on prod not captured in migrations.
* Long transactions holding locks during peak.

---

## Summary

Use **expand/contract**, **concurrent indexes**, **small migrations**, and treat **rollback** as new forward migrations plus **backups**.
