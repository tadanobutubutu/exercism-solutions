class BaseConverter
  def self.convert(input_base, digits, output_base)
    raise ArgumentError if input_base < 2 || output_base < 2
    raise ArgumentError if digits.any? { |d| d < 0 || d >= input_base }

    value = digits.reduce(0) { |acc, d| acc * input_base + d }
    return [0] if value == 0

    result = []
    while value > 0
      result.unshift(value % output_base)
      value /= output_base
    end
    result
  end
end
