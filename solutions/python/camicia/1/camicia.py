from collections import deque


def simulate_game(player_a, player_b):
    players = [deque(player_a), deque(player_b)]
    penalties = {"J": 1, "Q": 2, "K": 3, "A": 4}
    current = 0
    owed = 0
    pile = []
    cards_played = 0
    tricks = 0
    seen = set()

    def signature(deck):
        return tuple("N" if card not in penalties else card for card in deck)

    while True:
        if not pile and owed == 0:
            state = (signature(players[0]), signature(players[1]), current)
            if state in seen:
                return {"status": "loop", "cards": cards_played, "tricks": tricks}
            seen.add(state)

        if not players[current]:
            winner = 1 - current
            players[winner].extend(pile)
            pile.clear()
            tricks += 1
            if not players[1 - winner]:
                return {"status": "finished", "cards": cards_played, "tricks": tricks}
            current = winner
            owed = 0
            continue

        card = players[current].popleft()
        pile.append(card)
        cards_played += 1

        if card in penalties:
            owed = penalties[card]
            current = 1 - current
        elif owed:
            owed -= 1
            if owed == 0:
                winner = 1 - current
                players[winner].extend(pile)
                pile.clear()
                tricks += 1
                if not players[1 - winner]:
                    return {"status": "finished", "cards": cards_played, "tricks": tricks}
                current = winner
            # A normal card during payment leaves the same player paying.
        else:
            current = 1 - current
