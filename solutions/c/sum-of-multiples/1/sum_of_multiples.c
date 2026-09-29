#include "sum_of_multiples.h"

#include <stdint.h>

unsigned int sum(const unsigned int *factors, const size_t number_of_factors,
                 const unsigned int limit)
{
   uint64_t total = 0;
   for (unsigned int value = 1; value < limit; ++value) {
      for (size_t i = 0; factors && i < number_of_factors; ++i) {
         if (factors[i] != 0 && value % factors[i] == 0) {
            total += value;
            break;
         }
      }
   }
   return (unsigned int)total;
}
