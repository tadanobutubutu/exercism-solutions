#include "grains.h"

uint64_t square(uint8_t index)
{
    if (index == 0 || index > 64) {
        return 0;
    }
    return UINT64_C(1) << (index - 1);
}

uint64_t total(void)
{
    return UINT64_MAX;
}
