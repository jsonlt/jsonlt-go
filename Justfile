set shell := ['bash', '-euxo', 'pipefail', '-c']
set unstable
set positional-arguments

project := "jsonlt-go"

# Tool versions
golangci_lint := "github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.1.6"
govulncheck := "golang.org/x/vuln/cmd/govulncheck@latest"

# List available recipes
default:
  @just --list

# Format code
format: format-spelling format-config format-docs
  gofmt -s -w .

# Format configuration files
format-config:
  biome format --write .

# Format documentation
format-docs *args:
  just format-markdown {{ args }}

# Format Markdown files
format-markdown *args:
  rumdl fmt {{ if args == "" { "." } else { args } }}

# Fix spelling
format-spelling *args:
  codespell -w {{ if args == "" { "." } else { args } }}

# Fix code issues
fix: fix-config fix-docs
  gofmt -s -w .
  go run {{golangci_lint}} run --fix ./...

# Fix configuration files
fix-config:
  biome check --write .

# Fix documentation
fix-docs *args:
  just fix-markdown {{ args }}

# Fix Markdown files
fix-markdown *args:
  rumdl check --fix {{ if args == "" { "." } else { args } }}

# Run all linters
lint: lint-go lint-docs lint-config lint-spelling

# Lint configuration files
lint-config: lint-json lint-yaml

# Lint documentation
lint-docs *args:
  just lint-markdown {{ args }}
  just lint-prose {{ args }}

# Lint Go code
lint-go:
  go run {{golangci_lint}} run ./...
  go run {{govulncheck}} ./...

# Lint JSON/JS/TS files
lint-json:
  biome check --files-ignore-unknown=true .

# Lint Markdown files
lint-markdown *args:
  rumdl check {{ if args == "" { "." } else { args } }}

# Lint prose in Markdown files
lint-prose *args:
  vale {{ if args == "" { "README.md" } else { args } }}

# Check spelling
lint-spelling:
  codespell

# Check types (Go vet)
lint-types:
  go vet ./...

# Lint YAML files
lint-yaml:
  yamllint --strict .

# Install dependencies
install:
  vale sync
  go mod download

# Build the module
build:
  go build ./...

# Clean build artifacts
clean:
  go clean -cache -testcache
  rm -rf coverage.out coverage.html

# Run tests (unit tests colocated with code)
test *args:
  go test . ./internal/... "$@"

# Run all tests including conformance
test-all *args:
  go test -tags=conformance ./... "$@"

# Run conformance tests
test-conformance *args:
  go test -tags=conformance ./tests/conformance/... "$@"

# Run tests with coverage
test-coverage *args:
  go test -coverprofile=coverage.out -covermode=atomic . ./internal/... "$@"
  go tool cover -html=coverage.out -o coverage.html

# Run fuzz tests (short duration)
test-fuzz *args:
  go test -fuzz=Fuzz -fuzztime=10s ./tests/fuzz/... "$@"

# Run benchmarks
benchmark *args:
  go test -bench=. -benchmem ./tests/benchmark/... "$@"

# Run pre-commit hooks on changed files
prek:
  prek

# Run pre-commit hooks on all files
prek-all:
  prek run --all-files

# Install pre-commit hooks
prek-install:
  prek install

# Sync Vale styles and dictionaries
vale-sync:
  vale sync

# Generate full changelog
generate-changelog:
  cog changelog | { echo "# Changelog"; cat; } | rumdl check -d MD024 --fix --stdin > CHANGELOG.md

# Preview changelog since last release
preview-changelog:
  cog changelog --at $(git describe --tags)..HEAD -t full_hash | rumdl check -d MD041 --fix --stdin

# Generate release notes
[script]
generate-release-notes version="":
  v=$([[ -n "{{ version }}" ]] && echo "v{{ version }}" || echo "..$(git rev-parse HEAD)" )
  cog changelog --at $v -t full_hash | rumdl check -d MD024,MD041 --isolated --fix --stdin
