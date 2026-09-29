#include "perfect_numbers.h"

#include <stdint.h>

kind classify_number(int number)
{
    if (number <= 0) {
        return ERROR;
    }
    if (number == 1) {
        return DEFICIENT_NUMBER;
    }

    int64_t aliquot_sum = 1;
    for (int divisor = 2; divisor <= number / divisor; ++divisor) {
        if (number % divisor == 0) {
            aliquot_sum += divisor;
            int paired_divisor = number / divisor;
            if (paired_divisor != divisor) {
                aliquot_sum += paired_divisor;
            }
        }
    }

    if (aliquot_sum == number) {
        return PERFECT_NUMBER;
    }
    if (aliquot_sum > number) {
        return ABUNDANT_NUMBER;
    }
    return DEFICIENT_NUMBER;
}
