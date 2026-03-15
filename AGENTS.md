# Fermentum Agent Guide

## Purpose

This repository exists to build Fermentum as a free and open-source, cross-platform fermentation application for beer, cider, wine, and compliance-aware distilling workflows.

All implementation work should protect four non-negotiables:

- mobile and desktop parity
- local-first behavior
- deterministic brewing calculations
- source-backed domain guidance

## Execution rules

- Read the relevant docs in `docs/` before making architectural or data-model changes.
- Prefer small, reviewable changes over broad rewrites.
- Do not bypass the documented domain model with ad hoc fields.
- Do not let AI-generated text change recipe math or calculated outputs without deterministic code paths.
- Keep all calculations testable and separate from UI concerns.
- Preserve offline use for core workflows: recipe design, batch logging, notes, and import/export.
- Every imported or seeded recipe must retain provenance metadata.
- Distilling features must respect legal and regional compliance constraints.

## Source of truth order

When there is a conflict, use this order:

1. deterministic calculation code and tests
2. domain-model and database-schema docs
3. architecture docs and ADRs
4. product-plan and backlog docs
5. UI implementation details

## Repository expectations

- `apps/client` should contain the user-facing application.
- `packages/brewing-core` should contain deterministic beverage calculations and import/export logic.
- `packages/shared-models` should contain serialized models shared across app and services.
- `docs/adr` should record important technical decisions.

## Quality bar

- New behavior requires tests unless the change is documentation-only.
- Domain formulas must cite a source in code comments or nearby docs.
- Imports and exports must round-trip cleanly where possible.
- UI should support touch and desktop pointer interactions.
- Accessibility and clear language matter as much as feature depth.

## AI feature constraints

- AI may explain, summarize, coach, compare, and retrieve.
- AI may not silently mutate recipes, water adjustments, or fermentation parameters.
- AI answers should cite sources when available and state when they are making an inference.
- Local-only operation must remain possible without AI services.

## Documentation updates

Update docs when changing:

- architecture boundaries
- schema or entity relationships
- calculation formulas
- import/export formats
- contributor workflows
- design tokens or UI component contracts

