#!env lua

function multiples_of_3_or_5_rec(limit) -- recursive version
   local function iter(sum, first)
      if first >= limit then
         return sum
      end
      if first % 3 == 0 or first % 5 == 0 then
         return iter(sum + first, first+1)
      else
         return iter(sum, first+1)
      end
   end
   return iter(0, 1)
end

function multiples_of_3_or_5_for(limit) -- for loop version
   local sum = 0
   for i = 1, limit-1 do
      if i % 3 == 0 or i % 5 == 0 then
         sum = sum + i
      end
   end
   return sum
end

-- check that two method are return same values.
for i=1, 1000 do
   assert(multiples_of_3_or_5_rec(i) == multiples_of_3_or_5_for(i))
end

function multiples_of_3_or_5(limit)
   return multiples_of_3_or_5_for(limit)
end         

-- test
assert(multiples_of_3_or_5(10) == 23)

-- anwser the question.
print(multiples_of_3_or_5(1000))
