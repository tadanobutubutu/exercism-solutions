local function measure(args)
  local first_capacity = args.bucket_one_capacity
  local second_capacity = args.bucket_two_capacity
  local goal = args.goal_volume
  local first_start = args.start_bucket == 1
  if goal < 0 or goal > math.max(first_capacity, second_capacity) then
    error('goal cannot be measured')
  end

  local initial = first_start and { first_capacity, 0 } or { 0, second_capacity }
  local queue = { { first = initial[1], second = initial[2], moves = 1 } }
  local seen, head = {}, 1
  local function key(first, second) return first .. ':' .. second end
  seen[key(initial[1], initial[2])] = true
  while head <= #queue do
    local state = queue[head]
    head = head + 1
    local goal_bucket
    if state.first == goal then goal_bucket = 1
    elseif state.second == goal then goal_bucket = 2 end
    if goal_bucket then
      return {
        moves = state.moves,
        other_bucket_volume = goal_bucket == 1 and state.second or state.first,
        goal_bucket_number = goal_bucket
      }
    end

    local transfer = math.min(state.first, second_capacity - state.second)
    local reverse_transfer = math.min(state.second, first_capacity - state.first)
    local next_states = {
      { first_capacity, state.second },
      { state.first, second_capacity },
      { 0, state.second },
      { state.first, 0 },
      { state.first - transfer, state.second + transfer },
      { state.first + reverse_transfer, state.second - reverse_transfer }
    }
    for _, next_state in ipairs(next_states) do
      local start_bucket_empty_and_other_full
      if first_start then
        start_bucket_empty_and_other_full = next_state[1] == 0 and next_state[2] == second_capacity
      else
        start_bucket_empty_and_other_full = next_state[2] == 0 and next_state[1] == first_capacity
      end
      local state_key = key(next_state[1], next_state[2])
      if not start_bucket_empty_and_other_full and not seen[state_key]
        and (next_state[1] ~= state.first or next_state[2] ~= state.second) then
        seen[state_key] = true
        queue[#queue + 1] = { first = next_state[1], second = next_state[2], moves = state.moves + 1 }
      end
    end
  end
  error('goal cannot be measured')
end

return { measure = measure }
