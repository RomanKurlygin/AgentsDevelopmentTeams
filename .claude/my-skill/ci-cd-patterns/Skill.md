---
name: ci-cd-patterns
description: CI/CD pipelines, deployment strategies, and automation for testing and releasing software. Use when building reliable delivery from commit to production.
user-invocable: false
---

# CI/CD Patterns

Automate quality gates and controlled releases.

---

## Continuous Integration

* On every PR: **lint**, **unit tests**, **build**, **security scan** (deps, SAST optional).
* **Main branch** stays green; merge queue or required checks.

---

## Continuous Delivery / Deployment

* **Artifact** — immutable container image or package per build.
* **Environments** — dev, staging, prod with **parity** where affordable.

---

## Deployment Strategies

* **Rolling** — replace instances gradually.
* **Blue/green** — switch traffic atomically; fast rollback.
* **Canary** — small % traffic to new version; promote on metrics.

---

## Database

* Run **migrations** as explicit step before or during deploy; backward-compatible first.

---

## Secrets

* Injected at runtime from vault; not baked into images.

---

## Anti-Patterns

* Manual deploys only — drift and fear.
* Skipping tests in “hotfix” without follow-up.

---

## Summary

**Automate** build/test/security, ship **immutable artifacts**, use **blue/green or canary**, and treat **migrations** as first-class release steps.
