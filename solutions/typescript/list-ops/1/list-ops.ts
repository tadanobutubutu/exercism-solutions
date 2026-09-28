export class List<T = unknown> {
  private constructor(private readonly values: T[]) {}

  public static create<T>(...values: T[]): List<T> {
    return new List(values)
  }

  public append(other: List<T>): List<T> {
    return List.create(...this.values, ...other.values)
  }

  public concatenate<U>(lists: List<List<U>>): List<T | U> {
    let result: List<T | U> = List.create(...this.values)
    for (let index = 0; index < lists.values.length; index++) {
      const list = lists.values[index]
      if (list !== undefined) result = result.append(list)
    }
    return result
  }

  public filter(predicate: (item: T) => boolean): List<T> {
    let result = List.create<T>()
    for (let index = 0; index < this.values.length; index++) {
      const item = this.values[index]
      if (item !== undefined && predicate(item)) {
        result = List.create(...result.values, item)
      }
    }
    return result
  }

  public length(): number {
    let count = 0
    for (const _item of this.values) count++
    return count
  }

  public map<U>(transform: (item: T) => U): List<U> {
    let result = List.create<U>()
    for (let index = 0; index < this.values.length; index++) {
      const item = this.values[index]
      if (item !== undefined) result = List.create(...result.values, transform(item))
    }
    return result
  }

  public foldl<U>(combine: (accumulator: U, item: T) => U, initial: U): U {
    let accumulator = initial
    for (let index = 0; index < this.values.length; index++) {
      const item = this.values[index]
      if (item !== undefined) accumulator = combine(accumulator, item)
    }
    return accumulator
  }

  public foldr<U>(combine: (accumulator: U, item: T) => U, initial: U): U {
    let accumulator = initial
    for (let index = this.values.length - 1; index >= 0; index--) {
      const item = this.values[index]
      if (item !== undefined) accumulator = combine(accumulator, item)
    }
    return accumulator
  }

  public reverse(): List<T> {
    let result = List.create<T>()
    for (let index = 0; index < this.values.length; index++) {
      const item = this.values[index]
      if (item !== undefined) result = List.create(item, ...result.values)
    }
    return result
  }

  public forEach(callback: (item: T) => void): void {
    for (let index = 0; index < this.values.length; index++) {
      const item = this.values[index]
      if (item !== undefined) callback(item)
    }
  }
}
