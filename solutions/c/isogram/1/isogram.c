#include "isogram.h"

#include <stddef.h>

bool is_isogram(const char phrase[])
{
    if (phrase == NULL) {
        return false;
    }

    bool seen[26] = { false };
    for (const char *character = phrase; *character != '\0'; ++character) {
        char letter = *character;
        if (letter >= 'A' && letter <= 'Z') {
            letter = (char)(letter - 'A' + 'a');
        }
        if (letter < 'a' || letter > 'z') {
            continue;
        }

        unsigned int index = (unsigned int)(letter - 'a');
        if (seen[index]) {
            return false;
        }
        seen[index] = true;
    }
    return true;
}
