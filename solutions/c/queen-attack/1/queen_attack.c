#include "queen_attack.h"

#include <stdlib.h>

attack_status_t can_attack(position_t queen_1, position_t queen_2)
{
   if (queen_1.row > 7 || queen_1.column > 7 || queen_2.row > 7 ||
       queen_2.column > 7 ||
       (queen_1.row == queen_2.row && queen_1.column == queen_2.column)) {
      return INVALID_POSITION;
   }

   int row_distance = abs((int)queen_1.row - (int)queen_2.row);
   int column_distance = abs((int)queen_1.column - (int)queen_2.column);
   if (queen_1.row == queen_2.row || queen_1.column == queen_2.column ||
       row_distance == column_distance) {
      return CAN_ATTACK;
   }

   return CAN_NOT_ATTACK;
}
