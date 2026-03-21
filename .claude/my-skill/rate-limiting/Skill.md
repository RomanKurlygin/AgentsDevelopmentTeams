---
name: rate-limiting
description: Implementing rate limiting, throttling, and abuse prevention for APIs and background operations. Use when protecting infrastructure and fair usage across tenants.
user-invocable: false
---

# Rate Limiting

Protect services from abuse and noisy neighbors.

---

## Dimensions

* **Per IP** — basic bot protection.
* **Per user / API key** — fair usage by account.
* **Per tenant** — B2B isolation.
* **Per route** — stricter limits on expensive endpoints (search, exports, login).

---

## Algorithms

* **Fixed window** — simple; boundary bursts possible.
* **Sliding window / token bucket** — smoother (Redis, in-memory libraries).
* **Leaky bucket** — steady output rate.

---

## HTTP Semantics

* Return **429 Too Many Requests** with `Retry-After` (seconds or HTTP-date).
* Optional headers: `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`.

---

## Storage

* **Redis** for distributed APIs; **local memory** only for single-instance or best-effort.
* Consider **edge rate limits** (CDN/API gateway) first to absorb junk traffic.

---

## Login & Sensitive Routes

* Stricter limits on `/login`, password reset, OTP send — mitigate credential stuffing.
* CAPTCHA or step-up after repeated failures (product decision).

---

## Anti-Patterns

* Same global limit for all routes — starves heavy users on cheap routes.
* Silent drops without 429 — confuses clients.

---

## Summary

Apply **multi-dimensional** limits, use **429 + Retry-After**, store counters in **Redis** when scaled, and **tighten** auth-adjacent routes.
