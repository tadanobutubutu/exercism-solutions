#include "dnd_character.h"

#include <stdlib.h>

int ability(void)
{
   int rolls[4];
   int lowest = 7;
   int sum = 0;
   for (size_t i = 0; i < 4; ++i) {
      rolls[i] = rand() % 6 + 1;
      sum += rolls[i];
      if (rolls[i] < lowest)
         lowest = rolls[i];
   }
   return sum - lowest;
}

int modifier(int score)
{
   int difference = score - 10;
   return difference >= 0 ? difference / 2 : (difference - 1) / 2;
}

dnd_character_t make_dnd_character(void)
{
   dnd_character_t character = {
      .strength = ability(),
      .dexterity = ability(),
      .constitution = ability(),
      .intelligence = ability(),
      .wisdom = ability(),
      .charisma = ability(),
   };
   character.hitpoints = 10 + modifier(character.constitution);
   return character;
}
