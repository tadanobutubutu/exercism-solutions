#include "sieve.h"

#include <stdbool.h>
#include <stdlib.h>

uint32_t sieve(uint32_t limit, uint32_t *primes, size_t max_primes)
{
   if (limit < 2 || primes == NULL || max_primes == 0) {
      return 0;
   }

   bool *composite = calloc((size_t)limit + 1, sizeof(*composite));
   if (composite == NULL) {
      return 0;
   }

   for (uint64_t prime = 2; prime * prime <= limit; prime++) {
      if (!composite[prime]) {
         for (uint64_t multiple = prime * prime; multiple <= limit;
              multiple += prime) {
            composite[multiple] = true;
         }
      }
   }

   size_t count = 0;
   for (uint64_t number = 2; number <= limit && count < max_primes; number++) {
      if (!composite[number]) {
         primes[count++] = (uint32_t)number;
      }
   }

   free(composite);
   return (uint32_t)count;
}
