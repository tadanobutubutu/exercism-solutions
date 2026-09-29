#include "acronym.h"

#include <ctype.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

char *abbreviate(const char *phrase)
{
   size_t length;
   size_t output_length = 0;
   int at_word_start = 1;

   if (phrase == NULL || phrase[0] == '\0') {
      return NULL;
   }

   length = strlen(phrase);
   char *result = malloc(length + 1);
   if (result == NULL) {
      return NULL;
   }

   for (size_t index = 0; index < length; index++) {
      unsigned char character = (unsigned char)phrase[index];

      if (isspace(character) || character == '-') {
         at_word_start = 1;
      } else if (isalpha(character)) {
         if (at_word_start) {
            result[output_length++] = (char)toupper(character);
         }
         at_word_start = 0;
      }
   }

   if (output_length == 0) {
      free(result);
      return NULL;
   }

   result[output_length] = '\0';
   return result;
}
