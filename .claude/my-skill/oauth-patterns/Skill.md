---
name: oauth-patterns
description: OAuth2 flows including authorization code, client credentials, and PKCE. Use when integrating identity providers or securing browser and machine-to-machine access.
user-invocable: false
---

# OAuth 2.0 Patterns

Select the right grant for each client type.

---

## Flows

### Authorization Code + PKCE (public clients, SPAs, mobile)

* User redirected to IdP; callback with `code`; exchange `code` for tokens using **PKCE** (`code_verifier` / `code_challenge`).
* **Never** put client secrets in SPAs; use PKCE instead of implicit flow.

### Authorization Code (confidential server-side clients)

* Backend holds `client_secret`; redirect handled server-side; tokens stored server-side only.

### Client Credentials (M2M)

* Service account obtains access token for API-to-API calls; no end-user.

### Refresh Tokens

* Store **refresh tokens** securely (httpOnly cookie or server vault); rotate refresh tokens when IdP supports it.

---

## Security Checklist

* Validate `state` CSRF parameter on callback.
* Use exact **redirect URI** allowlists.
* Prefer **short-lived access tokens** + refresh over long-lived JWTs in browsers.
* Validate JWTs: **issuer**, **audience**, **expiry**, signature (JWKS).

---

## Scopes

* Request **minimal scopes**; document what each scope allows.

---

## Anti-Patterns

* Implicit flow for new apps (deprecated).
* Long-lived access tokens in `localStorage`.
* Sharing one global service token across all users for user-specific actions.

---

## Summary

Use **auth code + PKCE** for public clients, **client credentials** for M2M, validate **state** and **tokens**, and store secrets **only** where appropriate.
