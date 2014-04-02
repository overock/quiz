#!/usr/bin/env lua

function get_recurring_cycle(dividend, divisor)
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
      return ""
   else
      local s = table.concat(cycle, "")
      return s:sub(mark)
   end
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
print(find_value_has_longest_recurring_cycle(1, 1000))
