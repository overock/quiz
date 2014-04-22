#!/usr/bin/env lua

function table.reverse(a)
   local half = (#a - (#a % 2)) / 2
   for left = 1, half do
      local right = #a - left + 1
      a[left], a[right] = a[right], a[left]
   end
end

function count_ways_to_make_change(coins, money)
   local ncalls = 0
   local nfails = 0
   local function iterate(coins, money, pos, total)
      ncalls = ncalls + 1
      if money == 0 then
         return 1
      elseif pos > #coins or money < 0 then
         nfails = nfails + 1
         return 0
      else
         local sum = 0
         local r = money % coins[pos]
         local n = (money - r) / coins[pos]
         for i = 0, n do
            local x = coins[pos] * i
            sum = sum + iterate(coins, money - x, pos+1, total + x)
         end
         return sum
      end
   end
   return iterate(coins, money, 1, 0), ncalls, nfails
end

--[[ It is more faster to count with descending orderd coins
   rather than ascending orderd one. ]]--
print("count", "ncalls", "nfails")
coins = {1, 2, 5, 10, 20, 50, 100, 200}
--print(count_ways_to_make_change(coins, 200))
table.reverse(coins)
print(count_ways_to_make_change(coins, 200))
