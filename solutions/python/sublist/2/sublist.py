SUBLIST = "sublist"
SUPERLIST = "superlist"
EQUAL = "equal"
UNEQUAL = "unequal"


def sublist(list_one, list_two):
    if list_one == list_two:
        return EQUAL
    if _is_sublist(list_one, list_two):
        return SUBLIST
    if _is_sublist(list_two, list_one):
        return SUPERLIST
    return UNEQUAL


def _is_sublist(possible, other):
    if not possible:
        return True
    if len(possible) > len(other):
        return False
    for i in range(len(other) - len(possible) + 1):
        if other[i:i + len(possible)] == possible:
            return True
    return False