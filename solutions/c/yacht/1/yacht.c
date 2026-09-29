#include "yacht.h"

#include <stddef.h>

int score(dice_t dice, category_t category)
{
   int counts[7] = { 0 };
   int total = 0;

   for (size_t index = 0; index < 5; index++) {
      int face = dice.faces[index];
      if (face >= 1 && face <= 6) {
         counts[face]++;
         total += face;
      }
   }

   if (category >= ONES && category <= SIXES) {
      int face = (int)category + 1;
      return face * counts[face];
   }

   switch (category) {
   case FULL_HOUSE: {
      int has_pair = 0;
      int has_three = 0;
      for (int face = 1; face <= 6; face++) {
         has_pair |= counts[face] == 2;
         has_three |= counts[face] == 3;
      }
      return has_pair && has_three ? total : 0;
   }
   case FOUR_OF_A_KIND:
      for (int face = 1; face <= 6; face++) {
         if (counts[face] >= 4) {
            return 4 * face;
         }
      }
      return 0;
   case LITTLE_STRAIGHT:
      for (int face = 1; face <= 5; face++) {
         if (counts[face] != 1) {
            return 0;
         }
      }
      return 30;
   case BIG_STRAIGHT:
      for (int face = 2; face <= 6; face++) {
         if (counts[face] != 1) {
            return 0;
         }
      }
      return 30;
   case CHOICE:
      return total;
   case YACHT:
      for (int face = 1; face <= 6; face++) {
         if (counts[face] == 5) {
            return 50;
         }
      }
      return 0;
   default:
      return 0;
   }
}
