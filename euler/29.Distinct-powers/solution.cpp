#include <cassert>
#include <set>
#include <iostream>
#include "../large_number.hpp"

std::size_t count_distinct_terms(int begin, int end)
{
        std::set<std::string> terms;
        for (int a=begin; a<end; ++a) {
                for (int b=begin; b<end; ++b) {
                        terms.insert(large_number::power(a, b));
                }
        }
        return terms.size();
}

int main()
{
        assert(count_distinct_terms(2, 6) == 15);
        std::cout << count_distinct_terms(2, 101) << std::endl;
}
