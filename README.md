# JSON Lines Table (JSONLT) Go package

<!-- vale off -->
[![CI](https://github.com/jsonlt/jsonlt-go/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/jsonlt/jsonlt-go/actions/workflows/ci.yml)
[![Go Reference](https://pkg.go.dev/badge/github.com/jsonlt/jsonlt-go.svg)](https://pkg.go.dev/github.com/jsonlt/jsonlt-go)
[![Codecov](https://codecov.io/gh/jsonlt/jsonlt-go/branch/main/graph/badge.svg)](https://codecov.io/gh/jsonlt/jsonlt-go)
[![Go 1.21+](https://img.shields.io/badge/go-1.21+-blue.svg)](https://go.dev/dl/)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)
<!-- vale on -->

**jsonlt-go** is the Go implementation of the [JSON Lines Table (JSONLT) specification][jsonlt].

## Installation

```bash
go get github.com/jsonlt/jsonlt-go
```

## Usage

```go
import "github.com/jsonlt/jsonlt-go/pkg/jsonlt"

table, err := jsonlt.Open("data.jsonlt", jsonlt.WithKey("id"))
if err != nil {
    log.Fatal(err)
}
defer table.Close()
```

## License

MIT License. See [LICENSE](LICENSE) for details.

[jsonlt]: https://jsonlt.org/
