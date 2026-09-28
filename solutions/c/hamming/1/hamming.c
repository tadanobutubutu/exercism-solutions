#include "hamming.h"
#include <stddef.h>
#include <string.h>

#include "hamming.h"

int compute(const char *lhs, const char *rhs)
{
   size_t distance = 0;
   size_t length;

   if (lhs == NULL || rhs == NULL) {
      return -1;
   }

   length = strlen(lhs);
   if (length != strlen(rhs)) {
      return -1;
   }

   for (size_t index = 0; index < length; index++) {
      if (lhs[index] != rhs[index]) {
         distance++;
      }
   }

   return (int)distance;
}
