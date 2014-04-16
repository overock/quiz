#!/usr/bin/env lua

exp_tab = {}

function digit_power(x, e)
   assert(x >= 0)
   local sum = 0
   while x ~= 0 do
      local r = x % 10
      sum = sum + r ^ e
      x = (x - r) / 10
   end
   return sum
end

function is_cony_number(x, e)
   return digit_power(x, e) == x
end

assert(is_cony_number(1634, 4))
assert(is_cony_number(8208, 4))
assert(is_cony_number(9474, 4))
assert(not is_cony_number(2123, 4))

local exp = 5
local n = 1
while 9 ^ exp * n >= 10 ^ (n-1) do
   n = n + 1
end

local sum = 0
for x = 2, 10 ^ (n-1) do
   if is_cony_number(x, exp) then
      sum = sum + x
   end
end
print(sum)
