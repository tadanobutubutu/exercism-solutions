#include "resistor_color_trio.h"

resistor_value_t color_code(const resistor_band_t bands[])
{
    static const uint64_t powers_of_ten[] = {
        UINT64_C(1), UINT64_C(10), UINT64_C(100), UINT64_C(1000),
        UINT64_C(10000), UINT64_C(100000), UINT64_C(1000000),
        UINT64_C(10000000), UINT64_C(100000000), UINT64_C(1000000000)
    };

    uint64_t value = (10 * (uint64_t)bands[0] + bands[1]) * powers_of_ten[bands[2]];
    resistor_unit_t unit = OHMS;
    while (unit < GIGAOHMS && value >= 1000 && value % 1000 == 0) {
        value /= 1000;
        unit = (resistor_unit_t)(unit + 1);
    }

    return (resistor_value_t){ .value = (uint16_t)value, .unit = unit };
}
