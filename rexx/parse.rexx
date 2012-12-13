#!/usr/bin/rexx
/* Hey, a shebang works!  W00t! */
 
/* Could replace arg with pull */
parse upper arg a.1 a.2 a.3 a.4
do i=1 to 4
   say 'Arg' i 'was' a.i
end

/* Woah... 'arg' is just 'parse upper arg', and pull is just parse upper pull
*/
arg b
say b

pull c
say c

d = date()
parse var d day month year
say day month year

parse value time() with hour ':' min ':' sec
say hour min sec
