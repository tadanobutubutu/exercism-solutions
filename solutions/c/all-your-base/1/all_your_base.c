#include "all_your_base.h"

size_t rebase(int8_t digits[DIGITS_ARRAY_SIZE], int16_t input_base,
              int16_t output_base, size_t input_length)
{
   int32_t working[DIGITS_ARRAY_SIZE];
   int8_t reversed[DIGITS_ARRAY_SIZE];
   size_t first = 0;
   size_t output_length = 0;

   if (digits == NULL || input_base < 2 || output_base < 2 ||
       input_length == 0 || input_length > DIGITS_ARRAY_SIZE) {
      return 0;
   }

   for (size_t index = 0; index < input_length; index++) {
      if (digits[index] < 0 || digits[index] >= input_base) {
         return 0;
      }
      working[index] = digits[index];
   }

   while (first < input_length && working[first] == 0) {
      first++;
   }

   if (first == input_length) {
      digits[0] = 0;
      return 1;
   }

   while (first < input_length) {
      int32_t remainder = 0;
      for (size_t index = first; index < input_length; index++) {
         int32_t value = remainder * input_base + working[index];
         working[index] = value / output_base;
         remainder = value % output_base;
      }

      if (remainder > INT8_MAX || output_length == DIGITS_ARRAY_SIZE) {
         return 0;
      }
      reversed[output_length++] = (int8_t)remainder;

      while (first < input_length && working[first] == 0) {
         first++;
      }
   }

   for (size_t index = 0; index < output_length; index++) {
      digits[index] = reversed[output_length - index - 1];
   }

   return output_length;
}
