local Robot = {}
Robot.__index = Robot

local issued = {}

local function make_name()
  for _ = 1, 70000 do
    local name = string.char(math.random(0, 25) + string.byte('A'), math.random(0, 25) + string.byte('A'))
      .. string.format('%03d', math.random(0, 999))
    if not issued[name] then
      issued[name] = true
      return name
    end
  end
  error('all robot names have been used')
end

function Robot:new()
  return setmetatable({ name = make_name() }, self)
end

function Robot:reset()
  self.name = make_name()
end

return Robot
