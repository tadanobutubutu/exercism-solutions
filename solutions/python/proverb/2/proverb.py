def proverb(*inputs, qualifier=None):
    if not inputs:
        return []
    result = []
    for i in range(len(inputs) - 1):
        result.append(f"For want of a {inputs[i]} the {inputs[i + 1]} was lost.")
    if qualifier:
        result.append(f"And all for the want of a {qualifier} {inputs[0]}.")
    else:
        result.append(f"And all for the want of a {inputs[0]}.")
    return result
