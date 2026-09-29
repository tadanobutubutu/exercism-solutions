#include "anagram.h"

#include <ctype.h>
#include <string.h>

static int same_word_ignoring_case(const char *left, const char *right)
{
   size_t index = 0;
   while (left[index] != '\0' && right[index] != '\0') {
      if (tolower((unsigned char)left[index]) !=
          tolower((unsigned char)right[index])) {
         return 0;
      }
      index++;
   }
   return left[index] == '\0' && right[index] == '\0';
}

static int have_same_letters(const char *left, const char *right)
{
   unsigned int counts[26] = { 0 };

   for (size_t index = 0; left[index] != '\0'; index++) {
      unsigned int position =
          (unsigned int)(tolower((unsigned char)left[index]) - 'a');
      counts[position]++;
   }

   for (size_t index = 0; right[index] != '\0'; index++) {
      unsigned int position =
          (unsigned int)(tolower((unsigned char)right[index]) - 'a');
      if (counts[position] == 0) {
         return 0;
      }
      counts[position]--;
   }

   for (size_t index = 0; index < 26; index++) {
      if (counts[index] != 0) {
         return 0;
      }
   }

   return 1;
}

void find_anagrams(const char *subject, struct candidates *candidates)
{
   if (candidates == NULL || candidates->candidate == NULL) {
      return;
   }

   for (size_t index = 0; index < candidates->count; index++) {
      const char *word = candidates->candidate[index].word;
      int is_anagram = subject != NULL && word != NULL &&
                       strlen(subject) == strlen(word) &&
                       !same_word_ignoring_case(subject, word) &&
                       have_same_letters(subject, word);
      candidates->candidate[index].is_anagram =
          is_anagram ? IS_ANAGRAM : NOT_ANAGRAM;
   }
}
