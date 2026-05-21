class Element:
    def __init__(self, datum, _next=None):
        self.datum = datum
        self._next = _next

    def next(self):
        return self._next

    def value(self):
        return self.datum


class LinkedList:
    def __init__(self):
        self._head = None
        self._size = 0

    def __len__(self):
        return self._size

    def head(self):
        if self._head is None:
            raise EmptyListException("List is empty")
        return self._head

    def push(self, datum):
        self._head = Element(datum, self._head)
        self._size += 1

    def pop(self):
        if self._head is None:
            raise EmptyListException("List is empty")
        datum = self._head.datum
        self._head = self._head._next
        self._size -= 1
        return datum

    def reverse(self):
        prev, curr = None, self._head
        while curr:
            nxt = curr._next
            curr._next = prev
            prev = curr
            curr = nxt
        self._head = prev


class EmptyListException(Exception):
    pass
