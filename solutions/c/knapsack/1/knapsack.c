#include "knapsack.h"

#include <stdlib.h>

unsigned int maximum_value(unsigned int maximum_weight, const item_t *items,
                           size_t item_count)
{
   unsigned int *best = calloc((size_t)maximum_weight + 1, sizeof(*best));
   if (!best)
      return 0;

   for (size_t i = 0; items && i < item_count; ++i) {
      if (items[i].weight > maximum_weight)
         continue;
      for (unsigned int capacity = maximum_weight;; --capacity) {
         if (capacity >= items[i].weight) {
            unsigned int candidate =
                best[capacity - items[i].weight] + items[i].value;
            if (candidate > best[capacity])
               best[capacity] = candidate;
         }
         if (capacity == items[i].weight)
            break;
      }
   }
   unsigned int result = best[maximum_weight];
   free(best);
   return result;
}
