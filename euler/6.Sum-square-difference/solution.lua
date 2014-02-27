#!/usr/bin/env lua

function square_sum(n)
   return (n * (n+1) / 2) ^ 2
end

function sum_square(n)
   local sum = 0
   for i = 1, n do
      sum = sum + i ^ 2
   end
   return sum
end

function sum_square_difference(n)
   return square_sum(n) - sum_square(n)
end

assert(sum_square_difference(10) == 2640)
print(sum_square_difference(100))
