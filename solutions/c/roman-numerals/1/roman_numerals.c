#include "roman_numerals.h"

#include <stdlib.h>

char *to_roman_numeral(unsigned int number)
{
   static const unsigned int values[] = {
      1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1
   };
   static const char *symbols[] = {
      "M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"
   };
   char *result = malloc(32);
   if (!result)
      return NULL;

   size_t position = 0;
   for (size_t i = 0; i < sizeof(values) / sizeof(values[0]); ++i) {
      while (number >= values[i]) {
         const char *symbol = symbols[i];
         while (*symbol)
            result[position++] = *symbol++;
         number -= values[i];
      }
   }
   result[position] = '\0';
   return result;
}
