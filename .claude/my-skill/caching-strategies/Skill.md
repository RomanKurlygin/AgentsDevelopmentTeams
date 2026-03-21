---
name: caching-strategies
description: Caching patterns including Redis, in-memory layers, CDN usage, and cache invalidation. Use when reducing load and latency for read-heavy or expensive computations.
user-invocable: false
---

# Caching Strategies

Speed up reads without serving stale wrong data.

---

## Layers

1. **CDN** — static assets, cacheable GET responses at edge (with correct cache headers).
2. **HTTP cache** — `Cache-Control`, `ETag`, `Last-Modified` for public GETs.
3. **Application cache** — in-process (LRU) for hot keys; **Redis/Memcached** for shared.
4. **Database** — query cache deprecated in many DBs; prefer app-level.

---

## Patterns

* **Cache-aside** — app reads cache, on miss loads DB and sets cache.
* **Write-through** — write DB and cache together (stronger consistency, more write cost).
* **TTL** — simplest invalidation; choose per data freshness needs.

---

## Invalidation

* Hardest problem: prefer **explicit invalidation** on writes, **versioned keys** (`user:123:v2`), or **short TTL** + tolerate staleness.
* Avoid thundering herd — **singleflight** or jittered TTL.

---

## Redis Notes

* Serialize with stable format (JSON/MessagePack).
* Use **key namespaces** per domain (`session:`, `catalog:`).

---

## Anti-Patterns

* Caching **personalized** responses without varying by user key.
* No TTL on eventually corrected data — stale forever.

---

## Summary

Pick **layer** (CDN vs Redis vs local), use **cache-aside** + **TTL** or **explicit invalidation**, and design keys for **correct scoping** and **eviction**.
