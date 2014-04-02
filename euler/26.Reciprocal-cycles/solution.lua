#!/usr/bin/env lua

function get_decimal_representation(dividend, divisor)
   local quotient = math.modf(dividend, divisor)
   local remainder = dividend % divisor
   local memo = {}
   local cycle = {}
   local mark = 0
   local counter = 1
   while remainder ~= 0 do
      dividend = remainder * 10
      if memo[dividend] then
         mark = memo[dividend]
         break
      end
      memo[dividend] = counter
      table.insert(cycle, (math.modf(dividend / divisor)))
      remainder = dividend % divisor
      counter = counter + 1
   end
   if mark == 0 then
      return tostring(quotient), table.concat(cycle, ""), ""
   else
      local s = table.concat(cycle, "")
      return tostring(quotient), s:sub(1, mark-1), s:sub(mark)
   end
end

function get_recurring_cycle(dividend, divisor)
   local q, non_cycle, cycle = get_decimal_representation(dividend, divisor)
   return cycle
end

function max_element(arr)
   if #arr == 0 then
      return
   end
   local record = arr[1]
   local index = 1
   for i, v in ipairs(arr) do
      if record < v then
         index = i
         record = v
      end
   end
   return index, record
end

function find_value_has_longest_recurring_cycle(dividend, last)
   local first = 1
   local recurring_cycle_length = {}
   for i = first, last do
      recurring_cycle_length[i] = get_recurring_cycle(dividend, i):len()
   end
   return max_element(recurring_cycle_length)
end

assert(get_recurring_cycle(1, 2) == "")
assert(get_recurring_cycle(1, 6) == "6")
assert(get_recurring_cycle(1, 7) == "142857")
print(get_decimal_representation(1, 6))
print(get_decimal_representation(1, 7))

local i, v = find_value_has_longest_recurring_cycle(1, 1000)
print(string.format("%d has %d digits as recurring cycle.\n", i, v))
