#include "rail_fence_cipher.h"

#include <stdlib.h>
#include <string.h>

char *encode(char *text, size_t rails)
{
   if (!text)
      text = "";
   size_t length = strlen(text);
   char *encoded = malloc(length + 1);
   if (!encoded)
      return NULL;
   if (rails <= 1 || rails >= length) {
      memcpy(encoded, text, length + 1);
      return encoded;
   }

   size_t cycle = 2 * (rails - 1);
   size_t out = 0;
   for (size_t rail = 0; rail < rails; ++rail) {
      for (size_t position = rail; position < length; position += cycle) {
         encoded[out++] = text[position];
         size_t diagonal = position + cycle - 2 * rail;
         if (rail != 0 && rail + 1 != rails && diagonal < length)
            encoded[out++] = text[diagonal];
      }
   }
   encoded[out] = '\0';
   return encoded;
}

char *decode(char *ciphertext, size_t rails)
{
   if (!ciphertext)
      ciphertext = "";
   size_t length = strlen(ciphertext);
   char *decoded = malloc(length + 1);
   if (!decoded)
      return NULL;
   if (rails <= 1 || rails >= length) {
      memcpy(decoded, ciphertext, length + 1);
      return decoded;
   }

   size_t *counts = calloc(rails, sizeof(*counts));
   size_t *offsets = calloc(rails, sizeof(*offsets));
   if (!counts || !offsets) {
      free(counts);
      free(offsets);
      free(decoded);
      return NULL;
   }

   size_t rail = 0;
   int direction = 1;
   for (size_t i = 0; i < length; ++i) {
      ++counts[rail];
      if (rail == 0)
         direction = 1;
      else if (rail + 1 == rails)
         direction = -1;
      rail = (size_t)((long)rail + direction);
   }
   for (size_t r = 1; r < rails; ++r)
      offsets[r] = offsets[r - 1] + counts[r - 1];

   rail = 0;
   direction = 1;
   for (size_t i = 0; i < length; ++i) {
      decoded[i] = ciphertext[offsets[rail]++];
      if (rail == 0)
         direction = 1;
      else if (rail + 1 == rails)
         direction = -1;
      rail = (size_t)((long)rail + direction);
   }
   decoded[length] = '\0';
   free(counts);
   free(offsets);
   return decoded;
}
