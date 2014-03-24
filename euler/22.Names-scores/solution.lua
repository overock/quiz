#!/usr/bin/env lua


function  get_alphabetical_order(alpha)
   return string.find("ABCDEFGHIJKLMNOPQRSTUVWXYZ",  alpha:upper())
end

function calculate_name_score(name, index)
   local score = 0
   for c in name:gmatch "." do
      score = score + get_alphabetical_order(c)
   end
   return score * index
end

function sum_name_scores(names)
   local sum = 0
   table.sort(names)
   for i, v in ipairs(names) do
      sum = sum + calculate_name_score(v, i)
   end
   return sum
end

assert(calculate_name_score("COLIN", 938) == 49714)

file = io.open("names.txt")
code = "print(sum_name_scores{" .. file:read() .. "})"
assert(loadstring(code))()
