#!/usr/bin/env lua

function repack(a)
   return {unpack(a)}
end

function table.generate_n(n, v)
   local a = {}
   for i = 1, n do
      a[i] = v
   end
   return a
end

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
   local dump_counter
   
   dump_counter = function(coins, counter)
      for i, v in ipairs(counter) do
         io.write(string.format("%d:%d ", coins[i], v))
      end
      io.write(string.format("(total: %d)\n", total))
   end

   make_change = function(coins, money, pos, counter, total)
      if pos > #coins or money < 0 then
         return 0
      elseif money == 0 then
         return 1
      else
         return subtract_make_change(coins, money, pos, counter, total) +
            make_change(coins, money, pos + 1, counter, total)
      end
   end

   subtract_make_change = function(coins, money, pos, counter, total)
      local new_counter = repack(counter)
      new_counter[pos] = new_counter[pos] + 1
      return make_change(coins, money - coins[pos], pos, new_counter, total + coins[pos])
   end
   
   local counter = table.generate_n(#coins, 0)
   local pos = 1
   return make_change(coins, money, pos, counter, 0)
end

--[[ It is more faster to count with decremet orderd coins
   rather than increment orderd one. ]]--
coins = {1, 2, 5, 10, 20, 50, 100, 200}
table.reverse(coins)
print(count_ways_to_make_change(coins, 200))
