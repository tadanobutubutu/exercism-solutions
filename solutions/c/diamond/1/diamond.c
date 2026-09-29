#include "diamond.h"

#include <ctype.h>
#include <stdlib.h>

char **make_diamond(const char letter)
{
   char upper = (char)toupper((unsigned char)letter);
   if (upper < 'A' || upper > 'Z')
      return NULL;
   size_t radius = (size_t)(upper - 'A');
   size_t width = radius * 2 + 1;
   size_t rows = width;
   char **diamond = calloc(rows + 1, sizeof(*diamond));
   if (!diamond)
      return NULL;

   for (size_t r = 0; r < rows; ++r) {
      size_t level = r <= radius ? r : rows - 1 - r;
      size_t left = radius - level;
      diamond[r] = malloc(width + 1);
      if (!diamond[r]) {
         free_diamond(diamond);
         return NULL;
      }
      for (size_t c = 0; c < width; ++c)
         diamond[r][c] = ' ';
      diamond[r][left] = (char)('A' + level);
      diamond[r][width - 1 - left] = (char)('A' + level);
      diamond[r][width] = '\0';
   }
   return diamond;
}

void free_diamond(char **diamond)
{
   if (!diamond)
      return;
   for (size_t r = 0; diamond[r]; ++r)
      free(diamond[r]);
   free(diamond);
}
