---
name: error-handling
description: Centralized error handling, error classes, and consistent API error responses. Use when designing failure modes, status codes, and client-facing error shapes across a backend.
user-invocable: false
---

# Error Handling

Standardize how errors are thrown, mapped, and returned to clients.

---

## Core Principles

1. **Typed application errors** — distinguish *expected* failures (not found, conflict) from *bugs* (500).
2. **Single mapping layer** — HTTP status and body shape decided in one place (middleware / filter).
3. **Stable codes** — machine-readable `code` for clients; human `message` for debugging.
4. **Never leak internals** — stack traces and SQL in production responses.

---

## Application Error Type

```ts
export class AppError extends Error {
  constructor(
    public readonly statusCode: number,
    message: string,
    public readonly code: string,
    public readonly details?: unknown
  ) {
    super(message);
    this.name = "AppError";
  }
}
```

Throw in services: `throw new AppError(404, "User not found", "USER_NOT_FOUND")`.

---

## HTTP Mapping

| Situation | Status | Example code |
|-----------|--------|----------------|
| Validation (client) | 400 | `VALIDATION_ERROR` |
| Auth missing/invalid | 401 | `UNAUTHORIZED` |
| Forbidden | 403 | `FORBIDDEN` |
| Not found | 404 | `NOT_FOUND` |
| Conflict | 409 | `CONFLICT` |
| Rate limit | 429 | `RATE_LIMITED` |
| Unexpected | 500 | `INTERNAL_ERROR` |

---

## Response Shape

Use a consistent JSON envelope:

```json
{
  "error": {
    "code": "USER_NOT_FOUND",
    "message": "User not found",
    "requestId": "abc-123"
  }
}
```

Include **request/correlation ID** on every error for support.

---

## Middleware

* Catch `AppError` → map to status + body.
* Catch `ZodError` / validation → 400 with field errors.
* Catch unknown → log + 500 generic message.

---

## Anti-Patterns

* `throw new Error("...")` everywhere without classification.
* Different JSON shapes per endpoint.
* Returning database driver errors verbatim to clients.

---

## When to Use

* All HTTP APIs and message consumers that need predictable failure contracts.

---

## Summary

Use **typed errors** in domain/services, **centralize** HTTP mapping, expose **stable codes**, and **log** unexpected failures without exposing secrets.
