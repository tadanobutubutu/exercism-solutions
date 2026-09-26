defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add(a, b) do
    {a_numerator, a_denominator} = a
    {b_numerator, b_denominator} = b

    reduce({a_numerator * b_denominator + b_numerator * a_denominator, a_denominator * b_denominator})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, b) do
    {a_numerator, a_denominator} = a
    {b_numerator, b_denominator} = b

    reduce({a_numerator * b_denominator - b_numerator * a_denominator, a_denominator * b_denominator})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply(a, b) do
    {a_numerator, a_denominator} = a
    {b_numerator, b_denominator} = b

    reduce({a_numerator * b_numerator, a_denominator * b_denominator})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(num, den) do
    {numerator, denominator} = num
    {divisor_numerator, divisor_denominator} = den

    reduce({numerator * divisor_denominator, denominator * divisor_numerator})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs(a) do
    {numerator, denominator} = a

    reduce({Kernel.abs(numerator), Kernel.abs(denominator)})
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(a, n) do
    {numerator, denominator} = a

    if n < 0 do
      power = Kernel.abs(n)
      reduce({Integer.pow(denominator, power), Integer.pow(numerator, power)})
    else
      reduce({Integer.pow(numerator, n), Integer.pow(denominator, n)})
    end
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n) do
    {numerator, denominator} = n

    :math.pow(x, numerator / denominator)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce(a) do
    {numerator, denominator} = a
    divisor = Integer.gcd(Kernel.abs(numerator), Kernel.abs(denominator))
    reduced_numerator = div(numerator, divisor)
    reduced_denominator = div(denominator, divisor)

    if reduced_denominator < 0 do
      {-reduced_numerator, -reduced_denominator}
    else
      {reduced_numerator, reduced_denominator}
    end
  end
end
