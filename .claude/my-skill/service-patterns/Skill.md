---
name: service-patterns
description: Design service layer patterns, business logic isolation, and use-case driven services. Use when structuring domain logic, orchestration, and keeping controllers thin. Promotes testable, cohesive services.
user-invocable: false
---

# Service Layer Patterns

Use these patterns when implementing or refactoring application services.

---

## Core Principles

1. **One use case per public method** — `createOrder`, `cancelSubscription`, not `doStuff`.
2. **Services own business rules** — controllers and repositories stay dumb.
3. **Explicit inputs/outputs** — typed DTOs in and domain models or DTOs out.
4. **Dependencies face inward** — services depend on repositories and domain helpers, not HTTP or ORM details leaked upward.

---

## Use-Case Services

Model services around user- or system-intent, not around database tables.

**Prefer:**

```ts
// order.service.ts
async function placeOrder(cmd: PlaceOrderCommand): Promise<OrderResult> {
  await ensureInventory(cmd.items);
  const order = await orderRepository.createDraft(cmd);
  await paymentGateway.authorize(order.total);
  return orderRepository.confirm(order.id);
}
```

**Avoid:**

* God objects that mix unrelated flows.
* Services named only after entities with dozens of unrelated methods.

---

## Orchestration vs Domain Logic

* **Orchestration:** sequence steps, call multiple ports (repos, gateways), handle transactions at this layer.
* **Domain logic:** pure rules (pricing, eligibility) — extract to pure functions or domain modules when they grow.

---

## Boundaries

| Do in service | Do not do in service |
|----------------|----------------------|
| Business validation | HTTP status mapping (map in controller or error middleware) |
| Transactions spanning repos | Raw SQL unless behind repository |
| Calling other services | Direct `res.json()` |

---

## Testing

* Mock repositories and external clients; assert behavior and thrown domain errors.
* Prefer testing public methods that match real use cases.

---

## Anti-Patterns

* Anemic services that only delegate one line to repository.
* Services that import framework request/response types.
* Copy-pasted validation between services — share domain validators.

---

## When to Use

* Medium and large backends with clear business workflows.
* When multiple entry points (HTTP, queue, CLI) share the same rules.

---

## Summary

Structure services by **use case**, keep **business rules** here, **orchestrate** dependencies, and keep the surface **testable** and **cohesive**.
