def flatten(iterable):
    res = []
    for item in iterable:
        if isinstance(item, list):
            res.extend(flatten(item))
        elif item is not None:
            res.append(item)
    return res
