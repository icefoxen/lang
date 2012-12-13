% Simple prolog program thingy.
% Just practice.

a( X ):-
  b( X, Y ),
  c( Y ).

a( X ):-
  c( X ).

b( 1, 2 ).
b( 2, 2 ).
b( 3, 3 ).
b( 3, 4 ).
c( 2 ).
c( 5 ).
