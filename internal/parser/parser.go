// Package parser provides JSONLT file parsing functionality.
package parser

// Parser reads JSONLT files and extracts operations.
type Parser struct {
	keyField string
}

// New creates a new Parser with the specified key field.
func New(keyField string) *Parser {
	return &Parser{keyField: keyField}
}
