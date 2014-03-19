#include <cassert>
#include <iostream>
#include <large_number.hpp>

std::string factorial(int n)
{
        using large_number::multiply;

        std::string s("1");
        for (int i=2; i<=n; ++i) {
                s = multiply(s, i);
        }
        return s;
}

int main()
{
        assert(large_number::sum_digits<int>(factorial(10)) == 27);
        std::cout << large_number::sum_digits<int>(factorial(100)) << std::endl;
}
