# Fermentum Deployment Architecture

## Goal

Deploy Fermentum so the core application remains local-first while optional hosted services add sync, community, AI, and asset delivery.

## Recommended platform split

- Render for application services, Postgres, workers, and cron jobs
- object storage for attachments and recipe assets
- CDN in front of static web assets if needed

## Environment topology

### Local

- Flutter app running locally
- SQLite database on device
- optional local mock API

### Preview

- web preview build
- preview API service
- preview Postgres database

### Production

- web client
- API service
- worker service
- Postgres
- object storage
- observability stack

## Service map

### Web client

- serves Flutter web build
- calls API for optional synced features

### API service

- auth
- sync
- recipe library
- AI orchestration
- file metadata

### Worker service

- indexing
- imports
- AI document processing
- notifications

### Database

- user accounts
- sync state
- shared recipes
- audit and job metadata

## Secrets and config

- use per-environment secrets
- never ship secrets in the client
- API keys stay server-side
- feature flags should be environment-aware

## Domains

- `app.<domain>` for web client
- `api.<domain>` for API
- `assets.<domain>` for static assets if needed

## Non-negotiables

- local-only use must work without hosted services
- backend outages must not block local brewing workflows
- sync conflicts must fail visibly, not silently

