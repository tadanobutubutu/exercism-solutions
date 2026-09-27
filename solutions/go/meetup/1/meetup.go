package meetup

import "time"

type WeekSchedule int

const (
	First WeekSchedule = iota
	Second
	Third
	Fourth
	Teenth
	Last
)

func Day(wSched WeekSchedule, wDay time.Weekday, month time.Month, year int) int {
	if wSched == Teenth {
		start := 13
		weekday := time.Date(year, month, start, 0, 0, 0, 0, time.UTC).Weekday()
		return start + int((wDay-weekday+7)%7)
	}
	if wSched == Last {
		last := time.Date(year, month+1, 0, 0, 0, 0, 0, time.UTC)
		return last.Day() - int((last.Weekday()-wDay+7)%7)
	}

	first := time.Date(year, month, 1, 0, 0, 0, 0, time.UTC)
	offset := int((wDay - first.Weekday() + 7) % 7)
	return 1 + offset + 7*int(wSched)
}
