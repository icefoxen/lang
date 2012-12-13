-- play with loops

a = 10
print( "While" )
while a > 0 do
   print( a )
   a = a - 1
end

print( "Repeat" )
repeat
   print( a )
   a = a + 1
until a > 10


print( "For" )
for count = 0,10 do
   print( count )
end

for key,value in {10, 20, 30, 40, 50} do
   print( key, value )
end

for count = 0,1000,100 do
   print( count )
end


if a > 10 then
   print( "a > 10" )
elseif a < 10 then
   print( "a < 10" )
else
   print( "a == 10" )
end
