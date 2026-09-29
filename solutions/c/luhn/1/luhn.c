#include "luhn.h"

#include <stddef.h>
#include <string.h>

bool luhn(const char *num)
{
   if (num == NULL) {
      return false;
   }

   size_t digits = 0;
   int sum = 0;
   size_t length = strlen(num);
   bool double_digit = false;
   for (size_t index = length; index > 0; index--) {
      char character = num[index - 1];
      if (character == ' ') {
         continue;
      }
      if (character < '0' || character > '9') {
         return false;
      }

      int value = character - '0';
      if (double_digit) {
         value *= 2;
         if (value > 9) {
            value -= 9;
         }
      }
      sum += value;
      digits++;
      double_digit = !double_digit;
   }

   return digits > 1 && sum % 10 == 0;
}
