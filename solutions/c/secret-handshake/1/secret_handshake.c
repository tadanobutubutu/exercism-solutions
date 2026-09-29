#include "secret_handshake.h"

#include <stdlib.h>

const char **commands(size_t number)
{
   static const char *actions[] = {
      "wink", "double blink", "close your eyes", "jump"
   };
   const char **result = calloc(4, sizeof(*result));
   if (!result)
      return NULL;

   size_t count = 0;
   for (size_t bit = 0; bit < 4; ++bit)
      if (number & ((size_t)1 << bit))
         result[count++] = actions[bit];
   if (number & 16)
      for (size_t left = 0; left < count / 2; ++left) {
         const char *swap = result[left];
         result[left] = result[count - 1 - left];
         result[count - 1 - left] = swap;
      }
   return result;
}
