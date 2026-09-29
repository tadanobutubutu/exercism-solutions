#include "pascals_triangle.h"

#include <stdlib.h>

uint8_t **create_triangle(size_t rows)
{
   if (rows == 0) {
      uint8_t **empty = calloc(1, sizeof(*empty));
      if (empty)
         empty[0] = calloc(1, sizeof(*empty[0]));
      if (empty && !empty[0]) {
         free(empty);
         return NULL;
      }
      return empty;
   }
   uint8_t **triangle = calloc(rows, sizeof(*triangle));
   if (!triangle)
      return NULL;

   for (size_t r = 0; r < rows; ++r) {
      triangle[r] = calloc(r + 1, sizeof(*triangle[r]));
      if (!triangle[r]) {
         free_triangle(triangle, rows);
         return NULL;
      }
      triangle[r][0] = 1;
      triangle[r][r] = 1;
      for (size_t c = 1; c < r; ++c)
         triangle[r][c] = (uint8_t)(triangle[r - 1][c - 1] +
                                    triangle[r - 1][c]);
   }
   return triangle;
}

void free_triangle(uint8_t **triangle, size_t rows)
{
   if (!triangle)
      return;
   for (size_t r = 0; r < rows; ++r)
      free(triangle[r]);
   free(triangle);
}
