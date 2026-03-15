# Fermentum

Fermentum is an open-source fermentation platform for recipe design, brew-day execution, fermentation tracking, packaging, and learning across beer, cider, wine, and compliance-aware distilling workflows.

## Product direction

The current implementation direction is:

- Flutter client for iOS, Android, web, Windows, macOS, and Linux
- Rust calculation engine for deterministic brewing math and import/export
- SQLite for local-first app data
- optional self-hosted backend for sync and community features

See the planning docs in `docs/` for current decisions.

## Current docs

- `docs/product-plan.md`
- `docs/architecture.md`
- `docs/domain-model.md`
- `docs/database-schema.md`
- `docs/engineering-process.md`
- `docs/style-guide.md`
- `docs/design-tokens.json`
- `docs/deployment-architecture.md`
- `docs/sync-strategy.md`
- `docs/api-contract.md`
- `docs/import-export-spec.md`
- `docs/calculation-reference.md`
- `docs/security-privacy.md`
- `docs/ai-architecture.md`
- `docs/release-distribution.md`
- `docs/component-spec.md`

## Principles

- local-first
- cross-platform
- scientifically grounded
- open-source
- AI-assisted, not AI-driven

## Implementation status

Planning and repository setup.

## Planned workspace layout

- `apps/client`
- `packages/brewing-core`
- `packages/shared-models`
- `.github/workflows`
- `.github/ISSUE_TEMPLATE`

