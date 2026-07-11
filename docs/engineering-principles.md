# AirOS Engineering Principles

This document serves as the central repository for the engineering principles guiding the architecture and development of AirOS.

These principles are not arbitrary rules; they are hard-won lessons in systems engineering, designed to keep the system modular, debuggable, and maintainable over the long term.

---

## The Principles

### 1. Minimum Useful Information
> *"Collect the minimum useful information required to solve the problem reliably."*

Every piece of data collected has a cost: storage, processing time, network bandwidth, and cognitive overhead. Do not collect data "just in case." Collect exactly what is needed to fulfill the current requirement, and no more.
*(Introduced in [Document 01](handbook/01-hand-landmarks-and-coordinate-system.md))*

### 2. Facts Over Interpretations
> *"Store facts, not interpretations."*

Facts are direct observations (e.g., "The index finger tip is at coordinates 0.5, 0.4"). Interpretations are conclusions drawn from facts (e.g., "The user is pointing"). Algorithms change, making old interpretations obsolete. Facts remain true forever.
*(Introduced in [Document 02](handbook/02-data-pipeline.md))*

### 3. Separate Collection and Processing
> *"Separate data collection from data processing."*

The system that gathers data from the outside world should not be the same system that decides what the data means. Mixing these concerns makes the system brittle and impossible to unit test effectively.
*(Introduced in [Document 02](handbook/02-data-pipeline.md))*

### 4. Freshness Over Completeness
> *"In real-time systems, freshness is often more valuable than completeness."*

For interactive systems like cursor control, a slightly inaccurate landmark position delivered in 10ms is better than a perfectly accurate position delivered in 150ms. High latency breaks the illusion of control. Drop old data if it means staying real-time.
*(Introduced in [Document 02](handbook/02-data-pipeline.md))*

### 5. Single Responsibility
> *"Every module should have exactly one responsibility."*

A module that does two things will eventually fail at both, because changes required for one responsibility will break the other. Keep boundaries sharp.
*(Introduced in [Document 02](handbook/02-data-pipeline.md))*

### 6. Passive Infrastructure
> *"Infrastructure modules preserve facts; they do not make decisions."*

Infrastructure modules (like the Recorder) exist to support the pipeline. They must not filter, judge, or interpret data. Every decision made by infrastructure removes a degree of freedom from future downstream consumers.
*(Introduced in [Document 03](handbook/03-recorder-and-replay.md))*

### 7. Strict Ownership
> *"A module should own only the information required by its responsibility."*

If the Recorder owns gesture labels, it becomes coupled to the gesture vocabulary. Owning information outside your core responsibility creates tight coupling and fragile systems.
*(Introduced in [Document 03](handbook/03-recorder-and-replay.md))*

### 8. Downstream Privacy
> *"Privacy-preserving transformations belong to downstream processing modules, not to data capture modules."*

Anonymization (like face blurring) modifies data. If data is modified at capture, the original is permanently lost. Capture faithfully; transform later.
*(Introduced in [Document 03](handbook/03-recorder-and-replay.md))*

### 9. Frequency of Change
> *"Store information at the lowest frequency at which it changes."*

Observations change every frame (store them per frame). Metadata changes once per session (store it once per session). Mixing these frequencies wastes space and risks inconsistency.
*(Introduced in [Document 03](handbook/03-recorder-and-replay.md))*

### 10. Session Coherence
> *"A recording session should represent one coherent experiment."*

A session must have an unbroken time range and consistent metadata throughout. If conditions change (e.g., camera resolution changes), end the current session and start a new one.
*(Introduced in [Document 03](handbook/03-recorder-and-replay.md))*

### 11. Recordings as Long-Term Assets
> *"Recordings are long-term engineering assets — self-describing, durable, and understandable without reading the current implementation."*

A recording made today will be a regression test in six months. It must be structured with version stamps and clear metadata so it survives codebase evolution.
*(Introduced in [Document 03](handbook/03-recorder-and-replay.md))*

### 12. Evolution by Extension
> *"A recording format should evolve through extension rather than replacement whenever possible."*

Extension preserves backward compatibility. New optional fields allow older software to continue reading new recordings. Replacement destroys value and forces migrations.
*(Introduced in [Document 03](handbook/03-recorder-and-replay.md))*

### 13. Replay Determinism and Context
> *"The same recording should always reproduce the same observations — including their temporal relationships and original context."*

Replaying a session must produce identical results every time. Modifying timestamps or stripping timing gaps destroys the historical record. *(Corollary: Replay speed changes the rate of playback, not the recorded history.)*
*(Introduced in [Document 03](handbook/03-recorder-and-replay.md))*

### 14. Interface Equivalence
> *"Replay should be indistinguishable from live perception to downstream modules."*

Downstream modules must consume from a common interface. If a module has to ask "is this data live or replayed?", the interface abstraction is broken.
*(Introduced in [Document 03](handbook/03-recorder-and-replay.md))*

### 15. Policy Injection
> *"Infrastructure modules execute policies; they should not define them."*

The Replay module should not decide how fast to replay; the caller provides the speed policy. Hardcoding policies inside infrastructure makes the infrastructure rigid and single-use.
*(Introduced in [Document 03](handbook/03-recorder-and-replay.md))*
