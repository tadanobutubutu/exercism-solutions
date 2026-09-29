#include "largest_series_product.h"

#include <string.h>

int64_t largest_series_product(char *digits, size_t span)
{
   if (!digits)
      return -1;
   size_t length = strlen(digits);
   if (span > length)
      return -1;
   for (size_t i = 0; i < length; ++i)
      if (digits[i] < '0' || digits[i] > '9')
         return -1;
   if (span == 0)
      return 1;

   int64_t largest = 0;
   for (size_t start = 0; start + span <= length; ++start) {
      int64_t product = 1;
      for (size_t offset = 0; offset < span; ++offset)
         product *= digits[start + offset] - '0';
      if (product > largest)
         largest = product;
   }
   return largest;
}
