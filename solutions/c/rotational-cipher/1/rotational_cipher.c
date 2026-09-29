#include "rotational_cipher.h"

#include <stddef.h>
#include <stdlib.h>
#include <string.h>

char *rotate(const char *text, int shift_key)
{
   if (text == NULL) {
      return NULL;
   }

   size_t length = strlen(text);
   char *result = malloc(length + 1);
   if (result == NULL) {
      return NULL;
   }

   int shift = shift_key % 26;
   if (shift < 0) {
      shift += 26;
   }

   for (size_t index = 0; index < length; index++) {
      char character = text[index];
      if (character >= 'a' && character <= 'z') {
         result[index] = (char)('a' + (character - 'a' + shift) % 26);
      } else if (character >= 'A' && character <= 'Z') {
         result[index] = (char)('A' + (character - 'A' + shift) % 26);
      } else {
         result[index] = character;
      }
   }

   result[length] = '\0';
   return result;
}
