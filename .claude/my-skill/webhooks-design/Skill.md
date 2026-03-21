---
name: webhooks-design
description: Designing webhook systems with delivery guarantees, retries, idempotency, and signature validation. Use when building outbound event notifications to partners or internal subscribers.
user-invocable: false
---

# Webhooks Design

Build reliable outbound HTTP callbacks.

---

## Core Principles

1. **Sign payloads** — HMAC (e.g. SHA-256) with a shared secret; include timestamp to limit replay window.
2. **Idempotent processing** — subscribers use event IDs; you store delivery attempts with unique keys.
3. **Retries with backoff** — exponential backoff, jitter, max attempts; dead-letter after limit.
4. **Explicit versioning** — header or payload field `api_version` / `event_schema_version`.

---

## Delivery Flow

1. Persist event in an **outbox** (same DB transaction as state change when possible).
2. Worker picks outbox rows, POSTs to subscriber URL.
3. On **2xx**, mark delivered; on **non-retryable 4xx** (except 429), pause or disable endpoint after policy.
4. On **timeouts/5xx/429**, retry with backoff.

---

## Signature Example

```
X-Webhook-Timestamp: 1710000000
X-Webhook-Signature: sha256=<hmac(secret, timestamp + "." + rawBody)>
```

Subscriber verifies timestamp within skew (e.g. 5 minutes) and recomputes HMAC.

---

## Payload Shape

```json
{
  "id": "evt_123",
  "type": "invoice.paid",
  "created": "2025-03-21T10:00:00Z",
  "data": { "invoiceId": "inv_1" }
}
```

---

## Subscriber Guidance

Document: timeouts you use, retry schedule, how to verify signatures, sample secrets rotation.

---

## Anti-Patterns

* Fire-and-forget HTTP with no persistence.
* Infinite retries on 400 Bad Request.
* Same secret forever without rotation story.

---

## Summary

Use **outbox + workers**, **signed** payloads, **idempotent** events, and **disciplined retries** so webhooks are **trustworthy** and **recoverable**.
