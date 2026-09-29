#include "gigasecond.h"

#include <stdio.h>
#include <time.h>

void gigasecond(time_t input, char *output, size_t size)
{
   if (output == NULL || size == 0) {
      return;
   }

   time_t result = input + (time_t)1000000000;
   struct tm *utc = gmtime(&result);
   if (utc == NULL || strftime(output, size, "%Y-%m-%d %H:%M:%S", utc) == 0) {
      output[0] = '\0';
   }
}
