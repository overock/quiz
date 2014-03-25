-- functional programming in lua

function plus(a, b)
   return a + b
end

function identity(...)
   return ...
end

function first(a)
   return a
end

function second(a, b)
   return b
end

function indexed_map(fn, arr)
   local result = {}
   for i, v in ipairs(arr) do
      result[i] = fn(i, v)
   end
   return result
end

function map(fn, list)
   return indexed_map(function (i, v) return fn(v) end,
                      list)
end

function inverse_indexed_map(fn, arr)
   return indexed_map(function (i, v) return fn(v, i) end,
                      arr)
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

function each(fn, arr)
   map(fn, arr)
end

function indexed_filter(pred, arr)
   local result = {}
   for i, v in ipairs(arr) do
      if pred(i, v) then
         table.insert(result, v)
      end
   end
   return result
end

function filter(pred, list)
   return indexed_filter(function (i, v) return pred(v) end,
                         list)
end

