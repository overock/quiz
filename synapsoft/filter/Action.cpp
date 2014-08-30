#include "Action.hpp"

synap::detail::ActionBase::~ActionBase() {}

void synap::detail::ActionBase::build_attribute_map(tinyxml2::XMLElement* element,
							 AttributeMap& attr_map,
							 const std::string& prefix)
{
  const tinyxml2::XMLAttribute* attr = element->FirstAttribute();
  for (; attr != nullptr; attr = attr->Next()) {
    if (attr->Value()) {
      attr_map[prefix + attr->Name()] = attr->Value();
    }
  }
  const char* text = element->GetText();
  if (text) {
    attr_map[prefix + ".text"] = text;
  }
  // build recursively.
  tinyxml2::XMLElement* child = element->FirstChildElement();
  for (; child != nullptr; child=child->NextSiblingElement()) {
    std::string child_prefix = prefix + child->Name() + "/";
    build_attribute_map(child, attr_map, child_prefix);
  }
}

void synap::detail::ActionBase::build_attribute_map(tinyxml2::XMLElement* element,
							 AttributeMap& attr)
{
  build_attribute_map(element, attr, "./");
}

void synap::detail::NullAction::enter(tinyxml2::XMLElement*) {}

void synap::detail::NullAction::exit(tinyxml2::XMLElement*) {}

synap::Action::Action()
  : m_kernel(new detail::NullAction)
{}

synap::Action::Action(kernel_type* kernel)
  : m_kernel(kernel)
{}

void synap::Action::swap(Action& other)
{
  m_kernel.swap(other.m_kernel);
}

void synap::Action::enter(tinyxml2::XMLElement* element)
{
  m_kernel->enter(element);
}

void synap::Action::exit(tinyxml2::XMLElement* element)
{
  m_kernel->exit(element);
}
