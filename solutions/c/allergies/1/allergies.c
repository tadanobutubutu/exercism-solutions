#include "allergies.h"

bool is_allergic_to(allergen_t allergen, int score)
{
   if (allergen < ALLERGEN_EGGS || allergen >= ALLERGEN_COUNT) {
      return false;
   }

   unsigned int mask = 1u << (unsigned int)allergen;
   return ((unsigned int)score & mask) != 0u;
}

allergen_list_t get_allergens(int score)
{
   allergen_list_t list = { 0, { false } };
   unsigned int bits = (unsigned int)score;

   for (int allergen = ALLERGEN_EGGS; allergen < ALLERGEN_COUNT; allergen++) {
      bool allergic = (bits & (1u << (unsigned int)allergen)) != 0u;
      list.allergens[allergen] = allergic;
      if (allergic) {
         list.count++;
      }
   }

   return list;
}
