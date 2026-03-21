---
name: api-versioning
description: API versioning strategies including URL paths, headers, and semantic versioning of contracts. Use when evolving public APIs without breaking clients.
user-invocable: false
---

# API Versioning

Choose explicit strategies so clients can migrate safely.

---

## Strategies

### 1. URL path (common)

`GET /v1/users`, `GET /v2/users`

* **Pros:** Visible, easy to cache and route.
* **Cons:** Duplicated routes if many versions live long.

### 2. Header

`Accept: application/vnd.myapi+json; version=2`

* **Pros:** Clean URLs.
* **Cons:** Harder to test in browser; CDN/cache rules more complex.

### 3. Query (less ideal)

`?version=2` — use sparingly; pollutes caching keys.

---

## Semantic Versioning (API contract)

* **Major** — breaking changes (remove field, change type, behavior).
* **Minor** — additive (new optional fields, new endpoints).
* **Patch** — docs-only or bug fixes that restore intended behavior.

Document deprecations with **sunset headers** or changelog dates.

---

## Deprecation

* Announce in docs + `Deprecation` / `Sunset` HTTP headers.
* Keep old versions for a **defined period**; monitor traffic before removal.

---

## Guidelines

* Version **resource contracts**, not individual query params ad hoc.
* Prefer **additive** changes first; avoid breaking unless necessary.
* Internal APIs can use looser rules; **public** APIs need strict compatibility policy.

---

## Anti-Patterns

* Silent behavior changes on the same path/version.
* Unlimited supported versions without retirement plan.

---

## Summary

Pick **URL or header** versioning consistently, align with **semver** for contract changes, and **deprecate** with time windows and observability.
