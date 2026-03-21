---
name: logging-patterns
description: Structured logging, log levels, correlation IDs, and observability practices. Use when instrumenting backends for debugging, audits, and production troubleshooting.
user-invocable: false
---

# Logging Patterns

Instrument services with structured, searchable logs.

---

## Core Principles

1. **Structured fields** — JSON logs with `level`, `msg`, `time`, and domain keys (not only strings).
2. **Levels** — `error` (action needed), `warn` (degraded), `info` (lifecycle), `debug` (dev only).
3. **Correlation** — propagate `requestId` / `traceId` across services and async jobs.
4. **No secrets** — never log passwords, tokens, full PAN, or raw health payloads with PHI.

---

## What to Log

| Event | Level | Fields |
|-------|--------|--------|
| Request start/end | info | method, path, status, durationMs, requestId |
| Business outcome | info | action, entityId, result |
| External call failure | warn/error | provider, operation, status, retry |
| Security event | warn | userId, action, reason |

---

## Example (JSON)

```json
{
  "level": "info",
  "time": "2025-03-21T10:00:00.000Z",
  "msg": "order_placed",
  "requestId": "req-1",
  "orderId": "ord-99",
  "durationMs": 42
}
```

---

## Correlation IDs

* Generate at edge (API gateway / first middleware); attach to **AsyncLocalStorage** / request context.
* Pass to downstream HTTP calls as `X-Request-Id` or W3C `traceparent` when using OpenTelemetry.

---

## Anti-Patterns

* `console.log` only in production services.
* Logging entire request bodies on every call.
* Different log formats per module — pick one logger (pino, winston, zap, etc.).

---

## When to Use

* Any production backend and long-running workers.

---

## Summary

Prefer **structured JSON**, correct **levels**, **request/trace correlation**, and **PII-safe** messages so logs work with your **metrics and tracing** stack.
