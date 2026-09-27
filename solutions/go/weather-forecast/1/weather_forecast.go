// Package weather stores and reports simple weather forecast information.
package weather

var (
	// CurrentCondition is the latest reported weather condition.
	CurrentCondition string
	// CurrentLocation is the city for the latest forecast.
	CurrentLocation string
)

// Forecast records and returns the current weather for a city.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
