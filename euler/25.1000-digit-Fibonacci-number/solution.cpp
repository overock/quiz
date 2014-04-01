#include <cassert>
#include <map>
#include <iostream>
#include "../large_number.hpp"

namespace large_number {
        std::string fibonacci(int n)
        {
                static std::map<int, std::string> memo;
                if (memo.empty()) {
                        memo[1] = "1";
                        memo[2] = "1";
                }
                auto it = memo.find(n);
                if (it != memo.end())
                        return it->second;
                Adder adder;
                adder.push_back(fibonacci(n-2));
                adder.push_back(fibonacci(n-1));
                return memo[n] = adder();
        }
}

namespace {
        int first_fibonacci_term_contain_n_digits(int ndigits)
        {
                for (int n=3; ; ++n) {
                        std::string f = large_number::fibonacci(n);
                        if (f.size() >= ndigits) {
                                return n;
                        }
                }
                
        }
}

int main()
{
        assert(large_number::fibonacci(12) == "144");
        std::cout << first_fibonacci_term_contain_n_digits(1000) << std::endl;
}
