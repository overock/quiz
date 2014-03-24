-- functional programming in lua

function plus(a, b)
   return a + b
end

function map(fn, list)
   local result = {}
   for i, v in ipairs(list) do
      table.insert(result, fn(v, i))
   end
   return result
end

function reduce(fn, arr)
   function iter(head, index)
      if #arr < index then
         return head
      else
         return iter(fn(head, arr[index]), index+1)
      end
   end
   return (#arr == 0) and nil or iter(arr[1], 2)
end

