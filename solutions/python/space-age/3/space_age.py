class SpaceAge:
    EARTH_YEAR_SECONDS = 31557600
    
    RATIOS = {
        'mercury': 0.2408467,
        'venus': 0.61519726,
        'earth': 1.0,
        'mars': 1.8808158,
        'jupiter': 11.862615,
        'saturn': 29.447498,
        'uranus': 84.016846,
        'neptune': 164.79132
    }

    def __init__(self, seconds):
        self.seconds = seconds
        for planet, ratio in self.RATIOS.items():
            setattr(self, f'on_{planet}', self._on_planet(ratio))

    def _on_planet(self, ratio):
        return lambda: round(self.seconds / (self.EARTH_YEAR_SECONDS * ratio), 2)
