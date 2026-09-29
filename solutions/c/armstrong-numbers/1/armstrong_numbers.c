#include "armstrong_numbers.h"

#include <stdint.h>

bool is_armstrong_number(int candidate)
{
    if (candidate < 0) {
        return false;
    }

    unsigned int digits = 1;
    for (int remaining = candidate; remaining >= 10; remaining /= 10) {
        ++digits;
    }

    uint64_t sum = 0;
    int remaining = candidate;
    do {
        unsigned int digit = (unsigned int)(remaining % 10);
        uint64_t power = 1;
        for (unsigned int exponent = 0; exponent < digits; ++exponent) {
            power *= digit;
        }
        sum += power;
        remaining /= 10;
    } while (remaining > 0);

    return sum == (uint64_t)candidate;
}
