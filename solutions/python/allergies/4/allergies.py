class Allergies:
    def __init__(self, score: int):
        self.score = score
        self.allergens = {
            "eggs": 1,
            "peanuts": 2,
            "shellfish": 4,
            "strawberries": 8,
            "tomatoes": 16,
            "chocolate": 32,
            "pollen": 64,
            "cats": 128,
        }
    
    def allergic_to(self, allergen: str) -> bool:
        if allergen not in self.allergens:
            return False
        return (self.score & self.allergens[allergen]) != 0
    
    @property
    def lst(self) -> list[str]:
        return [
            allergen for allergen, value in self.allergens.items()
            if (self.score & value) != 0
        ]