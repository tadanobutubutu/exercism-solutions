#include "variable_length_quantity.h"

int encode(const uint32_t *integers, size_t integers_len, uint8_t *output)
{
   if ((integers_len > 0 && (integers == NULL || output == NULL)) ||
       integers_len > (size_t)INT32_MAX / 5) {
      return -1;
   }

   size_t output_length = 0;
   for (size_t index = 0; index < integers_len; index++) {
      uint32_t value = integers[index];
      uint8_t encoded[5];
      size_t byte_count = 0;
      do {
         encoded[byte_count++] = (uint8_t)(value & 0x7Fu);
         value >>= 7;
      } while (value != 0);

      for (size_t byte = byte_count; byte > 0; byte--) {
         uint8_t value_byte = encoded[byte - 1];
         if (byte > 1) {
            value_byte |= 0x80u;
         }
         output[output_length++] = value_byte;
      }
   }

   return (int)output_length;
}

int decode(const uint8_t *bytes, size_t buffer_len, uint32_t *output)
{
   if ((buffer_len > 0 && (bytes == NULL || output == NULL)) ||
       buffer_len > (size_t)INT32_MAX) {
      return -1;
   }

   size_t output_length = 0;
   uint32_t value = 0;
   size_t byte_count = 0;

   for (size_t index = 0; index < buffer_len; index++) {
      uint8_t byte = bytes[index];
      uint32_t payload = (uint32_t)(byte & 0x7Fu);
      if (byte_count == 5 || value > (UINT32_MAX >> 7) ||
          (value == (UINT32_MAX >> 7) && payload > (UINT32_MAX & 0x7Fu))) {
         return -1;
      }
      value = (value << 7) | payload;
      byte_count++;

      if ((byte & 0x80u) == 0) {
         output[output_length++] = value;
         value = 0;
         byte_count = 0;
      }
   }

   return byte_count == 0 ? (int)output_length : -1;
}
