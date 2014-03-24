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
            table.insert(new_leaves, new_node)
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
