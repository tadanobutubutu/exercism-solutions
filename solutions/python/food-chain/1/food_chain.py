_ANIMALS = ("fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse")
_COMMENTS = {
    2: "It wriggled and jiggled and tickled inside her.",
    3: "How absurd to swallow a bird!",
    4: "Imagine that, to swallow a cat!",
    5: "What a hog, to swallow a dog!",
    6: "Just opened her throat and swallowed a goat!",
    7: "I don't know how she swallowed a cow!",
    8: "She's dead, of course!",
}


def _verse(number):
    animal = _ANIMALS[number - 1]
    lines = [f"I know an old lady who swallowed a {animal}.", _COMMENTS.get(number)]

    if number == 8:
        return lines

    if number == 1:
        return lines[:1] + ["I don't know why she swallowed the fly. Perhaps she'll die."]

    for index in range(number - 1, 0, -1):
        swallowed = _ANIMALS[index]
        prey = _ANIMALS[index - 1]
        line = f"She swallowed the {swallowed} to catch the {prey}"
        if index == 2:
            line += " that wriggled and jiggled and tickled inside her."
        else:
            line += "."
        lines.append(line)

    lines.append("I don't know why she swallowed the fly. Perhaps she'll die.")
    return lines


def recite(start_verse, end_verse):
    verses = []
    for number in range(start_verse, end_verse + 1):
        if verses:
            verses.append("")
        verses.extend(_verse(number))
    return verses
