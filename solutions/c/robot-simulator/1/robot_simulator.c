#include "robot_simulator.h"

#include <stddef.h>

robot_status_t robot_create(robot_direction_t direction, int x, int y)
{
   robot_status_t robot = { direction, { x, y } };
   return robot;
}

void robot_move(robot_status_t *robot, const char *commands)
{
   if (robot == NULL || commands == NULL) {
      return;
   }

   for (size_t index = 0; commands[index] != '\0'; index++) {
      switch (commands[index]) {
      case 'R':
         robot->direction =
             (robot_direction_t)((robot->direction + 1) % DIRECTION_MAX);
         break;
      case 'L':
         robot->direction =
             (robot_direction_t)((robot->direction + DIRECTION_MAX - 1) %
                                 DIRECTION_MAX);
         break;
      case 'A':
         switch (robot->direction) {
         case DIRECTION_NORTH:
            robot->position.y++;
            break;
         case DIRECTION_EAST:
            robot->position.x++;
            break;
         case DIRECTION_SOUTH:
            robot->position.y--;
            break;
         case DIRECTION_WEST:
            robot->position.x--;
            break;
         default:
            break;
         }
         break;
      default:
         break;
      }
   }
}
