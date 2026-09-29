#include "palindrome_products.h"

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

static int is_palindrome(long long value)
{
   long long original = value;
   long long reversed = 0;
   while (value > 0) {
      reversed = reversed * 10 + value % 10;
      value /= 10;
   }
   return original == reversed;
}

static void free_factors(factor_t *factor)
{
   while (factor) {
      factor_t *next = factor->next;
      free(factor);
      factor = next;
   }
}

static void append_factor(factor_t **head, factor_t **tail, int a, int b)
{
   factor_t *factor = malloc(sizeof(*factor));
   if (!factor)
      return;
   *factor = (factor_t){ .factor_a = a, .factor_b = b, .next = NULL };
   if (*tail)
      (*tail)->next = factor;
   else
      *head = factor;
   *tail = factor;
}

product_t *get_palindrome_product(int from, int to)
{
   product_t *product = calloc(1, sizeof(*product));
   if (!product)
      return NULL;
   if (from > to) {
      snprintf(product->error, sizeof(product->error),
               "invalid input: min is %d and max is %d", from, to);
      return product;
   }

   long long smallest = LLONG_MAX;
   long long largest = -1;
   factor_t *small_tail = NULL;
   factor_t *large_tail = NULL;
   for (int a = from; a <= to; ++a) {
      for (int b = a; b <= to; ++b) {
         long long value = (long long)a * b;
         if (!is_palindrome(value))
            continue;
         if (value < smallest) {
            free_factors(product->factors_sm);
            product->factors_sm = NULL;
            small_tail = NULL;
            smallest = value;
         }
         if (value == smallest)
            append_factor(&product->factors_sm, &small_tail, a, b);
         if (value > largest) {
            free_factors(product->factors_lg);
            product->factors_lg = NULL;
            large_tail = NULL;
            largest = value;
         }
         if (value == largest)
            append_factor(&product->factors_lg, &large_tail, a, b);
      }
   }

   if (largest < 0) {
      snprintf(product->error, sizeof(product->error),
               "no palindrome with factors in the range %d to %d", from, to);
      return product;
   }
   product->smallest = (int)smallest;
   product->largest = (int)largest;
   return product;
}

void free_product(product_t *product)
{
   if (!product)
      return;
   free_factors(product->factors_sm);
   free_factors(product->factors_lg);
   free(product);
}
