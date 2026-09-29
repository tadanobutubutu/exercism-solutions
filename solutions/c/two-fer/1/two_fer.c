#include "two_fer.h"

#include <stdio.h>

void two_fer(char *buffer, const char *name)
{
    const char *recipient = name == NULL ? "you" : name;
    sprintf(buffer, "One for %s, one for me.", recipient);
}
