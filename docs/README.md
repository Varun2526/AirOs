# `docs/`

## Why This Exists

All project documentation beyond the root README lives here. Centralising documentation makes it discoverable and maintainable.

## Structure

```
docs/
├── adr/                # Architecture Decision Records
│   ├── template.md     # ADR template
│   └── 0001-*.md       # Individual decisions
├── architecture.md     # System architecture overview
└── README.md
```

## What Belongs Here

- Architecture overview and diagrams
- Setup and deployment guides
- API documentation
- Design documents
- Architecture Decision Records (ADRs) in `docs/adr/`
- User guides and tutorials

## What Does NOT Belong Here

- **Research notes** → `research/notes/`
- **Inline code documentation** → Keep in source files in `src/`
- **README files for specific directories** → Keep in their respective directories
- **Auto-generated API docs** → Generate into `docs/api/` but don't hand-write there

## Architecture Decision Records (ADRs)

ADRs capture the *why* behind significant technical decisions. See [adr/template.md](adr/template.md) for the format.

To create a new ADR:
1. Copy `adr/template.md`
2. Number it sequentially (e.g., `0002-choose-mediapipe.md`)
3. Fill in all sections
4. Set status to `Proposed`, then update to `Accepted`/`Rejected` after review
