type StopwatchState = 'ready' | 'running' | 'stopped'

export class SplitSecondStopwatch {
  private stateValue: StopwatchState = 'ready'
  private currentSeconds = 0
  private readonly laps: number[] = []

  public get state(): StopwatchState {
    return this.stateValue
  }

  public get currentLap(): string {
    return this.format(this.currentSeconds)
  }

  public get total(): string {
    const completedSeconds = this.laps.reduce((sum, lap) => sum + lap, 0)
    return this.format(completedSeconds + this.currentSeconds)
  }

  public get previousLaps(): string[] {
    return this.laps.map((lap) => this.format(lap))
  }

  public start(): void {
    if (this.stateValue === 'running') {
      throw new Error('cannot start an already running stopwatch')
    }
    this.stateValue = 'running'
  }

  public stop(): void {
    if (this.stateValue !== 'running') {
      throw new Error('cannot stop a stopwatch that is not running')
    }
    this.stateValue = 'stopped'
  }

  public lap(): void {
    if (this.stateValue !== 'running') {
      throw new Error('cannot lap a stopwatch that is not running')
    }
    this.laps.push(this.currentSeconds)
    this.currentSeconds = 0
  }

  public reset(): void {
    if (this.stateValue !== 'stopped') {
      throw new Error('cannot reset a stopwatch that is not stopped')
    }
    this.currentSeconds = 0
    this.laps.length = 0
    this.stateValue = 'ready'
  }

  public advanceTime(duration: unknown): void {
    if (this.stateValue !== 'running') return
    if (typeof duration !== 'string') throw new Error('invalid duration')

    const match = duration.match(/^(\d+):([0-5]\d):([0-5]\d)$/)
    if (!match) throw new Error('invalid duration')

    const [, hours, minutes, seconds] = match
    this.currentSeconds += Number(hours) * 3600 + Number(minutes) * 60 + Number(seconds)
  }

  private format(seconds: number): string {
    const hours = Math.floor(seconds / 3600)
    const minutes = Math.floor((seconds % 3600) / 60)
    const remainder = seconds % 60
    return [hours, minutes, remainder]
      .map((value) => String(value).padStart(2, '0'))
      .join(':')
  }
}
