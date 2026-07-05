# Contributing to AirOS

Thank you for your interest in contributing to AirOS! This document provides guidelines to make the contribution process smooth for everyone.

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Branching Strategy](#branching-strategy)
- [Commit Conventions](#commit-conventions)
- [Pull Request Process](#pull-request-process)
- [Code Style](#code-style)
- [Testing](#testing)
- [Research Contributions](#research-contributions)
- [Reporting Issues](#reporting-issues)

---

## Code of Conduct

Be respectful, constructive, and professional. We're all here to build something great.

---

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Create a feature branch from `main`
4. Set up the development environment: `make setup`
5. Make your changes
6. Run tests: `make test`
7. Submit a pull request

---

## Development Workflow

```
main (stable) ← feature branches ← your work
```

1. Always branch from `main`
2. Keep branches short-lived and focused
3. Rebase onto `main` before submitting a PR
4. Delete branches after merge

---

## Branching Strategy

Use descriptive branch names with a category prefix:

| Prefix | Use Case | Example |
|---|---|---|
| `feat/` | New feature | `feat/palm-gesture-detection` |
| `fix/` | Bug fix | `fix/camera-init-crash` |
| `docs/` | Documentation | `docs/setup-guide` |
| `refactor/` | Code refactoring | `refactor/pipeline-module` |
| `test/` | Test additions | `test/gesture-unit-tests` |
| `research/` | Experimental work | `research/transformer-model` |
| `bench/` | Benchmark work | `bench/latency-profiling` |

---

## Commit Conventions

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <short description>

<optional body>

<optional footer>
```

### Types

| Type | Description |
|---|---|
| `feat` | A new feature |
| `fix` | A bug fix |
| `docs` | Documentation changes |
| `style` | Formatting (no logic change) |
| `refactor` | Code restructuring (no feature/fix) |
| `test` | Adding or updating tests |
| `chore` | Build, CI, tooling changes |
| `perf` | Performance improvement |
| `research` | Experimental/research work |

### Examples

```
feat(gestures): add pinch-to-zoom gesture recognition
fix(camera): resolve frame drop on macOS Ventura
docs(readme): update installation instructions
research(models): experiment with MobileNet v3 backbone
```

---

## Pull Request Process

1. **Fill out the PR template** — Don't skip sections
2. **Link related issues** — Use `Closes #123` or `Related to #456`
3. **Keep PRs focused** — One concern per PR
4. **Ensure CI passes** — All tests and linters must pass
5. **Request review** — Tag relevant reviewers
6. **Respond to feedback** — Address all comments before merge

---

## Code Style

- Follow the project's linter configuration (see `tools/`)
- Write docstrings for all public functions and classes
- Keep functions short and single-purpose
- Prefer clarity over cleverness
- Add type hints where applicable

---

## Testing

- Write tests for all new features and bug fixes
- Place tests in `tests/`, mirroring `src/` structure
- Run the full suite before submitting: `make test`
- Aim for meaningful test coverage, not 100% line coverage

---

## Research Contributions

Research and experimental work follows a slightly different process:

1. Open a **Research Proposal** issue first
2. Work in the `research/experiments/` directory
3. Document your approach, results, and conclusions
4. If the experiment is successful, open a follow-up issue to integrate into `src/`

See [research/README.md](research/README.md) for the experiment structure.

---

## Reporting Issues

Use the appropriate GitHub Issue template:

- **Bug Report** — Something isn't working as expected
- **Feature Request** — Suggest a new capability
- **Research Proposal** — Propose an experiment or model change

Provide as much context as possible: OS, Python version, steps to reproduce, expected vs actual behavior.

---

Thank you for contributing! 🎉
