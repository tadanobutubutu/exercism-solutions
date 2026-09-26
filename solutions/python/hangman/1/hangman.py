# Game status categories
# Change the values as you see fit
STATUS_WIN = 'win'
STATUS_LOSE = 'lose'
STATUS_ONGOING = 'ongoing'


class Hangman:
    def __init__(self, word):
        self.word = word
        self.remaining_guesses = 9
        self.status = STATUS_ONGOING
        self.guessed = set()

    def guess(self, char):
        if self.status != STATUS_ONGOING:
            raise ValueError("The game has already ended.")
        if char in self.word and char not in self.guessed:
            self.guessed.add(char)
            if all(letter in self.guessed for letter in self.word):
                self.status = STATUS_WIN
        else:
            if self.remaining_guesses == 0:
                self.status = STATUS_LOSE
            else:
                self.remaining_guesses -= 1

    def get_masked_word(self):
        return "".join(letter if letter in self.guessed else "_" for letter in self.word)

    def get_status(self):
        return self.status
