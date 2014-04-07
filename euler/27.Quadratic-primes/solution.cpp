#include <cassert>
#include <iostream>
#include <set>

bool is_prime(int n)
{
        if (n < 2)
                return false;
        
        for (int i=2; i * i <= n; ++i) {
                if (n % i == 0)
                        return false;
        }
        return true;
}

int f(int n, int a, int b)
{
        return n * n + a * n + b;
}

void filter(int n, std::set<std::pair<int, int>>& ab_pairs)
{
        for (auto i = ab_pairs.begin(); i != ab_pairs.end();) {
                if (is_prime(f(n, i->first, i->second))) {
                        ++i;
                } else {
                        ab_pairs.erase(i++);
                }
        }
}

int main()
{
        const int LOWER_BOUND = -999;
        const int UPPER_BOUND = 999;

        /* f(0, a, b) is prime number only if b is prime number. */
        std::set<int> prime_numbers;
        for (int i=2; i<=UPPER_BOUND; ++i) {
                if (is_prime(i)) {
                        prime_numbers.insert(i);
                }
        }
        int n = 1;
        std::set<std::pair<int, int>> ab_pairs;
        for (auto ib = prime_numbers.begin(); ib != prime_numbers.end(); ++ib) {
                auto b = *ib;
                for (int a=LOWER_BOUND; a<=UPPER_BOUND; ++a) {
                        int m = f(n, a, b);
                        if (is_prime(m)) {
                                ab_pairs.insert(std::make_pair(a, b));
                        }
                }
        }
        assert(ab_pairs.find(std::make_pair(1, 41)) != ab_pairs.end());
        for (n=2; ab_pairs.size() > 1; ++n) {
                filter(n, ab_pairs);
        }
        
        if (ab_pairs.empty()) {
                std::cerr << "solution not found\n";
        } else {
                auto s = ab_pairs.begin();
                std::cout << "product of coefficient: " << (s->first * s->second) << std::endl;
        }
}
