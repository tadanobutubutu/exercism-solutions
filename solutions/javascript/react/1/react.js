export class InputCell {
  constructor(value) {
    this._value = value;
    this._dependents = [];
  }

  get value() {
    return this._value;
  }

  setValue(value) {
    if (this._value !== value) {
      this._value = value;
      const affected = [];
      const visited = new Set();
      this._collect(affected, visited);
      for (let i = affected.length - 1; i >= 0; i--) {
        affected[i]._recompute();
      }
    }
  }

  _collect(affected, visited) {
    for (const dep of this._dependents) {
      if (!visited.has(dep)) {
        visited.add(dep);
        dep._collect(affected, visited);
        affected.push(dep);
      }
    }
  }

  _addDependent(cell) {
    this._dependents.push(cell);
  }
}

export class ComputeCell {
  constructor(inputCells, fn) {
    this._inputs = inputCells;
    this._fn = fn;
    this._callbacks = [];
    this._dependents = [];
    this._value = this._compute();
    for (const cell of inputCells) {
      cell._addDependent(this);
    }
  }

  get value() {
    return this._value;
  }

  _compute() {
    return this._fn(this._inputs);
  }

  _recompute() {
    const newValue = this._compute();
    if (this._value !== newValue) {
      this._value = newValue;
      for (const cb of this._callbacks) {
        cb._fire(this);
      }
    }
  }

  _collect(affected, visited) {
    for (const dep of this._dependents) {
      if (!visited.has(dep)) {
        visited.add(dep);
        dep._collect(affected, visited);
        affected.push(dep);
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
    this._values = [];
  }

  get values() {
    return this._values;
  }

  _fire(cell) {
    this._values.push(this._fn(cell));
  }
}
