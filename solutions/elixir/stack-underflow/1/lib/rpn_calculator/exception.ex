defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl Exception
    def exception([]), do: %__MODULE__{message: "stack underflow occurred"}
    def exception(context), do: %__MODULE__{message: "stack underflow occurred, context: #{context}"}
  end

  def divide(stack) do
    case stack do
      [0, _dividend | _rest] -> raise DivisionByZeroError
      [divisor, dividend | _rest] -> dividend / divisor
      _ -> raise StackUnderflowError, "when dividing"
    end
  end
end
