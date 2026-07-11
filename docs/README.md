# `docs/`

## Why This Exists

All project documentation beyond the root README lives here. Centralising documentation makes it discoverable and maintainable.

## Structure

```
docs/
├── adr/                      # Architecture Decision Records
│   ├── template.md           # ADR template
│   ├── 0001-record-architecture-decisions.md
│   ├── 0002-recording-format.md
│   ├── 0003-session-structure.md
│   └── 0004-landmark-stream.md
├── handbook/              # Engineering Handbook — technical concept references
│   ├── 01-hand-landmarks-and-coordinate-system.md
│   ├── 02-data-pipeline.md
│   └── 03-recorder-and-replay.md
├── architecture.md           # System architecture overview
├── engineering-principles.md # Central repository of engineering principles
└── README.md
```

## What Belongs Here

- Architecture overview and diagrams
- Setup and deployment guides
- API documentation
- Design documents
- Architecture Decision Records (ADRs) in `docs/adr/`
- Engineering concept references in `docs/handbook/`
- User guides and tutorials

## What Does NOT Belong Here

- **Research notes** → `research/notes/`
- **Inline code documentation** → Keep in source files in `src/`
- **README files for specific directories** → Keep in their respective directories
- **Auto-generated API docs** → Generate into `docs/api/` but don't hand-write there

## Engineering Handbook

AirOS is documented as an engineering handbook that grows alongside the implementation. Each document explains foundational concepts, engineering trade-offs, and design reasoning — not just what was built, but *why*.

| # | Document | Status |
|---|---|---|
| 01 | [Hand Landmarks and Coordinate System](handbook/01-hand-landmarks-and-coordinate-system.md) | ✅ Complete |
| 02 | [Data Pipeline — Recording, Replay, and Engineering Thinking](handbook/02-data-pipeline.md) | ✅ Complete |
| 03 | [Recorder and Replay Architecture](handbook/03-recorder-and-replay.md) | ✅ Complete |
| 04 | Real-Time Systems | ⬜ Planned |
| 05 | Filtering and Smoothing | ⬜ Planned |
| 06 | Feature Extraction | ⬜ Planned |
| 07 | Rule-Based Gesture Recognition | ⬜ Planned |
| 08 | Machine Learning Fundamentals | ⬜ Planned |
| 09 | Training and Evaluation | ⬜ Planned |
| 10 | Performance Optimization | ⬜ Planned |
| 11 | Production Readiness | ⬜ Planned |

See [`docs/handbook/`](handbook/) for the full handbook.

## Architecture Decision Records (ADRs)

ADRs capture the *why* behind significant technical decisions. See [adr/template.md](adr/template.md) for the format.

| ADR | Title |
|---|---|
| 0001 | [Record Architecture Decisions](adr/0001-record-architecture-decisions.md) |
| 0002 | [Recording Format](adr/0002-recording-format.md) |
| 0003 | [Session Structure](adr/0003-session-structure.md) |
| 0004 | [Landmark Stream Interface](adr/0004-landmark-stream.md) |

To create a new ADR:
1. Copy `adr/template.md`
2. Number it sequentially (e.g., `0005-choose-mediapipe.md`)
3. Fill in all sections
4. Set status to `Proposed`, then update to `Accepted`/`Rejected` after review
