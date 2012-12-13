-- tablespeed.lua
-- Tests how fast Lua tables are, basic getting and setting of strings.

a = {}
c = {}

for count = 0,1000000 do
   b = "" .. count
   a[b] = count
end

for count = 0,1000000 do
   b = "" .. count
   c[b] = a[b]
end

print( a, c )
