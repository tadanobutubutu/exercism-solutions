local CircularBuffer = {}

function CircularBuffer:new(capacity)
  if type(capacity) ~= 'number' or capacity < 1 or capacity % 1 ~= 0 then
    error('capacity must be a positive integer')
  end
  return setmetatable({ capacity = capacity, data = {}, head = 1, count = 0 }, self)
end

function CircularBuffer:read()
  if self.count == 0 then error('buffer is empty') end
  local value = self.data[self.head]
  self.data[self.head] = nil
  self.head = self.head % self.capacity + 1
  self.count = self.count - 1
  return value
end

function CircularBuffer:write(value)
  if value == nil then return end
  if self.count == self.capacity then error('buffer is full') end
  local tail = (self.head + self.count - 1) % self.capacity + 1
  self.data[tail] = value
  self.count = self.count + 1
end

function CircularBuffer:forceWrite(value)
  if value == nil then return end
  if self.count == self.capacity then
    self.data[self.head] = nil
    self.head = self.head % self.capacity + 1
    self.count = self.count - 1
  end
  self:write(value)
end

function CircularBuffer:clear()
  self.data = {}
  self.head = 1
  self.count = 0
end

CircularBuffer.__index = CircularBuffer

return CircularBuffer
