# ADR 0004: Landmark Stream Interface

**Date**: 2026-07-09

**Status**: Accepted

## Context

AirOS features a pipeline that processes landmark data to recognize gestures and map them to OS interactions. This pipeline receives data from two distinct sources:
1. **Live Perception**: The MediaPipe engine processing live camera feeds.
2. **Replay**: The infrastructure module reading historical `.jsonl` files from disk.

If the downstream modules (e.g., Gesture Engine, Filtering, Benchmarking) are aware of which source the data comes from, the system becomes tightly coupled. It would require conditional logic (e.g., `if is_live then ... else ...`), breaking encapsulation and making it difficult to test the gesture recognition algorithms reliably against recorded baselines.

**Principle #14** states: *"Replay should be indistinguishable from live perception to downstream modules."*

## Decision

We will implement a **Common Interface Pattern** for landmark data, referred to conceptually as the `Landmark Stream`.

- Both the **Perception module** and the **Replay module** must implement the identical producer interface.
- Downstream modules (the processing queue, consumers) will consume from this common interface without any knowledge of the data's origin.
- Replay will emit the exact original timestamps captured in the recording, preserving the temporal context of the session (Principle #13).

## Consequences

### Positive

- **Transparent Replay**: The Gesture Engine processes replayed data exactly as it processes live data.
- **Reliable Benchmarking**: Because the downstream modules cannot tell the difference, benchmarking against a recorded session provides an accurate simulation of live performance.
- **Decoupled Architecture**: New data sources (e.g., a synthetic data generator for unit tests) can be added simply by implementing the `Landmark Stream` interface.

### Negative

- **Rigid Contract**: Changes to the structure of the observation data require updating the common interface, which affects both Perception and Replay implementations simultaneously.

### Neutral

- Replay timing (wall-clock playback speed) is controlled by the Replay module based on caller policy (e.g., real-time, fast-forward), but the data emitted across the boundary relies solely on the original embedded timestamps.

## Alternatives Considered

- **Direct Injection into Queue**: Having the Replay module push directly into the downstream processing queue. Rejected because it bypasses the interface boundary and ties the Replay module to a specific consumer (the queue) rather than acting as a standard producer.
- **Replay-Specific Flags**: Adding an `is_replay` boolean to the frame objects so downstream modules know they are running in test mode. Rejected because it invites branching logic in the core algorithms, violating Principle #14. The algorithm should behave identically regardless of the source.
