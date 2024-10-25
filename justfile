# set dotenv-load

# Yeah, this is what I can do
default:
  just --list

# Lint all files
lint: 
  uv run ruff check src tests

typecheck:
  pyright src

test:
  uv run pytest tests --benchmark-skip -ra

snap:
  uv run pytest --snapshot-update

benchsave:
  uv run pytest --benchmark-only --benchmark-autosave

bench:
  uv run pytest --benchmark-only --benchmark-compare

