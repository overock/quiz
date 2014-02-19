#include <stdio.h>

int main(int argc, char* argv[])
{
     const int limit = 1000;
     int i = 1, sum = 0;
     for (; i<limit; ++i) {
          if (i % 3 == 0 || i % 5 == 0) {
               sum += i;
          }
     }
     printf("%d\n", sum);
}
