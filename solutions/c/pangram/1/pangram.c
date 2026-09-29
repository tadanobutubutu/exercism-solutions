#include "pangram.h"

#include <stddef.h>

bool is_pangram(const char *sentence)
{
    if (sentence == NULL) {
        return false;
    }

    bool seen[26] = { false };
    unsigned int letter_count = 0;
    for (const char *character = sentence; *character != '\0'; ++character) {
        char letter = *character;
        if (letter >= 'A' && letter <= 'Z') {
            letter = (char)(letter - 'A' + 'a');
        }
        if (letter >= 'a' && letter <= 'z') {
            unsigned int index = (unsigned int)(letter - 'a');
            if (!seen[index]) {
                seen[index] = true;
                ++letter_count;
            }
        }
    }
    return letter_count == 26;
}
