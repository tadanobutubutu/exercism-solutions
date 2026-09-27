//
// This is only a SKELETON file for the 'Clock' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Clock {
  constructor(hours = 0, minutes = 0) {
    this.minuteOfDay = ((hours * 60 + minutes) % 1440 + 1440) % 1440;
  }

  toString() {
    const hours = Math.floor(this.minuteOfDay / 60);
    const minutes = this.minuteOfDay % 60;
    return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}`;
  }

  plus(minutes) {
    return new Clock(0, this.minuteOfDay + minutes);
  }

  minus(minutes) {
    return new Clock(0, this.minuteOfDay - minutes);
  }

  equals(other) {
    return other instanceof Clock && this.minuteOfDay === other.minuteOfDay;
  }
}
