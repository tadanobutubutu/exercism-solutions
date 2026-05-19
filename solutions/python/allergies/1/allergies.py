class Allergies:
    ALLERGENS = [
        'eggs',
        'peanuts',
        'shellfish',
        'strawberries',
        'tomatoes',
        'chocolate',
        'pollen',
        'cats'
    ]

    def __init__(self, score):
        self.score = score

    def allergic_to(self, item):
        return item in self.lst

    @property
    def lst(self):
        res = []
        for i, allergen in enumerate(self.ALLERGENS):
            if (self.score >> i) & 1:
                res.append(allergen)
        return res
