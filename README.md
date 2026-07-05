# AirOS

> AI-powered hand gesture interaction system — control your desktop with just a webcam.

<!--
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()
-->

---

## What is AirOS?

AirOS is an AI-powered hand gesture interaction system that enables users to control desktop applications using only a laptop webcam. No special hardware required — just your hands and a camera.

<!-- TODO: Add demo GIF here -->
<!-- ![AirOS Demo](assets/demo.gif) -->

---

## Features (Planned)

- **Real-time hand tracking** — Low-latency gesture detection via webcam
- **Gesture recognition** — Configurable gesture-to-action mapping
- **Desktop integration** — Native OS control (mouse, keyboard, app switching)
- **Session recording** — Record and replay gesture sessions for debugging
- **Extensible architecture** — Plugin system for custom gestures and actions
- **Benchmarking suite** — Track model performance across versions

---

## Architecture Overview

AirOS follows a modular pipeline architecture:

```
Camera Input → Hand Detection → Gesture Recognition → Action Mapping → OS Control
```

For detailed architecture documentation, see [docs/architecture.md](docs/architecture.md).

---

## Project Structure

```
AirOS/
├── src/            # Production application source
├── tests/          # All test code
├── research/       # AI/ML experiments (isolated from production)
├── notebooks/      # Jupyter notebooks for exploration
├── benchmarks/     # Performance benchmarks
├── data/           # Datasets (raw + processed)
├── models/         # Trained model artifacts
├── recordings/     # Recorded gesture sessions
├── config/         # Configuration files
├── docs/           # Documentation + ADRs
├── scripts/        # Developer utility scripts
├── tools/          # Dev tooling (linters, formatters)
├── assets/         # Static media (icons, images)
└── logs/           # Runtime logs (git-ignored)
```

Each directory contains a `README.md` explaining its purpose, contents, and anti-patterns.

---

## Development

### Prerequisites

- Python 3.10+
- A webcam

### Setup

```bash
# Clone the repository
git clone https://github.com/Varun2526/AirOS.git
cd AirOS

# Set up development environment
make setup

# Run tests
make test

# Run linter
make lint
```

### Common Commands

| Command | Description |
|---|---|
| `make setup` | Install dependencies and set up environment |
| `make test` | Run all tests |
| `make lint` | Run linters and formatters |
| `make benchmark` | Run benchmark suite |
| `make clean` | Remove generated files |

---

## Roadmap

<!-- TODO: Link to GitHub Projects board -->

See the [GitHub Issues](../../issues) for planned work.

---

## Contributing

We welcome contributions! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:

- Branching strategy
- Commit conventions
- Pull request process
- Code style

---

## License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.
