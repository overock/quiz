#ifndef SYNAP_ATTRIBUTE_MAP_HPP_
#define SYNAP_ATTRIBUTE_MAP_HPP_

#include <map>
#include <string>

namespace synap {
  typedef std::map<std::string, std::string> AttributeMap;
  // 주어진 key로 map을 탐색합니다. 
  // 못찾는 경우 def를 반환합니다.
  inline std::string attribute_map_get_field(const AttributeMap& attr,
					     const std::string& key,
					     const std::string& def)
  {
    auto it = attr.find(key);
    return (it == attr.end()) ? def : it->second;
  }
  inline int attribute_map_get_fieldi(const AttributeMap& attr,
				      const std::string& key, int n) 
  {
    return std::stoi(attribute_map_get_field(attr, key, std::to_string(n)));
  }
  inline bool attribute_map_get_fieldb(const AttributeMap& attr,
				       const std::string& key, bool b)
  {
    auto s = attribute_map_get_field(attr, key, b ? "true" : "false");
    return (s == "true" || s == "1");
  }

}

#endif
