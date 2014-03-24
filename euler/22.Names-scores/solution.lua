#!/usr/bin/env lua


function  get_alphabetical_order(alpha)
   return string.find("ABCDEFGHIJKLMNOPQRSTUVWXYZ",  alpha:upper())
end

function calculate_name_score(name)
   local score = 0
   for c in name:gmatch "." do
      score = score + get_alphabetical_order(c)
   end
   return score
end

assert(calculate_name_score("COLIN") == 53)

file = io.open("names.txt")
code = "return {" .. file:read() .. "}"
names = assert(loadstring(code))()
name_score_sum = 0
table.sort(names)
for i, v in ipairs(names) do
   name_score_sum = name_score_sum + calculate_name_score(v) * i
end
print(name_score_sum)

