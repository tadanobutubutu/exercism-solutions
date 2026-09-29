#include "binary.h"

#include <limits.h>
#include <stddef.h>

int convert(const char *input)
{
    if (input == NULL || *input == '\0') {
        return INVALID;
    }

    int value = 0;
    for (const char *digit = input; *digit != '\0'; ++digit) {
        if (*digit != '0' && *digit != '1') {
            return INVALID;
        }

        int bit = *digit - '0';
        if (value > (INT_MAX - bit) / 2) {
            return INVALID;
        }
        value = value * 2 + bit;
    }
    return value;
}
