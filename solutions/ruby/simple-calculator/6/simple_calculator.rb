class SimpleCalculator
  class UnsupportedOperation < StandardError
  end

  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  def self.calculate(first_operand, second_operand, operation)
    unless first_operand.is_a?(Numeric) && second_operand.is_a?(Numeric)
      raise ArgumentError.new("Operands must be numbers")
    end

    unless ALLOWED_OPERATIONS.include?(operation)
      raise UnsupportedOperation.new("Unsupported operation: #{operation}")
    end

    begin
      result = first_operand.public_send(operation, second_operand)
      "#{first_operand} #{operation} #{second_operand} = #{result}"
    rescue ZeroDivisionError
      "Division by zero is not allowed."
    end
  end
end
