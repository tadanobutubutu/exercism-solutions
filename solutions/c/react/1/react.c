#include "react.h"

#include <stdlib.h>

typedef enum { INPUT_CELL, COMPUTE_ONE, COMPUTE_TWO } cell_kind_t;

typedef struct callback_entry {
   callback_id id;
   void *context;
   callback function;
   struct callback_entry *next;
} callback_entry_t;

struct cell {
   struct reactor *owner;
   cell_kind_t kind;
   int value;
   struct cell *input_a;
   struct cell *input_b;
   compute1 function1;
   compute2 function2;
   callback_entry_t *callbacks;
   struct cell *next;
};

struct reactor {
   struct cell *first;
   struct cell *last;
   callback_id next_callback_id;
};

static struct cell *create_cell(struct reactor *reactor, cell_kind_t kind)
{
   if (!reactor)
      return NULL;
   struct cell *cell = calloc(1, sizeof(*cell));
   if (!cell)
      return NULL;
   cell->owner = reactor;
   cell->kind = kind;
   if (reactor->last)
      reactor->last->next = cell;
   else
      reactor->first = cell;
   reactor->last = cell;
   return cell;
}

struct reactor *create_reactor(void)
{
   struct reactor *reactor = calloc(1, sizeof(*reactor));
   if (reactor)
      reactor->next_callback_id = 1;
   return reactor;
}

void destroy_reactor(struct reactor *reactor)
{
   if (!reactor)
      return;
   struct cell *cell = reactor->first;
   while (cell) {
      struct cell *next_cell = cell->next;
      callback_entry_t *entry = cell->callbacks;
      while (entry) {
         callback_entry_t *next_entry = entry->next;
         free(entry);
         entry = next_entry;
      }
      free(cell);
      cell = next_cell;
   }
   free(reactor);
}

struct cell *create_input_cell(struct reactor *reactor, int initial_value)
{
   struct cell *cell = create_cell(reactor, INPUT_CELL);
   if (cell)
      cell->value = initial_value;
   return cell;
}

struct cell *create_compute1_cell(struct reactor *reactor, struct cell *input,
                                  compute1 function)
{
   if (!input || input->owner != reactor || !function)
      return NULL;
   struct cell *cell = create_cell(reactor, COMPUTE_ONE);
   if (!cell)
      return NULL;
   cell->input_a = input;
   cell->function1 = function;
   cell->value = function(input->value);
   return cell;
}

struct cell *create_compute2_cell(struct reactor *reactor, struct cell *input_a,
                                  struct cell *input_b, compute2 function)
{
   if (!input_a || !input_b || input_a->owner != reactor ||
       input_b->owner != reactor || !function)
      return NULL;
   struct cell *cell = create_cell(reactor, COMPUTE_TWO);
   if (!cell)
      return NULL;
   cell->input_a = input_a;
   cell->input_b = input_b;
   cell->function2 = function;
   cell->value = function(input_a->value, input_b->value);
   return cell;
}

int get_cell_value(struct cell *cell)
{
   return cell ? cell->value : 0;
}

static void notify_callbacks(struct cell *cell)
{
   for (callback_entry_t *entry = cell->callbacks; entry;) {
      callback_entry_t *next = entry->next;
      entry->function(entry->context, cell->value);
      entry = next;
   }
}

void set_cell_value(struct cell *cell, int new_value)
{
   if (!cell || cell->kind != INPUT_CELL || cell->value == new_value)
      return;
   cell->value = new_value;

   for (struct cell *dependent = cell->owner->first; dependent;
        dependent = dependent->next) {
      int value;
      if (dependent->kind == COMPUTE_ONE)
         value = dependent->function1(dependent->input_a->value);
      else if (dependent->kind == COMPUTE_TWO)
         value = dependent->function2(dependent->input_a->value,
                                      dependent->input_b->value);
      else
         continue;

      if (value != dependent->value) {
         dependent->value = value;
         notify_callbacks(dependent);
      }
   }
}

callback_id add_callback(struct cell *cell, void *context, callback function)
{
   if (!cell || !function)
      return -1;
   callback_entry_t *entry = malloc(sizeof(*entry));
   if (!entry)
      return -1;
   callback_id id = cell->owner->next_callback_id++;
   *entry = (callback_entry_t){ .id = id,
                                .context = context,
                                .function = function,
                                .next = cell->callbacks };
   cell->callbacks = entry;
   return id;
}

void remove_callback(struct cell *cell, callback_id id)
{
   if (!cell)
      return;
   callback_entry_t **link = &cell->callbacks;
   while (*link) {
      if ((*link)->id == id) {
         callback_entry_t *removed = *link;
         *link = removed->next;
         free(removed);
         return;
      }
      link = &(*link)->next;
   }
}
