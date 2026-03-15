# Brewing Core

This directory will contain the Rust domain engine.

It should own:

- deterministic brewing calculations
- validators
- import and export transforms
- style-guideline helpers

It should not own:

- UI logic
- network orchestration
- persistence adapters tied to a single client framework

