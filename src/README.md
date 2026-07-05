# `src/`

## Why This Exists

This is the production application. All code that ships lives here. The boundary is clear: if it runs in production, it's in `src/`. If it's experimental, it's in `research/`.

## What Belongs Here

- Core application modules
- Gesture detection pipeline
- Hand tracking and landmark extraction
- Gesture classification and recognition
- Action mapping and execution
- OS integration layer
- Configuration loading
- Utility functions and helpers

## What Does NOT Belong Here

- **Experiments and research code** → `research/`
- **Test code** → `tests/`
- **Scripts and utilities** → `scripts/`
- **Jupyter notebooks** → `notebooks/`
- **Configuration files** → `config/`

## Future Structure

As the codebase grows, `src/` will naturally develop sub-packages. A likely evolution:

```
src/
├── __init__.py
├── main.py             # Application entry point
├── camera/             # Webcam capture and frame processing
├── detection/          # Hand detection models
├── gestures/           # Gesture recognition and classification
├── actions/            # Gesture-to-action mapping and execution
├── platform/           # OS-specific integration (macOS, Linux, Windows)
├── ui/                 # User interface (if applicable)
└── utils/              # Shared utilities
```

**Don't create sub-packages prematurely.** Start flat and refactor when a module grows beyond ~300 lines or ~5 closely related files.
