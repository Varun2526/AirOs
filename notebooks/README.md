# `notebooks/`

## Why This Exists

Quick interactive exploration that doesn't fit the more structured `research/` workflow. Notebooks are excellent for data exploration, visualisation, prototyping, and creating demos.

## What Belongs Here

- Jupyter / Colab notebooks for data exploration and visualisation
- Quick prototyping and proof-of-concept work
- Demo notebooks showcasing features
- Tutorial notebooks for onboarding

## What Does NOT Belong Here

- **Production logic** → Extract reusable code into `src/`
- **Formal experiments** → `research/experiments/` (experiments need structure and reproducibility)
- **Importable modules** → Notebooks should never be imported by production code

## Conventions

- Name notebooks descriptively: `01_explore_hand_landmarks.ipynb`
- Number notebooks if they follow a sequence
- Clear all outputs before committing (to keep diffs clean and repo size small)
- Add a markdown cell at the top of each notebook explaining its purpose
