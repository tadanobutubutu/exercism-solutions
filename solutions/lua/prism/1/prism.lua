local function find_sequence(start, prisms)
  local x, y = start.x, start.y
  local angle = start.angle
  local sequence, seen_states = {}, {}
  for _ = 1, 10000 do
    local radians = math.rad(angle)
    local dx, dy = math.cos(radians), math.sin(radians)
    local nearest, nearest_distance
    for _, prism in ipairs(prisms) do
      local vx, vy = prism.x - x, prism.y - y
      local distance = vx * dx + vy * dy
      local cross_track = math.abs(vx * dy - vy * dx)
      if distance > 1e-8 and cross_track <= 0.08
        and (not nearest_distance or distance < nearest_distance) then
        nearest, nearest_distance = prism, distance
      end
    end
    if not nearest then break end

    local normalized_angle = ((angle % 360) + 360) % 360
    local state = tostring(nearest.id) .. ':' .. string.format('%.6f', normalized_angle)
    if seen_states[state] then break end
    seen_states[state] = true

    sequence[#sequence + 1] = nearest.id
    x, y = nearest.x, nearest.y
    angle = angle + nearest.angle
  end
  return sequence
end

return { find_sequence = find_sequence }
