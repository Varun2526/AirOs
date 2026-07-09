# ADR 0003: Session Structure

**Date**: 2026-07-09

**Status**: Accepted

## Context

A recording session captures data over a continuous period of time. This data needs to be stored on disk in a structured manner that supports the AirOS engineering principles:
- **Principle #9**: Store information at the lowest frequency at which it changes.
- **Principle #10**: A recording session should represent one coherent experiment.
- **Principle #11**: Recordings are long-term engineering assets — self-describing, durable, and understandable without reading the current implementation.

The storage structure must prevent naming conflicts when multiple sessions are recorded (potentially across different machines) and allow for metadata (which is static for the session) to be cleanly separated from observation data (which changes every frame).

## Decision

We will structure recording sessions using a **UUID-based directory format** with separate metadata and observation files.

1. **Directory**: Each session is stored in a dedicated subdirectory named using a UUID (e.g., `recordings/a3f1b2c4-5d6e-7f8a-9b0c-1d2e3f4a5b6c/`).
2. **Metadata**: A `metadata.json` file inside the directory stores the session-level context (e.g., start time, resolution, version). This file is written once per session.
3. **Observations**: A `landmarks.jsonl` file inside the directory stores the per-frame observation data.

## Consequences

### Positive

- **Self-Contained Sessions**: Moving, archiving, or deleting a session is a simple directory operation. The metadata and the data it describes travel together.
- **Conflict-Free Identity**: Using UUIDs instead of sequential numbers or timestamps mathematically eliminates naming conflicts without requiring a centralized naming authority or registry.
- **Frequency Separation**: By splitting `metadata.json` from `landmarks.jsonl`, we adhere to Principle #9. We avoid duplicating static metadata in every frame, reducing file size and the risk of inconsistency. Replay modules can load the metadata instantly without parsing the entire frame file.
- **Extensibility**: The directory acts as a container. If we later decide to record video or audio, we can simply add `video.mp4` or `audio.wav` to the same directory without changing the existing file structures.

### Negative

- **Human Discoverability**: UUIDs are opaque. A developer looking for a specific session cannot find it by the folder name alone (unlike `session_2026-07-08`). They must rely on tooling to read the `metadata.json` files or search the contents.

### Neutral

- To mitigate the discoverability issue, tooling can be built to list sessions based on the `start_time` and `frame_count` within their metadata files. The UUID is the identity; the timestamp is metadata.

## Alternatives Considered

- **Date-Based Directories (`recordings/2026-07-08/session1/`)**: Rejected because it requires sub-naming (e.g., `session1`, `session2`) to prevent collisions within the same day, adding complexity.
- **Flat Files (`recordings/session_uuid.jsonl`)**: Rejected because it requires injecting metadata into the JSON Lines file (either as a special first line or duplicated per frame). A special first line makes parsing brittle (the parser must treat line 1 differently than line 2). Duplicating metadata wastes space.
- **Single Monolithic File (e.g., SQLite or HDF5)**: Rejected as premature optimization (see [ADR-0002](0002-recording-format.md)).
