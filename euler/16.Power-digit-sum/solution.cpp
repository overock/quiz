#include <cassert>
#include <iostream>
#include <large_number.hpp>

typedef int integer;

integer sum_power_digit(integer base, integer exponent)
{
        using namespace large_number;
        
        return sum_digits<integer>(power(base, exponent));
}

int main()
{
        using large_number::multiply;
        using large_number::sum_digits;

        assert(multiply("1", 2) == "2");
        assert(multiply("99", 2) == "198");
        assert(sum_digits<integer>("32768") == 26);
        assert(sum_power_digit(2, 15) == 26);
        std::cout << sum_power_digit(2, 1000) << std::endl;
}
