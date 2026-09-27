package prism

import (
	"math"
)

const geometryEpsilon = 1e-7

type Position struct {
	x     float64
	y     float64
	angle float64
}

type Prism struct {
	id    int
	x     float64
	y     float64
	angle float64
}

type rayState struct {
	prism int
	angle int64
}

// FindSequence returns the IDs of prisms encountered by the refracted ray.
func FindSequence(start Position, prisms []Prism) []int {
	sequence := make([]int, 0, len(prisms))
	position := start
	position.angle = normalize(position.angle)
	seen := make(map[rayState]bool)

	for {
		radians := position.angle * math.Pi / 180
		dx, dy := math.Cos(radians), math.Sin(radians)
		closest, distance := -1, math.Inf(1)

		for i, prism := range prisms {
			offsetX := prism.x - position.x
			offsetY := prism.y - position.y
			along := offsetX*dx + offsetY*dy
			if along <= geometryEpsilon {
				continue
			}

			cross := offsetX*dy - offsetY*dx
			tolerance := geometryEpsilon * (1 + math.Hypot(offsetX, offsetY))
			if math.Abs(cross) > tolerance || along >= distance {
				continue
			}
			closest, distance = i, along
		}
		if closest < 0 {
			return sequence
		}

		state := rayState{prism: closest, angle: int64(math.Round(position.angle * 1e8))}
		if seen[state] {
			return sequence
		}
		seen[state] = true

		prism := prisms[closest]
		sequence = append(sequence, prism.id)
		position.x, position.y = prism.x, prism.y
		position.angle = normalize(position.angle + prism.angle)
	}
}

func normalize(angle float64) float64 {
	angle = math.Mod(angle, 360)
	if angle < 0 {
		angle += 360
	}
	return angle
}
