#include "eliuds_eggs.h"

unsigned int egg_count(unsigned int display_value)
{
    unsigned int count = 0;
    while (display_value != 0) {
        display_value &= display_value - 1;
        ++count;
    }
    return count;
}
