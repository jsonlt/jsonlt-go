package state

import "testing"

func TestNew(t *testing.T) {
	s := New()
	if s == nil {
		t.Fatal("New returned nil")
	}
	if s.Records == nil {
		t.Error("Records map should be initialized")
	}
}

func TestCount(t *testing.T) {
	s := New()
	if s.Count() != 0 {
		t.Errorf("expected count 0, got %d", s.Count())
	}

	s.Records["key1"] = map[string]any{"id": "key1"}
	if s.Count() != 1 {
		t.Errorf("expected count 1, got %d", s.Count())
	}
}
