# `config/`

## Why This Exists

Single source of truth for all configuration. Keeping config separate from code makes it easy to change behaviour without modifying source, and to maintain environment-specific overrides.

## What Belongs Here

- Application settings (YAML, TOML, or JSON)
- Model hyperparameter files
- Logging configuration
- Environment-specific overrides (e.g., `config.dev.yaml`, `config.prod.yaml`)
- Example/template configuration files

## What Does NOT Belong Here

- **Secrets or API keys** → Use environment variables or a `.env` file (git-ignored)
- **Source code** → `src/`
- **CI/CD configuration** → `.github/`
- **Editor/IDE settings** → `.editorconfig` or `.vscode/` (git-ignored)
- **Tool-specific configs** (linters, formatters) → `tools/`

## Conventions

- Suffix config files with their environment: `app.dev.yaml`, `app.prod.yaml`
- Provide an example for every config file: `app.example.yaml`
- Never commit files containing real secrets
