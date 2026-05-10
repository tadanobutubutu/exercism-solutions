class Garden
  DEFAULT_STUDENTS = %w[Alice Bob Charlie David Eve Fred Ginny Harriet Ileana Joseph Kincaid Larry].freeze
  PLANTS = {
    'G' => :grass,
    'C' => :clover,
    'R' => :radishes,
    'V' => :violets
  }.freeze

  def initialize(diagram, students = DEFAULT_STUDENTS)
    @rows = diagram.split("\n")
    @students = students.sort
    @students.each_with_index do |student, index|
      define_singleton_method(student.downcase) do
        plants_for(index)
      end
    end
  end

  private

  def plants_for(index)
    start_pos = index * 2
    chars = []
    @rows.each do |row|
      chars << row[start_pos]
      chars << row[start_pos + 1]
    end
    chars.compact.map { |c| PLANTS[c] }
  end
end
