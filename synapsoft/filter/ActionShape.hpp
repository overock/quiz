#ifndef SYNAP_ACTION_SHAPE_HPP_
#define SYNAP_ACTION_SHAPE_HPP_

#include <functional>
#include "Shape.hpp"
#include "Action.hpp"

namespace synap {
  // Shape을 만드는 액션을 생성합니다.
  // http://www.datypic.com/sc/ooxml/e-p_sp-1.html
  Action make_action_shape(std::function<void (const Shape&)> fn);
}

#endif
