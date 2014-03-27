#!/usr/bin/env lua

function permutations(...)
   local cache = {}
   function iter(arr, start)
      if start == #arr then
         return {arr[start]}
      end
      local result = {}
      for i = start, #arr do
         -- swap
         arr[start], arr[i] = arr[i], arr[start]
         local sub_perm = iter(arr, start+1)
         for _, w in ipairs(sub_perm) do
            table.insert(result, arr[start] .. w)
         end
         -- restore
         arr[start], arr[i] = arr[i], arr[start]      
      end
      return result
   end
   return iter({...}, 1)
end

function lexicographic_permutations(...)
   local p = permutations(...)
   table.sort(p)
   return p
end

function factorial(n)
   if n == 1 then
      return 1
   else
      return n * factorial(n-1)
   end
end

function number_of_permutations(n)
   return factorial(n)
end

function last_lexicographic_permutation(arr)
   table.sort(arr, function (a, b) return b < a end)
   return table.concat(arr, "")
end

function nth_lexicographic_permutation(n, ...)
   local function iterate(head, n, arr)
      local upper_bound = number_of_permutations(#arr)
      local divisor = upper_bound / #arr
      if upper_bound < n then
         return nil
      elseif upper_bound == n then
         return head .. last_lexicographic_permutation(arr)
      else
         local r = n % divisor
         if r == 0 then
            r = divisor
         end
         local q = (n - r) / divisor + 1
         assert(q <= #arr)
         assert(q > 0)
         assert(r > 0)
         assert(r <= divisor)
         local neck = arr[q]
         table.remove(arr, q)
         return iterate(head .. neck, r, arr)
      end
   end
   local arr = {...}
   table.sort(arr)
   return iterate("", n, arr)
end

result = lexicographic_permutations("0", "1", "2")
assert(table.concat(result, " ") == "012 021 102 120 201 210")
--result = lexicographic_permutations("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
--print(result[1000000])
print(nth_lexicographic_permutation(1000000, "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"))

