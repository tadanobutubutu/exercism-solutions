#include "rational_numbers.h"

#include <math.h>
#include <stdint.h>

static int64_t gcd64(int64_t left, int64_t right)
{
   if (left < 0) {
      left = -left;
   }
   if (right < 0) {
      right = -right;
   }
   while (right != 0) {
      int64_t remainder = left % right;
      left = right;
      right = remainder;
   }
   return left == 0 ? 1 : left;
}

static rational_t from_int64(int64_t numerator, int64_t denominator)
{
   if (denominator == 0) {
      return (rational_t){ 0, 1 };
   }
   if (denominator < 0) {
      numerator = -numerator;
      denominator = -denominator;
   }
   int64_t divisor = gcd64(numerator, denominator);
   numerator /= divisor;
   denominator /= divisor;
   return (rational_t){ (int16_t)numerator, (int16_t)denominator };
}

rational_t reduce(rational_t r)
{
   return from_int64(r.numerator, r.denominator);
}

rational_t add(rational_t r1, rational_t r2)
{
   return from_int64((int64_t)r1.numerator * r2.denominator +
                         (int64_t)r2.numerator * r1.denominator,
                     (int64_t)r1.denominator * r2.denominator);
}

rational_t subtract(rational_t r1, rational_t r2)
{
   return from_int64((int64_t)r1.numerator * r2.denominator -
                         (int64_t)r2.numerator * r1.denominator,
                     (int64_t)r1.denominator * r2.denominator);
}

rational_t multiply(rational_t r1, rational_t r2)
{
   return from_int64((int64_t)r1.numerator * r2.numerator,
                     (int64_t)r1.denominator * r2.denominator);
}

rational_t divide(rational_t r1, rational_t r2)
{
   return from_int64((int64_t)r1.numerator * r2.denominator,
                     (int64_t)r1.denominator * r2.numerator);
}

rational_t absolute(rational_t r)
{
   r = reduce(r);
   if (r.numerator < 0) {
      r.numerator = (int16_t)-r.numerator;
   }
   return r;
}

rational_t exp_rational(rational_t r, int16_t n)
{
   int32_t exponent = n;
   int64_t numerator = 1;
   int64_t denominator = 1;
   int64_t base_numerator = r.numerator;
   int64_t base_denominator = r.denominator;

   if (exponent < 0) {
      exponent = -exponent;
      int64_t temporary = base_numerator;
      base_numerator = base_denominator;
      base_denominator = temporary;
   }

   while (exponent > 0) {
      if (exponent % 2 != 0) {
         numerator *= base_numerator;
         denominator *= base_denominator;
      }
      exponent /= 2;
      if (exponent > 0) {
         base_numerator *= base_numerator;
         base_denominator *= base_denominator;
      }
   }

   return from_int64(numerator, denominator);
}

float exp_real(uint16_t x, rational_t r)
{
   if (r.denominator == 0) {
      return NAN;
   }
   return (float)pow((double)x,
                     (double)r.numerator / (double)r.denominator);
}
