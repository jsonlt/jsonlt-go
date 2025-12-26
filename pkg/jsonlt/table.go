package jsonlt

// Table represents a JSONLT table backed by a file.
// It provides operations for reading and writing keyed records.
type Table struct {
	path string
	key  string
}

// Open opens or creates a JSONLT table at the specified path.
func Open(path string, opts ...Option) (*Table, error) {
	t := &Table{path: path}
	for _, opt := range opts {
		opt(t)
	}
	return t, nil
}

// Close releases resources associated with the table.
func (t *Table) Close() error {
	return nil
}

// Option configures a Table.
type Option func(*Table)

// WithKey specifies the field name to use as the record key.
func WithKey(field string) Option {
	return func(t *Table) {
		t.key = field
	}
}
