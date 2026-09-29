#include "pig_latin.h"

#include <ctype.h>
#include <stdlib.h>
#include <string.h>

static size_t pig_latin_offset(const char *word, size_t length)
{
   if (length >= 2 && ((word[0] == 'x' && word[1] == 'r') ||
                       (word[0] == 'y' && word[1] == 't')))
      return 0;

   for (size_t i = 0; i < length; ++i) {
      char ch = (char)tolower((unsigned char)word[i]);
      int vowel = ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u' ||
                  (ch == 'y' && i > 0);
      if (vowel) {
         if (ch == 'u' && i > 0 && word[i - 1] == 'q')
            return i + 1;
         return i;
      }
   }
   return length;
}

char *translate(const char *phrase)
{
   if (!phrase)
      phrase = "";
   size_t length = strlen(phrase);
   size_t words = 0;
   for (size_t i = 0; i < length; ++i)
      if (!isspace((unsigned char)phrase[i]) &&
          (i == 0 || isspace((unsigned char)phrase[i - 1])))
         ++words;
   if (words > ((size_t)-1 - length - 1) / 2)
      return NULL;

   char *translated = malloc(length + words * 2 + 1);
   if (!translated)
      return NULL;
   size_t in = 0;
   size_t out = 0;
   while (in < length) {
      if (isspace((unsigned char)phrase[in])) {
         translated[out++] = phrase[in++];
         continue;
      }
      size_t start = in;
      while (in < length && !isspace((unsigned char)phrase[in]))
         ++in;
      size_t word_length = in - start;
      size_t offset = pig_latin_offset(phrase + start, word_length);
      memcpy(translated + out, phrase + start + offset, word_length - offset);
      out += word_length - offset;
      memcpy(translated + out, phrase + start, offset);
      out += offset;
      translated[out++] = 'a';
      translated[out++] = 'y';
   }
   translated[out] = '\0';
   return translated;
}
