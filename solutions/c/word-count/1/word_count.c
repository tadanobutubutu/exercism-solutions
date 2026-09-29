#include "word_count.h"

#include <ctype.h>
#include <string.h>

static int is_ascii_alnum(unsigned char ch)
{
   return (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z') ||
          (ch >= '0' && ch <= '9');
}

static int add_word(word_count_word_t *words, int count, const char *text)
{
   for (int i = 0; i < count; ++i) {
      if (strcmp(words[i].text, text) == 0) {
         ++words[i].count;
         return count;
      }
   }
   if (count >= MAX_WORDS)
      return EXCESSIVE_NUMBER_OF_WORDS;
   strncpy(words[count].text, text, MAX_WORD_LENGTH);
   words[count].text[MAX_WORD_LENGTH] = '\0';
   words[count].count = 1;
   return count + 1;
}

int count_words(const char *sentence, word_count_word_t *words)
{
   if (!sentence || !words)
      return 0;
   memset(words, 0, MAX_WORDS * sizeof(*words));

   char token[MAX_WORD_LENGTH + 1];
   size_t length = 0;
   int count = 0;
   for (const unsigned char *p = (const unsigned char *)sentence;; ++p) {
      unsigned char ch = *p;
      if (is_ascii_alnum(ch)) {
         if (length >= MAX_WORD_LENGTH)
            return EXCESSIVE_LENGTH_WORD;
         token[length++] = (char)tolower(ch);
      } else if (ch == '\'' && length > 0 && is_ascii_alnum(p[1])) {
         if (length >= MAX_WORD_LENGTH)
            return EXCESSIVE_LENGTH_WORD;
         token[length++] = '\'';
      } else {
         if (length > 0) {
            token[length] = '\0';
            int next_count = add_word(words, count, token);
            if (next_count < 0)
               return next_count;
            count = next_count;
            length = 0;
         }
         if (ch == '\0')
            break;
      }
   }
   return count;
}
