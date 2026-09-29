#include "list_ops.h"

#include <string.h>

list_t *new_list(size_t length, list_element_t elements[])
{
   if (length > (SIZE_MAX - sizeof(list_t)) / sizeof(list_element_t)) {
      return NULL;
   }
   list_t *list = malloc(sizeof(*list) + length * sizeof(list_element_t));
   if (list == NULL) {
      return NULL;
   }
   list->length = length;
   if (length > 0 && elements != NULL) {
      memcpy(list->elements, elements, length * sizeof(list_element_t));
   } else if (length > 0) {
      memset(list->elements, 0, length * sizeof(list_element_t));
   }
   return list;
}

list_t *append_list(list_t *list1, list_t *list2)
{
   size_t first_length = list1 == NULL ? 0 : list1->length;
   size_t second_length = list2 == NULL ? 0 : list2->length;
   if (first_length > SIZE_MAX - second_length) {
      return NULL;
   }
   list_t *result = new_list(first_length + second_length, NULL);
   if (result == NULL) {
      return NULL;
   }
   if (first_length > 0) {
      memcpy(result->elements, list1->elements,
             first_length * sizeof(list_element_t));
   }
   if (second_length > 0) {
      memcpy(result->elements + first_length, list2->elements,
             second_length * sizeof(list_element_t));
   }
   return result;
}

list_t *filter_list(list_t *list, bool (*filter)(list_element_t))
{
   size_t length = list == NULL ? 0 : list->length;
   list_t *result = new_list(length, NULL);
   if (result == NULL) {
      return NULL;
   }
   result->length = 0;
   if (list != NULL && filter != NULL) {
      for (size_t index = 0; index < length; index++) {
         if (filter(list->elements[index])) {
            result->elements[result->length++] = list->elements[index];
         }
      }
   }
   return result;
}

size_t length_list(list_t *list)
{
   return list == NULL ? 0 : list->length;
}

list_t *map_list(list_t *list, list_element_t (*map)(list_element_t))
{
   size_t length = list == NULL ? 0 : list->length;
   list_t *result = new_list(length, NULL);
   if (result == NULL) {
      return NULL;
   }
   if (list != NULL) {
      for (size_t index = 0; index < length; index++) {
         result->elements[index] = map == NULL ? list->elements[index]
                                              : map(list->elements[index]);
      }
   }
   return result;
}

list_element_t foldl_list(list_t *list, list_element_t initial,
                          list_element_t (*foldl)(list_element_t,
                                                  list_element_t))
{
   if (list == NULL || foldl == NULL) {
      return initial;
   }
   for (size_t index = 0; index < list->length; index++) {
      initial = foldl(list->elements[index], initial);
   }
   return initial;
}

list_element_t foldr_list(list_t *list, list_element_t initial,
                          list_element_t (*foldr)(list_element_t,
                                                  list_element_t))
{
   if (list == NULL || foldr == NULL) {
      return initial;
   }
   for (size_t index = list->length; index > 0; index--) {
      initial = foldr(list->elements[index - 1], initial);
   }
   return initial;
}

list_t *reverse_list(list_t *list)
{
   size_t length = list == NULL ? 0 : list->length;
   list_t *result = new_list(length, NULL);
   if (result == NULL) {
      return NULL;
   }
   for (size_t index = 0; index < length; index++) {
      result->elements[index] = list->elements[length - index - 1];
   }
   return result;
}

void delete_list(list_t *list)
{
   free(list);
}
