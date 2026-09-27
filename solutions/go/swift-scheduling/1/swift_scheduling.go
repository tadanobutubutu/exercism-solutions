package swiftscheduling

import (
	"strconv"
	"strings"
	"time"
)

func DeliveryDate(start, delivery string) string {
	meeting, err := time.Parse("2006-01-02T15:04:05", start)
	if err != nil {
		return ""
	}
	var due time.Time
	switch delivery {
	case "NOW":
		due = meeting.Add(2 * time.Hour)
	case "ASAP":
		if meeting.Hour() < 13 {
			due = atTime(meeting, 17)
		} else {
			due = atTime(meeting.AddDate(0, 0, 1), 13)
		}
	case "EOW":
		weekday := int(meeting.Weekday())
		if weekday == 0 {
			due = atTime(meeting, 20)
		} else if weekday <= int(time.Wednesday) {
			days := int(time.Friday) - weekday
			due = atTime(meeting.AddDate(0, 0, days), 17)
		} else {
			days := 7 - weekday
			due = atTime(meeting.AddDate(0, 0, days), 20)
		}
	default:
		if strings.HasSuffix(delivery, "M") {
			month, parseErr := strconv.Atoi(strings.TrimSuffix(delivery, "M"))
			if parseErr != nil || month < 1 || month > 12 {
				return ""
			}
			year := meeting.Year()
			if meeting.Month() >= time.Month(month) {
				year++
			}
			due = time.Date(year, time.Month(month), 1, 8, 0, 0, 0, meeting.Location())
			for due.Weekday() == time.Saturday || due.Weekday() == time.Sunday {
				due = due.AddDate(0, 0, 1)
			}
		} else if strings.HasPrefix(delivery, "Q") {
			quarter, parseErr := strconv.Atoi(strings.TrimPrefix(delivery, "Q"))
			if parseErr != nil || quarter < 1 || quarter > 4 {
				return ""
			}
			lastMonth := time.Month(quarter * 3)
			year := meeting.Year()
			if meeting.Month() > lastMonth {
				year++
			}
			firstNextQuarter := time.Date(year, lastMonth+1, 1, 8, 0, 0, 0, meeting.Location())
			due = firstNextQuarter.AddDate(0, 0, -1)
			for due.Weekday() == time.Saturday || due.Weekday() == time.Sunday {
				due = due.AddDate(0, 0, -1)
			}
		} else {
			return ""
		}
	}
	return due.Format("2006-01-02T15:04:05")
}

func atTime(date time.Time, hour int) time.Time {
	return time.Date(date.Year(), date.Month(), date.Day(), hour, 0, 0, 0, date.Location())
}
