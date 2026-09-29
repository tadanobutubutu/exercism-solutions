#include "collatz_conjecture.h"

#include <stdint.h>

int steps(int start)
{
    if (start <= 0) {
        return ERROR_VALUE;
    }

    int64_t value = start;
    int count = 0;
    while (value != 1) {
        if (value % 2 == 0) {
            value /= 2;
        } else {
            value = 3 * value + 1;
        }
        ++count;
    }
    return count;
}
