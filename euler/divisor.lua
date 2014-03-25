function generate_divisor_sum_table_le(max)
   local d = {0}
   for i = 2, max do
      d[i] = 1
   end
   for i = 2, #d do
      local j = i * 2
      while j <= #d do
         d[j] = d[j] + i
         j = j + i
      end
   end
   return d
end
