class ComplexNumber
  attr_reader :real, :imaginary

  def initialize(real, imaginary = 0)
    @real = real
    @imaginary = imaginary
  end

  def +(other)
    ComplexNumber.new(@real + other.real, @imaginary + other.imaginary)
  end

  def -(other)
    ComplexNumber.new(@real - other.real, @imaginary - other.imaginary)
  end

  def *(other)
    ComplexNumber.new(
      @real * other.real - @imaginary * other.imaginary,
      @real * other.imaginary + @imaginary * other.real
    )
  end

  def /(other)
    denom = other.real * other.real + other.imaginary * other.imaginary
    ComplexNumber.new(
      (@real * other.real + @imaginary * other.imaginary).to_f / denom,
      (@imaginary * other.real - @real * other.imaginary).to_f / denom
    )
  end

  def abs
    Math.sqrt(@real * @real + @imaginary * @imaginary)
  end

  def conjugate
    ComplexNumber.new(@real, -@imaginary)
  end

  def exp
    ComplexNumber.new(Math.exp(@real) * Math.cos(@imaginary), Math.exp(@real) * Math.sin(@imaginary))
  end

  def ==(other)
    (@real - other.real).abs < 1e-12 && (@imaginary - other.imaginary).abs < 1e-12
  end

  def eql?(other)
    self == other
  end
end
