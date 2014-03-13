#!/usr/bin/env lua

function table.reverse (tab)
   local reversed = {}
   local size = #tab
   for i, v in ipairs(tab) do
      reversed[size - i + 1] = v
   end
   return reversed
end

word_table = {
   [0] = "",
   "one", "two", "three", "four", "five",
   "six", "seven", "eight", "nine", "ten",
   "eleven", "twelve", "thirteen", "fourteen", "fifteen",
   "sixteen", "seventeen", "eighteen", "nineteen",
   [20] = "twenty",
   [30] = "thirty",
   [40] = "forty",
   [50] = "fifty",
   [60] = "sixty",
   [70] = "seventy",
   [80] = "eighty",
   [90] = "ninety",
}

function get_number_words_lower_100(x)
   assert(x < 100)
   if word_table[x] then
      return word_table[x]
   else
      local a = math.modf(x / 10) * 10
      local b = x % 10
      return word_table[a] .. "-" .. word_table[b]
   end
end

function get_number_words_lower_1000(x)
   assert(x < 1000)
   local head, tail

   head = get_number_words_lower_100(math.modf(x / 100))
   tail = get_number_words_lower_100(x % 100)
   if #head ~= 0 and #tail ~= 0 then
      return head .. " hundred and " .. tail
   end
   if #head == 0 then
      return tail
   else
      return head .. " hundred"
   end
end

function f(x, suffix)
   local s = get_number_words_lower_1000(x)
   if #s == 0 then
      return s
   else
      return s .. " " .. suffix
   end
end
      
function get_number_words(x)
   assert(x >= 0)
   assert(x < 10^15)
   if x == 0 then
      return "zero"
   end

   local suffix = {
      "", "thousand", "million", "billion", "trillion"
   }

   i = 1
   result = {}
   while x ~= 0 do
      result[i] = f(x % 1000, suffix[i])
      x = math.modf(x / 1000)
      i = i + 1
   end
   local s = table.concat(table.reverse(result), " ")
   return (s:gsub(" *$", "")) -- string.gsub returns two values. use first one
end

assert(get_number_words(21) == "twenty-one")
assert(get_number_words(152) == "one hundred and fifty-two")
assert(get_number_words(1000) == "one thousand")
assert(get_number_words(23380000000) == "twenty-three billion three hundred and eighty million")

words_stack = {}
for i = 1, 1000 do
   words_stack[#words_stack+1] = get_number_words(i)
end

long_string = table.concat(words_stack, " ")
long_string = long_string:gsub(" ", "")
long_string = long_string:gsub("-", "")
print(#long_string)
