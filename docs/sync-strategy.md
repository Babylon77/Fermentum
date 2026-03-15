# Fermentum Sync Strategy

## Principle

Fermentum is local-first, not cloud-first.

## Sync targets

- recipes
- recipe versions
- ingredient libraries
- batches
- tasting notes
- user settings

## Conflict model

- recipes use version-aware merge or explicit duplication
- batches prefer append-only logs
- destructive auto-merge is not allowed for brew-critical values

## Approach

1. local write succeeds first
2. sync job packages changed entities
3. server acknowledges accepted versions
4. conflicts return structured resolution payloads

## Conflict handling

- show users conflicting fields
- allow keep local, keep remote, or fork
- preserve both sides when lossless merge is impossible

## Offline behavior

- all core brewing workflows work offline
- sync retries in the background when connectivity returns

