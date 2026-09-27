return function(config)
  local robot = {
    x = config.x,
    y = config.y,
    heading = config.heading,
  }
  local directions = { 'north', 'east', 'south', 'west' }
  local deltas = {
    north = { 0, 1 }, east = { 1, 0 },
    south = { 0, -1 }, west = { -1, 0 },
  }
  robot.move = function(self, commands)
    local heading_index = 1
    for index, heading in ipairs(directions) do
      if heading == self.heading then heading_index = index; break end
    end
    for command in commands:gmatch('.') do
      if command == 'R' then
        heading_index = heading_index % 4 + 1
        self.heading = directions[heading_index]
      elseif command == 'L' then
        heading_index = (heading_index - 2) % 4 + 1
        self.heading = directions[heading_index]
      elseif command == 'A' then
        local delta = deltas[self.heading]
        self.x = self.x + delta[1]
        self.y = self.y + delta[2]
      else
        error('invalid command')
      end
    end
    return self
  end
  return robot
end
