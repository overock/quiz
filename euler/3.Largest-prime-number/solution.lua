#!/usr/bin/env lua

function find_largest_prime_factor(n)
   if n == 1 then
      return 1
   end
   local function find_prime_factor_greater_than(x, n)
      assert(n > x)
      local y = x + 1
      local q = n
      while q % y == 0 do
         q = q / y
      end
      if q == n then -- y is not prime factor of n
         return find_prime_factor_greater_than(y, n)
      elseif q == 1 then
         return y
      else -- n == y^a * z^b * w^c...  (y < z < w)
         return find_prime_factor_greater_than(y, q)
      end
   end
   return find_prime_factor_greater_than(1, n)
end

-- 5 * 7 * 13 * 29 == 13195
assert(find_largest_prime_factor(13195))

print(find_largest_prime_factor(600851475143))
