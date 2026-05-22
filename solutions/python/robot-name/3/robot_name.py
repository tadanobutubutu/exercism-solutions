import random
import string

class Robot:
    _used_names = set()

    def __init__(self):
        self.reset()

    def reset(self):
        self.name = self._generate_unique_name()

    def _generate_unique_name(self):
        while True:
            name = "".join(random.choices(string.ascii_uppercase, k=2)) + \
                   "".join(random.choices(string.digits, k=3))
            if name not in Robot._used_names:
                Robot._used_names.add(name)
                return name
