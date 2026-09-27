local Clock = {}

local ClockValue = {}
ClockValue.__index = ClockValue

local function normalized(minutes)
  return minutes % (24 * 60)
end

function ClockValue:__tostring()
  return string.format('%02d:%02d', math.floor(self.minutes / 60), self.minutes % 60)
end

function ClockValue:plus(minutes)
  return setmetatable({ minutes = normalized(self.minutes + minutes) }, ClockValue)
end

function ClockValue:minus(minutes)
  return setmetatable({ minutes = normalized(self.minutes - minutes) }, ClockValue)
end

function ClockValue:equals(other)
  return getmetatable(other) == ClockValue and self.minutes == other.minutes
end

function Clock.at(hours, minutes)
  return setmetatable({ minutes = normalized(hours * 60 + (minutes or 0)) }, ClockValue)
end

return Clock
