export class Bowling {
  constructor() {
    this.rolls = [];
    this._frame = 1;
    this._ball = 1;
    this._framePins = 0;
    this._done = false;
  }

  roll(pins) {
    if (this._done) throw new Error('Cannot roll after game is over');
    if (pins < 0) throw new Error('Negative roll is invalid');
    if (pins > 10) throw new Error('Pin count exceeds pins on the lane');

    const frame = this._frame;
    const ball = this._ball;

    if (frame < 10) {
      if (ball === 1) {
        if (pins === 10) {
          this._frame++;
        } else {
          this._framePins = pins;
          this._ball = 2;
        }
      } else {
        if (this._framePins + pins > 10) {
          throw new Error('Pin count exceeds pins on the lane');
        }
        this._frame++;
        this._ball = 1;
        this._framePins = 0;
      }
    } else {
      if (ball === 1) {
        if (pins === 10) {
          this._ball = 2;
          this._framePins = 10;
        } else {
          this._framePins = pins;
          this._ball = 2;
        }
      } else if (ball === 2) {
        if (this._framePins === 10) {
          this._ball = 3;
          this._framePins = pins;
        } else {
          if (this._framePins + pins > 10) {
            throw new Error('Pin count exceeds pins on the lane');
          }
          if (this._framePins + pins === 10) {
            this._ball = 3;
            this._framePins = 0;
          } else {
            this._done = true;
          }
        }
      } else {
        if (this._framePins !== 10 && this._framePins + pins > 10) {
          throw new Error('Pin count exceeds pins on the lane');
        }
        this._done = true;
      }
    }

    this.rolls.push(pins);
  }

  score() {
    if (!this._done) {
      throw new Error('Score cannot be taken until the end of the game');
    }

    let score = 0;
    let i = 0;

    for (let frame = 0; frame < 10; frame++) {
      if (this.rolls[i] === 10) {
        score += 10 + this.rolls[i + 1] + this.rolls[i + 2];
        i++;
      } else if (this.rolls[i] + this.rolls[i + 1] === 10) {
        score += 10 + this.rolls[i + 2];
        i += 2;
      } else {
        score += this.rolls[i] + this.rolls[i + 1];
        i += 2;
      }
    }

    return score;
  }
}
