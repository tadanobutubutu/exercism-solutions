#include "pythagorean_triplet.h"

#include <stdlib.h>

static unsigned int gcd(unsigned int a, unsigned int b)
{
   while (b != 0) {
      unsigned int remainder = a % b;
      a = b;
      b = remainder;
   }
   return a;
}

triplets_t *triplets_with_sum(uint16_t sum)
{
   triplets_t *result = calloc(1, sizeof(*result));
   if (!result)
      return NULL;

   size_t capacity = 0;
   unsigned int total = sum;
   for (unsigned int m = 2; 2 * m * (m + 1) <= total; ++m) {
      for (unsigned int n = 1; n < m; ++n) {
         if (((m - n) % 2) == 0 || gcd(m, n) != 1)
            continue;
         unsigned int perimeter = 2 * m * (m + n);
         if (perimeter == 0 || total % perimeter != 0)
            continue;

         unsigned int scale = total / perimeter;
         unsigned int a = (m * m - n * n) * scale;
         unsigned int b = (2 * m * n) * scale;
         unsigned int c = (m * m + n * n) * scale;
         if (a > b) {
            unsigned int swap = a;
            a = b;
            b = swap;
         }

         if (result->count == capacity) {
            size_t next_capacity = capacity ? capacity * 2 : 4;
            triplet_t *grown =
                realloc(result->triplets, next_capacity * sizeof(*grown));
            if (!grown) {
               free_triplets(result);
               return NULL;
            }
            result->triplets = grown;
            capacity = next_capacity;
         }
         result->triplets[result->count++] =
             (triplet_t){ (uint16_t)a, (uint16_t)b, (uint16_t)c };
      }
   }
   return result;
}

void free_triplets(triplets_t *triplets)
{
   if (!triplets)
      return;
   free(triplets->triplets);
   free(triplets);
}
