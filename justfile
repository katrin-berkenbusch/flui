# set dotenv-load

# Yeah, this is what I can do
default:
  just --list

# Lint all files
lint: 
  ruff check src tests

typecheck:
  pyright src

test:
  pytest tests --benchmark-skip -ra

snap:
  pytest --snapshot-update

benchsave:
  pytest --benchmark-only --benchmark-autosave

bench:
  pytest --benchmark-only --benchmark-compare

