class Allergies:
    """
    Class to determine allergies based on a person's allergy score.
    """
    def __init__(self, score: int):
        """
        Initialize the Allergies class with a score.
        
        Args:
            score: The allergy score.
        """
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
        
    def allergic_to(self, item: str) -> bool:
        """
        Determine if the person is allergic to a specific item.
        
        Args:
            item: The item to check for allergy.
        
        Returns:
            bool: True if the person is allergic to the item, False otherwise.
        """
        if item not in self.allergens:
            return False
        return (self.score & self.allergens[item]) != 0
    
    @property
    def lst(self) -> list[str]:
        """
        Get the list of allergens the person is allergic to.
        
        Returns:
            list[str]: A list of allergens the person is allergic to.
        """
        allergies = []
        for item, value in self.allergens.items():
            if (self.score & value) != 0:
                allergies.append(item)
        return allergies