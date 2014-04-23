#include <cassert>
#include <cstdint>
#include <iostream>
#include <algorithm>
#include <numeric>
#include <vector>

typedef std::int64_t integer;

integer summation_primes_below(integer max)
{
        // Sieve of Eratosthenes
        std::vector<integer> primes(max+1, 0);
        for (integer i=2; i<primes.size(); ++i)
                primes[i] = i;

        integer sum = 0;
        for (integer i=2; i<primes.size(); ++i) {
                if (primes[i] == 0)
                        continue;
                sum += i;
                for (integer m=i*2; m<primes.size(); m+=i) {
                        primes[m] = 0;
                }
        }
        return sum;
}

int main()
{
        using namespace std;
        
        assert(summation_primes_below(10) == 17);
        cout << summation_primes_below(2000000) << endl;
}
