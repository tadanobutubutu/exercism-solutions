type Direction = 'north' | 'east' | 'south' | 'west'
type Coordinates = [number, number]

const directions: Direction[] = ['north', 'east', 'south', 'west']

export class InvalidInputError extends Error {
  constructor(message: string) {
    super(message || 'Invalid Input')
    this.name = 'InvalidInputError'
  }
}

export class Robot {
  private x = 0
  private y = 0
  private currentBearing: Direction = 'north'

  get bearing(): Direction {
    return this.currentBearing
  }

  get coordinates(): Coordinates {
    return [this.x, this.y]
  }

  place({ x, y, direction }: { x: number; y: number; direction: string }): void {
    if (!directions.includes(direction as Direction)) throw new InvalidInputError('Invalid bearing')
    this.x = x
    this.y = y
    this.currentBearing = direction as Direction
  }

  evaluate(instructions: string): void {
    for (const instruction of instructions) {
      if (instruction === 'R') {
        const index = directions.indexOf(this.currentBearing)
        this.currentBearing = directions[(index + 1) % directions.length]!
      } else if (instruction === 'L') {
        const index = directions.indexOf(this.currentBearing)
        this.currentBearing = directions[(index + directions.length - 1) % directions.length]!
      } else if (instruction === 'A') {
        if (this.currentBearing === 'north') this.y++
        else if (this.currentBearing === 'south') this.y--
        else if (this.currentBearing === 'east') this.x++
        else this.x--
      } else {
        throw new InvalidInputError('Invalid instruction')
      }
    }
  }
}
