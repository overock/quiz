#include <cassert>
#include <cstdint>
#include <iostream>
#include <algorithm>
#include <numeric>
#include <set>

typedef std::int64_t integer;

bool is_prime(const std::set<integer>& primes, integer n)
{
        auto iter = std::find_if(primes.begin(), primes.end(),
                                 [&](integer x) { return n % x == 0;});
        return iter == primes.end();
}

void get_primes_below(integer max, std::set<integer>& primes)
{
        integer begin = 2;
        integer end = max;
        primes.clear();
        for (integer i=begin; i<end; ++i) {
                if (is_prime(primes, i))
                        primes.insert(i);
        }
}

integer summation_primes_below(integer max)
{
        std::set<integer> primes;
        get_primes_below(max, primes);
        return std::accumulate(primes.begin(), primes.end(), static_cast<integer>(0));
}

int main()
{
        using namespace std;
        
        assert(summation_primes_below(10) == 17);
        cout << summation_primes_below(2000000) << endl;
}
