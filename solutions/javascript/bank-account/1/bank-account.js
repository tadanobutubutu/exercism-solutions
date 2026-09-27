//
// This is only a SKELETON file for the 'Bank Account' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class BankAccount {
  constructor() {
    this._isOpen = false;
    this._balance = 0;
  }

  open() {
    if (this._isOpen) throw new ValueError();
    this._isOpen = true;
    this._balance = 0;
  }

  close() {
    this.#requireOpen();
    this._isOpen = false;
    this._balance = 0;
  }

  deposit(amount) {
    this.#requireOpen();
    if (amount < 0) throw new ValueError();
    this._balance += amount;
  }

  withdraw(amount) {
    this.#requireOpen();
    if (amount < 0 || amount > this._balance) throw new ValueError();
    this._balance -= amount;
  }

  get balance() {
    this.#requireOpen();
    return this._balance;
  }

  #requireOpen() {
    if (!this._isOpen) throw new ValueError();
  }
}

export class ValueError extends Error {
  constructor() {
    super('Bank account error');
  }
}
