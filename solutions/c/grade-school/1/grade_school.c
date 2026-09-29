#include "grade_school.h"

#include <string.h>

void init_roster(roster_t *roster)
{
   if (roster != NULL) {
      roster->count = 0;
   }
}

bool add_student(roster_t *roster, const char *name, uint8_t grade)
{
   if (roster == NULL || name == NULL || roster->count >= MAX_STUDENTS ||
       strlen(name) >= MAX_NAME_LENGTH) {
      return false;
   }

   for (size_t index = 0; index < roster->count; index++) {
      if (strcmp(roster->students[index].name, name) == 0) {
         return false;
      }
   }

   size_t position = roster->count;
   while (position > 0) {
      student_t *previous = &roster->students[position - 1];
      if (previous->grade < grade ||
          (previous->grade == grade && strcmp(previous->name, name) < 0)) {
         break;
      }
      roster->students[position] = *previous;
      position--;
   }

   roster->students[position].grade = grade;
   (void)strcpy(roster->students[position].name, name);
   roster->count++;
   return true;
}

roster_t get_grade(const roster_t *roster, uint8_t grade)
{
   roster_t result = { .count = 0 };
   if (roster == NULL) {
      return result;
   }

   for (size_t index = 0; index < roster->count; index++) {
      if (roster->students[index].grade == grade &&
          result.count < MAX_STUDENTS) {
         result.students[result.count++] = roster->students[index];
      }
   }
   return result;
}
