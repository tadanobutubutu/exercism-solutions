//
// This is only a SKELETON file for the 'React' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class InputCell {
  constructor(value) {
    this.value = value;
    this._dependents = new Set();
  }

  setValue(value) {
    if (Object.is(value, this.value)) return;
    this.value = value;
    const affected = new Set();
    const collect = (cell) => {
      for (const dependent of cell._dependents) {
        if (!affected.has(dependent)) {
          affected.add(dependent);
          collect(dependent);
        }
      }
    };
    collect(this);

    const ordered = [];
    const visited = new Set();
    const visit = (cell) => {
      if (visited.has(cell)) return;
      visited.add(cell);
      for (const input of cell._inputs) {
        if (affected.has(input)) visit(input);
      }
      ordered.push(cell);
    };
    for (const cell of affected) visit(cell);

    const changed = [];
    for (const cell of ordered) {
      const previous = cell._value;
      cell._value = cell._fn(cell._inputs);
      if (!Object.is(previous, cell._value)) changed.push(cell);
    }
    for (const cell of changed) cell._notify();
  }
}

export class ComputeCell {
  constructor(inputCells, fn) {
    this._inputs = [...inputCells];
    this._fn = fn;
    this._callbacks = new Set();
    this._dependents = new Set();
    this._value = this._fn(this._inputs);
    for (const input of this._inputs) input._dependents.add(this);
  }

  get value() {
    return this._value;
  }

  addCallback(cb) {
    this._callbacks.add(cb);
  }

  removeCallback(cb) {
    this._callbacks.delete(cb);
  }

  _notify() {
    for (const callback of this._callbacks) {
      if (typeof callback === 'function') callback(this);
      else callback._notify(this);
    }
  }
}

export class CallbackCell {
  constructor(fn) {
    this._fn = fn;
    this.values = [];
  }

  _notify(cell) {
    this.values.push(this._fn(cell));
  }
}
