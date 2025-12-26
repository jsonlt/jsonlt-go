package fuzz_test

import "testing"

func FuzzParseLine(f *testing.F) {
	// Seed with valid JSONLT lines
	f.Add([]byte(`{"id": "test"}`))
	f.Add([]byte(`{"id": 123, "name": "example"}`))
	f.Add([]byte(`{"$deleted": true, "id": "removed"}`))

	f.Fuzz(func(t *testing.T, data []byte) {
		// Placeholder for fuzz testing
		// TODO: Implement actual parsing and verify no panics
		_ = data
	})
}
