export class InputCell {
  constructor(value) {
    this._value = value;
    this._dependents = [];
    this._level = 0;
  }

  get value() {
    return this._value;
  }

  setValue(value) {
    this._value = value;
    const affected = new Set();
    const stack = [...this._dependents];
    while (stack.length > 0) {
      const cell = stack.pop();
      if (!affected.has(cell)) {
        affected.add(cell);
        stack.push(...cell._dependents);
      }
    }
    const byLevel = [];
    for (const cell of affected) {
      if (!byLevel[cell._level]) byLevel[cell._level] = [];
      byLevel[cell._level].push(cell);
    }
    for (let level = 1; level < byLevel.length; level++) {
      if (byLevel[level]) {
        for (const cell of byLevel[level]) {
          cell._recompute();
        }
      }
    }
  }

  _addDependent(cell) {
    this._dependents.push(cell);
  }
}

export class ComputeCell {
  constructor(inputCells, fn) {
    this._inputCells = inputCells;
    this._fn = fn;
    this._callbacks = [];
    this._dependents = [];
    let maxLevel = 0;
    for (const cell of inputCells) {
      cell._addDependent(this);
      maxLevel = Math.max(maxLevel, cell._level);
    }
    this._level = maxLevel + 1;
    this._value = this._fn(this._inputCells);
  }

  get value() {
    return this._value;
  }

  _recompute() {
    const newValue = this._fn(this._inputCells);
    if (newValue !== this._value) {
      this._value = newValue;
      for (const cb of this._callbacks) {
        cb.values.push(cb._fn(this));
      }
    }
  }

  _addDependent(cell) {
    this._dependents.push(cell);
  }

  addCallback(cb) {
    this._callbacks.push(cb);
  }

  removeCallback(cb) {
    const idx = this._callbacks.indexOf(cb);
    if (idx !== -1) {
      this._callbacks.splice(idx, 1);
    }
  }
}

export class CallbackCell {
  constructor(fn) {
    this._fn = fn;
    this.values = [];
  }
}
