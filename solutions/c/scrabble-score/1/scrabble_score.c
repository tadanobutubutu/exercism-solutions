#include "scrabble_score.h"

#include <ctype.h>
#include <stddef.h>

unsigned int score(const char *word)
{
   static const char *const groups[] = {
      "AEIOULNRST", "DG", "BCMP", "FHVWY", "K", "JX", "QZ"
   };
   static const unsigned int values[] = { 1, 2, 3, 4, 5, 8, 10 };

   if (word == NULL) {
      return 0;
   }

   unsigned int total = 0;
   for (size_t index = 0; word[index] != '\0'; index++) {
      char letter = (char)toupper((unsigned char)word[index]);
      for (size_t group = 0; group < sizeof(groups) / sizeof(groups[0]);
           group++) {
         for (size_t position = 0; groups[group][position] != '\0'; position++) {
            if (letter == groups[group][position]) {
               total += values[group];
               group = sizeof(groups) / sizeof(groups[0]);
               break;
            }
         }
      }
   }

   return total;
}
