---
name: api-security
description: API security patterns including rate limiting, input validation, authentication integration, and abuse protection. Use when hardening HTTP and RPC surfaces.
user-invocable: false
---

# API Security

Layer defenses on every public endpoint.

---

## Core Practices

1. **TLS everywhere** — HTTPS in production; HSTS at edge.
2. **Validate all input** — schema (JSON body, query, headers); reject unknown fields when feasible.
3. **Authenticate by default** — opt-out only for truly public resources.
4. **Authorize per resource** — check ownership/roles after auth.
5. **Rate limit** — per IP, per user, per API key; stricter on auth and expensive routes.

---

## Input Validation

* Use strict schemas (Zod, Joi, OpenAPI-generated validators).
* Limit sizes (body max bytes, array lengths, string lengths).
* Normalize encodings; beware file uploads (type, size, scan).

---

## Headers & CORS

* Set security headers (`Content-Security-Policy` for APIs that return HTML; `X-Content-Type-Options`, etc.).
* **CORS:** allow only known origins; avoid `*` with credentials.

---

## Abuse & Bots

* CAPTCHA or proof-of-work only where UX allows.
* IP reputation, WAF at edge (Cloudflare, AWS WAF).
* Idempotency keys for mutating operations to prevent duplicate financial effects.

---

## Secrets

* No keys in repos; use vault or env injection.
* Rotate API keys and JWT signing keys on policy.

---

## Anti-Patterns

* Trusting client-side validation only.
* Logging tokens or passwords.
* Global admin bypass in application code without audit.

---

## Summary

Combine **TLS, validation, authz, rate limits, and edge protection**; treat APIs as **always hostile** inputs.
