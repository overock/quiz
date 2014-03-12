#include <cassert>
#include <string>
#include <algorithm>
#include <iostream>

typedef int integer;

std::string multiply(const std::string& s, integer n)
{
        using namespace std;
        
        integer carrying = 0;
        string result;
        for (auto i=s.rbegin(); i!=s.rend(); ++i) {
                carrying += integer(*i - '0') * n;
                result.push_back((carrying % 10) + '0');
                carrying /= 10;
        }
        while (carrying != 0) {
                result.push_back((carrying % 10) + '0');
                carrying /= 10;
        }
        reverse(result.begin(), result.end());
        return result;
}

integer sum_digits(const std::string& s)
{
        return std::accumulate(s.begin(), s.end(), integer(0),
                               [](integer i, char c) {
                                       return i + integer(c - '0');
                               });
}

std::string power(integer base, integer exponent)
{
        std::string s = "1";
        for (integer i=0; i<exponent; ++i) {
                s = multiply(s, base);
        }
        return s;
}

integer sum_power_digit(integer base, integer exponent)
{
        return sum_digits(power(base, exponent));
}

int main()
{
        assert(multiply("1", 2) == "2");
        assert(multiply("99", 2) == "198");
        assert(sum_digits("32768") == 26);
        assert(sum_power_digit(2, 15) == 26);
        std::cout << sum_power_digit(2, 1000) << std::endl;
}
