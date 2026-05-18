PARTS = [
    ("the house that Jack built.", ""),
    ("the malt", "that lay in"),
    ("the rat", "that ate"),
    ("the cat", "that killed"),
    ("the dog", "that worried"),
    ("the cow with the crumpled horn", "that tossed"),
    ("the maiden all forlorn", "that milked"),
    ("the man all tattered and torn", "that kissed"),
    ("the priest all shaven and shorn", "that married"),
    ("the rooster that crowed in the morn", "that woke"),
    ("the farmer sowing his corn", "that kept"),
    ("the horse and the hound and the horn", "that belonged to")
]

def recite(start_verse, end_verse):
    res = []
    for i in range(start_verse, end_verse + 1):
        res.append(get_verse(i))
    return res

def get_verse(n):
    verse = f"This is {PARTS[n-1][0]}"
    for i in range(n-1, 0, -1):
        verse += f" {PARTS[i][1]} {PARTS[i-1][0]}"
    return verse
