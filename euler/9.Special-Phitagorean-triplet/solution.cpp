#include <cassert>
#include <iostream>

bool is_phitagorean_triplet(int c, int b, int a)
{
        return c * c == b * b + a * a;
}

void find_phitagorean_triplet(int c, int b, int a, std::ostream& os)
{
        assert(a > 0);
        assert(a < b);
        assert(b < c);
        if (is_phitagorean_triplet(c, b, a)) {
                os << a << " " << b << " " << c;
        }
}

void find_phitagorean_triplet(int c, int left, std::ostream& os)
{
        assert(left > 0);
        int start = left / 2 + 1;
        for (int b=start; (b < left) && (b < c); ++b) {
                int a = left - b;
                assert(a < b);
                assert(a > 0);
                find_phitagorean_triplet(c, b, a, os);
        }
        
}

void find_phitagorean_triplet(int sum, std::ostream& os)
{
        const int smallest_sum_of_phitagorean_triplet = 3 + 4 + 5;
        if (sum < smallest_sum_of_phitagorean_triplet)
                return;
        int start = sum / 3 + 1;
        for (int c = start; c < sum; ++c) {
                find_phitagorean_triplet(c, sum-c, os);
        }
}


int main()
{
        using std::cout;
        using std::endl;
        
        find_phitagorean_triplet(12, cout);
        cout << endl;
        find_phitagorean_triplet(1000, cout);
        cout << endl;
}
