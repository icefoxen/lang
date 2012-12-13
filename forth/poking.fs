\ Poking directly at memory.
\ What fun!!
\ 
\ Simon Heath
\ 16/5/2003

\ create 2 variables.
\ Forth does not seem to have, like, scope...  'Tis global or nothing.
\ I should also be aware of the difference between allocating on the
\ dictionary stack with allot, and on the heap (?) with allocate.
\ And what's the difference between 'create' and 'variable' anyway?
create v 10 cells allot    \ Allocate 10 cells and bind it to v
variable v2 here

\ Poke the letters directly into memory
: inscribe  ( -- )

  ." Here = " here . cr
  \ create v 10 cells allot 
  ." 10 cells allocated; here = " here . cr

  'S v 0  + !             \ Poke the bytes directly into var + offset
  'i v 1  + !
  'm v 2  + !
  'o v 3  + !
  'n v 4  + !
  32 v 5  + !             \ 32 is ASCII space character
  'r v 6  + !
  'o v 7  + !
  'c v 8  + !
  'k v 9  + !
  's v 10 + !
  '! v 11 + !

." Memory dump: " cr
  v 10 cells dump         \ Dump the memory so ye can see my handywork!  ^_^
  
  \ -10 cells allot           \ De-allocate 
  \ ." De-allocated; here = " here . cr
  ;


\ Poke the letters directly into memory as it is allocated.
\ This does not work right for some reason... Something screwy with the 
\ variables.
: inscribe2 ( -- )
  ." Here = " here . cr
  
  here v2 !
  'S , 'i , 'm , 'o , 'n , 32 , 'r , 'o , 'c , 'k , 's , '! ,
  ." 11 characters allocated and poked; here = " here . cr
  
  ." Memory dump: " cr  
  v2 10 cells dump
  
  -11 allot                 \ De-allocate 
  ." De-allocated; here = " here . cr
  ;


\ Do it The Easy Way
: inscribe3 ( -- )
  s" Simon rocks!" ( -- addr len )
  swap dup         ( addr len -- len addr addr )
  10 cells dump    ( len addr addr -- len addr )
  swap -1 * allot  \ De-allocate
  ;
