export class Gigasecond {
  private readonly startDate: Date

  constructor(startDate: Date) {
    this.startDate = new Date(startDate.getTime())
  }

  public date(): Date {
    return new Date(this.startDate.getTime() + 1_000_000_000 * 1_000)
  }
}
