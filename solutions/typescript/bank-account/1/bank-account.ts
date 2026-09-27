export class ValueError extends Error {
  constructor() {
    super('Bank account error')
    this.name = 'ValueError'
  }
}

export class BankAccount {
  private opened = false
  private amount = 0

  open(): void {
    if (this.opened) throw new ValueError()
    this.opened = true
    this.amount = 0
  }

  close(): void {
    this.ensureOpen()
    this.opened = false
    this.amount = 0
  }

  deposit(amount: unknown): void {
    this.ensureOpen()
    if (typeof amount !== 'number' || !Number.isFinite(amount) || amount < 0) {
      throw new ValueError()
    }
    this.amount += amount
  }

  withdraw(amount: unknown): void {
    this.ensureOpen()
    if (
      typeof amount !== 'number' ||
      !Number.isFinite(amount) ||
      amount < 0 ||
      amount > this.amount
    ) {
      throw new ValueError()
    }
    this.amount -= amount
  }

  get balance(): number {
    this.ensureOpen()
    return this.amount
  }

  private ensureOpen(): void {
    if (!this.opened) throw new ValueError()
  }
}
