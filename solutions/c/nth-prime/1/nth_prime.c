#include "nth_prime.h"

#include <stddef.h>
#include <stdlib.h>

uint32_t nth(uint32_t n)
{
   if (n == 0 || (size_t)n > SIZE_MAX / sizeof(uint32_t)) {
      return 0;
   }

   uint32_t *primes = malloc((size_t)n * sizeof(*primes));
   if (primes == NULL) {
      return 0;
   }

   size_t count = 0;
   uint64_t candidate = 2;
   while (count < n && candidate <= UINT32_MAX) {
      int is_prime = 1;
      for (size_t index = 0; index < count; index++) {
         uint64_t prime = primes[index];
         if (prime > candidate / prime) {
            break;
         }
         if (candidate % prime == 0) {
            is_prime = 0;
            break;
         }
      }
      if (is_prime) {
         primes[count++] = (uint32_t)candidate;
      }
      candidate = candidate == 2 ? 3 : candidate + 2;
   }

   uint32_t result = count == n ? primes[n - 1] : 0;
   free(primes);
   return result;
}
