#!/usr/bin/env lua

function table.push_back(tab, val)
   tab[#tab+1] = val
end

function make_node(value, left_parent, right_parent, prev)
   return {
      value = value,
      left_parent = left_parent,
      right_parent = right_parent,
      prev = prev,
   }
end

function make_triangle(arg)
   local root
   local leaves
   for level, items in ipairs(arg) do
      if level == 1 then
         root = make_node(items[1])
         root.sum = root.value
         leaves = {root}
      else
         local new_leaves = {}
         for i, v in ipairs(items) do
            local left_parent = leaves[i-1]
            local right_parent = leaves[i]
            local prev = new_leaves[#new_leaves]
            local new_node = make_node(v, left_parent, right_parent, prev)
            local left_sum = left_parent and left_parent.sum or 0
            local right_sum = right_parent and right_parent.sum or 0
            if left_sum < right_sum then
               new_node.sum = new_node.value + right_sum
               new_node.best_path = right_parent
            else
               new_node.sum = new_node.value + left_sum
               new_node.best_path = left_parent
            end
            table.push_back(new_leaves, new_node)
         end
         leaves = new_leaves
      end
      assert(#leaves == level)
   end
   return {root=root, first_leaf=leaves[1], last_leaf=leaves[#leaves]}
end

function print_triangle_base(first, last)
   if first == last then
      io.write(first.value)
   else
      print_triangle_base(first, last.prev)
      io.write(string.format(" %d", last.value))
   end
end

function print_triangle(triangle)
   if triangle.first_leaf == triangle.root then
      assert(triangle.last_leaf == triangle.first_leaf)
      print(triangle.root.value)
      return
   end

   assert(triangle.last_leaf.right_parent == nil)
   assert(triangle.last_leaf.left_parent ~= nil)
   assert(triangle.first_leaf.left_parent == nil)
   assert(triangle.first_leaf.right_parent ~= nil)

   local upper_triangle = {
      root = triangle.root,
      first_leaf = triangle.first_leaf.right_parent,
      last_leaf = triangle.last_leaf.left_parent
   }
   print_triangle(upper_triangle)
   print_triangle_base(triangle.first_leaf, triangle.last_leaf)
   print("")
end

function find_maximum_path(first, last)
   if first == last then
      return first
   end
   local champion = find_maximum_path(first, last.prev)
   return last.sum < champion.sum and champion or last
end

triangle = make_triangle {
   {75},
   {95, 64},
   {17, 47, 82},
   {18, 35, 87, 10},
   {20, 04, 82, 47, 65},
   {19, 01, 23, 75, 03, 34},
   {88, 02, 77, 73, 07, 63, 67},
   {99, 65, 04, 28, 06, 16, 70, 92},
   {41, 41, 26, 56, 83, 40, 80, 70, 33},
   {41, 48, 72, 33, 47, 32, 37, 16, 94, 29},
   {53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14},
   {70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57},
   {91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48},
   {63, 66, 04, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31},
   {04, 62, 98, 27, 23, 09, 70, 98, 73, 93, 38, 53, 60, 04, 23},
}

maximum_path = find_maximum_path(triangle.first_leaf, triangle.last_leaf)
print(maximum_path.sum)
