#include "crypto_square.h"

#include <ctype.h>
#include <stdlib.h>
#include <string.h>

char *ciphertext(const char *input)
{
   if (!input)
      input = "";
   size_t input_length = strlen(input);
   char *normalized = malloc(input_length + 1);
   if (!normalized)
      return NULL;

   size_t length = 0;
   for (const unsigned char *p = (const unsigned char *)input; *p; ++p)
      if (isalnum(*p))
         normalized[length++] = (char)tolower(*p);
   normalized[length] = '\0';
   if (length == 0)
      return normalized;

   size_t columns = 1;
   while (columns * columns < length)
      ++columns;
   size_t rows = (length + columns - 1) / columns;
   size_t output_length = rows * columns + columns - 1;
   char *result = malloc(output_length + 1);
   if (!result) {
      free(normalized);
      return NULL;
   }

   size_t out = 0;
   for (size_t column = 0; column < columns; ++column) {
      for (size_t row = 0; row < rows; ++row) {
         size_t index = row * columns + column;
         result[out++] = index < length ? normalized[index] : ' ';
      }
      if (column + 1 < columns)
         result[out++] = ' ';
   }
   result[out] = '\0';
   free(normalized);
   return result;
}
