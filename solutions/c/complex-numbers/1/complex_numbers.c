#include "complex_numbers.h"

#include <math.h>

complex_t c_add(complex_t a, complex_t b)
{
   return (complex_t){ a.real + b.real, a.imag + b.imag };
}

complex_t c_sub(complex_t a, complex_t b)
{
   return (complex_t){ a.real - b.real, a.imag - b.imag };
}

complex_t c_mul(complex_t a, complex_t b)
{
   return (complex_t){ a.real * b.real - a.imag * b.imag,
                       a.real * b.imag + a.imag * b.real };
}

complex_t c_div(complex_t a, complex_t b)
{
   double denominator = b.real * b.real + b.imag * b.imag;
   if (denominator == 0.0)
      return (complex_t){ NAN, NAN };
   return (complex_t){ (a.real * b.real + a.imag * b.imag) / denominator,
                       (a.imag * b.real - a.real * b.imag) / denominator };
}

double c_abs(complex_t x)
{
   return hypot(x.real, x.imag);
}

complex_t c_conjugate(complex_t x)
{
   return (complex_t){ x.real, -x.imag };
}

double c_real(complex_t x)
{
   return x.real;
}

double c_imag(complex_t x)
{
   return x.imag;
}

complex_t c_exp(complex_t x)
{
   double scale = exp(x.real);
   return (complex_t){ scale * cos(x.imag), scale * sin(x.imag) };
}
