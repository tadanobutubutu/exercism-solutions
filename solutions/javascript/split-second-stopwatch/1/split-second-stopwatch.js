export class SplitSecondStopwatch {
  constructor() {
    this._state = 'ready';
    this._currentLap = 0;
    this._total = 0;
    this._previousLaps = [];
  }

  get state() {
    return this._state;
  }

  get currentLap() {
    return this.format(this._currentLap);
  }

  get total() {
    return this.format(this._total);
  }

  get previousLaps() {
    return [...this._previousLaps];
  }

  start() {
    if (this._state === 'running') {
      throw new Error('cannot start an already running stopwatch');
    }
    this._state = 'running';
  }

  stop() {
    if (this._state !== 'running') {
      throw new Error('cannot stop a stopwatch that is not running');
    }
    this._state = 'stopped';
  }

  lap() {
    if (this._state !== 'running') {
      throw new Error('cannot lap a stopwatch that is not running');
    }
    this._previousLaps.push(this.format(this._currentLap));
    this._currentLap = 0;
  }

  reset() {
    if (this._state !== 'stopped') {
      throw new Error('cannot reset a stopwatch that is not stopped');
    }
    this._state = 'ready';
    this._currentLap = 0;
    this._total = 0;
    this._previousLaps = [];
  }

  advanceTime(duration) {
    if (this._state !== 'running') return;
    const seconds = duration.split(':').reduce((total, part) => total * 60 + Number(part), 0);
    this._currentLap += seconds;
    this._total += seconds;
  }

  format(seconds) {
    const hours = Math.floor(seconds / 3600);
    const minutes = Math.floor((seconds % 3600) / 60);
    const remainingSeconds = seconds % 60;
    return [hours, minutes, remainingSeconds]
      .map((value) => String(value).padStart(2, '0'))
      .join(':');
  }
}
