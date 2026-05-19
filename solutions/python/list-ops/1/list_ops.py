def append(list1, list2):
    return list1 + list2


def concat(lists):
    res = []
    for l in lists:
        res = append(res, l)
    return res


def filter(function, list):
    return [item for item in list if function(item)]


def length(list):
    count = 0
    for _ in list:
        count += 1
    return count


def map(function, list):
    return [function(item) for item in list]


def foldl(function, list, initial):
    res = initial
    for item in list:
        res = function(res, item)
    return res


def foldr(function, list, initial):
    res = initial
    for item in list[::-1]:
        res = function(res, item)
    return res


def reverse(list):
    return list[::-1]
