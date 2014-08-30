#include <iostream>
#include <tinyxml2.h>
#include "XMLTraverser.hpp"

namespace {
  synap::Action DUMMY;
}

void synap::XMLTraverser::traverse(tinyxml2::XMLElement* element)
{
  Action* action = &DUMMY;
  auto iter = m_actions.find(element->Name());
  if (iter != m_actions.end()) {
    action = &iter->second;
  }
  
  action->enter(element);
  tinyxml2::XMLElement* child = element->FirstChildElement();
  for (; child != nullptr; child=child->NextSiblingElement()) {
    traverse(child);
  }
  action->exit(element);
}

synap::XMLTraverser::value_type& synap::XMLTraverser::operator[] (const key_type& key)
{
  return m_actions[key];
}

void synap::XMLTraverser::clear()
{
  m_actions.clear();
}
