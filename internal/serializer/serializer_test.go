package serializer

import "testing"

func TestSerialize(t *testing.T) {
	record := map[string]any{
		"id":   "test-1",
		"name": "Test",
	}

	data, err := Serialize(record)
	if err != nil {
		t.Fatalf("Serialize failed: %v", err)
	}

	if len(data) == 0 {
		t.Error("Serialize returned empty data")
	}
}
