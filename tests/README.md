# `tests/`

## Why This Exists

All test code lives here, mirroring the `src/` structure. Centralising tests makes them easy to discover, run, and maintain.

## What Belongs Here

- Unit tests
- Integration tests
- End-to-end tests
- Test fixtures and factories
- Test utilities and helpers
- Conftest files (for pytest)

## What Does NOT Belong Here

- **Benchmarks** → `benchmarks/`
- **Production code** → `src/`
- **Large test data files** → `data/` or `tests/fixtures/` (keep fixtures small)
- **Manual testing scripts** → `scripts/`

## Structure

Mirror the `src/` directory structure:

```
tests/
├── conftest.py         # Shared fixtures
├── unit/               # Fast, isolated unit tests
├── integration/        # Tests that cross module boundaries
├── e2e/                # End-to-end system tests
└── fixtures/           # Small test data files
```

## Conventions

- Name test files with `test_` prefix: `test_gesture_classifier.py`
- Name test functions with `test_` prefix: `def test_detects_open_palm():`
- Keep unit tests fast (< 100ms each)
- Use fixtures for setup/teardown, not copy-pasted setup code
- Run tests with: `make test`
