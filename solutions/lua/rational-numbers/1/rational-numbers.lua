local function reduce(a)
  local n, d = a[1], a[2]
  if d < 0 then n, d = -n, -d end
  if n == 0 then return { 0, 1 } end
  local x, y = math.abs(n), math.abs(d)
  while y ~= 0 do x, y = y, x % y end
  return { n / x, d / x }
end

local function add(a, b)
  return reduce({ a[1] * b[2] + b[1] * a[2], a[2] * b[2] })
end

local function subtract(a, b)
  return reduce({ a[1] * b[2] - b[1] * a[2], a[2] * b[2] })
end

local function multiply(a, b)
  return reduce({ a[1] * b[1], a[2] * b[2] })
end

local function divide(a, b)
  return reduce({ a[1] * b[2], a[2] * b[1] })
end

local function abs(a)
  local r = reduce(a)
  return { math.abs(r[1]), r[2] }
end

local function exp_rational(a, p)
  if p == 0 then return { 1, 1 } end
  if p < 0 then return reduce({ a[2] ^ (-p), a[1] ^ (-p) }) end
  return reduce({ a[1] ^ p, a[2] ^ p })
end

local function exp_real(p, a)
  return p ^ (a[1] / a[2])
end

return {
  add = add,
  subtract = subtract,
  multiply = multiply,
  divide = divide,
  abs = abs,
  exp_rational = exp_rational,
  exp_real = exp_real,
  reduce = reduce
}
