# `research/`

## Why This Exists

Complete isolation of experimental AI/ML work from the production application. Experiments can (and should) be messy — production code cannot. This boundary lets you move fast in research without risking production stability.

## Structure

```
research/
├── experiments/    # Structured experiment folders
├── notes/          # Research notes, paper summaries, brainstorming
└── README.md
```

## What Belongs Here

### `experiments/`
Each experiment gets its own folder with a consistent structure:

```
experiments/
└── YYYY-MM-DD_experiment-name/
    ├── README.md       # Hypothesis, approach, results, conclusions
    ├── config.yaml     # Experiment-specific configuration
    ├── train.py        # Training script (if applicable)
    ├── evaluate.py     # Evaluation script
    └── results/        # Outputs, plots, metrics
```

### `notes/`
- Paper summaries and literature reviews
- Brainstorming documents
- Meeting notes related to research direction
- Competitive analysis

## What Does NOT Belong Here

- **Production-ready code** → Graduate successful experiments to `src/`
- **Datasets** → `data/`
- **Trained models** → `models/`
- **Jupyter notebooks** → `notebooks/` (unless tightly coupled to a specific experiment)

## Experiment Workflow

1. Open a [Research Proposal](../../.github/ISSUE_TEMPLATE/research_proposal.md) issue
2. Create a folder in `experiments/` with the date and a descriptive name
3. Document your hypothesis in the experiment's `README.md`
4. Run the experiment, log results
5. Update the `README.md` with conclusions
6. If successful, open a follow-up issue to integrate into `src/`
