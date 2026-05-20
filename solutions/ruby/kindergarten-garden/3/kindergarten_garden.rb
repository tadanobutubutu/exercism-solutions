class Garden
  PLANTS = { 'V' => :violets, 'R' => :radishes, 'C' => :clover, 'G' => :grass }.freeze
  DEFAULT_STUDENTS = %w[alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry].freeze

  def initialize(diagram, students = DEFAULT_STUDENTS)
    @diagram = diagram.split("\n")
    @students = students.map(&:downcase).sort
  end

  def method_missing(name, *args)
    idx = @students.index(name.to_s.downcase)
    if idx
      get_plants(idx)
    else
      super
    end
  end

  def respond_to_missing?(name, include_private = false)
    @students.include?(name.to_s.downcase) || super
  end

  private

  def get_plants(idx)
    res = []
    [0, 1].each do |r|
      [0, 1].each do |c|
        res << PLANTS[@diagram[r][idx * 2 + c]]
      end
    end
    res
  end
end
