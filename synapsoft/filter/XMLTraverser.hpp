#ifndef SYNAP_XML_TRAVERSER_HPP_
#define SYNAP_XML_TRAVERSER_HPP_

#include <string>
#include <unordered_map>
#include <tinyxml2.h>
#include "Action.hpp"

namespace synap {
  // XML tree를 훑다가 지정한 태그를 발견했을 때
  // 같이 등록한 액션을 호출하는 역할을 담당합니다.
  class XMLTraverser {
  public:
    typedef std::string key_type;
    typedef Action value_type;
  public:
    void traverse(tinyxml2::XMLElement* element);
    value_type& operator[](const key_type& key);
    void clear();
  private:
    std::unordered_map<std::string, Action> m_actions;
  };
}

#endif
