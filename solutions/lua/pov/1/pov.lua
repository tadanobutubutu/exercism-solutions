local function find_path(node, label, path)
  path[#path + 1] = node
  if node[1] == label then
    return true
  end
  for _, child in ipairs(node[2] or {}) do
    if find_path(child, label, path) then
      return true
    end
  end
  path[#path] = nil
  return false
end

local function pov_from(target)
  return {
    of = function(tree)
      local path = {}
      if not find_path(tree, target, path) then
        error('node not found')
      end

      local target = path[#path]
      local children = {}
      for _, child in ipairs(target[2] or {}) do children[#children + 1] = child end
      local result = #children > 0 and { target[1], children } or { target[1] }
      local branch
      local tail
      for i = #path - 1, 1, -1 do
        local ancestor, path_child = path[i], path[i + 1]
        local ancestor_children = {}
        for _, child in ipairs(ancestor[2] or {}) do
          if child ~= path_child then
            ancestor_children[#ancestor_children + 1] = child
          end
        end
        local ancestor_branch = #ancestor_children > 0 and { ancestor[1], ancestor_children } or { ancestor[1] }
        if not branch then
          branch, tail = ancestor_branch, ancestor_branch
        else
          tail[2] = tail[2] or {}
          tail[2][#tail[2] + 1] = ancestor_branch
          tail = ancestor_branch
        end
      end
      if branch then
        local rooted_children = {}
        for _, child in ipairs(children) do rooted_children[#rooted_children + 1] = child end
        rooted_children[#rooted_children + 1] = branch
        result = { target[1], rooted_children }
      end
      return result
    end
  }
end

local function path_from(source)
  return {
    to = function(destination)
      return {
        of = function(tree)
          local path = {}
          if not find_path(tree, source, path) then
            error('source node not found')
          end
          local source_path = {}
          for _, node in ipairs(path) do source_path[#source_path + 1] = node[1] end

          local target_path = {}
          if not find_path(tree, destination, target_path) then
            error('destination node not found')
          end
          local target_labels = {}
          for _, node in ipairs(target_path) do target_labels[#target_labels + 1] = node[1] end

          local common = 0
          while common < #source_path and common < #target_labels
            and source_path[common + 1] == target_labels[common + 1] do
            common = common + 1
          end

          local result = {}
          for i = #source_path, common + 1, -1 do result[#result + 1] = source_path[i] end
          if common > 0 then result[#result + 1] = source_path[common] end
          for i = common + 1, #target_labels do result[#result + 1] = target_labels[i] end
          return result
        end
      }
    end
  }
end

return { pov_from = pov_from, path_from = path_from }
