#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdbool.h>

typedef int integer;

void make_digit_power_table(integer exp, integer* table)
{
        for (integer base=0; base<10; ++base) {
                table[base] = 1;
                for (integer c=0; c<exp; ++c) {
                        table[base] *= base;
                }
        }
}

integer sum_digit_powers(integer n, integer exp)
{
        assert(n >= 0);
        integer sum = 0;
        while (n != 0) {
                integer r = n % 10;
                sum += pow(r, exp);
                n /= 10;
        }
        return sum;
}

integer sum_digit_powers_with_table(integer n, integer* table)
{
        assert(n >= 0);
        integer sum = 0;
        while (n != 0) {
                integer r = n % 10;
                sum += table[r];
                n /= 10;
        }
        return sum;
}

bool is_cony_number(integer n, integer exp)
{
        return sum_digit_powers(n, exp) == n;
}

bool is_cony_number_with_table(integer n, integer* table)
{
        return sum_digit_powers_with_table(n, table) == n;
}

int main()
{
        assert(is_cony_number(1634, 4));
        assert(is_cony_number(8208, 4));
        assert(is_cony_number(9474, 4));
        assert(!is_cony_number(2123, 4));

        integer exp = 5;
        integer ndigits = 1; 
        while (pow(9, exp) * ndigits > pow(10, ndigits-1)) {
                ++ndigits;
        }

        integer digit_power_table[10];
        make_digit_power_table(exp, digit_power_table);
        
        integer sum = 0;
        integer limit = pow(10, ndigits-1);
        for (integer n=2; n < limit; ++n) {
                if (is_cony_number_with_table(n, digit_power_table)) {
                        sum += n;
                }
        }
        printf("%d\n", sum);
}
