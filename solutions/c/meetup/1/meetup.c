#include "meetup.h"

#include <string.h>

static int weekday(unsigned int year, unsigned int month, unsigned int day)
{
   static const int offsets[] = { 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4 };
   if (month < 3)
      --year;
   return (int)((year + year / 4 - year / 100 + year / 400 +
                 (unsigned int)offsets[month - 1] + day) % 7);
}

static unsigned int days_in_month(unsigned int year, unsigned int month)
{
   static const unsigned int days[] =
       { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
   if (month == 2 && (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)))
      return 29;
   return days[month - 1];
}

static int weekday_number(const char *day)
{
   static const char *names[] = { "Sunday", "Monday", "Tuesday", "Wednesday",
                                  "Thursday", "Friday", "Saturday" };
   for (int i = 0; i < 7; ++i)
      if (strcmp(day, names[i]) == 0)
         return i;
   return -1;
}

int meetup_day_of_month(unsigned int year, unsigned int month, const char *week,
                        const char *day_of_week)
{
   if (month < 1 || month > 12 || !week || !day_of_week)
      return 0;
   int wanted = weekday_number(day_of_week);
   if (wanted < 0)
      return 0;
   unsigned int first_day = 1;
   unsigned int last_day = days_in_month(year, month);

   if (strcmp(week, "teenth") == 0) {
      first_day = 13;
      last_day = 19;
   } else if (strcmp(week, "first") == 0) {
      last_day = 7;
   } else if (strcmp(week, "second") == 0) {
      first_day = 8;
      last_day = 14;
   } else if (strcmp(week, "third") == 0) {
      first_day = 15;
      last_day = 21;
   } else if (strcmp(week, "fourth") == 0) {
      first_day = 22;
      last_day = 28;
   } else if (strcmp(week, "last") == 0) {
      first_day = last_day >= 6 ? last_day - 6 : 1;
   } else {
      return 0;
   }

   for (unsigned int day = first_day; day <= last_day; ++day)
      if (weekday(year, month, day) == wanted)
         return (int)day;
   return 0;
}
