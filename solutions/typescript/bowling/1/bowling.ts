export class Bowling {
  private readonly rolls: number[] = []
  private frame = 0
  private firstRoll: number | undefined
  private tenthStart: number | undefined

  private advanceFrame(): void {
    this.frame++
    if (this.frame === 9) this.tenthStart = this.rolls.length
  }

  public roll(pins: unknown): void {
    if (this.frame >= 10) throw new Error('Cannot roll after game is over')
    if (typeof pins !== 'number' || !Number.isInteger(pins) || pins < 0) {
      throw new Error('Negative roll is invalid')
    }
    if (pins > 10) throw new Error('Pin count exceeds pins on the lane')

    if (this.frame < 9) {
      if (this.firstRoll === undefined) {
        this.rolls.push(pins)
        if (pins === 10) this.advanceFrame()
        else this.firstRoll = pins
      } else {
        if (this.firstRoll + pins > 10) {
          throw new Error('Pin count exceeds pins on the lane')
        }
        this.rolls.push(pins)
        this.firstRoll = undefined
        this.advanceFrame()
      }
      return
    }

    const tenth = this.rolls.slice(this.tenthStart ?? 18)
    if (tenth.length === 0) {
      this.rolls.push(pins)
      return
    }
    if (tenth.length === 1) {
      const first = tenth[0]!
      if (first < 10 && first + pins > 10) {
        throw new Error('Pin count exceeds pins on the lane')
      }
      this.rolls.push(pins)
      if (first < 10 && first + pins < 10) this.frame++
      return
    }

    const first = tenth[0]!
    const second = tenth[1]!
    if (first === 10 && second < 10 && second + pins > 10) {
      throw new Error('Pin count exceeds pins on the lane')
    }
    this.rolls.push(pins)
    this.frame++
  }

  public score(): number {
    if (this.frame < 10) {
      throw new Error('Score cannot be taken until the end of the game')
    }

    let total = 0
    let roll = 0
    for (let frame = 0; frame < 10; frame++) {
      if (this.rolls[roll] === 10) {
        total += 10 + this.rolls[roll + 1]! + this.rolls[roll + 2]!
        roll++
      } else if (this.rolls[roll]! + this.rolls[roll + 1]! === 10) {
        total += 10 + this.rolls[roll + 2]!
        roll += 2
      } else {
        total += this.rolls[roll]! + this.rolls[roll + 1]!
        roll += 2
      }
    }
    return total
  }
}
