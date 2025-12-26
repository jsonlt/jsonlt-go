package parser

import "testing"

func TestNew(t *testing.T) {
	p := New("id")
	if p == nil {
		t.Fatal("New returned nil")
	}
	if p.keyField != "id" {
		t.Errorf("expected keyField 'id', got '%s'", p.keyField)
	}
}
