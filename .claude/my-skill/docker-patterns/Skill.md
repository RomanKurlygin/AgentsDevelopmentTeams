---
name: docker-patterns
description: Docker best practices for images, multi-stage builds, and container runtime hygiene. Use when containerizing backends for local dev and production.
user-invocable: false
---

# Docker Patterns

Build small, secure, reproducible images.

---

## Dockerfile Practices

* **Multi-stage builds** — compile in builder stage; copy only artifacts to runtime image.
* **Non-root user** in final image (`USER node`, numeric UID).
* **Pin base images** by digest or minor version; rebuild for patches.

---

## Layers

* Order **least-changing** layers first (deps) then **app code** to maximize cache.
* Use **.dockerignore** — exclude `node_modules`, `.git`, tests if not needed in image.

---

## Runtime

* **One process per container** (main app); sidecars when orchestrator requires.
* **Health checks** — `HEALTHCHECK` or K8s probes hitting `/health`.
* **Signals** — PID 1 handles SIGTERM for graceful shutdown (use `dumb-init` or proper Node signal handling).

---

## Secrets

* **Runtime injection** — env from orchestrator, not `ENV` in Dockerfile for secrets.
* Never `COPY` `.env` with prod secrets into image.

---

## Anti-Patterns

* Giant images with full OS and dev tools in production.
* Storing data only in container filesystem — use volumes or external stores.

---

## Summary

Use **multi-stage**, **minimal base**, **non-root**, **.dockerignore**, **health checks**, and **inject secrets** at runtime.
