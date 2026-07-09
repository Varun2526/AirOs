# ADR 0002: Recording Format

**Date**: 2026-07-09

**Status**: Accepted

## Context

The Recorder module needs a serialization format to persist per-frame observation data (landmarks, timestamps, confidence values) to disk.

The chosen format must satisfy the following constraints:
- Must not block the live perception pipeline during writing.
- Must support sequential writing (appending) so that if a session crashes, all prior frames are preserved.
- Must be readable by a Replay module line-by-line without loading the entire file into memory (streaming).
- Must be readable by humans for debugging and inspection without specialized parser tools.
- Must be resilient to format evolution (e.g., adding new optional fields).

Binary formats (like Protocol Buffers or MessagePack) offer excellent parse speed and compact file sizes, but require external schemas, specific parsing libraries, and obscure debugging without specialized tools. Traditional JSON requires parsing the entire file into memory to read a single frame.

## Decision

We will use **JSON Lines (`.jsonl`)** for per-frame data serialization.

- Every frame is serialized as a standalone JSON object.
- Each object is written on a single newline.
- Session metadata is stored in a separate standard JSON file (`metadata.json`).

## Consequences

### Positive

- **Streamable**: Replay and processing tools can read the file line-by-line with $O(1)$ memory consumption.
- **Appendable**: Writing is a simple append operation. A crash midway leaves a perfectly valid file containing all frames up to the crash.
- **Human-Readable**: Developers can use standard Unix tools (`head`, `tail`, `grep`) to inspect frames.
- **Future-Proof**: Adding new fields to future frames does not break parsers that expect the old schema, provided the parser ignores unknown fields. No external schema registry is required to read the data.

### Negative

- **File Size**: JSON is verbose. A 30-minute session at 30 FPS (54,000 frames) yields approximately 27 MB, which is 3–5× larger than a binary equivalent.
- **Parse Speed**: JSON parsing is slower than binary deserialization, though still well within the budget required for 30 FPS replay.

### Neutral

- The file size is acceptable for the current scale (landmarks only, no video). If data volumes increase substantially, we may need to revisit this decision, but we should not optimize prematurely.

## Alternatives Considered

- **Standard JSON (Single Object)**: Rejected because it cannot be streamed. Replaying a 30-minute session would require loading the entire JSON structure into memory. It is also not cleanly appendable without rewriting the closing brackets.
- **CSV**: Rejected because landmarks require nested arrays (21 landmarks, each with x, y, z coordinates). Flattening this into CSV columns creates a brittle, wide table that is difficult to evolve.
- **Protocol Buffers / MessagePack**: Rejected for V1. While more efficient, they require schema maintenance, specific libraries in the consumer language, and specialized tools for manual inspection. The engineering overhead outweighs the disk space savings at the current scale.
- **SQLite**: Rejected because it introduces a database dependency for simple sequential reading and writing.
