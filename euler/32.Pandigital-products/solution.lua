#!/usr/bin/env lua

-- see http://www.lua.org/pil/9.3.html
function permgen (a, n)
   if n == 0 then
      coroutine.yield(a)
   else
      for i=1,n do
         -- put i-th element as the last one
         a[n], a[i] = a[i], a[n]
         -- generate all permutations of the other elements
         permgen(a, n - 1)
         -- restore i-th element
         a[n], a[i] = a[i], a[n]
      end
   end
end

function perm (a)
   return coroutine.wrap(function () permgen(a, #a) end)
end


local solutions = {}
for i in perm{1, 2, 3, 4, 5, 6, 7, 8, 9} do
   local a1 = i[1]
   local b1 = i[2] * 1000 + i[3] * 100 + i[4] * 10 + i[5]
   local a2 = i[1] * 10 + i[2]
   local b2 = i[3] * 100 + i[4] * 10 + i[5]
   local c = i[6] * 1000 + i[7] * 100 + i[8] * 10 + i[9]
   if a1 * b1 == c or a2 * b2 == c then
      solutions[c] = true
   end
end

sum = 0
for k, v in pairs(solutions) do
   sum = sum + k
end
print(sum)
