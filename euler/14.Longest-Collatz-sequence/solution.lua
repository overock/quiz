#!/usr/bin/env lua

cache = {1}

function find_length_of_collatz_sequence(seed)
   local next
   if (seed % 2 == 1) then
      next = 3 * seed + 1
   else
      next = seed / 2
   end

   cache[seed] = cache[seed] or (find_length_of_collatz_sequence(next) + 1)
   return cache[seed]
end

function find_longest_collatz_sequence_under(limit)
   local max_length = 1
   local best_seed = 1
   for seed = 2, limit-1 do
      local length = find_length_of_collatz_sequence(seed)
      if length > max_length then
         best_seed, max_length = seed, length
      end
   end
   return best_seed, max_length
end

assert(find_length_of_collatz_sequence(13) == 10)

print(find_longest_collatz_sequence_under(1000000))
