#include "series.h"

#include <stdlib.h>
#include <string.h>

slices_t slices(char *input_text, unsigned int substring_length)
{
   slices_t result = { 0, NULL };
   if (!input_text || substring_length == 0)
      return result;

   size_t length = strlen(input_text);
   if ((size_t)substring_length > length)
      return result;

   size_t count = length - substring_length + 1;
   result.substring = calloc(count, sizeof(*result.substring));
   if (!result.substring)
      return result;
   for (size_t i = 0; i < count; ++i) {
      result.substring[i] = malloc((size_t)substring_length + 1);
      if (!result.substring[i]) {
         for (size_t j = 0; j < i; ++j)
            free(result.substring[j]);
         free(result.substring);
         result.substring = NULL;
         return result;
      }
      memcpy(result.substring[i], input_text + i, substring_length);
      result.substring[i][substring_length] = '\0';
   }
   result.substring_count = (unsigned int)count;
   return result;
}
