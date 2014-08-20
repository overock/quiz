#include <cstdlib>
#include <list>
#include <iostream>
#include "minsum.hpp"

namespace {
        int to_digit(char c)
        {
                return (std::isdigit(c)) ? (c - '0') : 0;
        }

}

int main(int argc, char* argv[])
{
        using namespace std;
        
        list<int> digits;
        for (int i=1; i<argc; ++i) {
                digits.push_back(to_digit(*argv[i]));
        }
        if (digits.size() < 2) {
                cerr << "usage: " << argv[0] << " digit digit ...\n";
                return EXIT_FAILURE;
        }
        cout << minsum(digits) << endl;
}
