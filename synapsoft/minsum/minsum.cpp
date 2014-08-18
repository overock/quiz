#include <algorithm>
#include <list>
#include "minsum.hpp"

namespace {
        bool is_zero(int x)
        {
                return x == 0;
        }

        void shift_and_add(int* x, int y)
        {
                *x = *x * 10 + y;
        }

        void shift_and_add_if_not_empty(int* x, std::list<int>& digits)
        {
                if (!digits.empty()) {
                        shift_and_add(x, digits.front());
                        digits.pop_front();
                }
        }

        bool shift_and_add_not_zero(int* x, std::list<int>& digits)
        {
                auto i = find_if_not(digits.begin(), digits.end(), is_zero);
                if (i == digits.end()) {
                        return false;
                }
                shift_and_add(x, *i);
                digits.erase(i);
                return true;
        }
}

int minsum(std::list<int>& digits)
{
        int a = 0, b = 0;
        digits.sort();
        bool good = true;
        good = good && shift_and_add_not_zero(&a, digits);
        good = good && shift_and_add_not_zero(&b, digits);
        if (!good) { 
                // It is impossible to make a pair of two natural numbers.
                return -1;
        }
        while (!digits.empty()) {
                shift_and_add_if_not_empty(&a, digits);
                shift_and_add_if_not_empty(&b, digits);
        }
        return a + b;
}
        
