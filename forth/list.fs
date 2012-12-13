(  list.fs
   Linked-list in Forth...
   Is this madness?

   Only does ints for the moment.  'Tis sorta a feasibility study.

   Simon Heath
   21/5/2003
)

: list-create ( -- addr )
  2 cells allocate throw
  0 over !           \ Set car to zero
  0 over cell+ !     \ Set cdr to zero
  ;

\ Makes the node at addr1 point to addr2
: list-direct ( addr1 addr2 -- )
  swap list-tail ! ;

\ General node creation
: list-add ( addr1 addr2 -- )
  2 cells allocate throw tuck
  list-direct 
  list-direct
  ;

: list-item ( addr -- n )
  @ 
  ;

: list-tail ( addr -- n )
  cell+
  ;

\ Next node
: list-next ( addr1 -- addr2 )
  list-tail @ 
  ;

: list-isend ( addr -- bool )
  list-next 0= ;

: list-end recursive ( addr1 -- addr2 )
  dup list-isend if
     noop
  else
     list-tail list-end
  then ;

: list-length ( addr1 -- u )
  0 list-length' ;

: list-length' recursive ( addr1 u1 -- u2 )
  over list-isend if
    nip
  else
    >r list-next r> 1+
  then ;

: list-append ( addr -- )
  
