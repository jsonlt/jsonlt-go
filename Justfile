set shell := ['uv', 'run', '--frozen', 'bash', '-euxo', 'pipefail', '-c']
set unstable
set positional-arguments

project := "jsonlt-go"
pnpm := "pnpm exec"

# List available recipes
default:
  @just --list

# Run benchmarks
benchmark *args:
  go test -bench=. -benchmem ./tests/benchmark/... "$@"

# Build the module
build:
  go build ./...

# Clean build artifacts
clean:
  go clean -cache -testcache
  rm -rf coverage.out coverage.html

# Format code
format:
  codespell -w
  gofmt -s -w .
  {{pnpm}} biome format --write .

# Fix code issues
fix:
  gofmt -s -w .
  golangci-lint run --fix ./...
  {{pnpm}} biome check --write .

# Fix code issues including unsafe fixes
fix-unsafe:
  gofmt -s -w .
  golangci-lint run --fix ./...
  {{pnpm}} biome check --write --unsafe .

# Run all linters
lint:
  golangci-lint run ./...
  govulncheck ./...
  codespell
  yamllint --strict .
  {{pnpm}} biome check .
  {{pnpm}} markdownlint-cli2 "**/*.md"

# Lint Go code only
lint-go:
  golangci-lint run ./...

# Lint Markdown files
lint-markdown:
  {{pnpm}} markdownlint-cli2 "**/*.md"

# Lint prose in Markdown files
lint-prose:
  vale README.md

# Check spelling
lint-spelling:
  codespell

# Check types (Go vet)
lint-types:
  go vet ./...

# Lint web files (JSON)
lint-web:
  {{pnpm}} biome check .

# Install all dependencies (Python + Node.js + Go)
install: install-node install-python install-go

# Install only Go dependencies
install-go:
  #!/usr/bin/env bash
  go mod download

# Install only Node.js dependencies
install-node:
  #!/usr/bin/env bash
  pnpm install --frozen-lockfile

# Install pre-commit hooks
install-prek:
  prek install

# Install only Python dependencies
install-python:
  #!/usr/bin/env bash
  uv sync --frozen

# Run pre-commit hooks on changed files
prek:
  prek

# Run pre-commit hooks on all files
prek-all:
  prek run --all-files

# Run tests (unit tests colocated with code)
test *args:
  go test ./pkg/... ./internal/... "$@"

# Run all tests including conformance
test-all *args:
  go test -tags=conformance ./... "$@"

# Run conformance tests
test-conformance *args:
  go test -tags=conformance ./tests/conformance/... "$@"

# Run tests with coverage
test-coverage *args:
  go test -coverprofile=coverage.out -covermode=atomic ./pkg/... ./internal/... "$@"
  go tool cover -html=coverage.out -o coverage.html

# Run fuzz tests (short duration)
test-fuzz *args:
  go test -fuzz=Fuzz -fuzztime=10s ./tests/fuzz/... "$@"

# Sync Vale styles
vale-sync:
  vale sync
