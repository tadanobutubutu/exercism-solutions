return function(s)
  local first_row, second_row = s:match('([^\n]+)\n([^\n]+)')
  first_row = first_row or ''
  second_row = second_row or ''
  local names = {
    'Alice', 'Bob', 'Charlie', 'David', 'Eve', 'Fred',
    'Ginny', 'Harriet', 'Ileana', 'Joseph', 'Kincaid', 'Larry',
  }
  local plants_by_code = { V = ' violets', R = 'radishes', C = 'clover', G = 'grass' }
  local plant = { V = 'violets', R = 'radishes', C = 'clover', G = 'grass' }
  local name_indices = {}
  for index, name in ipairs(names) do name_indices[name] = index end

  return {
    plants = function(student)
      local index = name_indices[student]
      if not index then return nil end
      local start = (index - 1) * 2 + 1
      local result = {}
      for position = start, start + 1 do
        result[#result + 1] = plant[first_row:sub(position, position)]
      end
      for position = start, start + 1 do
        result[#result + 1] = plant[second_row:sub(position, position)]
      end
      return result
    end,
  }
end
