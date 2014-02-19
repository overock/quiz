#!/usr/bin/env lua

function receive(prod)
         local good, value = coroutine.resume(prod)
         return value
end

function send(x)
         coroutine.yield(x)
end

function producer()
         return coroutine.create(function ()
                local a, b = 1, 2;
                send(a)
                send(b)
                while true do
                      a, b = b, a + b
                      send(b)
                end
         end)
end

function filter(prod)
         return coroutine.create(function()
                while true do
                local x = receive(prod)
                      if x == nil then
                         send(x)
                         break
                      end
                      if x % 2 == 0 then
                         send(x)
                      end
                end
         end)
end

function consumer(prod, max)
         local sum = 0
         local x = receive(prod)
         while x < max do
               sum = sum + x
               x = receive(prod)
         end
         print(sum)
end

consumer(filter(producer()), 4000000)
