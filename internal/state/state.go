// Package state computes the logical state of a JSONLT table.
package state

// State represents the logical state of a table.
type State struct {
	Records map[string]map[string]any
}

// New creates an empty state.
func New() *State {
	return &State{
		Records: make(map[string]map[string]any),
	}
}

// Count returns the number of records in the state.
func (s *State) Count() int {
	return len(s.Records)
}
