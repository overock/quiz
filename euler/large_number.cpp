#include <algorithm>
#include <functional>
#include "large_number.hpp"

namespace {
        std::string pad_with_0(std::string s, std::string::size_type n)
        {
                std::reverse(s.begin(), s.end());
                s.resize(std::max(n, s.size()), '0');
                std::reverse(s.begin(), s.end());
                return s;
        }

        bool compare_size(const std::string& a, const std::string& b)
        {
                return a.size() < b.size();
        }
}

void large_number::Adder::push_back(const std::string& x)
{
        m_numbers.push_back(x);
}

bool large_number::Adder::empty() const
{
        assert(!m_numbers.empty());
        return m_numbers.size() == 1;
}

void large_number::Adder::clear()
{
        m_numbers.clear();
        m_numbers.push_back("0");
}

std::string large_number::Adder::operator()()
{
        resize();
        std::string sum = do_add(m_numbers.data(), m_numbers.size());
        clear();
        return sum;
}

void large_number::Adder::resize()
{
        assert(!m_numbers.empty());
        auto longest = std::max_element(m_numbers.begin(), m_numbers.end(), compare_size);
        std::string::size_type max_len = longest->size();
        std::transform(m_numbers.begin(), m_numbers.end(),
                       m_numbers.begin(),
                       std::bind(pad_with_0, std::placeholders::_1, max_len));
}

std::string large_number::Adder::do_add(std::string* numbers, int size)
{
        using namespace std;
        
        int len = numbers[0].size();
        string sum;
        int carrying = 0;

        for (int i=0; i<len; ++i) {
                for (string* number=numbers; number!=numbers+size; ++number) {
                        carrying += number->back() - '0';
                        number->pop_back();
                }
                sum.push_back((carrying % 10) + '0');
                carrying /= 10;
        }
        while (carrying != 0) {
                sum.push_back((carrying % 10) + '0');
                carrying /= 10;
        }
        reverse(sum.begin(), sum.end());
        return sum;
}
