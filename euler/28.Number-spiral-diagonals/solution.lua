#!/usr/bin/env lua

function number_spiral_diagonals(size)
   assert(size >= 1)
   assert(size % 2 == 1)
   local sum = 1
   local last = 1
   for i = 3, size, 2 do
      --[[
         sum = sum +
               last + (i - 1) * 1 +
               last + (i - 1) * 2 +
               last + (i - 1) * 3 +
               last + (i - 1) * 4
      ]]--
      sum = sum + last * 4 + (i - 1) * 10
      last = last + (i - 1) * 4
   end
   return sum
end

assert(number_spiral_diagonals(5) == 101)
print(number_spiral_diagonals(1001))
