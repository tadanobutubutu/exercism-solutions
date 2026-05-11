class Garden
  def initialize(diagram)
    @diagram = diagram
  end
  
  def plants
    result = []
    @diagram.split("\n").each do |row|
      row.chars.each do |char|
        case char
        when 'R'
          result << :radishes
        when 'C'
          result << :clover
        when 'G'
          result << :grass
        end
      end
    end
    result
  end
  
  def alice
    plants
  end
end
