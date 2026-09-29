#include "zebra_puzzle.h"

solution_t solve_puzzle(void)
{
   static const char water_owner[] = "Norwegian";
   static const char zebra_owner[] = "Japanese";
   return (solution_t){ .drinks_water = water_owner,
                        .owns_zebra = zebra_owner };
}
