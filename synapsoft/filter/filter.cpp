#include <cassert>
#include <cstdlib>
#include <string>
#include <list>
#include <iostream>
#include <algorithm>
#include <tinyxml2.h>
#include "XMLTraverser.hpp"
#include "ActionShape.hpp"
#include "AttributeMap.hpp"

namespace {
  const std::size_t MAX_ERROR_MESSAGE = 1024;
  
  void write_error_message(char* buf, const char* msg)
  {
    std::size_t n = std::min(strlen(msg), MAX_ERROR_MESSAGE);
    std::strncpy(buf, msg, n);
    buf[MAX_ERROR_MESSAGE] = '\0';
  }

  struct Mask {
    Mask(const char* s)
      : m_should_be_bold(false),
	m_should_be_italic(false),
	m_should_be_strike(false),
	m_should_be_underline(false)
    {
      std::size_t n = std::strlen(s);
      for (std::size_t i=0; i<n; ++i) {
	switch (s[i]) {
	case 'i':
	  m_should_be_italic = true;
	  break;
	case 'b':
	  m_should_be_bold = true;
	  break;
	case 'u':
	  m_should_be_underline = true;
	  break;
	case 's':
	  m_should_be_strike = true;
	  break;
	default:
	  break;
	}
      }
    }    
    bool operator()(const synap::Shape& s) const
    {
      if (m_should_be_bold && !s.bold())
	return true;
      if (m_should_be_italic && !s.italic())
	return true;
      if (m_should_be_underline && !s.underline())
	return true;
      if (m_should_be_strike && !s.strike())
	return true;
    
      return false;
    }
  private:
    bool m_should_be_bold;
    bool m_should_be_italic;
    bool m_should_be_strike;
    bool m_should_be_underline;
  };
    
  bool filter(const char* filename, const Mask& mask, char* error_message)
  {
    using namespace tinyxml2;

    XMLDocument doc;
    int error = doc.LoadFile(filename);
    switch (error) {
    case XML_NO_ERROR:
      break;
    case XML_ERROR_FILE_NOT_FOUND:
      write_error_message(error_message, "file not found!");
      return false;
    default:
      write_error_message(error_message, "parsing error!");
      return false;
    }

    // traverse XML tree and make shapes.
    XMLElement* root = doc.RootElement();
    std::list<synap::Shape> shapes;
    auto callback = [&](const synap::Shape& s) {shapes.push_back(s);};
    if (root != nullptr) {
      synap::XMLTraverser traverser;
      // http://www.datypic.com/sc/ooxml/e-p_sp-1.html
      traverser["p:sp"] = synap::make_action_shape(callback);
      traverser.traverse(root);
    }

    // remove, sort, and print
    shapes.remove_if(mask);
    shapes.sort(synap::shape_compare_position_yx);
    if (!shapes.empty()) {
      std::cout << shapes.front().text();
      std::for_each(std::next(shapes.begin()), shapes.end(), [](const synap::Shape& s) {
	  std::cout << " " << s.text();
	});
      std::cout << "\n";
    }
    return true;
  }
}
int main(int argc, char* argv[])
{
  using namespace std;
  
  if (argc < 3) {
    std::cerr << "usage: " << argv[0] << " MASK FILE...\n";
    return EXIT_FAILURE;
  }

  Mask mask(argv[1]);
  for (int i=2; i<argc; ++i) {
    char error_message[MAX_ERROR_MESSAGE+1];
    if (!filter(argv[i], mask, error_message))
      cerr << error_message << endl;
  }
}

