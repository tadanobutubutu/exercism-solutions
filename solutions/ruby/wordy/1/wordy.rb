class WordProblem
  OPERATORS = {
    'plus' => :+, 'minus' => :-,
    'multiplied by' => :*, 'divided by' => :/
  }

  def initialize(question)
    @question = question
  end

  def answer
    tokens = tokenize
    raise ArgumentError if tokens.empty? || tokens.length.even?
    result = tokens.shift
    until tokens.empty?
      op = tokens.shift
      raise ArgumentError unless op.is_a?(Symbol)
      num = tokens.shift
      raise ArgumentError unless num.is_a?(Integer)
      result = result.send(op, num)
    end
    result
  end

  private

  def tokenize
    m = @question.match(/^What is (.+)\?$/)
    raise ArgumentError unless m
    expr = m[1]
    tokens = []
    i = 0
    while i < expr.length
      if expr[i] == ' '
        i += 1
        next
      end
      if expr[i] =~ /-|\d/
        num = expr[i..].match(/^-?\d+/)
        raise ArgumentError unless num
        tokens << num[0].to_i
        i += num[0].length
      else
        op = OPERATORS.keys.find { |k| expr[i..].start_with?(k) }
        raise ArgumentError unless op
        tokens << OPERATORS[op]
        i += op.length
      end
    end
    tokens
  end
end
