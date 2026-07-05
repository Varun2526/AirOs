# 0001. Record Architecture Decisions

**Date**: 2026-07-05

**Status**: Accepted

## Context

As AirOS evolves, we will make many technical decisions. Without a record of these decisions and their rationale, future contributors (including future-us) will not understand *why* things are the way they are. This leads to:

- Revisiting already-settled debates
- Accidentally reversing good decisions
- Difficulty onboarding new contributors

## Decision

We will use Architecture Decision Records (ADRs) as described by [Michael Nygard](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions).

- ADRs are stored in `docs/adr/`
- Each ADR is a numbered markdown file (e.g., `0002-choose-mediapipe.md`)
- ADRs follow the template in `docs/adr/template.md`
- ADRs are immutable once accepted — if a decision is reversed, a new ADR supersedes the old one

## Consequences

### Positive

- Decisions are documented with their context and trade-offs
- New contributors can understand the project's evolution
- Reduces repeated debates about settled questions

### Negative

- Small overhead to write an ADR for each significant decision
- Must remember to actually write them

### Neutral

- ADRs are only for *significant* decisions. Not every code change needs one.

## Alternatives Considered

- **Wiki pages**: Less discoverable, not version-controlled with the code.
- **Comments in code**: Too scattered, lacks structure.
- **No documentation**: Unacceptable for a long-term project.
