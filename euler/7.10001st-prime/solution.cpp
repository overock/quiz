#include <cassert>
#include <algorithm>
#include <iostream>
#include <vector>

bool is_prime_number(int i, const std::vector<int>& prime_numbers)
{
        auto found = std::find_if(prime_numbers.begin(),
                                  prime_numbers.end(),
                                  [&](int j) {return i % j == 0;});
        return found == prime_numbers.end();
}

int n_th_prime_number(int n)
{
        using namespace std;

        vector<int> prime_numbers;
        for (int i=2; prime_numbers.size() < n; ++i) {
                if (is_prime_number(i, prime_numbers)) {
                        prime_numbers.push_back(i);
                }
        }
        return *prime_numbers.rbegin();
}

int main()
{
        assert(n_th_prime_number(6) == 13);
        std::cout << n_th_prime_number(10001) << std::endl;
}
