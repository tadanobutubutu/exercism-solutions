// Package leap determines which years are leap years.
package leap

// IsLeapYear reports whether year follows the Gregorian leap-year rules.
func IsLeapYear(year int) bool {
	return year%400 == 0 || (year%4 == 0 && year%100 != 0)
}
