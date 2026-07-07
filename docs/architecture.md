# AirOS Architecture

> This document describes the high-level architecture of AirOS. It is a living document that will evolve as the system grows.

## System Overview

AirOS is an AI-powered hand gesture interaction system that processes webcam input in real time to detect hand gestures and map them to desktop actions.

## Pipeline Architecture

```
┌──────────┐    ┌───────────────┐    ┌────────────────────┐    ┌────────────────┐    ┌────────────┐
│  Camera   │───▶│ Hand Detection │───▶│ Gesture Recognition │───▶│ Action Mapping │───▶│ OS Control │
│  Input    │    │  (CV/ML)       │    │  (Classification)   │    │  (Config)      │    │ (Platform) │
└──────────┘    └───────────────┘    └────────────────────┘    └────────────────┘    └────────────┘
```

### Stage Descriptions

| Stage | Responsibility | Key Concerns |
|---|---|---|
| **Camera Input** | Capture frames from webcam | Frame rate, resolution, device selection |
| **Hand Detection** | Locate hands and extract landmarks | Model accuracy, latency, GPU/CPU |
| **Gesture Recognition** | Classify hand poses into named gestures | Gesture vocabulary, confidence thresholds |
| **Action Mapping** | Map gestures to system actions | Configuration, customisability |
| **OS Control** | Execute system-level actions | Platform compatibility, permissions |

> The pipeline between stages uses a producer–consumer model with bounded queues, a Recorder for raw data persistence, and a Replay system for offline processing. For full details, see [Engineering Document 02: Data Pipeline](engineering/02-data-pipeline.md).

## Design Principles

1. **Each stage is a module** — Stages communicate through well-defined interfaces. Any stage can be swapped without affecting others.
2. **Configuration over code** — Gesture-to-action mappings are config, not hardcoded.
3. **Research ≠ Production** — Experiments happen in `research/`. Proven approaches graduate to `src/`.
4. **Measure everything** — Latency and accuracy benchmarks are first-class citizens.

## Module Boundaries

<!-- TODO: Define module interfaces as the implementation begins -->

## Key Technical Decisions

See [Architecture Decision Records](adr/) for the reasoning behind significant technical choices.

## Engineering Handbook

For foundational concepts — landmarks, coordinate systems, data pipelines, producer/consumer patterns, and engineering principles — see the [Engineering Handbook](engineering/).
