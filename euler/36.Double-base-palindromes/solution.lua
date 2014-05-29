#!/usr/bin/env lua

function send(...)
   coroutine.yield(...)
end

function generator()
   function worker () 
      for n = 1, 9 do
         send(n)
      end
      for n = 1, 999 do
         local s = tostring(n)
         local r = string.reverse(s)
         send(tonumber(s .. r))
      end
      for n = 1, 99 do
         local s = tostring(n)
         local r = string.reverse(s)
         for m = 0, 9 do
            send(tonumber(s .. m .. r))
         end
      end
   end
   return coroutine.wrap(worker)
end


function ispalindromic(s)
   return string.reverse(s) == s
end

function isodd(n)
   return n % 2 == 1
end

function tobinary(n)
   assert(n >= 0)
   local oct = string.format("%o", n)
   local tab = {[0] = "000", "001", "010", "011", "100", "101", "110", "111"}
   local bin = ''
   for c in string.gmatch(oct, ".") do
      bin = bin .. tab[tonumber(c)]
   end
   bin = string.gsub(bin, "^0*", "") -- remove leading 0s
   return bin == '' and '0' or bin
end

assert(tobinary(0) == '0')
assert(tobinary(585) == '1001001001')

function generator2()
   return coroutine.wrap(
      function()
         for n = 1, 1000 * 1000 do
            send(n)
         end
   end)
end

function filter(gen)
   function worker()
      while true do
         local n = gen()
         if n == nil then
            break
         end
         if isodd(n) and ispalindromic(tobinary(n)) then
            send(n)
         end
      end
   end
   return coroutine.wrap(worker)
end

function filter2(gen)
   function worker()
      while true do
         local n = gen()
         if n == nil then
            break
         end
         local s = tostring(n)
         if string.reverse(s) == s then
            send(n)
         end
      end
   end
   return coroutine.wrap(worker)
end

function adder(gen)
   local sum = 0
   while true do
      local x = gen()
      if x == nil then
         break
      end
      --print(x, tobinary(x))
      sum = sum + x
   end
   return sum
end

print(adder(filter(generator())))
--print(adder(filter2(filter(generator2()))))
