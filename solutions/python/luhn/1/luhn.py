class Luhn:
    def __init__(self, card_num):
        self.card_num = card_num.replace(" ", "")

    def valid(self):
        if len(self.card_num) <= 1 or not self.card_num.isdigit():
            return False
        
        digits = [int(d) for d in self.card_num]
        
        # Luhn algorithm
        # Double every second digit from the right
        for i in range(len(digits) - 2, -1, -2):
            val = digits[i] * 2
            if val > 9:
                val -= 9
            digits[i] = val
            
        return sum(digits) % 10 == 0
