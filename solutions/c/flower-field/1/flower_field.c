#include "flower_field.h"

#include <stdlib.h>
#include <string.h>

char **annotate(const char **garden, const size_t rows)
{
   if (!garden || rows == 0)
      return NULL;

   size_t columns = garden[0] ? strlen(garden[0]) : 0;
   char **result = calloc(rows + 1, sizeof(*result));
   if (!result)
      return NULL;

   for (size_t r = 0; r < rows; ++r) {
      result[r] = malloc(columns + 1);
      if (!result[r]) {
         free_annotation(result);
         return NULL;
      }
      result[r][columns] = '\0';
      for (size_t c = 0; c < columns; ++c) {
         if (garden[r][c] == '*') {
            result[r][c] = '*';
            continue;
         }
         unsigned int flowers = 0;
         for (int dr = -1; dr <= 1; ++dr) {
            for (int dc = -1; dc <= 1; ++dc) {
               if (dr == 0 && dc == 0)
                  continue;
               long nr = (long)r + dr;
               long nc = (long)c + dc;
               if (nr >= 0 && (size_t)nr < rows && nc >= 0 &&
                   (size_t)nc < columns && garden[nr][nc] == '*')
                  ++flowers;
            }
         }
         result[r][c] = flowers ? (char)('0' + flowers) : garden[r][c];
      }
   }
   return result;
}

void free_annotation(char **annotation)
{
   if (!annotation)
      return;
   for (size_t r = 0; annotation[r]; ++r)
      free(annotation[r]);
   free(annotation);
}
