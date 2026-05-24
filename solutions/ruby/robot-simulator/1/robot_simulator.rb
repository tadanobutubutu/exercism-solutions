class Robot
  attr_reader :bearing, :coordinates

  DIRECTIONS = [:north, :east, :south, :west]

  def orient(direction)
    raise ArgumentError unless DIRECTIONS.include?(direction)
    @bearing = direction
  end

  def at(x, y)
    @coordinates = [x, y]
  end

  def turn_right
    i = DIRECTIONS.index(@bearing)
    @bearing = DIRECTIONS[(i + 1) % 4]
  end

  def turn_left
    i = DIRECTIONS.index(@bearing)
    @bearing = DIRECTIONS[(i - 1) % 4]
  end

  def advance
    x, y = @coordinates
    case @bearing
    when :north then @coordinates = [x, y + 1]
    when :east  then @coordinates = [x + 1, y]
    when :south then @coordinates = [x, y - 1]
    when :west  then @coordinates = [x - 1, y]
    end
  end
end

class Simulator
  COMMANDS = { 'L' => :turn_left, 'R' => :turn_right, 'A' => :advance }

  def instructions(str)
    str.chars.map { |c| COMMANDS[c] }
  end

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, str)
    instructions(str).each { |cmd| robot.send(cmd) }
  end
end
