#include "sublist.h"

#include <stdbool.h>

static bool contains(const int *haystack, size_t haystack_count,
                     const int *needle, size_t needle_count)
{
   if (needle_count == 0) {
      return true;
   }
   if (needle_count > haystack_count || haystack == NULL || needle == NULL) {
      return false;
   }

   for (size_t start = 0; start <= haystack_count - needle_count; start++) {
      size_t offset = 0;
      while (offset < needle_count &&
             haystack[start + offset] == needle[offset]) {
         offset++;
      }
      if (offset == needle_count) {
         return true;
      }
   }
   return false;
}

comparison_result_t check_lists(int *list_to_compare, int *base_list,
                                size_t list_to_compare_element_count,
                                size_t base_list_element_count)
{
   if (list_to_compare_element_count == base_list_element_count) {
      return contains(base_list, base_list_element_count, list_to_compare,
                      list_to_compare_element_count)
                 ? EQUAL
                 : UNEQUAL;
   }

   if (list_to_compare_element_count < base_list_element_count) {
      return contains(base_list, base_list_element_count, list_to_compare,
                      list_to_compare_element_count)
                 ? SUBLIST
                 : UNEQUAL;
   }

   return contains(list_to_compare, list_to_compare_element_count, base_list,
                   base_list_element_count)
              ? SUPERLIST
              : UNEQUAL;
}
