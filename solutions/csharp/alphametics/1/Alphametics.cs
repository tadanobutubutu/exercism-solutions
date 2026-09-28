public static class Alphametics
{
    public static IDictionary<char, int> Solve(string equation)
    {
        var sides = equation.Split("==", StringSplitOptions.TrimEntries);
        var addends = sides[0].Split('+', StringSplitOptions.TrimEntries);
        var result = sides[1];
        var words = addends.Append(result).ToArray();
        var letters = words.SelectMany(word => word).Distinct().ToArray();
        if (letters.Length > 10) throw new ArgumentException("There are more than ten distinct letters.", nameof(equation));

        var leadingLetters = words.Where(word => word.Length > 1).Select(word => word[0]).ToHashSet();
        var assignment = new Dictionary<char, int>();
        var usedDigits = new bool[10];
        var maxColumns = Math.Max(result.Length, addends.Max(word => word.Length));

        bool SearchColumn(int column, int carry)
        {
            if (column == maxColumns) return carry == 0;

            var columnLetters = addends
                .Where(word => word.Length > column)
                .Select(word => word[^(column + 1)])
                .Where(letter => !assignment.ContainsKey(letter))
                .Distinct()
                .ToArray();

            bool AssignAddendLetters(int index)
            {
                if (index < columnLetters.Length)
                {
                    var letter = columnLetters[index];
                    for (var digit = 0; digit <= 9; digit++)
                    {
                        if (usedDigits[digit] || (digit == 0 && leadingLetters.Contains(letter))) continue;
                        assignment[letter] = digit;
                        usedDigits[digit] = true;
                        if (AssignAddendLetters(index + 1)) return true;
                        assignment.Remove(letter);
                        usedDigits[digit] = false;
                    }

                    return false;
                }

                var sum = carry;
                foreach (var word in addends)
                {
                    if (word.Length > column) sum += assignment[word[^(column + 1)]];
                }

                var resultDigit = sum % 10;
                var nextCarry = sum / 10;
                if (result.Length <= column) return resultDigit == 0 && SearchColumn(column + 1, nextCarry);

                var resultLetter = result[^(column + 1)];
                if (assignment.TryGetValue(resultLetter, out var assignedDigit))
                {
                    return assignedDigit == resultDigit && SearchColumn(column + 1, nextCarry);
                }

                if (usedDigits[resultDigit] || (resultDigit == 0 && leadingLetters.Contains(resultLetter))) return false;
                assignment[resultLetter] = resultDigit;
                usedDigits[resultDigit] = true;
                if (SearchColumn(column + 1, nextCarry)) return true;
                assignment.Remove(resultLetter);
                usedDigits[resultDigit] = false;
                return false;
            }

            return AssignAddendLetters(0);
        }

        if (!SearchColumn(0, 0)) throw new ArgumentException("The equation has no solution.", nameof(equation));
        return assignment;
    }
}
