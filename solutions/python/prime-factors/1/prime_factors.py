def factors(value):
    res = []
    i = 2
    while i * i <= value:
        if value % i == 0:
            res.append(i)
            value //= i
        else:
            i += 1
    if value > 1:
        res.append(value)
    return res
