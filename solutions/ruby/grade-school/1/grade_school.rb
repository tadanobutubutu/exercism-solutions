class School
  def initialize
    @roster = {}
    @students = {}
  end

  def roster
    @roster.keys.sort.flat_map { |g| @roster[g] }
  end

  def add(name, grade)
    return false if @students.key?(name)
    @students[name] = grade
    @roster[grade] ||= []
    @roster[grade] << name
    @roster[grade].sort!
    true
  end

  def grade(n)
    @roster[n] || []
  end
end
