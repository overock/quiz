#ifndef SYNAP_SHAPE_HPP_
#define SYNAP_SHAPE_HPP_

#include <string>

namespace synap {
  class Shape {
  public:
    Shape(int x, int y, bool bold, bool italic,
	  bool strike, bool underline, const std::string& text);
    int x() const {return m_x;}
    int y() const {return m_y;}
    bool bold() const {return m_bold;}
    bool italic() const {return m_italic;}
    bool underline() const {return m_underline;}
    bool strike() const {return m_strike;}
    std::string text() const {return m_text;}
    bool compare_position_yx(const Shape& other) const;
  private:
    int m_x;
    int m_y;
    bool m_bold;
    bool m_italic;
    bool m_strike;
    bool m_underline;
    std::string m_text;
  };
  bool shape_compare_position_yx(const Shape& a, const Shape& b);
}

#endif
