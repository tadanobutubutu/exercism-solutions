def best_hands(hands):
    def rank(hand):
        cards = []
        for c in hand.split():
            v = c[:-1]
            s = c[-1:]
            cards.append((v, s))
        values = sorted("--23456789TJQKA".index(v) for v, s in cards)
        suits = [s for v, s in cards]
        is_flush = len(set(suits)) == 1
        is_straight = values == list(range(values[0], values[0]+5)) or values == [2,3,4,5,14]
        if is_straight and is_flush:
            return (8, 5 if values[-1]==14 and values[4]==5 else values[-1])
        groups = sorted([(values.count(v), v) for v in set(values)], reverse=True)
        if groups[0][0]==4: return (7, groups[0][1], groups[1][1])
        if groups[0][0]==3 and groups[1][0]==2: return (6, groups[0][1], groups[1][1])
        if is_flush: return (5, *reversed(values))
        if is_straight: return (4, 5 if values[-1]==14 and values[4]==5 else values[-1])
        if groups[0][0]==3: return (3, groups[0][1], *sorted([v for g in groups[1:] for v in [g[1]]*g[0]], reverse=True))
        pairs = sorted([g[1] for g in groups if g[0]==2], reverse=True)
        if len(pairs)==2: return (2, pairs[0], pairs[1], groups[0][1])
        if len(pairs)==1: return (1, pairs[0], *sorted([v for v in values if v!=pairs[0]], reverse=True))
        return (0, *reversed(values))
    return [max(hands, key=lambda h: rank(h))]
