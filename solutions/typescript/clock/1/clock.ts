export class Clock {
  private readonly minutesAfterMidnight: number

  constructor(hour: number, minute = 0) {
    const minutesInDay = 24 * 60
    const totalMinutes = hour * 60 + minute
    this.minutesAfterMidnight = ((totalMinutes % minutesInDay) + minutesInDay) % minutesInDay
  }

  public toString(): string {
    const hours = Math.floor(this.minutesAfterMidnight / 60)
    const minutes = this.minutesAfterMidnight % 60
    return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}`
  }

  public plus(minutes: number): Clock {
    return new Clock(0, this.minutesAfterMidnight + minutes)
  }

  public minus(minutes: number): Clock {
    return new Clock(0, this.minutesAfterMidnight - minutes)
  }

  public equals(other: unknown): boolean {
    return (
      other instanceof Clock &&
      this.minutesAfterMidnight === other.minutesAfterMidnight
    )
  }
}
