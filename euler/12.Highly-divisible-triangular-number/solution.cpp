#include <cassert>
#include <numeric>
#include <set>
#include <map>
#include <vector>
#include <iostream>

typedef int integer;

std::map<integer, integer> number_of_divisor_cache;
std::set<integer> prime_numbers;

integer number_of_divisor(integer x)
{
        auto found_item = number_of_divisor_cache.find(x);
        if (found_item != number_of_divisor_cache.end())
                return found_item->second;
        
        integer y = x;
        std::vector<integer> e;
        for (auto i=prime_numbers.begin(); i!=prime_numbers.end(); ++i) {
                int count = 1;
                while (y % *i == 0) {
                        count++;
                        y /= *i;
                }
                e.push_back(count);
        }
        if (y != 1) {
                e.push_back(2);
        }
        
        integer n = std::accumulate(e.begin(), e.end(), 1, std::multiplies<integer>());
        if (n == 2)
                prime_numbers.insert(x);
        return number_of_divisor_cache[x] = n;
}

integer number_of_divisor_of_nth_triangular_number(integer n)
{
        /* if c == ab (a and b are relative prime) then
           number-of-divisor(c) == number-of-divisor(a) * number-of-divisor(b) */
        if (n % 2 == 0) {
                /* n == 2k. k and 2k + 1 are relative primes. */
                return number_of_divisor(n / 2) * number_of_divisor(n + 1);
        } else {
                /* n == 2k -1. k and 2k - 1  are relative primes. */
                return number_of_divisor((n + 1) / 2) * number_of_divisor(n);
        }
}

integer nth_triangular_number(integer n)
{
        return (n + 1) * n / 2;
}

int main()
{
        number_of_divisor_cache[1] = 1;
        number_of_divisor_cache[2] = 2;
        prime_numbers.insert(2);

        integer i=1;
        for (; number_of_divisor_of_nth_triangular_number(i) <= 500; ++i) {
        }
        std::cout << nth_triangular_number(i) << std::endl;
}
