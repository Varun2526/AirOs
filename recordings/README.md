# `recordings/`

## Why This Exists

Stores recorded gesture sessions for replay, debugging, and regression testing. Recording real sessions allows you to reproduce issues without needing to physically repeat gestures.

## What Belongs Here

- Recorded session files (video, serialised frame data, landmark sequences)
- Replay metadata (timestamps, resolution, FPS, gesture labels)
- Session annotations (human-labeled ground truth for recorded sessions)

## What Does NOT Belong Here

- **Raw training datasets** → `data/`
- **Application logs** → `logs/`
- **Demo GIFs/screenshots** → `assets/`
- **Benchmark data** → `benchmarks/`

## Important Notes

- This directory is **git-ignored by default**. Session recordings can be large.
- For recordings needed by CI or other developers, use external storage and document the download process.
- Include metadata alongside each recording (device, resolution, lighting conditions, etc.).
