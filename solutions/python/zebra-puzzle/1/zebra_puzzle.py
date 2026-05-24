import itertools

COLORS = ["Red", "Green", "Ivory", "Yellow", "Blue"]
NATIONS = ["Englishman", "Spaniard", "Ukrainian", "Norwegian", "Japanese"]
DRINKS = ["Tea", "Coffee", "Milk", "OrangeJuice", "Water"]
SMOKES = ["OldGold", "Kools", "Chesterfield", "LuckyStrike", "Parliaments"]
PETS = ["Dog", "Snails", "Fox", "Horse", "Zebra"]


def solve():
    for colors in itertools.permutations(COLORS):
        if colors.index("Green") != colors.index("Ivory") + 1:
            continue

        for nations in itertools.permutations(NATIONS):
            if nations[0] != "Norwegian":
                continue
            if nations[colors.index("Red")] != "Englishman":
                continue
            if abs(nations.index("Norwegian") - colors.index("Blue")) != 1:
                continue

            for drinks in itertools.permutations(DRINKS):
                if drinks[colors.index("Green")] != "Coffee":
                    continue
                if drinks[nations.index("Ukrainian")] != "Tea":
                    continue
                if drinks[2] != "Milk":
                    continue

                for smokes in itertools.permutations(SMOKES):
                    if smokes[colors.index("Yellow")] != "Kools":
                        continue
                    if smokes[nations.index("Japanese")] != "Parliaments":
                        continue
                    if drinks[smokes.index("LuckyStrike")] != "OrangeJuice":
                        continue

                    for pets in itertools.permutations(PETS):
                        if pets[nations.index("Spaniard")] != "Dog":
                            continue
                        if pets[smokes.index("OldGold")] != "Snails":
                            continue
                        if abs(pets.index("Fox") - smokes.index("Chesterfield")) != 1:
                            continue
                        if abs(pets.index("Horse") - smokes.index("Kools")) != 1:
                            continue

                        water = nations[drinks.index("Water")]
                        zebra = nations[pets.index("Zebra")]
                        return water, zebra

    return None, None


def drinks_water():
    return solve()[0]


def owns_zebra():
    return solve()[1]
