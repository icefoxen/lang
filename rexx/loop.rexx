do 10
   say 'Mwa!'
end

d = 0
e = ''
do c = 1 to 20
   d = d + c
   e = e c
end
say d
say e


do f = 1 to 20 by 2.3
   say f
end

e = ''
do f = 0 for 6 by 59
   e = e f
end
say e

/*
Happens forever!
do n = 0
   say n
end
*/

say "I won't take no for an answer!"
do until answer \= 'NO'
   pull answer
end

/* Huh?   This doesn't work.
say 'Error?'
error = 0
do while error = 0
   pull a
   if a == "error" then error = 1
   else say a
end
*/

say 'Tell me no enough and I will listen'
do 3 until answer \= "NO"
   pull answer
end


/* leave == break */
say 'Fill out an array; use an empty line to stop'
do n = 0
   pull a.n
   if a.n == '' then leave
end
do n = 0 to 5
   a = a a.n
end
say a

/* iterate == continue */
do n = 0 to 10
   if n = 3 then iterate
   say n
end
