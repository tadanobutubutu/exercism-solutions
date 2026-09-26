def maximum_value(maximum_weight, items):
    best = [0] * (maximum_weight + 1)
    for item in items:
        weight = item["weight"]
        value = item["value"]
        for capacity in range(maximum_weight, weight - 1, -1):
            best[capacity] = max(best[capacity], best[capacity - weight] + value)
    return best[maximum_weight]
