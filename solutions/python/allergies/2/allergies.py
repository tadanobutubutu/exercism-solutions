class Allergies:
    ALLERGENS = [
        "eggs",
        "peanuts",
        "shellfish",
        "strawberries",
        "tomatoes",
        "chocolate",
        "pollen",
        "cats",
    ]

    def __init__(self, score):
        self.score = score

    def allergic_to(self, item):
        index = self.ALLERGENS.index(item)
        return bool(self.score & (1 << index))

    @property
    def lst(self):
        return [item for i, item in enumerate(self.ALLERGENS) if self.score & (1 << i)]
