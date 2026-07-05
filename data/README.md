# `data/`

## Why This Exists

Manages all dataset artifacts with a clear raw → processed pipeline. Separating raw from processed data ensures reproducibility and prevents accidental data corruption.

## Structure

```
data/
├── raw/            # Original, unmodified datasets
├── processed/      # Cleaned, transformed data ready for training/evaluation
└── README.md
```

## What Belongs Here

- **`raw/`** — Original datasets exactly as downloaded or collected. Never modify files here.
- **`processed/`** — Cleaned, normalised, augmented, or otherwise transformed data.
- Data manifests and metadata files (e.g., `manifest.json` describing dataset contents)
- Download scripts or instructions for obtaining datasets
- Dataset documentation (source, license, collection methodology)

## What Does NOT Belong Here

- **Trained models** → `models/`
- **Benchmark results** → `benchmarks/`
- **Recorded gesture sessions** → `recordings/`
- **Application code** → `src/`

## Important Notes

- **This directory is git-ignored by default** (except `.gitkeep` and `README.md` files). Large data files should not be committed to Git.
- For large datasets, use [Git LFS](https://git-lfs.github.com/) or external storage (S3, GCS, etc.) and document the download process.
- Always document the provenance and license of every dataset.
