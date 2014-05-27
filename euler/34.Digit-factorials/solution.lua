#!/usr/bin/env/ lua

factorial = {}

factorial[0] = 1
for n = 1, 9 do
   factorial[n] = factorial[n-1] * n
end

for n = 2, math.huge do
   max = 10 ^ (n - 1)
   if factorial[9] * n < max then
      break
   end
end

function factorial_sum(n)
   local sum = 0
   while n ~= 0 do
      local r = n % 10
      sum = sum + factorial[r]
      n = (n - r) / 10
   end
   return sum
end

assert(factorial_sum(145) == 145)

-- Find solution
total = 0
for n = 3, max do
   if n == factorial_sum(n) then
      total = total + n
   end
end

print(total)

