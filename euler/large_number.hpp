#include <cassert>
#include <string>
#include <algorithm>

namespace large_number {
        template <class Integer>
        std::string multiply(const std::string& s, Integer n)
        {
                using namespace std;
        
                Integer carrying = 0;
                string result;
                for (auto i=s.rbegin(); i!=s.rend(); ++i) {
                        carrying += Integer(*i - '0') * n;
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

        template <class Integer>
        Integer sum_digits(const std::string& s)
        {
                return std::accumulate(s.begin(), s.end(), Integer(0),
                                       [](Integer i, char c) {
                                               return i + Integer(c - '0');
                                       });
        }

        template <class Integer>
        std::string power(Integer base, Integer exponent)
        {
                std::string s = "1";
                for (Integer i=0; i<exponent; ++i) {
                        s = multiply(s, base);
                }
                return s;
        }
        
        class Adder {
        public:
                void push_back(const std::string& x);
                void clear();
                std::string operator()();
                bool empty() const;
        private:
                void resize();
                std::string do_add(std::string* numbers, int size);
                std::vector<std::string> m_numbers;
        };
}
