# Contributing

## Working agreement

- Read `AGENTS.md` and the relevant docs before coding.
- Keep pull requests focused and easy to review.
- Document architectural changes before or with the implementation.
- Add tests for domain logic and serialization changes.

## Branching

- `main` should stay releasable.
- Use short-lived feature branches.
- Prefer squash merges unless the team later decides otherwise.

## Pull request checklist

- behavior is described clearly
- tests were added or updated where needed
- docs were updated if the change affects architecture, schema, formulas, or workflows
- no unrelated refactors were bundled in

## Commit guidance

Prefer clear, imperative commit messages such as:

- `Add brew batch entity definitions`
- `Implement OG and ABV calculation tests`
- `Document local-first sync constraints`

