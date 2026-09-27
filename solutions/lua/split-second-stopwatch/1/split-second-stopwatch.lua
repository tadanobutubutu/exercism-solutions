local Stopwatch = {}

function Stopwatch:new()
  local obj = { status = 'ready', elapsed = 0, lap_elapsed = 0, laps = {} }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

function Stopwatch:start()
  if self.status == 'running' then error('cannot start an already running stopwatch') end
  self.status = 'running'
end

function Stopwatch:stop()
  if self.status ~= 'running' then error('cannot stop a stopwatch that is not running') end
  self.status = 'stopped'
end

function Stopwatch:reset()
  if self.status ~= 'stopped' then error('cannot reset a stopwatch that is not stopped') end
  self.status = 'ready'
  self.elapsed = 0
  self.lap_elapsed = 0
  self.laps = {}
end

function Stopwatch:advance_time(timestamp)
  if self.status ~= 'running' then return end
  local hours, minutes, seconds = timestamp:match('^(%d+):(%d%d):(%d%d)$')
  if not hours then error('invalid timestamp') end
  local amount = tonumber(hours) * 3600 + tonumber(minutes) * 60 + tonumber(seconds)
  self.elapsed = self.elapsed + amount
  self.lap_elapsed = self.lap_elapsed + amount
end

function Stopwatch:total()
  return string.format('%02d:%02d:%02d', math.floor(self.elapsed / 3600), math.floor(self.elapsed / 60) % 60, self.elapsed % 60)
end

function Stopwatch:lap()
  if self.status ~= 'running' then error('cannot lap a stopwatch that is not running') end
  self.laps[#self.laps + 1] = string.format('%02d:%02d:%02d', math.floor(self.lap_elapsed / 3600), math.floor(self.lap_elapsed / 60) % 60, self.lap_elapsed % 60)
  self.lap_elapsed = 0
end

function Stopwatch:current_lap()
  return string.format('%02d:%02d:%02d', math.floor(self.lap_elapsed / 3600), math.floor(self.lap_elapsed / 60) % 60, self.lap_elapsed % 60)
end

function Stopwatch:previous_laps()
  local copy = {}
  for i, lap in ipairs(self.laps) do copy[i] = lap end
  return copy
end

function Stopwatch:state()
  return self.status
end

return Stopwatch
