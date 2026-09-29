#include "space_age.h"

float age(planet_t planet, int64_t seconds)
{
    static const double orbital_periods[] = {
        0.2408467,
        0.61519726,
        1.0,
        1.8808158,
        11.862615,
        29.447498,
        84.016846,
        164.79132
    };

    if ((int)planet < 0 || planet > NEPTUNE) {
        return -1.0f;
    }

    const double earth_year_seconds = 31557600.0;
    return (float)((double)seconds / (earth_year_seconds * orbital_periods[planet]));
}
