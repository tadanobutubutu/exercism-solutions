#include "square_root.h"

uint16_t square_root(uint16_t radicand)
{
   uint32_t low = 0;
   uint32_t high = 255;

   while (low <= high) {
      uint32_t middle = low + (high - low) / 2;
      uint32_t square = middle * middle;
      if (square == radicand) {
         return (uint16_t)middle;
      }
      if (square < radicand) {
         low = middle + 1;
      } else {
         if (middle == 0) {
            break;
         }
         high = middle - 1;
      }
   }

   return 0;
}
