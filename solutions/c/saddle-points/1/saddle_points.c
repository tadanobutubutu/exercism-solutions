#include "saddle_points.h"

#include <stdint.h>
#include <stdlib.h>

saddle_points_t *saddle_points(size_t rows, size_t columns,
                              const uint8_t matrix[rows][columns])
{
   saddle_points_t *result = calloc(1, sizeof(*result));
   if (!result)
      return NULL;
   if (rows == 0 || columns == 0 || !matrix)
      return result;
   if (rows > (size_t)-1 / columns)
      return result;

   size_t maximum_points = rows * columns;
   result->points = malloc(maximum_points * sizeof(*result->points));
   if (!result->points)
      return result;

   for (size_t row = 0; row < rows; ++row) {
      uint8_t row_max = matrix[row][0];
      for (size_t column = 1; column < columns; ++column)
         if (matrix[row][column] > row_max)
            row_max = matrix[row][column];

      for (size_t column = 0; column < columns; ++column) {
         if (matrix[row][column] != row_max)
            continue;
         uint8_t column_min = matrix[0][column];
         for (size_t other_row = 1; other_row < rows; ++other_row)
            if (matrix[other_row][column] < column_min)
               column_min = matrix[other_row][column];
         if (matrix[row][column] == column_min)
            result->points[result->count++] =
                (saddle_point_t){ row + 1, column + 1 };
      }
   }

   if (result->count == 0) {
      free(result->points);
      result->points = NULL;
   }
   return result;
}

void free_saddle_points(saddle_points_t *points)
{
   if (!points)
      return;
   free(points->points);
   free(points);
}
