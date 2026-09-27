import gleam/list

pub opaque type CircularBuffer(t) {
  CircularBuffer(items: List(t), capacity: Int)
}

pub fn new(capacity: Int) -> CircularBuffer(t) {
  CircularBuffer(items: [], capacity: capacity)
}

pub fn read(buffer: CircularBuffer(t)) -> Result(#(t, CircularBuffer(t)), Nil) {
  case buffer {
    CircularBuffer(items: [], capacity: _) -> Error(Nil)
    CircularBuffer(items: [first, ..rest], capacity: capacity) ->
      Ok(#(first, CircularBuffer(items: rest, capacity: capacity)))
  }
}

pub fn write(
  buffer: CircularBuffer(t),
  item: t,
) -> Result(CircularBuffer(t), Nil) {
  case buffer {
    CircularBuffer(items: items, capacity: capacity) ->
      case list.length(items) >= capacity {
        True -> Error(Nil)
        False -> Ok(CircularBuffer(items: list.append(items, [item]), capacity: capacity))
      }
  }
}

pub fn overwrite(buffer: CircularBuffer(t), item: t) -> CircularBuffer(t) {
  case buffer {
    CircularBuffer(items: items, capacity: capacity) ->
      case list.length(items) >= capacity {
        True ->
          case items {
            [] -> CircularBuffer(items: [], capacity: capacity)
            [_oldest, ..rest] ->
              CircularBuffer(items: list.append(rest, [item]), capacity: capacity)
          }
        False -> CircularBuffer(items: list.append(items, [item]), capacity: capacity)
      }
  }
}

pub fn clear(buffer: CircularBuffer(t)) -> CircularBuffer(t) {
  case buffer {
    CircularBuffer(items: _, capacity: capacity) ->
      CircularBuffer(items: [], capacity: capacity)
  }
}
