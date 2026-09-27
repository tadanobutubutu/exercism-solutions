package jedlik

import "fmt"

func (c *Car) Drive() {
	if c.battery >= c.batteryDrain {
		c.distance += c.speed
		c.battery -= c.batteryDrain
	}
}

func (c Car) DisplayDistance() string {
	return fmt.Sprintf("Driven %d meters", c.distance)
}

func (c Car) DisplayBattery() string {
	return fmt.Sprintf("Battery at %d%%", c.battery)
}

func (c Car) CanFinish(trackDistance int) bool {
	if trackDistance <= 0 {
		return true
	}
	if c.speed <= 0 {
		return false
	}
	requiredDrives := 1 + (trackDistance-1)/c.speed
	if c.batteryDrain <= 0 {
		return true
	}
	return c.battery/c.batteryDrain >= requiredDrives
}
