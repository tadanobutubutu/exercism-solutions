#include "binary_search.h"

const int *binary_search(int value, const int *arr, size_t length)
{
   size_t low = 0;
   size_t high = length;

   if (arr == NULL) {
      return NULL;
   }

   while (low < high) {
      size_t middle = low + (high - low) / 2;

      if (arr[middle] == value) {
         return &arr[middle];
      }
      if (arr[middle] < value) {
         low = middle + 1;
      } else {
         high = middle;
      }
   }

   return NULL;
}
