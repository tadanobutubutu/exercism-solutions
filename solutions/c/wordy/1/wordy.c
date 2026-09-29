#include "wordy.h"

#include <ctype.h>
#include <errno.h>
#include <limits.h>
#include <stdlib.h>
#include <string.h>

static const char *skip_spaces(const char *text)
{
   while (isspace((unsigned char)*text))
      ++text;
   return text;
}

static int parse_number(const char **text, long long *value)
{
   const char *start = skip_spaces(*text);
   if (*start != '-' && !isdigit((unsigned char)*start))
      return 0;
   errno = 0;
   char *end = NULL;
   long number = strtol(start, &end, 10);
   if (end == start || errno == ERANGE)
      return 0;
   *value = number;
   *text = end;
   return 1;
}

static int consume_operator(const char **text, int *operation)
{
   const char *start = skip_spaces(*text);
   const char *word = NULL;
   size_t length = 0;
   int op = 0;
   if (strncmp(start, "plus", 4) == 0) {
      word = "plus";
      length = 4;
      op = 1;
   } else if (strncmp(start, "minus", 5) == 0) {
      word = "minus";
      length = 5;
      op = 2;
   } else if (strncmp(start, "multiplied by", 13) == 0) {
      word = "multiplied by";
      length = 13;
      op = 3;
   } else if (strncmp(start, "divided by", 10) == 0) {
      word = "divided by";
      length = 10;
      op = 4;
   }
   if (!word)
      return 0;
   (void)length;
   *text = start + strlen(word);
   if (**text && !isspace((unsigned char)**text))
      return 0;
   *operation = op;
   return 1;
}

bool answer(const char *question, int *result)
{
   if (!question || !result)
      return false;
   const char *p = skip_spaces(question);
   const char prefix[] = "What is";
   if (strncmp(p, prefix, sizeof(prefix) - 1) != 0)
      return false;
   p += sizeof(prefix) - 1;
   if (!isspace((unsigned char)*p))
      return false;

   long long value;
   if (!parse_number(&p, &value))
      return false;

   for (;;) {
      p = skip_spaces(p);
      if (*p == '?') {
         p = skip_spaces(p + 1);
         if (*p != '\0' || value < INT_MIN || value > INT_MAX)
            return false;
         *result = (int)value;
         return true;
      }

      int operation;
      if (!consume_operator(&p, &operation))
         return false;
      long long operand;
      if (!parse_number(&p, &operand))
         return false;

      switch (operation) {
      case 1: value += operand; break;
      case 2: value -= operand; break;
      case 3: value *= operand; break;
      case 4:
         if (operand == 0)
            return false;
         value /= operand;
         break;
      default: return false;
      }
      if (value < INT_MIN || value > INT_MAX)
         return false;
   }
}
