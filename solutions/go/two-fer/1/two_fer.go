// Package twofer formats a two-for-one sharing message.
package twofer

import "fmt"

// ShareWith returns the message to say when sharing with name.
func ShareWith(name string) string {
	if name == "" {
		name = "you"
	}
	return fmt.Sprintf("One for %s, one for me.", name)
}
