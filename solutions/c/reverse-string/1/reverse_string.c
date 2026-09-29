#include "reverse_string.h"

#include <stddef.h>
#include <stdlib.h>
#include <string.h>

char *reverse(const char *value)
{
   if (value == NULL) {
      return NULL;
   }

   size_t length = strlen(value);
   char *result = malloc(length + 1);
   if (result == NULL) {
      return NULL;
   }

   for (size_t index = 0; index < length; index++) {
      result[index] = value[length - index - 1];
   }
   result[length] = '\0';
   return result;
}
