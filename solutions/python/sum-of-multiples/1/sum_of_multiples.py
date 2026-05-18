def sum_of_multiples(limit, multiples):
    res = set()
    for m in multiples:
        if m == 0:
            continue
        for i in range(m, limit, m):
            res.add(i)
    return sum(res)
