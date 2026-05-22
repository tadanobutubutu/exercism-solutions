def best_hands(hands):
    def rank(hand):
        cards = [(v, s) for v, s in (card.rstrip(",") for card in hand.split())]
        values = sorted("--23456789TJQKA".index(v) for v, s in cards)
        suits = [s for v, s in cards]
        is_flush = len(set(suits)) == 1
        is_straight = values == list(range(values[0], values[0] + 5)) or values == [2, 3, 4, 5, 14]
        if is_straight and is_flush:
            return (8, values[-1] if values[-1] != 14 or values[0] == 10 else 5)
        groups = sorted([(values.count(v), v) for v in set(values)], reverse=True)
        if groups[0][0] == 4:
            return (7, groups[0][1], groups[1][1])
        if groups[0][0] == 3 and groups[1][0] == 2:
            return (6, groups[0][1], groups[1][1])
        if is_flush:
            return (5, *reversed(values))
        if is_straight:
            return (4, values[-1] if values[-1] != 14 or values[0] == 10 else 5)
        if groups[0][0] == 3:
            return (3, groups[0][1], groups[1][1])
        pairs = [g[1] for g in groups if g[0] == 2]
        if len(pairs) == 2:
            return (2, *sorted(pairs, reverse=True), groups[0][1])
        if len(pairs) == 1:
            return (1, pairs[0], *sorted([v for v in values if v != pairs[0]], reverse=True))
        return (0, *reversed(values))
    best = max(hands, key=lambda h: rank(h))
    return [best]
