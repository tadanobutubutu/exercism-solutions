local function LinkedList()
  local list = { items = {} }

  function list:push(value)
    self.items[#self.items + 1] = value
  end

  function list:pop()
    return table.remove(self.items)
  end

  function list:shift()
    return table.remove(self.items, 1)
  end

  function list:unshift(value)
    table.insert(self.items, 1, value)
  end

  function list:count()
    return #self.items
  end

  function list:delete(value)
    for i, item in ipairs(self.items) do
      if item == value then table.remove(self.items, i); return end
    end
  end

  return list
end

return LinkedList
