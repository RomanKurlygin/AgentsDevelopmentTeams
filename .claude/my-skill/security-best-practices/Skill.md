---
name: security-best-practices
description: General backend security aligned with OWASP: headers, validation, dependency hygiene, and secure defaults. Use when reviewing or designing server-side systems.
user-invocable: false
---

# Security Best Practices

Apply defense in depth across the stack.

---

## OWASP-Oriented Baseline

1. **Injection** — parameterized queries; never concatenate SQL; sanitize where ORM cannot help.
2. **Broken auth** — strong password policies if you store passwords (argon2/bcrypt); MFA for admin; session fixation awareness.
3. **Sensitive data** — encrypt at rest (DB, backups); TLS in transit; minimize retention.
4. **XXE / deserialization** — safe XML/JSON parsers; disable dangerous features.
5. **Access control** — enforce on **server** for every request; no “hidden” admin params.
6. **Security misconfiguration** — default deny, remove debug in prod, patch OS and deps.
7. **XSS** — for APIs returning HTML, escape; mostly JSON APIs still need safe admin UIs.
8. **Insecure deserialization** — avoid pickle-like patterns; signed tokens only from trusted libs.
9. **Using components with known vulnerabilities** — Dependabot, lockfiles, regular updates.
10. **Insufficient logging** — audit auth failures and admin actions without leaking secrets.

---

## HTTP Headers (when serving HTML or mixed)

* `Content-Security-Policy`
* `X-Content-Type-Options: nosniff`
* `Referrer-Policy`
* `Permissions-Policy`

---

## Dependencies

* Pin versions; audit (`npm audit`, `osv-scanner`).
* Prefer maintained libraries for crypto and JWT.

---

## Secrets & Config

* Secrets from vault or sealed env; never in git.
* Separate dev/staging/prod credentials.

---

## Anti-Patterns

* “Security by obscurity” only.
* Admin endpoints without rate limits or IP allowlists where appropriate.

---

## Summary

Combine **secure defaults**, **input safety**, **authz on every path**, **dependency hygiene**, and **auditable logging** aligned with **OWASP** top risks.
