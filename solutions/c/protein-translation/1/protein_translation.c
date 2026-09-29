#include "protein_translation.h"

#include <string.h>

struct codon_entry {
   const char *codon;
   amino_acid_t amino_acid;
};

static const struct codon_entry codons[] = {
   { "AUG", Methionine },
   { "UUU", Phenylalanine }, { "UUC", Phenylalanine },
   { "UUA", Leucine },       { "UUG", Leucine },
   { "UCU", Serine },        { "UCC", Serine },
   { "UCA", Serine },        { "UCG", Serine },
   { "UAU", Tyrosine },      { "UAC", Tyrosine },
   { "UGU", Cysteine },      { "UGC", Cysteine },
   { "UGG", Tryptophan }
};

static int is_stop_codon(const char *codon)
{
   return strcmp(codon, "UAA") == 0 || strcmp(codon, "UAG") == 0 ||
          strcmp(codon, "UGA") == 0;
}

protein_t protein(const char *const rna)
{
   protein_t result = { .valid = false, .count = 0 };
   if (rna == NULL) {
      return result;
   }

   size_t length = strlen(rna);
   size_t offset = 0;
   result.valid = true;

   while (offset < length) {
      if (length - offset < 3) {
         result.valid = false;
         result.count = 0;
         return result;
      }

      char codon[4] = { rna[offset], rna[offset + 1], rna[offset + 2], '\0' };
      if (is_stop_codon(codon)) {
         return result;
      }

      bool found = false;
      for (size_t index = 0; index < sizeof(codons) / sizeof(codons[0]);
           index++) {
         if (strcmp(codon, codons[index].codon) == 0) {
            if (result.count == MAX_AMINO_ACIDS) {
               result.valid = false;
               result.count = 0;
               return result;
            }
            result.amino_acids[result.count++] = codons[index].amino_acid;
            found = true;
            break;
         }
      }

      if (!found) {
         result.valid = false;
         result.count = 0;
         return result;
      }
      offset += 3;
   }

   return result;
}
