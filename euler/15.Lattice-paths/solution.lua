#!/usr/bin/env lua

function make_lattice_path_counter()
   local memo = {}
   local function counter(row, col)
      if row < col then
         row, col = col, row -- transpose
      end
      if (col == 0) then
         return 1
      end
      local key = string.format("%d-%d", row, col)
      memo[key] = memo[key] or counter(row-1, col) + counter(row, col-1)
      return memo[key]
   end
   return counter
end

counter = make_lattice_path_counter()
assert(counter(2, 2) == 6)
print(counter(20, 20))
