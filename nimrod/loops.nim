echo("Counting to ten: ")
for i in countup(1, 10):
  echo($i)

echo("Counting down from 10 to 1: ")
for i in countdown(10, 1):
  echo($i)

echo("Counting to 10: ")
var i = 1
while i <= 10:
  echo($i)
  inc(i) # increment i by 1

echo("We also have shortcuts")
for i in 1..10:
  echo($i)

echo("Do they go the other way?")
for i in 10..1:
  echo($i)
