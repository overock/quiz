#!/usr/bin/env lua

max_number = 1000 * 1000

is_prime = {}

function count_digits(n)
   local count = 0
   while n ~= 0 do
      n = math.floor(n / 10)
      count = count + 1
   end
   return count
end

function rotations(n)
   return coroutine.wrap(
      function ()
         local ndigits = count_digits(n)
         local m = n
         for k = 1, ndigits do
            local r = m % 10
            local q = (m - r) / 10
            m = r * 10 ^ (ndigits-1) + q
            coroutine.yield(m)
         end
      end
   )
end

-- Get all prime numbers below max_number
for n = 1, max_number do
   is_prime[n] = true
end

is_prime[1] = false
for n = 2, max_number do
   if is_prime[n] then
      for m = n * 2, max_number, n do
         is_prime[m] = false
      end
   end
end

function all_of(iter, arg, pred)
   for v in iter(arg) do
      if not pred(v) then
         return false
      end
   end
   return true
end

is_circular_prime = {}
for n = 2, max_number do
   if is_prime[n] then
      local function _is_prime(r) return is_prime[r] end
      is_circular_prime[n] = all_of(rotations, n, _is_prime)
   end
end

solution = 0
for k, v in pairs(is_circular_prime) do
   if v then
      solution = solution + 1
   end
end
print(solution)   

   
