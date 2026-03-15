# Fermentum Architecture

## Goals

- one product experience across desktop and mobile
- deterministic domain logic
- offline-first operation
- extensible beverage workflows
- optional hosted services without making the app cloud-dependent

## Recommended stack

### Client

- Flutter application
- feature-oriented module structure
- responsive layouts tuned for phone, tablet, and desktop

### Domain engine

- Rust in `packages/brewing-core`
- pure calculation and transformation logic
- compiled for native targets and web where practical

### Local data

- SQLite on device
- migration-based schema management
- explicit export format for full-fidelity backups

### Optional backend

- Postgres
- thin API
- object storage for attachments and assets
- sync and community features only

## High-level module boundaries

### `apps/client`

Responsibilities:

- UI
- local orchestration
- offline persistence
- user workflows
- AI interaction shell

Must not own:

- core formula logic
- canonical serialization rules

### `packages/brewing-core`

Responsibilities:

- beer, cider, wine, and distilling calculations
- import/export adapters
- style-guideline helpers
- validation rules

Must not own:

- UI state
- network code

### `packages/shared-models`

Responsibilities:

- domain entity definitions
- API and export DTOs
- schema version metadata

## Architectural rules

- Calculation code is deterministic and test-first.
- Domain entities are versioned.
- Import/export must be explicit, reversible where possible, and provenance-aware.
- Core workflows must work without network access.
- AI features must consume documented interfaces, never private UI state.

## Data flow

1. User edits a recipe or batch in the client.
2. Client persists local state to SQLite.
3. Client requests calculations from `brewing-core`.
4. Results return as structured data, not formatted prose.
5. AI features consume user-approved context and return advisory output only.
6. Optional sync serializes entities through shared models.

## Sync philosophy

- local-first wins on conflict visibility
- avoid hidden merges for recipes and batches
- treat recipe versions and batch logs as append-friendly records
- allow manual resolution for conflicting edits to critical brewing data

## Security and privacy

- do not require accounts for local use
- keep user batch data exportable
- make cloud AI optional
- support self-hosted backend deployment

## Near-term implementation sequence

1. shared models
2. calculation engine
3. local persistence
4. recipe builder
5. brew-day workflow
6. import/export
7. AI retrieval layer


