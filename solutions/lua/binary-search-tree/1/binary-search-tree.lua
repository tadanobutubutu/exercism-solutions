local BinarySearchTree = {}
BinarySearchTree.__index = BinarySearchTree

function BinarySearchTree:new(value)
  return setmetatable({ value = value }, self)
end

function BinarySearchTree:insert(value)
  if value <= self.value then
    if self.left then self.left:insert(value) else self.left = BinarySearchTree:new(value) end
  else
    if self.right then self.right:insert(value) else self.right = BinarySearchTree:new(value) end
  end
end

function BinarySearchTree:from_list(values)
  if #values == 0 then error('cannot create a tree from an empty list') end
  local tree = BinarySearchTree:new(values[1])
  for i = 2, #values do tree:insert(values[i]) end
  return tree
end

function BinarySearchTree:values()
  local stack, current = {}, self
  return function()
    while current or #stack > 0 do
      while current do
        stack[#stack + 1] = current
        current = current.left
      end
      local node = table.remove(stack)
      current = node.right
      return node.value
    end
  end
end

return BinarySearchTree
