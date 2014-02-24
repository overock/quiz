#include <assert.h>
#include <stdio.h>

int max(int a, int b);
int get_min_number_ndigits(int ndigits);
int get_max_number_ndigits(int ndigits);
int reverse_digits(int n);
int is_palindrome(int n);
/* return largest palindrome made from two n-digits product or 0 if not found. */
int find_largest_palindrome_product(int ndigits);

int main(void)
{
        assert(get_max_number_ndigits(2) == 99);
        assert(get_max_number_ndigits(1) == 9);
        assert(get_min_number_ndigits(2) == 10);
        assert(get_min_number_ndigits(1) == 1);
        assert(reverse_digits(1234) == 4321);
        assert(reverse_digits(1) == 1);
        assert(reverse_digits(0) == 0);
        assert(is_palindrome(9009));
        assert(is_palindrome(131));
        assert(is_palindrome(1));
        assert(is_palindrome(0));
        assert(!is_palindrome(2134));
        assert(find_largest_palindrome_product(2) == 9009);
        printf("%d\n", find_largest_palindrome_product(3));
}

int max(int a, int b)
{
        return (a > b) ? a : b;
}

int reverse_digits(int n)
{
        assert(n >= 0);
        int reversed = 0;
        while (n != 0) {
                reversed = reversed * 10 + (n % 10);
                n /= 10;
        }
        return reversed;
}

int is_palindrome(int n)
{
        return reverse_digits(n) == n;
}

int find_largest_palindrome_product(int ndigits)
{
        int i, j;
        int largest_palindrome = 0;
        int upper = get_max_number_ndigits(ndigits);
        int lower = get_min_number_ndigits(ndigits);
        for (i=upper; i>=lower; --i) {
                for (j=i; j>=lower; --j) {
                        int product = i * j;
                        if (!is_palindrome(product)) 
                                continue;
                        largest_palindrome = max(product, largest_palindrome);
                }
        }
        return largest_palindrome;
}

int get_max_number_ndigits(int ndigits)
{
        return get_min_number_ndigits(ndigits + 1) - 1;
}

int get_min_number_ndigits(int ndigits)
{
        assert(ndigits > 0);
        int n = 1;
        int i;
        for (i=0; i<ndigits-1; ++i)
                n *= 10;
        return n;
}
