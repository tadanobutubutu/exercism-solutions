#include "clock.h"

#include <stdio.h>
#include <string.h>

static clock_t make_clock(long long total_minutes)
{
   const long long minutes_per_day = 24 * 60;
   int normalized = (int)(total_minutes % minutes_per_day);
   if (normalized < 0) {
      normalized += (int)minutes_per_day;
   }

   clock_t result;
   (void)snprintf(result.text, sizeof(result.text), "%02d:%02d",
                  normalized / 60, normalized % 60);
   return result;
}

static int clock_minutes(clock_t clock)
{
   int hour = (clock.text[0] - '0') * 10 + (clock.text[1] - '0');
   int minute = (clock.text[3] - '0') * 10 + (clock.text[4] - '0');
   return hour * 60 + minute;
}

clock_t clock_create(int hour, int minute)
{
   return make_clock((long long)hour * 60 + minute);
}

clock_t clock_add(clock_t clock, int minute_add)
{
   return make_clock((long long)clock_minutes(clock) + minute_add);
}

clock_t clock_subtract(clock_t clock, int minute_subtract)
{
   return make_clock((long long)clock_minutes(clock) - minute_subtract);
}

bool clock_is_equal(clock_t a, clock_t b)
{
   return strcmp(a.text, b.text) == 0;
}
