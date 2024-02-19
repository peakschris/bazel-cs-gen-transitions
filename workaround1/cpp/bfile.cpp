#include <cstdio>
#include <stdlib.h>

int afunction();

int main() {
    if (afunction() == 3)
    {
        printf("Program successful!\n");
        return 0;
    }

    printf("ERROR: Failed to call function\n");
    exit(1);
}

