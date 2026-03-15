# ADR 0001: Client Stack

## Status

Accepted

## Context

Fermentum must ship on iOS, Android, web, Windows, macOS, and Linux with as much shared UI and workflow logic as possible.

The product also needs:

- strong offline behavior
- responsive layouts
- app-store quality UX
- good integration with a deterministic domain engine

## Decision

Use Flutter as the primary client framework.

## Consequences

Positive:

- one client codebase across mobile, desktop, and web
- strong control over custom UI and motion
- suitable for a distinctive mission-command visual system

Tradeoffs:

- web SEO is weaker than a web-first framework
- the team must be disciplined about desktop-grade interaction design
- platform plugins must be evaluated carefully


