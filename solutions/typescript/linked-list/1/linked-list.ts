class Node<T> {
  public previous: Node<T> | undefined
  public next: Node<T> | undefined

  constructor(public value: T) {}
}

export class LinkedList<TElement> {
  private head: Node<TElement> | undefined
  private tail: Node<TElement> | undefined
  private size = 0

  public push(element: TElement): void {
    const node = new Node(element)
    if (this.tail) {
      node.previous = this.tail
      this.tail.next = node
    } else {
      this.head = node
    }
    this.tail = node
    this.size++
  }

  public pop(): TElement | undefined {
    if (!this.tail) return undefined
    const node = this.tail
    this.tail = node.previous
    if (this.tail) this.tail.next = undefined
    else this.head = undefined
    this.size--
    return node.value
  }

  public shift(): TElement | undefined {
    if (!this.head) return undefined
    const node = this.head
    this.head = node.next
    if (this.head) this.head.previous = undefined
    else this.tail = undefined
    this.size--
    return node.value
  }

  public unshift(element: TElement): void {
    const node = new Node(element)
    if (this.head) {
      node.next = this.head
      this.head.previous = node
    } else {
      this.tail = node
    }
    this.head = node
    this.size++
  }

  public delete(element: TElement): void {
    let current = this.head
    while (current) {
      if (current.value === element) {
        if (current.previous) current.previous.next = current.next
        else this.head = current.next
        if (current.next) current.next.previous = current.previous
        else this.tail = current.previous
        this.size--
        return
      }
      current = current.next
    }
  }

  public count(): number {
    return this.size
  }
}
