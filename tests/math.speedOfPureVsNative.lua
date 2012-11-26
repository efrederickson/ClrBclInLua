dofile'init.lua'

local amount = arg and tonumber(arg[1]) or 1000000
print("Executing", amount, " functions")

print'Running Pure Lua...'
System.Math.UsePureLuaImplementation = true
local x = os.time()
for i = 1, amount do
    System.Math.Tan(0.77)
    System.Math.Asin(0.1)
    System.Math.Abs(0.3)
    System.Math.Atan(0.5)
end
local y = os.time()
print("Pure Lua:", y - x)

print'Running Native...'
System.Math.UsePureLuaImplementation = false
local x = os.time()
for i = 1, amount do
    System.Math.Tan(0.77)
    System.Math.Asin(0.1)
    System.Math.Abs(0.3)
    System.Math.Atan(0.5)
end
local y = os.time()
print("Native:", y - x)

--[[
As expected, The native is faster.

Less expected, but still to be expected, is that SharpLua can't even run this with
the default loop max in any sort of decent time. It is incredibly slow...
]]
