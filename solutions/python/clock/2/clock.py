class Clock:
    def __init__(self, hour, minute):
        total = (hour * 60 + minute) % 1440
        self.h = total // 60
        self.m = total % 60

    def __repr__(self):
        return f"Clock({self.h}, {self.m})"

    def __eq__(self, other):
        return self.h == other.h and self.m == other.m

    def __add__(self, minutes):
        total = (self.h * 60 + self.m + minutes) % 1440
        return Clock(total // 60, total % 60)

    def __sub__(self, minutes):
        return self + (-minutes)
