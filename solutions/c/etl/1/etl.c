#include "etl.h"

#include <ctype.h>
#include <stdlib.h>

static int compare_new_maps(const void *left, const void *right)
{
   const new_map *a = left;
   const new_map *b = right;
   return (unsigned char)a->key - (unsigned char)b->key;
}

int convert(const legacy_map *input, const size_t input_len, new_map **output)
{
   if (!output)
      return -1;
   *output = NULL;
   if (!input || input_len == 0)
      return 0;

   size_t count = 0;
   for (size_t i = 0; i < input_len; ++i)
      if (input[i].keys)
         for (const char *p = input[i].keys; *p; ++p)
            ++count;

   if (count == 0)
      return 0;
   new_map *converted = malloc(count * sizeof(*converted));
   if (!converted)
      return -1;

   size_t index = 0;
   for (size_t i = 0; i < input_len; ++i) {
      if (!input[i].keys)
         continue;
      for (const unsigned char *p = (const unsigned char *)input[i].keys; *p;
           ++p) {
         converted[index++] = (new_map){ (char)tolower(*p), input[i].value };
      }
   }
   qsort(converted, count, sizeof(*converted), compare_new_maps);
   *output = converted;
   return (int)count;
}
