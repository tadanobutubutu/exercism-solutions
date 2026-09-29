#include "bob.h"

#include <ctype.h>

char *hey_bob(char *greeting)
{
   if (!greeting)
      return "Fine. Be that way!";

   int has_letter = 0;
   int has_lower = 0;
   int has_upper = 0;
   const unsigned char *p = (const unsigned char *)greeting;
   for (; *p; ++p) {
      if (isalpha(*p)) {
         has_letter = 1;
         has_lower |= islower(*p) != 0;
         has_upper |= isupper(*p) != 0;
      }
   }

   const unsigned char *end = p;
   while (end > (const unsigned char *)greeting && isspace(end[-1]))
      --end;
   if (end == (const unsigned char *)greeting)
      return "Fine. Be that way!";

   int question = end[-1] == '?';
   int shouting = has_letter && has_upper && !has_lower;
   if (shouting && question)
      return "Calm down, I know what I'm doing!";
   if (shouting)
      return "Whoa, chill out!";
   if (question)
      return "Sure.";
   return "Whatever.";
}
