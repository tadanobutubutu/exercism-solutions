export class Series {
  constructor(series) {
    this.series = series;
  }

  slices(sliceLength) {
    if (this.series.length === 0) throw new Error('series cannot be empty');
    if (sliceLength < 0) throw new Error('slice length cannot be negative');
    if (sliceLength === 0) throw new Error('slice length cannot be zero');
    if (sliceLength > this.series.length) {
      throw new Error('slice length cannot be greater than series length');
    }

    const digits = Array.from(this.series, Number);
    return Array.from(
      { length: digits.length - sliceLength + 1 },
      (_, start) => digits.slice(start, start + sliceLength),
    );
  }
}
