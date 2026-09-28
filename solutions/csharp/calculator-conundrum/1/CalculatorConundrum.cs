public static class SimpleCalculator
{
    public static string Calculate(int operand1, int operand2, string? operation)
    {
        ArgumentNullException.ThrowIfNull(operation);
        if (operation.Length == 0)
        {
            throw new ArgumentException("Operation cannot be empty.", nameof(operation));
        }

        if (operation == "/" && operand2 == 0)
        {
            return "Division by zero is not allowed.";
        }

        int result = operation switch
        {
            "+" => SimpleOperation.Addition(operand1, operand2),
            "*" => SimpleOperation.Multiplication(operand1, operand2),
            "/" => SimpleOperation.Division(operand1, operand2),
            _ => throw new ArgumentOutOfRangeException(nameof(operation), operation, "Unknown operation.")
        };

        return $"{operand1} {operation} {operand2} = {result}";
    }
}
