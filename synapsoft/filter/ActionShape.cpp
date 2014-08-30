#include <iostream>
#include "ActionShape.hpp"

namespace synap {
  namespace detail {
    class ActionShape: public ActionBase {
    public:
      typedef std::function<void (const Shape&)> callback_type;
      ActionShape(callback_type fn)
	: m_callback(fn)
      {}
      void enter(tinyxml2::XMLElement*)
      {
      }
      void exit(tinyxml2::XMLElement* element)
      {
	using std::string;

	AttributeMap attr;
	build_attribute_map(element, attr);
	// http://www.datypic.com/sc/ooxml/e-a_off-1.html
        string offset_path = "./p:spPr/a:xfrm/a:off/";
	// http://www.datypic.com/sc/ooxml/e-a_rPr-1.html
	string text_properties_path = "./p:txBody/a:p/a:r/a:rPr/";
	// http://www.datypic.com/sc/ooxml/e-a_t-1.html
	string text_path = "./p:txBody/a:p/a:r/a:t/";
	
	int x = attribute_map_get_fieldi(attr, offset_path + "x", 0);
        int y = attribute_map_get_fieldi(attr, offset_path + "y", 0);
	// http://www.datypic.com/sc/ooxml/a-b-6.html
	bool bold = attribute_map_get_fieldb(attr, text_properties_path + "b", false);
	// http://www.datypic.com/sc/ooxml/a-i-2.html
	bool italic = attribute_map_get_fieldb(attr, text_properties_path + "i", false);
	// http://www.datypic.com/sc/ooxml/t-a_ST_TextStrikeType.html
	string strike = attribute_map_get_field(attr, text_properties_path + "strike", "noStrike");
	// http://www.datypic.com/sc/ooxml/t-a_ST_TextUnderlineType.html
	string underline = attribute_map_get_field(attr, text_properties_path +"u", "none");
	string text = attribute_map_get_field(attr, text_path + ".text", "");
	
	m_callback(Shape(x, y, bold, italic,
			 strike != "noStrike",
			 underline != "none",
			 text));
      }
    private:
      callback_type m_callback;
    };
  }
}

synap::Action synap::make_action_shape(std::function<void (const Shape&)> fn)
{
  return Action(new detail::ActionShape(fn));
}
