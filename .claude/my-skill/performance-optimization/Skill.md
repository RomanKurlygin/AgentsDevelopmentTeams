---
name: performance-optimization
description: General performance tuning across CPU, I/O, memory, and concurrency for backend systems. Use when profiling and removing bottlenecks holistically.
user-invocable: false
---

# Performance Optimization

Optimize where measurement points.

---

## Process

1. **Define SLOs** — p95 latency, throughput, error budget.
2. **Profile** — CPU flame graphs, async waterfalls, DB slow queries.
3. **Fix biggest lever** — often DB or N+1, then serialization, then CPU.

---

## Backend Levers

* **Database** — indexes, query shape, connection pool sizing.
* **Concurrency** — async I/O, worker pools; avoid blocking event loop in Node.
* **Payload size** — pagination, field selection, compression (gzip/br).
* **Serialization** — faster JSON libs; avoid huge object graphs.

---

## Resource Limits

* Timeouts on all outbound calls.
* **Backpressure** — queue depth limits; reject with 503 when overloaded.

---

## Caching

* See `caching-strategies` skill — first line for read-heavy paths.

---

## Anti-Patterns

* Premature micro-optimizations without profiling.
* Increasing **instance size** only while ignoring O(n²) algorithms.

---

## Summary

**Measure** (SLO + profilers), fix **I/O and DB** first, then **payloads and concurrency**, and use **caching** where reads dominate.
