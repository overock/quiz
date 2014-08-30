#ifndef SYNAP_ACTION_H_
#define SYNAP_ACTION_H_

#include <memory>
#include <tinyxml2.h>
#include "AttributeMap.hpp"

namespace synap {
  namespace detail {
    class ActionBase {
    public:
      virtual ~ActionBase();
      virtual void enter(tinyxml2::XMLElement* element) = 0;
      virtual void exit(tinyxml2::XMLElement* element) = 0;
    protected:
      // XML 태그 속성을 key-value 쌍으로 이루어진 표로 정리합니다.
      void build_attribute_map(tinyxml2::XMLElement* element, AttributeMap& attr);
      void build_attribute_map(tinyxml2::XMLElement* element, AttributeMap& attr,
			       const std::string& prefix);
    };
  
    class NullAction: public ActionBase {
    public:
      void enter(tinyxml2::XMLElement* element);
      void exit(tinyxml2::XMLElement* element);
    };
  }

  // XMLTraverser에 등록할 액션입니다.
  // 태그 이름과 쌍으로 XMLTraverser에 등록합니다.
  // 지정한 태그를 만나면 enter와 exit를 호출합니다.
  class Action {
  public:
    typedef detail::ActionBase kernel_type;
  public:
    Action();
    Action(kernel_type* kernel);
    void swap(Action& other);
    // 태그가 시작할 때 호출합니다.
    void enter(tinyxml2::XMLElement* element);
    // 태그가 끝났을 때 호출합니다.
    void exit(tinyxml2::XMLElement* element);
  private:
    std::shared_ptr<kernel_type> m_kernel;
  };
}

#endif
