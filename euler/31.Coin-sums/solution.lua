#!/usr/bin/env lua

function table.reverse(a)
   local half = (#a - (#a % 2)) / 2
   for left = 1, half do
      local right = #a - left + 1
      a[left], a[right] = a[right], a[left]
   end
end

function count_ways_to_make_change(coins, money)
   local subtract_make_change
   local make_change
   
   make_change = function(coins, money, pos, total)
      if pos > #coins or money < 0 then
         return 0
      elseif money == 0 then
         return 1
      else
         return subtract_make_change(coins, money, pos, total) +
            make_change(coins, money, pos + 1, total)
      end
   end

   subtract_make_change = function(coins, money, pos, total)
      return make_change(coins, money - coins[pos], pos, total + coins[pos])
   end
   
   local pos = 1
   return make_change(coins, money, pos, 0)
end

--[[ It is more faster to count with decremet orderd coins
   rather than increment orderd one. ]]--
coins = {1, 2, 5, 10, 20, 50, 100, 200}
table.reverse(coins)
print(count_ways_to_make_change(coins, 200))
