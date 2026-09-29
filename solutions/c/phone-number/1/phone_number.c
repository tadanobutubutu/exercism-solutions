#include "phone_number.h"

#include <ctype.h>
#include <stdlib.h>

static char *invalid_number(void)
{
   char *invalid = malloc(11);
   if (invalid) {
      for (int i = 0; i < 10; ++i)
         invalid[i] = '0';
      invalid[10] = '\0';
   }
   return invalid;
}

char *phone_number_clean(const char *input)
{
   if (!input)
      return invalid_number();

   char digits[12];
   size_t count = 0;
   int seen_digit = 0;
   int seen_plus = 0;
   for (const unsigned char *p = (const unsigned char *)input; *p; ++p) {
      if (isdigit(*p)) {
         if (count >= sizeof(digits) - 1)
            return invalid_number();
         digits[count++] = (char)*p;
         seen_digit = 1;
      } else if (isspace(*p) || *p == '.' || *p == '-' || *p == '(' ||
                 *p == ')') {
         continue;
      } else if (*p == '+' && !seen_digit && !seen_plus) {
         seen_plus = 1;
      } else {
         return invalid_number();
      }
   }

   if (count == 11 && digits[0] == '1') {
      for (size_t i = 0; i < 10; ++i)
         digits[i] = digits[i + 1];
      count = 10;
   }
   if (count != 10 || digits[0] < '2' || digits[0] > '9' || digits[3] < '2' ||
       digits[3] > '9')
      return invalid_number();

   char *number = malloc(11);
   if (!number)
      return NULL;
   for (size_t i = 0; i < 10; ++i)
      number[i] = digits[i];
   number[10] = '\0';
   return number;
}
