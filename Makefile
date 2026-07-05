# ===========================
# AirOS Makefile
# ===========================
# Common development commands as make targets.
# Run `make help` to see all available targets.

.DEFAULT_GOAL := help

# ----- Setup -----

.PHONY: setup
setup: ## Set up the development environment
	@echo "TODO: Add environment setup commands"

# ----- Testing -----

.PHONY: test
test: ## Run all tests
	@echo "TODO: Add test runner command"

.PHONY: test-unit
test-unit: ## Run unit tests only
	@echo "TODO: Add unit test command"

.PHONY: test-integration
test-integration: ## Run integration tests only
	@echo "TODO: Add integration test command"

# ----- Code Quality -----

.PHONY: lint
lint: ## Run linters
	@echo "TODO: Add linter command"

.PHONY: format
format: ## Run code formatters
	@echo "TODO: Add formatter command"

.PHONY: typecheck
typecheck: ## Run type checker
	@echo "TODO: Add type checker command"

# ----- Benchmarks -----

.PHONY: benchmark
benchmark: ## Run benchmark suite
	@echo "TODO: Add benchmark command"

# ----- Cleanup -----

.PHONY: clean
clean: ## Remove generated files and caches
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".mypy_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	rm -rf build/ dist/ htmlcov/ .coverage
	@echo "Cleaned."

# ----- Help -----

.PHONY: help
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'
