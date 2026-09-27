local SpaceAge = {}

local seconds_per_earth_year = 31557600
local orbital_periods = {
  earth = 1,
  mercury = 0.2408467,
  venus = 0.61519726,
  mars = 1.8808158,
  jupiter = 11.862615,
  saturn = 29.447498,
  uranus = 84.016846,
  neptune = 164.79132,
}

function SpaceAge:new(seconds)
  return setmetatable({ seconds = seconds }, self)
end

SpaceAge.__index = function(age, key)
  local method = rawget(SpaceAge, key)
  if method then return method end
  local planet = key:match('^on_(.+)$')
  local period = planet and orbital_periods[planet]
  if period then
    return function()
      local years = age.seconds / seconds_per_earth_year / period
      return math.floor(years * 100 + 0.5) / 100
    end
  end
  if planet then return function() error('not a planet') end end
  return nil
end

return SpaceAge
