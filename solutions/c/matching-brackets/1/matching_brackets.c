#include "matching_brackets.h"

#include <stdlib.h>
#include <string.h>

bool is_paired(const char *input)
{
   if (!input)
      return true;
   size_t length = strlen(input);
   char *stack = malloc(length ? length : 1);
   if (!stack)
      return false;

   size_t top = 0;
   for (const char *p = input; *p; ++p) {
      if (*p == '(' || *p == '[' || *p == '{') {
         stack[top++] = *p;
      } else if (*p == ')' || *p == ']' || *p == '}') {
         if (top == 0) {
            free(stack);
            return false;
         }
         char open = stack[--top];
         if ((*p == ')' && open != '(') || (*p == ']' && open != '[') ||
             (*p == '}' && open != '{')) {
            free(stack);
            return false;
         }
      }
   }
   bool paired = top == 0;
   free(stack);
   return paired;
}
