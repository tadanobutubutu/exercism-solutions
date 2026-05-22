class Robot
  attr_reader :name

  def self.all_names
    @all_names ||= ('AA000'..'ZZ999').to_a.shuffle
  end

  def self.forget
    @all_names = nil
    @index = 0
  end

  def self.next_name
    name = all_names[@index]
    @index += 1
    name
  end

  def initialize
    reset
  end

  def reset
    @name = self.class.next_name
  end
end
