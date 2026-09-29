#include "triangle.h"

#include <math.h>

static bool is_valid_triangle(triangle_t sides)
{
   return isfinite(sides.a) && isfinite(sides.b) && isfinite(sides.c) &&
          sides.a > 0 && sides.b > 0 && sides.c > 0 &&
          sides.a + sides.b >= sides.c && sides.a + sides.c >= sides.b &&
          sides.b + sides.c >= sides.a;
}

bool is_equilateral(triangle_t sides)
{
   return is_valid_triangle(sides) && sides.a == sides.b &&
          sides.b == sides.c;
}

bool is_isosceles(triangle_t sides)
{
   return is_valid_triangle(sides) &&
          (sides.a == sides.b || sides.a == sides.c || sides.b == sides.c);
}

bool is_scalene(triangle_t sides)
{
   return is_valid_triangle(sides) && sides.a != sides.b &&
          sides.a != sides.c && sides.b != sides.c;
}
