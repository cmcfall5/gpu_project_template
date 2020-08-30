

#include <stdio.h>

int main(int argc, char **argv)
{
    printf("Hello World!\n");

    for (int ii = 0; ii < argc; ii++) {
        printf("argv[%d] = %s\n", ii, argv[ii]);
    }

    return 0;
}