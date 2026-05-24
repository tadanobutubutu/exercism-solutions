export class Forth {
  constructor() {
    this._stack = [];
    this._words = {};
  }

  evaluate(input) {
    const tokens = input.toLowerCase().split(/\s+/);
    let i = 0;
    while (i < tokens.length) {
      const token = tokens[i];
      if (token === ':') {
        i++;
        const name = tokens[i];
        i++;
        if (/^-?\d+$/.test(name)) throw new Error('Invalid definition');
        const defTokens = [];
        while (i < tokens.length && tokens[i] !== ';') {
          defTokens.push(tokens[i]);
          i++;
        }
        this._words[name] = this._expandDef(defTokens);
        i++;
      } else {
        this._exec(token);
        i++;
      }
    }
  }

  _expandDef(tokens) {
    const result = [];
    for (const token of tokens) {
      if (this._words[token]) {
        result.push(...this._expandDef(this._words[token]));
      } else {
        result.push(token);
      }
    }
    return result;
  }

  _exec(token) {
    if (/^-?\d+$/.test(token)) {
      this._stack.push(parseInt(token, 10));
      return;
    }
    if (this._words[token]) {
      for (const t of this._words[token]) {
        this._exec(t);
      }
      return;
    }
    switch (token) {
      case '+':
        this._binaryOp((a, b) => a + b);
        break;
      case '-':
        this._binaryOp((a, b) => a - b);
        break;
      case '*':
        this._binaryOp((a, b) => a * b);
        break;
      case '/':
        this._checkStack(2);
        {
          const divisor = this._stack.pop();
          const dividend = this._stack.pop();
          if (divisor === 0) throw new Error('Division by zero');
          this._stack.push(Math.trunc(dividend / divisor));
        }
        break;
      case 'dup':
        this._checkStack(1);
        this._stack.push(this._stack[this._stack.length - 1]);
        break;
      case 'drop':
        this._checkStack(1);
        this._stack.pop();
        break;
      case 'swap':
        this._checkStack(2);
        {
          const a = this._stack.pop();
          const b = this._stack.pop();
          this._stack.push(a, b);
        }
        break;
      case 'over':
        this._checkStack(2);
        this._stack.push(this._stack[this._stack.length - 2]);
        break;
      default:
        throw new Error('Unknown command');
    }
  }

  _checkStack(required) {
    if (this._stack.length === 0) throw new Error('Stack empty');
    if (this._stack.length < required) throw new Error('Only one value on the stack');
  }

  _binaryOp(op) {
    this._checkStack(2);
    const b = this._stack.pop();
    const a = this._stack.pop();
    this._stack.push(op(a, b));
  }

  get stack() {
    return this._stack;
  }
}
