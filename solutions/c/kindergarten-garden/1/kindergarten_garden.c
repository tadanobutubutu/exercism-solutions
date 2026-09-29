#include "kindergarten_garden.h"

#include <stddef.h>
#include <string.h>

static plant_t decode_plant(char plant)
{
   switch (plant) {
   case 'C':
      return CLOVER;
   case 'G':
      return GRASS;
   case 'R':
      return RADISHES;
   case 'V':
      return VIOLETS;
   default:
      return CLOVER;
   }
}

plants_t plants(const char *diagram, const char *student)
{
   static const char *const students[] = {
      "Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny",
      "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"
   };
   plants_t result = { .plants = { CLOVER, CLOVER, CLOVER, CLOVER } };
   if (diagram == NULL || student == NULL) {
      return result;
   }

   size_t student_index = sizeof(students) / sizeof(students[0]);
   for (size_t index = 0; index < sizeof(students) / sizeof(students[0]);
        index++) {
      if (strcmp(student, students[index]) == 0) {
         student_index = index;
         break;
      }
   }
   if (student_index == sizeof(students) / sizeof(students[0])) {
      return result;
   }

   const char *second_row = strchr(diagram, '\n');
   if (second_row == NULL) {
      return result;
   }
   second_row++;

   size_t offset = student_index * 2;
   result.plants[0] = decode_plant(diagram[offset]);
   result.plants[1] = decode_plant(diagram[offset + 1]);
   result.plants[2] = decode_plant(second_row[offset]);
   result.plants[3] = decode_plant(second_row[offset + 1]);
   return result;
}
