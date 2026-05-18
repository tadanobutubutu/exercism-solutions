from collections import Counter

# Score categories.
YACHT = lambda d: 50 if len(set(d)) == 1 else 0
ONES = lambda d: d.count(1) * 1
TWOS = lambda d: d.count(2) * 2
THREES = lambda d: d.count(3) * 3
FOURS = lambda d: d.count(4) * 4
FIVES = lambda d: d.count(5) * 5
SIXES = lambda d: d.count(6) * 6
FULL_HOUSE = lambda d: sum(d) if sorted(Counter(d).values()) == [2, 3] else 0
FOUR_OF_A_KIND = lambda d: sum(k * 4 for k, v in Counter(d).items() if v >= 4)
LITTLE_STRAIGHT = lambda d: 30 if sorted(d) == [1, 2, 3, 4, 5] else 0
BIG_STRAIGHT = lambda d: 30 if sorted(d) == [2, 3, 4, 5, 6] else 0
CHOICE = sum

def score(dice, category):
    return category(dice)
