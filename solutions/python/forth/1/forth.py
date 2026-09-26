class StackUnderflowError(Exception):
    pass


def evaluate(input_data):
    stack = []
    definitions = {}
    tokens = " ".join(input_data).lower().split()
    index = 0

    def is_integer(token):
        try:
            int(token)
            return True
        except ValueError:
            return False

    def compile_token(token):
        if token in definitions:
            return list(definitions[token])
        if token in {"+", "-", "*", "/", "dup", "drop", "swap", "over"}:
            return [("builtin", token)]
        return [token]

    def need(count):
        if len(stack) < count:
            raise StackUnderflowError("Insufficient number of items in stack")

    def execute(token):
        forced_builtin = isinstance(token, tuple) and token[0] == "builtin"
        if forced_builtin:
            token = token[1]
        if not forced_builtin and is_integer(token):
            stack.append(int(token))
            return
        if not forced_builtin and token in definitions:
            for instruction in definitions[token]:
                execute(instruction)
            return
        if token in ("+", "-", "*", "/"):
            need(2)
            right = stack.pop()
            left = stack.pop()
            if token == "+":
                stack.append(left + right)
            elif token == "-":
                stack.append(left - right)
            elif token == "*":
                stack.append(left * right)
            else:
                if right == 0:
                    raise ZeroDivisionError("divide by zero")
                stack.append(int(left / right))
        elif token == "dup":
            need(1)
            stack.append(stack[-1])
        elif token == "drop":
            need(1)
            stack.pop()
        elif token == "swap":
            need(2)
            stack[-1], stack[-2] = stack[-2], stack[-1]
        elif token == "over":
            need(2)
            stack.append(stack[-2])
        else:
            raise ValueError("undefined operation")

    while index < len(tokens):
        token = tokens[index]
        index += 1
        if token != ":":
            execute(token)
            continue

        if index >= len(tokens):
            raise ValueError("illegal operation")
        name = tokens[index]
        index += 1
        if is_integer(name):
            raise ValueError("illegal operation")
        body = []
        while index < len(tokens) and tokens[index] != ";":
            body.extend(compile_token(tokens[index]))
            index += 1
        if index == len(tokens):
            raise ValueError("illegal operation")
        definitions[name] = body
        index += 1

    return stack
