export class List {
  private readonly values: number[]

  constructor(...values: number[]) {
    this.values = values
  }

  private contains(needle: number[]): boolean {
    if (needle.length === 0) return true
    for (let start = 0; start <= this.values.length - needle.length; start++) {
      let matches = true
      for (let offset = 0; offset < needle.length; offset++) {
        if (this.values[start + offset] !== needle[offset]) {
          matches = false
          break
        }
      }
      if (matches) return true
    }
    return false
  }

  compare(other: List): 'equal' | 'sublist' | 'superlist' | 'unequal' {
    if (this.values.length === other.values.length && this.contains(other.values)) return 'equal'
    if (this.values.length > other.values.length && this.contains(other.values)) return 'superlist'
    if (this.values.length < other.values.length && other.contains(this.values)) return 'sublist'
    return 'unequal'
  }
}
