PIECES = [
    "the house that Jack built.",
    "the malt that lay in",
    "the rat that ate",
    "the cat that killed",
    "the dog that worried",
    "the cow with the crumpled horn that tossed",
    "the maiden all forlorn that milked",
    "the man all tattered and torn that kissed",
    "the priest all shaven and shorn that married",
    "the rooster that crowed in the morn that woke",
    "the farmer sowing his corn that kept",
    "the horse and the hound and the horn that belonged to",
]


def recite(start, end):
    result = []
    for i in range(start, end + 1):
        parts = " ".join(PIECES[j] for j in range(i - 1, -1, -1))
        result.append(f"This is {parts}")
    return result