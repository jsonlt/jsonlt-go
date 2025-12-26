// Package jsonlt provides a Go implementation of the JSON Lines Table (JSONLT)
// specification for storing keyed records in append-only files.
//
// JSONLT files use JSON Lines format where each line represents an operation
// (insert or delete). The logical state is computed by replaying all operations.
// This design optimizes for version control diffs and human readability.
//
// Basic usage:
//
//	table, err := jsonlt.Open("data.jsonlt", jsonlt.WithKey("id"))
//	if err != nil {
//	    log.Fatal(err)
//	}
//	defer table.Close()
//
//	// Insert a record
//	err = table.Put(map[string]any{"id": "user-1", "name": "Alice"})
//
//	// Retrieve a record
//	record, err := table.Get("user-1")
//
// See https://jsonlt.org for the full specification.
package jsonlt
