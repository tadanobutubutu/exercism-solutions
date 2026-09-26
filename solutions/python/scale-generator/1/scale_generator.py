_SHARPS = ("C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B")
_FLATS = ("C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B")
_FLAT_MAJOR_KEYS = {"F", "Bb", "Eb", "Ab", "Db", "Gb"}
_FLAT_MINOR_KEYS = {"d", "g", "c", "f", "bb", "eb"}


class Scale:
    def __init__(self, tonic):
        self.tonic = tonic[0].upper() + tonic[1:].lower()
        use_flats = self.tonic in _FLAT_MAJOR_KEYS or (
            tonic[0].islower() and tonic.lower() in _FLAT_MINOR_KEYS
        )
        self._notes = _FLATS if use_flats else _SHARPS
        self._start = self._notes.index(self.tonic)

    def chromatic(self):
        return [self._notes[(self._start + step) % 12] for step in range(12)]

    def interval(self, intervals):
        steps = {"m": 1, "M": 2, "A": 3}
        notes = [self.tonic]
        position = self._start
        for interval in intervals:
            position = (position + steps[interval]) % 12
            notes.append(self._notes[position])
        return notes
