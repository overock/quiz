#!/usr/bin/env lua

function table.reverse(a)
   local half = (#a - (#a % 2)) / 2
   for left = 1, half do
      local right = #a - left + 1
      a[left], a[right] = a[right], a[left]
   end
end

function count_ways_to_make_change(coins, money)
   local function iterate(coins, money, pos, total)
      if pos > #coins or money < 0 then
         return 0
      elseif money == 0 then
         return 1
      else
         return iterate(coins, money - coins[pos], pos, total + coins[pos]) +
                iterate(coins, money, pos + 1, total)
      end
   end
   return iterate(coins, money, 1, 0)
end

--[[ It is more faster to count with decremet orderd coins
   rather than increment orderd one. ]]--
coins = {1, 2, 5, 10, 20, 50, 100, 200}
table.reverse(coins)
print(count_ways_to_make_change(coins, 200))
