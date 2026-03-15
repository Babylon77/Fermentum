# Fermentum AI Architecture

## Product boundary

AI advises. Deterministic code calculates.

## Responsibilities

- retrieval over curated brewing sources
- user-question answering
- troubleshooting guidance
- explanation of calculations and process implications

## Must not do

- silently edit recipes
- silently change water chemistry targets
- fabricate citations
- bypass deterministic validation

## Request flow

1. user asks a question
2. system gathers allowed local and server context
3. retrieval fetches relevant sources
4. model answers with citations and uncertainty markers
5. UI separates AI guidance from canonical calculated values

## Modes

- cloud AI
- local-only no-AI
- later optional local model mode

