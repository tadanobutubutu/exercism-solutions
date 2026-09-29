#include "atbash_cipher.h"

#include <ctype.h>
#include <stdlib.h>
#include <string.h>

static char transform(char ch)
{
   if (ch >= 'a' && ch <= 'z')
      return (char)('z' - (ch - 'a'));
   if (ch >= 'A' && ch <= 'Z')
      return (char)('z' - (ch - 'A'));
   return ch;
}

static char *convert(const char *input, int grouped)
{
   if (!input)
      input = "";

   size_t count = 0;
   for (const unsigned char *p = (const unsigned char *)input; *p; ++p)
      if (isalnum(*p))
         ++count;

   size_t spaces = grouped && count ? (count - 1) / 5 : 0;
   char *output = malloc(count + spaces + 1);
   if (!output)
      return NULL;

   size_t out = 0;
   size_t emitted = 0;
   for (const unsigned char *p = (const unsigned char *)input; *p; ++p) {
      if (!isalnum(*p))
         continue;
      if (grouped && emitted && emitted % 5 == 0)
         output[out++] = ' ';
      output[out++] = transform((char)tolower(*p));
      ++emitted;
   }
   output[out] = '\0';
   return output;
}

char *atbash_encode(const char *input)
{
   return convert(input, 1);
}

char *atbash_decode(const char *input)
{
   return convert(input, 0);
}
