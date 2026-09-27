local function Reactor()
  local cells = {}
  local next_id = 0

  local function notify(cell)
    local callbacks = {}
    for i, callback in ipairs(cell.callbacks) do callbacks[i] = callback end
    for _, callback in ipairs(callbacks) do callback(cell.value) end
  end

  local function propagate(source)
    local affected, queue = {}, { source }
    affected[source] = true
    local index = 1
    while index <= #queue do
      local cell = queue[index]
      index = index + 1
      for _, dependent in ipairs(cell.dependents) do
        if not affected[dependent] then
          affected[dependent] = true
          queue[#queue + 1] = dependent
        end
      end
    end

    table.sort(queue, function(a, b) return a.id < b.id end)
    for _, cell in ipairs(queue) do
      if cell ~= source then
        local values = {}
        for i, input in ipairs(cell.inputs) do values[i] = input.value end
        local unpack_values = table.unpack or unpack
        local updated = cell.compute(unpack_values(values))
        if updated ~= cell.value then
          cell.value = updated
          notify(cell)
        end
      end
    end
  end

  local function make_cell(value)
    next_id = next_id + 1
    local cell = { id = next_id, value = value, callbacks = {}, dependents = {} }
    function cell.get_value() return cell.value end
    function cell.watch(callback)
      for _, existing in ipairs(cell.callbacks) do if existing == callback then return end end
      cell.callbacks[#cell.callbacks + 1] = callback
    end
    function cell.unwatch(callback)
      for i = #cell.callbacks, 1, -1 do
        if cell.callbacks[i] == callback then table.remove(cell.callbacks, i) end
      end
    end
    cells[#cells + 1] = cell
    return cell
  end

  local reactor = {}
  function reactor.InputCell(initial_value)
    local cell = make_cell(initial_value)
    function cell.set_value(value)
      if value ~= cell.value then
        cell.value = value
        propagate(cell)
      end
    end
    return cell
  end

  function reactor.ComputeCell(...)
    local arguments = { ... }
    local compute = arguments[#arguments]
    if type(compute) ~= 'function' then error('compute function required') end
    arguments[#arguments] = nil
    local inputs = arguments
    local values = {}
    for i, input in ipairs(inputs) do values[i] = input.value end
    local unpack_values = table.unpack or unpack
    local cell = make_cell(compute(unpack_values(values)))
    cell.inputs, cell.compute = inputs, compute
    for _, input in ipairs(inputs) do input.dependents[#input.dependents + 1] = cell end
    return cell
  end
  return reactor
end

return { Reactor = Reactor }
