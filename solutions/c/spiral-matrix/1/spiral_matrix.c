#include "spiral_matrix.h"

#include <stdlib.h>

spiral_matrix_t *spiral_matrix_create(int size)
{
   spiral_matrix_t *result = malloc(sizeof(*result));
   if (result == NULL) {
      return NULL;
   }
   result->size = size > 0 ? size : 0;
   result->matrix = NULL;

   if (result->size == 0) {
      return result;
   }

   result->matrix = calloc((size_t)result->size, sizeof(*result->matrix));
   if (result->matrix == NULL) {
      free(result);
      return NULL;
   }
   for (int row = 0; row < result->size; row++) {
      result->matrix[row] = calloc((size_t)result->size,
                                   sizeof(*result->matrix[row]));
      if (result->matrix[row] == NULL) {
         spiral_matrix_destroy(result);
         return NULL;
      }
   }

   int top = 0;
   int bottom = result->size - 1;
   int left = 0;
   int right = result->size - 1;
   int value = 1;

   while (top <= bottom && left <= right) {
      for (int column = left; column <= right; column++) {
         result->matrix[top][column] = value++;
      }
      top++;

      for (int row = top; row <= bottom; row++) {
         result->matrix[row][right] = value++;
      }
      right--;

      if (top <= bottom) {
         for (int column = right; column >= left; column--) {
            result->matrix[bottom][column] = value++;
         }
         bottom--;
      }

      if (left <= right) {
         for (int row = bottom; row >= top; row--) {
            result->matrix[row][left] = value++;
         }
         left++;
      }
   }

   return result;
}

void spiral_matrix_destroy(spiral_matrix_t *matrix)
{
   if (matrix == NULL) {
      return;
   }
   if (matrix->matrix != NULL) {
      for (int row = 0; row < matrix->size; row++) {
         free(matrix->matrix[row]);
      }
      free(matrix->matrix);
   }
   free(matrix);
}
