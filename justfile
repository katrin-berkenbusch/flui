# This is what I can do
default:
  just --list

# Lint all files
lint: 
  uv run ruff check src tests

# Typecheck all files
typecheck:
  uv run pyright src

# Run all tests
test:
  uv run pytest tests --benchmark-skip -ra

# Update snapshot tests
snap:
  uv run pytest --snapshot-update

# Save current benchmark results
benchsave:
  uv run pytest --benchmark-only --benchmark-autosave

# Benchmark (and compare)
bench:
  uv run pytest --benchmark-only --benchmark-compare

# Run all checks
check: lint typecheck test

