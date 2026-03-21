---
name: third-party-integration
description: Best practices for integrating external APIs with retries, timeouts, circuit breakers, and fallbacks. Use when wrapping SaaS providers, payment gateways, or internal HTTP services.
user-invocable: false
---

# Third-Party Integration

Isolate vendor calls behind clear ports and resilient clients.

---

## Core Principles

1. **Thin adapters** — one module per provider; map their errors to your `AppError` types.
2. **Timeouts** — connect + read timeouts on every outbound call; no infinite waits.
3. **Retries** — only for **idempotent** reads or operations with idempotency keys; exponential backoff + cap.
4. **Circuit breaker** — stop calling failing dependencies for a cooldown; fail fast or degrade.

---

## Client Wrapper

```ts
const res = await withTimeout(
  fetch(url, { signal: AbortSignal.timeout(5000) }),
  5000
);
```

Use a dedicated HTTP client with **metrics** (latency, error rate by provider).

---

## Idempotency

* For payments and creates, send **Idempotency-Key** header when provider supports it.
* Store your own idempotency records for critical side effects.

---

## Configuration

* Base URLs, API keys from **environment** or secret store.
* Feature flags to disable integrations without deploy.

---

## Testing

* Contract tests against provider **sandbox**.
* Record/replay or mocks for CI; never hit prod APIs in unit tests.

---

## Anti-Patterns

* Scattering raw `fetch` calls across services.
* Catching all errors and returning 500 without mapping.
* No timeout — ties up threads and cascades failures.

---

## Summary

Wrap externals in **adapters**, enforce **timeouts/retries/breakers**, and **map failures** into your domain so the core app stays stable when vendors misbehave.
