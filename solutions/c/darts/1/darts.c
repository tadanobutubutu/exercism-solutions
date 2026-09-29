#include "darts.h"

uint8_t score(coordinate_t landing_position)
{
    float distance_squared = landing_position.x * landing_position.x
        + landing_position.y * landing_position.y;

    if (distance_squared <= 1.0F) {
        return 10;
    }
    if (distance_squared <= 25.0F) {
        return 5;
    }
    if (distance_squared <= 100.0F) {
        return 1;
    }
    return 0;
}
