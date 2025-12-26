// Package serializer provides deterministic JSON serialization for JSONLT.
package serializer

import "encoding/json"

// Serialize converts a record to JSON.
// TODO: Implement deterministic serialization with sorted keys per spec.
func Serialize(record map[string]any) ([]byte, error) {
	return json.Marshal(record)
}
