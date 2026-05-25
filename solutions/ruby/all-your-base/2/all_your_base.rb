class BaseConverter
  def self.convert(input_base, digits, output_base)
    raise ArgumentError, 'Input base must be greater than 1' if input_base < 2
    raise ArgumentError, 'Output base must be greater than 1' if output_base < 2
    raise ArgumentError, 'Digits must be valid for the input base' if digits.any? { |d| d < 0 || d >= input_base }

    decimal_value = digits.each_with_index.reduce(0) do |sum, (digit, index)|
      sum + digit * (input_base ** (digits.size - index - 1))
    end

    return [0] if decimal_value == 0

    result = []
    while decimal_value > 0
      result.unshift(decimal_value % output_base)
      decimal_value /= output_base
    end

    result
  end
end