#include "intergalactic_transmission.h"

#include <stddef.h>

static unsigned int ones(uint8_t value)
{
   unsigned int count = 0;
   while (value) {
      count += value & 1u;
      value >>= 1;
   }
   return count;
}

int transmit_sequence(uint8_t *buffer, const uint8_t *message,
                      int message_length)
{
   if (!buffer || !message || message_length <= 0)
      return 0;
   size_t bit_length = (size_t)message_length * 8;
   size_t output_length = (bit_length + 6) / 7;
   size_t bit_position = 0;

   for (size_t out = 0; out < output_length; ++out) {
      uint8_t encoded = 0;
      for (size_t bit = 0; bit < 7; ++bit) {
         unsigned int value = 0;
         if (bit_position < bit_length) {
            size_t byte_index = bit_position / 8;
            unsigned int source_bit = 7u - (unsigned int)(bit_position % 8);
            value = (message[byte_index] >> source_bit) & 1u;
            ++bit_position;
         }
         if (value)
            encoded |= (uint8_t)(1u << (7u - (unsigned int)bit));
      }
      if (ones(encoded) & 1u)
         encoded |= 1u;
      buffer[out] = encoded;
   }
   return (int)output_length;
}

int decode_message(uint8_t *buffer, const uint8_t *message, int message_length)
{
   if (message_length <= 0)
      return 0;
   if (!buffer || !message)
      return 0;

   size_t output_length = (size_t)message_length * 7 / 8;
   for (int i = 0; i < message_length; ++i)
      if (ones(message[i]) & 1u)
         return WRONG_PARITY;

   size_t bit_position = 0;
   size_t output_position = 0;
   uint8_t current = 0;
   for (int i = 0; i < message_length && output_position < output_length; ++i) {
      uint8_t payload = message[i] >> 1;
      for (int bit = 6; bit >= 0 && output_position < output_length; --bit) {
         current = (uint8_t)((current << 1) | ((payload >> bit) & 1u));
         if (++bit_position == 8) {
            buffer[output_position++] = current;
            bit_position = 0;
            current = 0;
         }
      }
   }
   return (int)output_position;
}
