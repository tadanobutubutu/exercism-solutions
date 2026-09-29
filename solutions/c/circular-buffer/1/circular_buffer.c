#include "circular_buffer.h"

#include <errno.h>
#include <stdlib.h>

struct circular_buffer {
   size_t capacity;
   size_t read_index;
   size_t count;
   buffer_value_t *values;
};

circular_buffer_t *new_circular_buffer(size_t capacity)
{
   circular_buffer_t *buffer = malloc(sizeof(*buffer));
   if (buffer == NULL) {
      return NULL;
   }
   buffer->capacity = capacity;
   buffer->read_index = 0;
   buffer->count = 0;
   buffer->values = capacity == 0 ? NULL :
                    malloc(capacity * sizeof(*buffer->values));
   if (capacity > 0 && buffer->values == NULL) {
      free(buffer);
      return NULL;
   }
   return buffer;
}

void delete_buffer(circular_buffer_t *buffer)
{
   if (buffer != NULL) {
      free(buffer->values);
      free(buffer);
   }
}

int16_t read(circular_buffer_t *buffer, buffer_value_t *value)
{
   if (buffer == NULL || value == NULL || buffer->count == 0) {
      errno = ENODATA;
      return EXIT_FAILURE;
   }
   *value = buffer->values[buffer->read_index];
   buffer->read_index = (buffer->read_index + 1) % buffer->capacity;
   buffer->count--;
   return EXIT_SUCCESS;
}

int16_t write(circular_buffer_t *buffer, buffer_value_t value)
{
   if (buffer == NULL || buffer->capacity == 0 ||
       buffer->count == buffer->capacity) {
      errno = ENOBUFS;
      return EXIT_FAILURE;
   }
   size_t write_index = (buffer->read_index + buffer->count) % buffer->capacity;
   buffer->values[write_index] = value;
   buffer->count++;
   return EXIT_SUCCESS;
}

int16_t overwrite(circular_buffer_t *buffer, buffer_value_t value)
{
   if (buffer == NULL || buffer->capacity == 0) {
      errno = ENOBUFS;
      return EXIT_FAILURE;
   }
   if (buffer->count < buffer->capacity) {
      return write(buffer, value);
   }

   buffer->values[buffer->read_index] = value;
   buffer->read_index = (buffer->read_index + 1) % buffer->capacity;
   return EXIT_SUCCESS;
}

void clear_buffer(circular_buffer_t *buffer)
{
   if (buffer != NULL) {
      buffer->read_index = 0;
      buffer->count = 0;
   }
}
