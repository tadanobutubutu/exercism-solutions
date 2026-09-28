export class CustomSet {
  private readonly elements: Set<unknown>

  constructor(initial?: unknown) {
    this.elements = new Set(Array.isArray(initial) ? initial : [])
  }

  empty(): boolean {
    return this.elements.size === 0
  }

  contains(element: unknown): boolean {
    return this.elements.has(element)
  }

  add(element: unknown): CustomSet {
    return new CustomSet([...this.elements, element])
  }

  subset(other: unknown): boolean {
    if (!(other instanceof CustomSet)) return false
    for (const element of this.elements) {
      if (!other.elements.has(element)) return false
    }
    return true
  }

  disjoint(other: unknown): boolean {
    if (!(other instanceof CustomSet)) return true
    for (const element of this.elements) {
      if (other.elements.has(element)) return false
    }
    return true
  }

  eql(other: unknown): boolean {
    return other instanceof CustomSet && this.elements.size === other.elements.size && this.subset(other)
  }

  union(other: unknown): CustomSet {
    if (!(other instanceof CustomSet)) return new CustomSet([...this.elements])
    return new CustomSet([...this.elements, ...other.elements])
  }

  intersection(other: unknown): CustomSet {
    if (!(other instanceof CustomSet)) return new CustomSet()
    const shared: unknown[] = []
    for (const element of this.elements) {
      if (other.elements.has(element)) shared.push(element)
    }
    return new CustomSet(shared)
  }

  difference(other: unknown): CustomSet {
    const remaining: unknown[] = []
    for (const element of this.elements) {
      if (!(other instanceof CustomSet) || !other.elements.has(element)) remaining.push(element)
    }
    return new CustomSet(remaining)
  }
}
