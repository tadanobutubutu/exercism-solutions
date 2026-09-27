package ledger

import (
	"errors"
	"fmt"
	"sort"
	"strconv"
	"strings"
	"time"
)

type Entry struct {
	Date        string // YYYY-MM-DD
	Description string
	Change      int // cents
}

func FormatLedger(currency, locale string, entries []Entry) (string, error) {
	symbol := ""
	switch currency {
	case "USD":
		symbol = "$"
	case "EUR":
		symbol = "€"
	default:
		return "", errors.New("invalid currency")
	}

	var header []string
	var formatDate func(string) string
	switch locale {
	case "en-US":
		header = []string{"Date", "Description", "Change"}
		formatDate = func(date string) string {
			return date[5:7] + "/" + date[8:10] + "/" + date[:4]
		}
	case "nl-NL":
		header = []string{"Datum", "Omschrijving", "Verandering"}
		formatDate = func(date string) string {
			return date[8:10] + "-" + date[5:7] + "-" + date[:4]
		}
	default:
		return "", errors.New("invalid locale")
	}

	ordered := append([]Entry(nil), entries...)
	for _, entry := range ordered {
		if _, err := time.Parse("2006-01-02", entry.Date); err != nil || len(entry.Date) != 10 {
			return "", errors.New("invalid date")
		}
	}
	sort.Slice(ordered, func(i, j int) bool {
		if ordered[i].Date != ordered[j].Date {
			return ordered[i].Date < ordered[j].Date
		}
		if ordered[i].Description != ordered[j].Description {
			return ordered[i].Description < ordered[j].Description
		}
		return ordered[i].Change < ordered[j].Change
	})

	var output strings.Builder
	fmt.Fprintf(&output, "%-10s | %-25s | %-13s\n", header[0], header[1], header[2])
	for _, entry := range ordered {
		description := truncate(entry.Description, 25)
		amount := formatAmount(entry.Change, symbol, locale)
		fmt.Fprintf(&output, "%-10s | %-25s | %13s\n", formatDate(entry.Date), description, amount)
	}
	return output.String(), nil
}

func truncate(value string, width int) string {
	runes := []rune(value)
	if len(runes) > width {
		runes = append(runes[:width-3], '.', '.', '.')
	}
	return string(runes)
}

func formatAmount(change int, symbol, locale string) string {
	negative := change < 0
	var amount uint64
	if negative {
		amount = uint64(-(int64(change) + 1)) + 1
	} else {
		amount = uint64(change)
	}
	whole, cents := amount/100, amount%100
	wholeText := groupThousands(strconv.FormatUint(whole, 10), locale)
	decimal := fmt.Sprintf("%02d", cents)

	if locale == "nl-NL" {
		if negative {
			return fmt.Sprintf("%s -%s,%s ", symbol, wholeText, decimal)
		}
		return fmt.Sprintf("%s %s,%s ", symbol, wholeText, decimal)
	}
	if negative {
		return fmt.Sprintf("(%s%s.%s)", symbol, wholeText, decimal)
	}
	return fmt.Sprintf("%s%s.%s ", symbol, wholeText, decimal)
}

func groupThousands(value, locale string) string {
	separator := ","
	if locale == "nl-NL" {
		separator = "."
	}
	if len(value) <= 3 {
		return value
	}
	first := len(value) % 3
	if first == 0 {
		first = 3
	}
	var grouped strings.Builder
	grouped.WriteString(value[:first])
	for i := first; i < len(value); i += 3 {
		grouped.WriteString(separator)
		grouped.WriteString(value[i : i+3])
	}
	return grouped.String()
}
