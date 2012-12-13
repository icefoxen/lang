(  arraylib.fs
   Forth array library.  Does character, cell, double, and floating-point
   arrays.
   These count from zero, of course.

   These things have the element count included in the array, and all the
   functions check for out-of-bounds errors and negative numbers.

   TODO  Fix double-array funcs, add char-array funcs

   Simon Heath
   20/5/2003
)



\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\ \\  GENERIC FUNCTIONS  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


\ Returns the array length
: arraylen  ( addr -- len )
  @ ;

\ Checks whether an index is within bounds of the given array
: arraycheck ( addr index -- addr index bool )
  2dup swap arraylen u>= if      \ If index >= array length (read it unsigned)
    -9 throw                     \ Invalid memory address (in Gforth at least) 
  then
  ;

\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\ \\  INTEGER FUNCTIONS  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

\ Creates a cell array on the heap --NOT the dictionary stack.
\ That way you can free it just with "free"
: array-create  ( len -- addr )
  dup 1+ cells allocate throw    \ Allocate array
  2dup ! nip                     \ Stick the array length in the first cell
  ;

\ Put a cell value into an array --indexes from zero!
: array!  ( n addr index -- )
  arraycheck
  1+ cells + !                     \ Stick the value
  ;

\ Grab the element at the array index
: array@  ( addr index -- n )
  arraycheck
  1+ cells + @
  ;

\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\ \\  FLOATING-POINT FUNCTIONS  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


\ floating-point array
: farray-create  ( len -- addr )
  dup 2 * cells 1 cells + allocate throw
  2dup ! nip
  ;

\ put a floating-point value into an array --indexes from zero!
: farray!  ( f addr index -- )
  arraycheck
  \ A FP-number is 2 cells, + 1 cell for the array length index
  cells 2 * 1 cells + + f!
  ;

\ grab the element at the array index
: farray@  ( addr index -- f )
  arraycheck
  cells 2 * 1 cells + + f@
  ;
 
\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\ \\  DOUBLE FUNCTIONS  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\ XXX There are no d! and d@ words!!


\ double-cell array
: darray-create  ( len -- addr )
  dup dup 1+ cells + allocate throw
  2dup ! nip
  ;

\ put a double value into an array --indexes from zero!
: darray!  ( f addr index -- )
  arraycheck
  \ A FP-number is 2 cells, + 1 cell for the array length index
  cells 2 * 1 cells + + d!
  ;

\ grab the element at the array index
: darray@  ( addr index -- f )
  arraycheck
  1 cells * + f@
  ;
 
