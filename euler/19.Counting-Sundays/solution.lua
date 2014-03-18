#!/usr/bin/env lua

function is_leap(year)
   local is_leap
   if year % 400 == 0 then
      return true
   elseif year % 100 == 0 then
      return false
   elseif year % 4 == 0 then
      return true
   else
      return false
   end
end

function count_days(year, days, hook)
   local days_of_month = {
      [true] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
      [false] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
   }
   for m, d in ipairs(days_of_month[is_leap(year)]) do
      hook(days)
      days = days + d
   end
   return days
end

function count_sundays_on_first_of_the_month_from_1900(to)
   local total_days = 0
   local sundays = 0
   function count_sundays(days)
      --[[
         1 Jan 1900 was a Monday.
         Mon Tue Wed Thu Fri Sat Sun
         1   2   3   4   5   6   7
      ]]--
      if (days + 1) % 7 == 0 then
         sundays = sundays + 1
      end
   end
   for year = 1900, to do
      total_days = count_days(year, total_days, count_sundays)
   end
   return sundays
end

function count_sundays_on_first_of_the_month(from, to)
   return count_sundays_on_first_of_the_month_from_1900(to)
      - count_sundays_on_first_of_the_month_from_1900(from-1)
end

print(count_sundays_on_first_of_the_month(1901, 2000))
