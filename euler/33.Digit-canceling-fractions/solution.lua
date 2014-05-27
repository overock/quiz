#!/usr/bin/env lua

product = {1, 1}
for a = 1, 9 do
   for b = 1, 9 do
      for c = 1, 9 do
         local numerator = c * 10 + a
         local denominator = a * 10 + b
         local det = 9 * b * c + a * b - 10 * a * c
         if det == 0 and numerator ~= denominator then
            --print(string.format("%d / %d\n", numerator, denominator))
            product[1] = product[1] * numerator
            product[2] = product[2] * denominator
         end
      end
   end
end

function greatest_common_divisor(a, b)
   assert(a > 0 and b > 0)
   while b ~= 0 do
      a, b = b, a % b
   end
   return a
end

gcd = greatest_common_divisor(product[1], product[2])
print(product[1] / gcd, product[2] / gcd)
