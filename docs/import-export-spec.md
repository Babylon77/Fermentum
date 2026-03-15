# Fermentum Import Export Specification

## Supported formats

- BeerXML import and export
- Fermentum JSON full-fidelity export

## Fermentum JSON goals

- preserve all recipe, batch, note, and profile data
- store schema version
- preserve provenance
- support offline transfer between devices

## BeerXML policy

- import as faithfully as possible
- store conversion warnings when unsupported fields exist
- export a compatible subset when Fermentum-specific data has no BeerXML equivalent

## Required metadata

- source type
- source URL when known
- import timestamp
- converter version
- warnings

