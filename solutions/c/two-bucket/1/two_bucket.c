#include "two_bucket.h"

#include <stdint.h>
#include <stdlib.h>

typedef struct {
   bucket_liters_t first;
   bucket_liters_t second;
   int moves;
} state_t;

static bucket_result_t impossible(void)
{
   return (bucket_result_t){ .possible = false };
}

static bucket_result_t solved(state_t state, bucket_id_t goal_bucket)
{
   return (bucket_result_t){
      .possible = true,
      .move_count = state.moves,
      .goal_bucket = goal_bucket,
      .other_bucket_liters =
          goal_bucket == BUCKET_ID_1 ? state.second : state.first,
   };
}

bucket_result_t measure(bucket_liters_t bucket_1_size,
                        bucket_liters_t bucket_2_size,
                        bucket_liters_t goal_volume, bucket_id_t start_bucket)
{
   if (goal_volume == 0)
      return solved((state_t){ 0, 0, 0 }, start_bucket);
   if (goal_volume > bucket_1_size && goal_volume > bucket_2_size)
      return impossible();

   bucket_liters_t small = bucket_1_size;
   bucket_liters_t large = bucket_2_size;
   while (large != 0) {
      bucket_liters_t remainder = small % large;
      small = large;
      large = remainder;
   }
   if (small == 0 || goal_volume % small != 0)
      return impossible();

   size_t width = (size_t)bucket_2_size + 1;
   if ((size_t)bucket_1_size + 1 > SIZE_MAX / width)
      return impossible();
   size_t capacity = ((size_t)bucket_1_size + 1) * width;
   unsigned char *visited = calloc(capacity, sizeof(*visited));
   state_t *queue = malloc(capacity * sizeof(*queue));
   if (!visited || !queue) {
      free(visited);
      free(queue);
      return impossible();
   }

   size_t head = 0;
   size_t tail = 0;
   state_t first = start_bucket == BUCKET_ID_1
                       ? (state_t){ bucket_1_size, 0, 1 }
                       : (state_t){ 0, bucket_2_size, 1 };
   queue[tail++] = first;
   visited[(size_t)first.first * width + first.second] = 1;
   while (head < tail) {
      state_t current = queue[head++];
      if (current.first == goal_volume || current.second == goal_volume) {
         bucket_id_t goal_bucket = current.first == goal_volume ? BUCKET_ID_1
                                                               : BUCKET_ID_2;
         bucket_result_t answer = solved(current, goal_bucket);
         free(queue);
         free(visited);
         return answer;
      }

      bucket_liters_t pour_1_to_2 = current.first;
      if (pour_1_to_2 > bucket_2_size - current.second)
         pour_1_to_2 = bucket_2_size - current.second;
      bucket_liters_t pour_2_to_1 = current.second;
      if (pour_2_to_1 > bucket_1_size - current.first)
         pour_2_to_1 = bucket_1_size - current.first;

      state_t next[] = {
         { bucket_1_size, current.second, current.moves + 1 },
         { current.first, bucket_2_size, current.moves + 1 },
         { 0, current.second, current.moves + 1 },
         { current.first, 0, current.moves + 1 },
         { current.first - pour_1_to_2, current.second + pour_1_to_2,
           current.moves + 1 },
         { current.first + pour_2_to_1, current.second - pour_2_to_1,
           current.moves + 1 },
      };
      for (size_t i = 0; i < sizeof(next) / sizeof(next[0]); ++i) {
         if ((start_bucket == BUCKET_ID_1 && next[i].first == 0 &&
              next[i].second == bucket_2_size) ||
             (start_bucket == BUCKET_ID_2 && next[i].second == 0 &&
              next[i].first == bucket_1_size))
            continue;
         size_t index = (size_t)next[i].first * width + next[i].second;
         if (!visited[index]) {
            visited[index] = 1;
            queue[tail++] = next[i];
         }
      }
   }

   free(queue);
   free(visited);
   return impossible();
}
