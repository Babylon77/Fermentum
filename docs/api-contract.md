# Fermentum API Contract

## Scope

The API exists only for optional connected capabilities.

Core brewing features must not depend on it.

## Initial service areas

- authentication
- profile sync
- recipe library
- AI help requests
- file and import jobs

## API design rules

- versioned endpoints
- explicit schemas
- idempotent mutation semantics where practical
- opaque server IDs allowed, but client entities retain stable local IDs

## Initial endpoint groups

- `POST /v1/auth/session`
- `GET /v1/me`
- `GET /v1/recipes`
- `POST /v1/recipes`
- `POST /v1/sync/push`
- `POST /v1/sync/pull`
- `POST /v1/imports`
- `POST /v1/ai/ask`

## Response rules

- return structured data for calculations and sync
- avoid mixed prose and machine state in one field
- include conflict and validation codes explicitly

