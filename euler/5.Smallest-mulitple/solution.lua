#!/usr/bin/env lua

function least_common_multiple_range(first, last)
   if first == last then
      return first
   end
   return least_common_multiple(first, least_common_multiple_range(first+1, last))
end

function least_common_multiple(a, b)
   return a / greatest_common_divisor(a, b) * b
end

function greatest_common_divisor(a, b)
   assert(a > 0 and b > 0)
   while b ~= 0 do
      a, b = b, a % b
   end
   return a
end

assert(least_common_multiple_range(1, 10) == 2520)
print(least_common_multiple_range(1, 20))
