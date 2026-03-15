# Development Workflow

## Working model

The repository uses a docs-first setup phase followed by incremental implementation.

Preferred order for major changes:

1. capture or update the requirement
2. update architecture or schema docs if needed
3. write or update an ADR for durable technical decisions
4. implement
5. add or update tests
6. verify desktop and mobile impact

## Command contract

As tooling is added, the repository should support these standard commands:

- app run
- app test
- core test
- full CI validation

The exact command wrappers can be added after the Flutter and Rust workspaces are scaffolded, but every tool choice should preserve a one-command path for:

- local app startup
- full test run
- lint and formatting
- CI parity

## Review rules

- keep PRs focused
- no hidden architectural changes
- no undocumented schema changes
- no untested calculation logic
- no UI additions that ignore the style guide

## UI and UX rule

All new UI should follow the cyberpunk mission-command system in `docs/style-guide.md` and `docs/design-tokens.json`.
