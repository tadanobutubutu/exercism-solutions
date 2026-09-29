#include "beer_song.h"

#include <stdio.h>

void recite(uint8_t start_bottles, uint8_t take_down, char **song)
{
   if (song == NULL) {
      return;
   }

   unsigned int bottles = start_bottles;
   size_t line = 0;
   for (unsigned int verse = 0; verse < take_down; verse++) {
      if (bottles == 0) {
         (void)snprintf(song[line++], 1024,
                        "No more bottles of beer on the wall, no more bottles of beer.");
         (void)snprintf(song[line++], 1024,
                        "Go to the store and buy some more, 99 bottles of beer on the wall.");
      } else {
         const char *bottle_word = bottles == 1 ? "bottle" : "bottles";
         (void)snprintf(song[line++], 1024,
                        "%u %s of beer on the wall, %u %s of beer.", bottles,
                        bottle_word, bottles, bottle_word);

         if (bottles == 1) {
            (void)snprintf(song[line++], 1024,
                           "Take it down and pass it around, no more bottles of beer on the wall.");
         } else {
            unsigned int remaining = bottles - 1;
            const char *remaining_word = remaining == 1 ? "bottle" : "bottles";
            (void)snprintf(song[line++], 1024,
                           "Take one down and pass it around, %u %s of beer on the wall.",
                           remaining, remaining_word);
         }
      }

      bottles = bottles == 0 ? 99 : bottles - 1;
      if (verse + 1 < take_down) {
         song[line++][0] = '\0';
      }
   }
}
