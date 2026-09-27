local School = {}

function School:new()
  return setmetatable({ students = {} }, self)
end

function School:add(name, grade)
  if self.students[name] then return false end
  self.students[name] = grade
  return true
end

function School:grade(grade)
  local students = {}
  for name, student_grade in pairs(self.students) do
    if student_grade == grade then students[#students + 1] = name end
  end
  table.sort(students)
  return students
end

function School:roster()
  local roster = {}
  for _, name in ipairs(self:grade(1)) do roster[#roster + 1] = name end
  local grades = {}
  for _, grade in pairs(self.students) do grades[grade] = true end
  local sorted_grades = {}
  for grade in pairs(grades) do sorted_grades[#sorted_grades + 1] = grade end
  table.sort(sorted_grades)
  for _, grade in ipairs(sorted_grades) do
    if grade ~= 1 then
      for _, name in ipairs(self:grade(grade)) do roster[#roster + 1] = name end
    end
  end
  return roster
end

School.__index = School

return School
