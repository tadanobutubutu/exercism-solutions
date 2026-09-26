def solve(puzzle: str) -> dict[str, int] | None:
    left, result = puzzle.split("==")
    addends = [word.strip() for word in left.split("+")]
    result = result.strip()
    letters = set("".join(addends) + result)
    if len(letters) > 10:
        return None

    leading = {word[0] for word in addends + [result] if len(word) > 1}
    assignment: dict[str, int] = {}
    used: set[int] = set()
    columns = max(max(map(len, addends)), len(result))

    def solve_column(position: int, carry: int) -> dict[str, int] | None:
        if position == columns:
            return assignment.copy() if carry == 0 else None

        column_letters = [
            word[-position - 1]
            for word in addends
            if position < len(word) and word[-position - 1] not in assignment
        ]

        def assign_addends(index: int, subtotal: int) -> dict[str, int] | None:
            if index < len(column_letters):
                letter = column_letters[index]
                if letter in assignment:
                    return assign_addends(index + 1, subtotal + assignment[letter])

                for digit in range(10):
                    if digit in used or (digit == 0 and letter in leading):
                        continue
                    assignment[letter] = digit
                    used.add(digit)
                    solution = assign_addends(index + 1, subtotal + digit)
                    if solution is not None:
                        return solution
                    del assignment[letter]
                    used.remove(digit)
                return None

            total = subtotal + carry
            target_digit = total % 10
            next_carry = total // 10
            if position >= len(result):
                return solve_column(position + 1, next_carry) if target_digit == 0 else None

            target = result[-position - 1]
            if target in assignment:
                if assignment[target] != target_digit:
                    return None
                return solve_column(position + 1, next_carry)
            if target_digit in used or (target_digit == 0 and target in leading):
                return None

            assignment[target] = target_digit
            used.add(target_digit)
            solution = solve_column(position + 1, next_carry)
            if solution is not None:
                return solution
            del assignment[target]
            used.remove(target_digit)
            return None

        known_sum = sum(
            assignment[word[-position - 1]]
            for word in addends
            if position < len(word) and word[-position - 1] in assignment
        )
        return assign_addends(0, known_sum)

    return solve_column(0, 0)
