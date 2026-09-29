#include "say.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static const char *small_numbers[] = {
   "zero", "one", "two", "three", "four", "five", "six", "seven",
   "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen",
   "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
};

static const char *tens_names[] = {
   "", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy",
   "eighty", "ninety"
};

static void append_word(char *buffer, size_t *length, const char *word)
{
   if (*length)
      buffer[(*length)++] = ' ';
   size_t word_length = strlen(word);
   memcpy(buffer + *length, word, word_length);
   *length += word_length;
   buffer[*length] = '\0';
}

static void append_under_thousand(char *buffer, size_t *length,
                                  unsigned int number)
{
   if (number >= 100) {
      append_word(buffer, length, small_numbers[number / 100]);
      append_word(buffer, length, "hundred");
      number %= 100;
   }
   if (number >= 20) {
      const char *tens = tens_names[number / 10];
      if (number % 10 == 0) {
         append_word(buffer, length, tens);
      } else {
         if (*length)
            buffer[(*length)++] = ' ';
         size_t tens_length = strlen(tens);
         memcpy(buffer + *length, tens, tens_length);
         *length += tens_length;
         buffer[(*length)++] = '-';
         const char *ones_word = small_numbers[number % 10];
         size_t ones_length = strlen(ones_word);
         memcpy(buffer + *length, ones_word, ones_length);
         *length += ones_length;
         buffer[*length] = '\0';
      }
   } else if (number > 0) {
      append_word(buffer, length, small_numbers[number]);
   }
}

int say(int64_t input, char **ans)
{
   if (!ans)
      return -1;
   *ans = NULL;
   if (input < 0 || input > INT64_C(999999999999))
      return -1;

   char buffer[256] = "";
   size_t length = 0;
   if (input == 0) {
      append_word(buffer, &length, "zero");
   } else {
      static const char *scales[] = { "billion", "million", "thousand", "" };
      int64_t divisors[] = { INT64_C(1000000000), INT64_C(1000000),
                             INT64_C(1000), 1 };
      for (size_t i = 0; i < 4; ++i) {
         unsigned int group = (unsigned int)(input / divisors[i]);
         input %= divisors[i];
         if (group == 0)
            continue;
         append_under_thousand(buffer, &length, group);
         if (scales[i][0])
            append_word(buffer, &length, scales[i]);
      }
   }

   *ans = malloc(length + 1);
   if (!*ans)
      return -1;
   memcpy(*ans, buffer, length + 1);
   return 0;
}
