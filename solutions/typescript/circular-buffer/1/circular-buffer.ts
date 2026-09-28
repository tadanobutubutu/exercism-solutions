export default class CircularBuffer<T> {
  private readonly values: (T | undefined)[]
  private readIndex = 0
  private writeIndex = 0
  private size = 0

  constructor(initial: number) {
    if (!Number.isInteger(initial) || initial <= 0) throw new Error('Buffer size must be positive')
    this.values = Array<T | undefined>(initial).fill(undefined)
  }

  write(value: T): void {
    if (this.size === this.values.length) throw new BufferFullError()
    this.values[this.writeIndex] = value
    this.writeIndex = (this.writeIndex + 1) % this.values.length
    this.size++
  }

  read(): T {
    if (this.size === 0) throw new BufferEmptyError()
    const value = this.values[this.readIndex] as T
    this.values[this.readIndex] = undefined
    this.readIndex = (this.readIndex + 1) % this.values.length
    this.size--
    return value
  }

  forceWrite(value: T): void {
    if (this.size < this.values.length) {
      this.write(value)
      return
    }
    this.values[this.writeIndex] = value
    this.writeIndex = (this.writeIndex + 1) % this.values.length
    this.readIndex = this.writeIndex
  }

  clear(): void {
    this.values.fill(undefined)
    this.readIndex = 0
    this.writeIndex = 0
    this.size = 0
  }
}

export class BufferFullError extends Error {
  constructor() {
    super('Buffer is full')
    this.name = 'BufferFullError'
  }
}

export class BufferEmptyError extends Error {
  constructor() {
    super('Buffer is empty')
    this.name = 'BufferEmptyError'
  }
}
