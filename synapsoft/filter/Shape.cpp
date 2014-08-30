#include <utility>
#include "Shape.hpp"

synap::Shape::Shape(int x, int y, bool bold, bool italic,
		    bool strike, bool underline, const std::string& text)
  : m_x(x), m_y(y),
    m_bold(bold), m_italic(italic),
    m_strike(strike), m_underline(underline),
    m_text(text)
{
}

bool synap::Shape::compare_position_yx(const Shape& other) const
{
  using std::make_pair;
  return make_pair(y(), x()) < make_pair(other.y(), other.x());
}

bool synap::shape_compare_position_yx(const Shape& a, const Shape& b)
{
  return a.compare_position_yx(b);
}
