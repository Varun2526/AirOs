# `tools/`

## Why This Exists

Houses development tooling configuration and custom developer tools. Separating tool configuration from the project root keeps things tidy as the number of tools grows.

## What Belongs Here

- Linter configurations (e.g., `.flake8`, `ruff.toml`)
- Formatter configurations (e.g., `pyproject.toml` sections for Black)
- Pre-commit hook configurations (`.pre-commit-config.yaml`)
- Custom CLI tools for development
- Docker/container files for dev environments
- Type checker configuration

## What Does NOT Belong Here

- **Application code** → `src/`
- **CI/CD workflows** → `.github/`
- **Utility scripts** → `scripts/`
- **Application configuration** → `config/`

## Notes

- Some tools require their config at the project root (e.g., `pyproject.toml`). That's fine — keep root-level configs minimal and reference `tools/` where possible.
- As the project grows, consider adding a `tools/README.md` section for each tool with setup instructions.
