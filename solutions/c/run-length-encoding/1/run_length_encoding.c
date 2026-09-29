#include "run_length_encoding.h"

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *encode(const char *text)
{
   if (!text)
      text = "";
   size_t length = strlen(text);
   char *encoded = malloc(length + 1);
   if (!encoded)
      return NULL;

   size_t out = 0;
   for (size_t i = 0; i < length;) {
      size_t end = i + 1;
      while (end < length && text[end] == text[i])
         ++end;
      size_t count = end - i;
      if (count > 1) {
         int written = snprintf(encoded + out, length + 1 - out, "%zu", count);
         if (written < 0) {
            free(encoded);
            return NULL;
         }
         out += (size_t)written;
      }
      encoded[out++] = text[i];
      i = end;
   }
   encoded[out] = '\0';
   return encoded;
}

char *decode(const char *data)
{
   if (!data)
      data = "";
   size_t capacity = 1;
   for (const unsigned char *p = (const unsigned char *)data; *p;) {
      size_t count = 0;
      while (isdigit(*p)) {
         if (count > (size_t)-1 / 10)
            return NULL;
         count = count * 10 + (size_t)(*p - '0');
         ++p;
      }
      if (!*p)
         break;
      if (count == 0)
         count = 1;
      if (count > (size_t)-1 - capacity)
         return NULL;
      capacity += count;
      ++p;
   }

   char *decoded = malloc(capacity);
   if (!decoded)
      return NULL;
   size_t out = 0;
   const unsigned char *p = (const unsigned char *)data;
   while (*p) {
      size_t count = 0;
      while (isdigit(*p)) {
         if (count > (size_t)-1 / 10) {
            free(decoded);
            return NULL;
         }
         count = count * 10 + (size_t)(*p - '0');
         ++p;
      }
      if (!*p)
         break;
      if (count == 0)
         count = 1;
      memset(decoded + out, *p++, count);
      out += count;
   }
   decoded[out] = '\0';
   return decoded;
}
