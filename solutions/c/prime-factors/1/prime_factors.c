#include "prime_factors.h"

size_t find_factors(uint64_t n, uint64_t factors[static MAXFACTORS])
{
   if (n < 2 || factors == NULL) {
      return 0;
   }

   size_t count = 0;
   for (uint64_t factor = 2; factor <= n / factor && count < MAXFACTORS;
        factor = factor == 2 ? 3 : factor + 2) {
      while (n % factor == 0 && count < MAXFACTORS) {
         factors[count++] = factor;
         n /= factor;
      }
   }

   if (n > 1 && count < MAXFACTORS) {
      factors[count++] = n;
   }

   return count;
}
