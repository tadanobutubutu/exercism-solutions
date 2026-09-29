#include "linked_list.h"

#include <stdlib.h>

struct list_node {
   struct list_node *prev, *next;
   ll_data_t data;
};

struct list {
   struct list_node *first, *last;
   size_t count;
};

struct list *list_create(void)
{
   return calloc(1, sizeof(struct list));
}

size_t list_count(const struct list *list)
{
   return list ? list->count : 0;
}

void list_push(struct list *list, ll_data_t item_data)
{
   if (!list)
      return;
   struct list_node *node = malloc(sizeof(*node));
   if (!node)
      return;
   *node = (struct list_node){ .prev = list->last, .next = NULL,
                               .data = item_data };
   if (list->last)
      list->last->next = node;
   else
      list->first = node;
   list->last = node;
   ++list->count;
}

ll_data_t list_pop(struct list *list)
{
   if (!list || !list->last)
      return 0;
   struct list_node *node = list->last;
   ll_data_t value = node->data;
   list->last = node->prev;
   if (list->last)
      list->last->next = NULL;
   else
      list->first = NULL;
   free(node);
   --list->count;
   return value;
}

void list_unshift(struct list *list, ll_data_t item_data)
{
   if (!list)
      return;
   struct list_node *node = malloc(sizeof(*node));
   if (!node)
      return;
   *node = (struct list_node){ .prev = NULL, .next = list->first,
                               .data = item_data };
   if (list->first)
      list->first->prev = node;
   else
      list->last = node;
   list->first = node;
   ++list->count;
}

ll_data_t list_shift(struct list *list)
{
   if (!list || !list->first)
      return 0;
   struct list_node *node = list->first;
   ll_data_t value = node->data;
   list->first = node->next;
   if (list->first)
      list->first->prev = NULL;
   else
      list->last = NULL;
   free(node);
   --list->count;
   return value;
}

void list_delete(struct list *list, ll_data_t data)
{
   if (!list)
      return;
   for (struct list_node *node = list->first; node; node = node->next) {
      if (node->data != data)
         continue;
      if (node->prev)
         node->prev->next = node->next;
      else
         list->first = node->next;
      if (node->next)
         node->next->prev = node->prev;
      else
         list->last = node->prev;
      free(node);
      --list->count;
      return;
   }
}

void list_destroy(struct list *list)
{
   if (!list)
      return;
   struct list_node *node = list->first;
   while (node) {
      struct list_node *next = node->next;
      free(node);
      node = next;
   }
   free(list);
}
