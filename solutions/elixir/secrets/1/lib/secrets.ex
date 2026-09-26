defmodule Secrets do
  import Bitwise

  def secret_add(secret) do
    fn value -> value + secret end
  end

  def secret_subtract(secret) do
    fn value -> value - secret end
  end

  def secret_multiply(secret) do
    fn value -> value * secret end
  end

  def secret_divide(secret) do
    fn value -> div(value, secret) end
  end

  def secret_and(secret) do
    fn value -> band(value, secret) end
  end

  def secret_xor(secret) do
    fn value -> bxor(value, secret) end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn value -> secret_function2.(secret_function1.(value)) end
  end
end
