class BowlingGame:
    def __init__(self):
        self.rolls = []

    def _ninth_frame_end(self):
        index = 0
        for _ in range(9):
            if index >= len(self.rolls):
                return None
            if self.rolls[index] == 10:
                index += 1
            else:
                if index + 1 >= len(self.rolls):
                    return None
                index += 2
        return index

    def _first_nine_state(self):
        index = 0
        for _ in range(9):
            if index >= len(self.rolls):
                return None, None
            if self.rolls[index] == 10:
                index += 1
            elif index + 1 >= len(self.rolls):
                return None, self.rolls[index]
            else:
                index += 2
        return index, None

    def roll(self, pins):
        if not isinstance(pins, int) or not 0 <= pins <= 10:
            raise ValueError("Invalid pin count")

        frame_end, pending_first_roll = self._first_nine_state()
        if frame_end is None:
            if pending_first_roll is not None and pending_first_roll + pins > 10:
                raise ValueError("Pin count exceeds pins standing")
            self.rolls.append(pins)
            return

        tenth = self.rolls[frame_end:]
        if len(tenth) >= 3:
            raise ValueError("Game is already complete")
        if len(tenth) == 1 and tenth[0] != 10 and tenth[0] + pins > 10:
            raise ValueError("Pin count exceeds pins standing")
        if len(tenth) == 2:
            first, second = tenth
            if first == 10:
                if second != 10 and second + pins > 10:
                    raise ValueError("Pin count exceeds pins standing")
            elif first + second == 10:
                pass
            else:
                raise ValueError("Game is already complete")
        self.rolls.append(pins)

    def score(self):
        if not self.rolls:
            raise ValueError("Game has not started")
        index = 0
        total = 0
        for _ in range(9):
            if index >= len(self.rolls):
                raise ValueError("Game is incomplete")
            if self.rolls[index] == 10:
                if index + 2 >= len(self.rolls):
                    raise ValueError("Game is incomplete")
                total += 10 + self.rolls[index + 1] + self.rolls[index + 2]
                index += 1
            else:
                if index + 1 >= len(self.rolls):
                    raise ValueError("Game is incomplete")
                first, second = self.rolls[index : index + 2]
                frame_score = first + second
                if frame_score == 10:
                    if index + 2 >= len(self.rolls):
                        raise ValueError("Game is incomplete")
                    frame_score += self.rolls[index + 2]
                total += frame_score
                index += 2

        tenth = self.rolls[index:]
        if len(tenth) < 2:
            raise ValueError("Game is incomplete")
        if tenth[0] == 10:
            if len(tenth) < 3:
                raise ValueError("Game is incomplete")
        elif sum(tenth[:2]) == 10:
            if len(tenth) < 3:
                raise ValueError("Game is incomplete")
        elif len(tenth) != 2:
            raise ValueError("Invalid final frame")
        total += sum(tenth)
        return total
