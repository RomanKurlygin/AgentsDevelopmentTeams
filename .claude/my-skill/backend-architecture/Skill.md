---
name: backend-architecture
description: Design backend architecture including layering (controller/service/repository), modularization, and dependency boundaries. Use this skill when structuring backend systems, organizing codebases, or defining system layers. Ensures clean architecture, maintainability, and scalability.
user-invocable: false
---

# Backend Architecture Patterns

Apply these patterns when designing or refactoring backend systems.

---

## Core Principles

1. **Separation of Concerns**
   Each layer has a single responsibility.

2. **Dependency Direction**
   Dependencies must flow inward:

   Controller → Service → Repository → Database

3. **Business Logic Isolation**
   Business rules must live in the service layer, not controllers.

4. **Framework Independence**
   Core logic should not depend on frameworks (Express, NestJS, etc.).

---

## Standard Layered Architecture

### 1. Controller Layer

**Responsibility:**

* Handle HTTP requests
* Validate input
* Call services
* Return responses

**Example:**

```ts
router.post("/users", async (req, res) => {
  const input = validateCreateUser(req.body);
  const user = await userService.createUser(input);

  res.status(201).json({ data: user });
});
```

**Rules:**

* No business logic
* No direct DB access
* Keep thin (max ~10–20 lines per handler)

---

### 2. Service Layer

**Responsibility:**

* Business logic
* Orchestration
* Validation beyond basic schema

**Example:**

```ts
async function createUser(input: CreateUserInput) {
  const existing = await userRepository.findByEmail(input.email);

  if (existing) {
    throw new AppError(409, "Email already exists", "EMAIL_EXISTS");
  }

  const hashedPassword = await hashPassword(input.password);

  return userRepository.create({
    ...input,
    password: hashedPassword,
  });
}
```

**Rules:**

* Contains core logic
* Can call multiple repositories
* Must be testable in isolation

---

### 3. Repository Layer

**Responsibility:**

* Data access
* Database queries
* Mapping DB ↔ domain

**Example:**

```ts
async function findByEmail(email: string) {
  return db.user.findUnique({ where: { email } });
}

async function create(data: CreateUserData) {
  return db.user.create({ data });
}
```

**Rules:**

* No business logic
* No HTTP concerns
* Only DB operations

---

## Folder Structure

Use feature-based structure:

```
src/
  modules/
    user/
      user.controller.ts
      user.service.ts
      user.repository.ts
      user.types.ts
```

Avoid layer-based global folders:

```
❌ controllers/
❌ services/
❌ repositories/
```

---

## Dependency Rules

**Allowed:**

Controller → Service
Service → Repository
Repository → Database

**Forbidden:**

❌ Controller → Repository
❌ Service → Controller
❌ Repository → Service

---

## Data Flow

Request
↓
Controller
↓
Service
↓
Repository
↓
Database
↓
Response

---

## Validation Strategy

**Controller Level:**

* Schema validation (Zod, Joi, etc.)
* Required fields
* Types

**Service Level:**

* Business rules
* Cross-field validation
* Domain constraints

---

## Error Handling

Use centralized error classes:

```ts
class AppError extends Error {
  constructor(
    public statusCode: number,
    public message: string,
    public code: string
  ) {
    super(message);
  }
}
```

Throw errors in services:

```ts
throw new AppError(404, "User not found", "USER_NOT_FOUND");
```

---

## Transaction Handling

Handle transactions in service layer:

```ts
await db.$transaction(async (tx) => {
  await userRepository.create(data, tx);
  await auditRepository.logAction(action, tx);
});
```

---

## Modularity

Each module must be:

* isolated
* self-contained
* independently testable

---

## Testing Strategy

**Unit Tests**

* test services in isolation

**Integration Tests**

* test repositories with DB

**E2E Tests**

* test full flow via API

---

## Scalability Considerations

* keep services stateless
* avoid shared memory
* design for horizontal scaling
* isolate side effects

---

## Anti-Patterns to Avoid

* Fat controllers (business logic inside controllers)
* God services (too large, too many responsibilities)
* Direct DB access from controllers
* Shared mutable global state
* Tight coupling between modules

---

## When to Use This Architecture

Use when:

* building scalable backend systems
* working in teams
* long-term maintainability matters

Avoid for:

* small scripts
* quick prototypes

---

## Summary

A well-structured backend:

* separates concerns
* isolates business logic
* enforces clear dependencies
* scales with complexity

This architecture ensures:

* maintainability
* testability
* clarity
* scalability
