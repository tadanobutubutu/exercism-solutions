import re


def answer(question):
    question = question.removeprefix("What is").removesuffix("?").strip()
    if not question:
        raise ValueError("syntax error")

    pattern = r"-?\d+|plus|minus|multiplied by|divided by"
    tokens = re.findall(pattern, question)

    remaining = re.sub(pattern, "", question).strip()
    if remaining:
        raise ValueError("unknown operation")

    if not tokens or not re.match(r"-?\d+$", tokens[0]):
        raise ValueError("syntax error")
    result = int(tokens[0])

    i = 1
    while i < len(tokens):
        op = tokens[i]
        if i + 1 >= len(tokens) or not re.match(r"-?\d+$", tokens[i + 1]):
            raise ValueError("syntax error")
        num = int(tokens[i + 1])
        if op == "plus":
            result += num
        elif op == "minus":
            result -= num
        elif op == "multiplied by":
            result *= num
        elif op == "divided by":
            result //= num
        else:
            raise ValueError("unknown operation")
        i += 2

    return result