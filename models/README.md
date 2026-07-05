# `models/`

## Why This Exists

Stores trained, exported, or downloaded model artifacts. Keeping models separate from code and data makes versioning, deployment, and sharing straightforward.

## What Belongs Here

- Trained model weight files (`.pt`, `.onnx`, `.tflite`, etc.)
- Exported/serialised models
- Pre-trained model downloads
- Model cards (documentation describing model purpose, performance, limitations)
- Model conversion scripts
- Version metadata (which dataset, hyperparameters, and commit produced this model)

## What Does NOT Belong Here

- **Training code** → `src/` or `research/`
- **Datasets** → `data/`
- **Training logs** → `logs/`
- **Experiment results** → `research/experiments/`

## Important Notes

- This directory is **git-ignored by default**. Model files are typically too large for Git.
- Use [Git LFS](https://git-lfs.github.com/) or external storage (S3, GCS, Hugging Face Hub) for model versioning.
- Always include a model card or metadata file alongside each model artifact.
