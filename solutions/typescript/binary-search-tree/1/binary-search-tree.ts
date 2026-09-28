export class BinarySearchTree {
  private readonly value: number
  private leftNode: BinarySearchTree | undefined
  private rightNode: BinarySearchTree | undefined

  constructor(data: unknown) {
    if (typeof data !== 'number') throw new Error('Tree values must be numbers')
    this.value = data
  }

  public get data(): number {
    return this.value
  }

  public get right(): BinarySearchTree | undefined {
    return this.rightNode
  }

  public get left(): BinarySearchTree | undefined {
    return this.leftNode
  }

  public insert(item: unknown): void {
    if (typeof item !== 'number') throw new Error('Tree values must be numbers')
    if (item <= this.value) {
      if (this.leftNode) this.leftNode.insert(item)
      else this.leftNode = new BinarySearchTree(item)
    } else if (this.rightNode) {
      this.rightNode.insert(item)
    } else {
      this.rightNode = new BinarySearchTree(item)
    }
  }

  public each(callback: (data: unknown) => unknown): void {
    this.leftNode?.each(callback)
    callback(this.value)
    this.rightNode?.each(callback)
  }
}
