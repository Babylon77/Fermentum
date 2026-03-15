# Engineering Process

## Delivery model

Use short iterations with explicit scope and review gates.

Recommended cadence:

- weekly planning
- small pull requests
- release checkpoints at the end of each milestone

## Planning artifacts

The repository should maintain:

- product direction in `docs/product-plan.md`
- technical shape in `docs/architecture.md`
- data definitions in `docs/domain-model.md` and `docs/database-schema.md`
- major decisions in `docs/adr/`

## Definition of ready

Before implementation begins on a feature:

- the problem is stated clearly
- impacted entities are known
- acceptance criteria are written
- dependencies are called out
- testing approach is identified

## Definition of done

- code is implemented
- tests pass locally and in CI
- docs are updated where applicable
- import/export implications were considered
- mobile and desktop UX impact was checked

## Testing strategy

### Unit tests

Required for:

- calculations
- parsers
- serializers
- validation rules

### Integration tests

Required for:

- local persistence
- import/export round-trips
- migration safety

### UI tests

Required for:

- core recipe flow
- brew-day flow
- offline resume flow

## Documentation policy

Update documentation in the same change when modifying:

- architecture boundaries
- schema
- formulas
- workflow assumptions
- contributor commands

## ADR policy

Write an ADR when changing:

- primary stack choices
- persistence strategy
- sync model
- AI architecture
- licensing strategy
- major import/export formats

## Release policy

- MVP releases should be tagged and changeloged
- app-store builds should come from tagged revisions
- export format versions must be documented

