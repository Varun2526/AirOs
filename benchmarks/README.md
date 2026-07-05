# `benchmarks/`

## Why This Exists

Reproducible performance measurements that track regressions, compare approaches, and validate optimisations. Benchmarks should produce consistent, comparable results across runs.

## What Belongs Here

- Benchmark scripts that measure latency, throughput, accuracy, or resource usage
- Baseline result files for comparison
- Performance comparison tables and reports
- Profiling configurations
- README or markdown files documenting how to run benchmarks and interpret results

## What Does NOT Belong Here

- **Unit or integration tests** → `tests/`
- **One-off experiments** → `research/experiments/`
- **Production application code** → `src/`
- **Training scripts** → `src/` or `research/`

## Running Benchmarks

```bash
make benchmark
```
