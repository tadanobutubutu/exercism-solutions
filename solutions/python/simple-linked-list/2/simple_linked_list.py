class Element:
    def __init__(self, datum, _next=None):
        self.datum = datum
        self._next = _next

    def next(self):
        return self._next

    def value(self):
        return self.datum


class LinkedList:
    def __init__(self, values=None):
        self._head = None
        self._size = 0
        if values:
            for v in values:
                self.push(v)

    def __len__(self):
        return self._size

    def __iter__(self):
        current = self._head
        while current:
            yield current.datum
            current = current._next

    def head(self):
        if self._head is None:
            raise EmptyListException("The list is empty.")
        return self._head

    def push(self, datum):
        self._head = Element(datum, self._head)
        self._size += 1

    def pop(self):
        if self._head is None:
            raise EmptyListException("The list is empty.")
        datum = self._head.datum
        self._head = self._head._next
        self._size -= 1
        return datum

    def reversed(self):
        result = LinkedList()
        current = self._head
        while current:
            result.push(current.datum)
            current = current._next
        return result


class EmptyListException(Exception):
    pass
