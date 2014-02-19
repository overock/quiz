#include <assert.h>
#include <stdio.h>

int sum_even_fibonacci(int max)
{
     int pair[2] = {1, 2};
     int sum = 0;
     int last = 1;
     while (pair[last] <= max) {
          if (pair[last] % 2 == 0) {
               sum += pair[last];
          }
          last = !last;
          pair[last] = pair[0] + pair[1];
     }
     return sum;
}


int main(int argc, char* argv[])
{
     /* Fibonacci numbers: 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ... */
     assert(sum_even_fibonacci(100) == 2 + 8 + 34);
     printf("%d\n", sum_even_fibonacci(4000000));
}
