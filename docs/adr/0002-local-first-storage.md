# ADR 0002: Local-First Storage

## Status

Accepted

## Context

Core brewing workflows must work without network access. Users need to create recipes, log batches, review notes, and export their data even if no account exists.

## Decision

Use SQLite in the client as the primary operational datastore, with an optional backend for sync and community features.

## Consequences

Positive:

- excellent offline behavior
- user-owned data remains available and exportable
- app behavior is predictable without cloud dependency

Tradeoffs:

- sync conflicts must be designed explicitly
- migrations become a core product responsibility
- client data models need stronger backward-compatibility discipline

