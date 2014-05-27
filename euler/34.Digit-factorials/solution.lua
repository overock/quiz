#!/usr/bin/env/ lua

factorial = {}

factorial[0] = 1
for n = 1, 9 do
   factorial[n] = factorial[n-1] * n
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


for n = 2, math.huge do
   max_exp = n - 1
   if (factorial[9] * n) < (10 ^ max_exp) then
      break
   end
end

function find_solution()
   function acc(total, n)
      local x = factorial[9] * (n - 1)
      for head = 1, 9 do
         local lower_bound = head * (10 ^ n)
         local upper_bound = (head + 1) * (10 ^ n) - 1
         for i = lower_bound, upper_bound do
            if i > factorial[head] + x then
               break
            elseif i == factorial_sum(i) then
               total = total + i
            end
         end
      end
      return total
   end

   total = 0
   for n = 1, max_exp do
      total = acc(total, n)
   end
   return total
end

print(find_solution())

