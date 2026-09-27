// Package gigasecond calculates dates one gigasecond in the future.
package gigasecond

import "time"

// AddGigasecond returns the moment one billion seconds after t.
func AddGigasecond(t time.Time) time.Time {
	return t.Add(time.Second * 1_000_000_000)
}
