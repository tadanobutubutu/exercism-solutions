local Set = {}
Set.__index = Set
local new_set

function Set:is_empty()
  return next(self.elements) == nil
end

function Set:contains(value)
  return self.elements[value] == true
end

function Set:is_subset(other)
  for value in pairs(self.elements) do
    if not other:contains(value) then return false end
  end
  return true
end

function Set:is_disjoint(other)
  for value in pairs(self.elements) do
    if other:contains(value) then return false end
  end
  return true
end

function Set:equals(other)
  return self:is_subset(other) and other:is_subset(self)
end

function Set:add(value)
  self.elements[value] = true
  return self
end

function Set:intersection(other)
  local result = new_set()
  for value in pairs(self.elements) do
    if other:contains(value) then result.elements[value] = true end
  end
  return result
end

function Set:difference(other)
  local result = new_set()
  for value in pairs(self.elements) do
    if not other:contains(value) then result.elements[value] = true end
  end
  return result
end

function Set:union(other)
  local result = new_set()
  for value in pairs(self.elements) do result.elements[value] = true end
  for value in pairs(other.elements) do result.elements[value] = true end
  return result
end

new_set = function(...)
  local set = setmetatable({ elements = {} }, Set)
  for i = 1, select('#', ...) do set:add(select(i, ...)) end
  return set
end

return new_set
