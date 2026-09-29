#include "nucleotide_count.h"

#include <stdio.h>
#include <stdlib.h>

char *count(const char *dna_strand)
{
   size_t counts[4] = { 0, 0, 0, 0 };
   char *result = malloc(128);
   if (result == NULL) {
      return NULL;
   }

   if (dna_strand != NULL) {
      for (size_t index = 0; dna_strand[index] != '\0'; index++) {
         size_t nucleotide;
         switch (dna_strand[index]) {
         case 'A':
            nucleotide = 0;
            break;
         case 'C':
            nucleotide = 1;
            break;
         case 'G':
            nucleotide = 2;
            break;
         case 'T':
            nucleotide = 3;
            break;
         default:
            result[0] = '\0';
            return result;
         }
         counts[nucleotide]++;
      }
   }

   (void)snprintf(result, 128, "A:%zu C:%zu G:%zu T:%zu", counts[0],
                  counts[1], counts[2], counts[3]);
   return result;
}
