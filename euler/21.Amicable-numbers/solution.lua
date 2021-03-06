#!/usr/bin/env lua

require "divisor"

function math.sum(...)
   local s = 0
   for _, v in pairs({...}) do
      s = s + v
   end
   return s
end

function table.lexical_eq(a, b)
   return table.concat(a, " ") == table.concat(b, " ")
end

function sum_amicable_numbers(d)
   local sum = 0
   for a = 2, #d do
      local b = d[a]
      if a ~= b and d[b] == a then
         -- b was added already or will be added soon.
         sum = sum + a 
      end
   end
   return sum
end

function sum_amicable_numbers_under(limit)
   return sum_amicable_numbers(generate_divisor_sum_table_le(limit-1))
end

function is_amicable_pair(a, b, d)
   return a ~= b and d[a] == b and d[b] == a
end

d = generate_divisor_sum_table_le(10000)
assert(is_amicable_pair(220, 284, d))
print(sum_amicable_numbers(d))

