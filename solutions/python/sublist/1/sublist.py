"""
This exercise stub and the test suite contain several enumerated constants.

Enumerated constants can be done with a NAME assigned to an arbitrary,
but unique value. An integer is traditionally used because it’s memory
efficient.
It is a common practice to export both constants and functions that work with
those constants (ex. the constants in the os, subprocess and re modules).

You can learn more here: https://en.wikipedia.org/wiki/Enumerated_type
"""

# Possible sublist categories.
# Change the values as you see fit.
SUBLIST = 0
SUPERLIST = 1
EQUAL = 2
UNEQUAL = 3


def sublist(list_one, list_two):
    if list_one == list_two:
        return EQUAL
    
    def is_sub(small, large):
        if not small:
            return True
        len_s = len(small)
        len_l = len(large)
        if len_s > len_l:
            return False
        
        first = small[0]
        i = 0
        while i <= len_l - len_s:
            try:
                i = large.index(first, i)
            except ValueError:
                break
            if large[i : i + len_s] == small:
                return True
            i += 1
        return False

    if is_sub(list_one, list_two):
        return SUBLIST
    if is_sub(list_two, list_one):
        return SUPERLIST
    return UNEQUAL
