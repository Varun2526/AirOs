# AirOS Engineering Learning Notes

This directory documents the engineering concepts learned while building AirOS.

Unlike the [Engineering Handbook](../handbook/), which documents the system itself, these notes document the **knowledge and reasoning** developed throughout the project.

---

## Purpose

Each document focuses on one engineering topic and explains:

- **The engineering problem.** What real-world challenge does the concept address?
- **Why it exists.** What goes wrong without it?
- **Alternative approaches.** What other solutions were considered?
- **Trade-offs.** What does each approach gain and give up?
- **How AirOS applies the concept.** Concrete examples from this codebase.
- **Lessons learned.** What to remember for future work.

These notes are intended as a **long-term reference** for future study — not as a diary of what happened, but as a handbook of what was understood.

---

## Index

| # | Document | Topics Covered |
|---|----------|----------------|
| 01 | [Python Foundations](01-python-foundations.md) | Environment setup, virtual environments, dataclasses, type hints, immutability, `Frame` design |
| 02 | [Camera Capture Foundations](02-camera-capture-foundations.md) | Resource ownership, object lifetime, abstraction, public API design, state, error handling, context managers |

---

## Conventions

- Documents are numbered in the order they were written.
- Each document is self-contained and can be read independently.
- Code examples use AirOS modules wherever possible.
- Engineering concepts are always explained before Python syntax.
