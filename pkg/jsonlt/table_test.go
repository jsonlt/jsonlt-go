package jsonlt

import "testing"

func TestVersion(t *testing.T) {
	if Version == "" {
		t.Error("Version should not be empty")
	}
}

func TestOpen(t *testing.T) {
	table, err := Open(t.TempDir()+"/test.jsonlt", WithKey("id"))
	if err != nil {
		t.Fatalf("Open failed: %v", err)
	}
	t.Cleanup(func() {
		if err := table.Close(); err != nil {
			t.Errorf("Close failed: %v", err)
		}
	})
}

func TestWithKey(t *testing.T) {
	table, err := Open(t.TempDir()+"/test.jsonlt", WithKey("user_id"))
	if err != nil {
		t.Fatalf("Open failed: %v", err)
	}
	t.Cleanup(func() {
		if err := table.Close(); err != nil {
			t.Errorf("Close failed: %v", err)
		}
	})

	if table.key != "user_id" {
		t.Errorf("expected key 'user_id', got '%s'", table.key)
	}
}
