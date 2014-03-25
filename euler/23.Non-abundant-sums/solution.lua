#!/usr/bin/env lua

require "divisor"
require "functional"

upper_bound = 28123
numbers = {}
for i = 1, upper_bound do
   numbers[i] = i
end

abundant_numbers = {}
for number, divisor_sum in ipairs(generate_divisor_sum_table_le(upper_bound)) do
   local is_abundant = divisor_sum > number
   if is_abundant then
      table.insert(abundant_numbers, number)
   end
end

-- smallest abundant number is 12.
assert(abundant_numbers[1] == 12)

-- remove all numbers can be written as the sum of two abundant numbers.
for i = 1, #abundant_numbers do
   for j = i, #abundant_numbers do
      local a = abundant_numbers[i]
      local b = abundant_numbers[j]
      if a + b > upper_bound then
         break
      end
      numbers[a + b] = 0
   end
end

--[[ 
   print the sum of all the positive integers
   which cannot be written as the sum of two abundant numbers.
]]--
print(reduce(plus, numbers))
