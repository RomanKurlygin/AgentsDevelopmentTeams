---
name: config-management
description: Environment configuration, secrets, and twelve-factor style settings for applications. Use when separating config from code across environments.
user-invocable: false
---

# Config Management

Treat configuration as an externalized, typed contract.

---

## Twelve-Factor Style

* **Config in environment** — not hardcoded; different per deploy.
* **Strict separation** — code vs secrets vs feature flags.

---

## Layers

1. **Non-secret defaults** — safe fallbacks in code for dev only.
2. **Environment variables** — injected by K8s, Docker, PaaS.
3. **Secrets** — vault, sealed secrets, cloud secret managers; **never** in git.

---

## Schema

* Validate at startup (Zod, env-schema) — **fail fast** on missing `DATABASE_URL`.
* Document required vars in **README** or `.env.example` (no real secrets).

---

## Feature Flags

* Remote config service or env-based toggles for **gradual rollout**; avoid compile-time flags for ops changes.

---

## Anti-Patterns

* Copy-pasted `.env` files across prod machines unencrypted.
* Silent default to production credentials in dev.

---

## Summary

**Validate env at boot**, store **secrets** in managers, provide **.env.example**, and use **feature flags** for controlled behavior changes.
