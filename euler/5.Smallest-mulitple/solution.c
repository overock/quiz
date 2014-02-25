#include <assert.h>
#include <stdio.h>

int least_common_multiple_range(int first, int last)
{
        assert(first <= last);
        if (first == last)
                return first;
        return least_common_multiple(first, least_common_multiple_range(first+1, last));
}

int least_common_multiple(int a, int b)
{
        return a / greatest_common_divisor(a, b) * b;
}

int greatest_common_divisor(int a, int b)
{
        assert(a > 0 && b > 0);
        while (b != 0) {
                int r = a % b;
                a = b;
                b = r;
        }
        return a;
}

int main()
{
        assert(least_common_multiple_range(1, 10) == 2520);
        printf("%d\n", least_common_multiple_range(1, 20));
}
