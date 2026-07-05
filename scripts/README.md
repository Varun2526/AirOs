# `scripts/`

## Why This Exists

Houses developer-facing utility scripts that automate common tasks. Keeping scripts in a dedicated directory prevents them from cluttering the project root or getting mixed with application code.

## What Belongs Here

- Environment setup scripts (`setup_env.sh`)
- Data download and preparation scripts
- Model export and conversion scripts
- Release and deployment scripts
- Database migration scripts
- One-off maintenance scripts

## What Does NOT Belong Here

- **Application entry points** → `src/`
- **Test scripts** → `tests/`
- **Benchmark scripts** → `benchmarks/`
- **Linter/formatter configs** → `tools/`
- **CI/CD workflows** → `.github/`

## Conventions

- Name scripts descriptively: `download_dataset.sh`, `export_model.py`
- Include a usage comment or `--help` flag in every script
- Make shell scripts executable: `chmod +x script.sh`
- Prefer Python scripts over bash for anything complex
