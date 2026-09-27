local function flatten(input)
  local result = {}
  local function visit(values)
    for _, value in ipairs(values) do
      if type(value) == 'table' then visit(value)
      elseif value ~= nil then result[#result + 1] = value end
    end
  end
  visit(input)
  return result
end

return flatten
